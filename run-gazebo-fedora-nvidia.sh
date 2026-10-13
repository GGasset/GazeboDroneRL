#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

# Build (reuses Docker's build cache where possible).
docker build -t gazebo .

# X11/XWayland must be available in this graphical session.
: "${DISPLAY:?Run this script from your graphical desktop session}"

auth=$(mktemp)
trap 'rm -f "$auth"' EXIT
umask 077

xauth nlist "$DISPLAY" |
  sed 's/^..../ffff/' |
  xauth -f "$auth" nmerge -

if [[ ! -s "$auth" ]]; then
  echo "No X11 authorization cookie found for $DISPLAY" >&2
  exit 1
fi

docker run --rm -it \
  --runtime=nvidia \
  --mount type=bind,src=/tmp/.X11-unix,dst=/tmp/.X11-unix,readonly \
  --mount "type=bind,src=$auth,dst=/tmp/host.xauthority,readonly" \
  --security-opt label=disable \
  -e DISPLAY \
  -e XAUTHORITY=/tmp/host.xauthority \
  -e QT_QPA_PLATFORM=xcb \
  -e QT_X11_NO_MITSHM=1 \
  --gpus all \
  -e NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics,display \
  gazebo

