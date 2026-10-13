#!/bin/bash


./QGroundControl-x86_64.AppImage &
pid=$!

docker run --rm -it --name px4-sitl --network host \
    -e PX4_SIM_MODEL=gz_x500_mono_cam \
    -e PX4_GZ_WORLD=baylands \
    px4io/px4-sitl-gazebo:latest
status=$?

kill "$pid" 2>/dev/null
wait "$pid" 2>/dev/null
exit "$status"


