#!/bin/bash

sudo apt-get update
sudo apt-get install git curl lsb-release gnupg

sudo curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update
sudo apt-get install gz-jetty

sudo apt install pythonpy python3-pip pipx docker.io
pip install mavsdk aioconsole

sudo usermod -aG docker $(id -un)

sudo usermod -aG dialout "$(id -un)"

# stop and mask the ModemManager
sudo systemctl mask --now ModemManager.service

sudo apt install -y libfuse2 libxcb-xinerama0 libxkbcommon-x11-0 libxcb-cursor0

curl -L -o "./QGroundControl-x86_64.AppImage" \
  https://d176tv9ibo4jno.cloudfront.net/builds/master/QGroundControl-x86_64.AppImage
chmod +x "./QGroundControl-x86_64.AppImage"


