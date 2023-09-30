#!/bin/bash

cd $(dirname $0)
OPS_BASE_URL="https://github.com/NREL/OpenStudio/releases"

print_version () {
    _SDK_VERSION=$(pip show openstudio | awk '/Version/ {print $0}')
    _OPS_VERSON=$(openstudio --version | awk '{NF=NF;print $1}' FS="+")
    echo "OpenStudio Engine version: $_OPS_VERSION"
    echo "OpenStudio Python version: $_SDK_VERSION"
}

echo "Initial versions"
print_version 

## Dependencies. May or not need these. Uncomment if needed.
# sudo apt-get update
# sudo apt-get install dpkg-dev git cmake-curses-gui cmake-gui \
#     libssl-dev libxt-dev libncurses5-dev libgl1-mesa-dev \
#     autoconf libexpat1-dev libpng12-dev libfreetype6-dev \
#     libdbus-glib-1-dev libglib2.0-dev libfontconfig1-dev \
#     libxi-dev libxrender-dev libgeographiclib-dev chrpath

# Download openstudio engine
OPS_VERSION="3.6.1"
OPS_FNAME="OpenStudio-${OPS_VERSION}+bb9481519e-Ubuntu-20.04-x86_64.deb"
OPS_URL="$OPS_BASE_URL/download/v$OPS_VERSION/$OPS_FNAME"
OPS_FPATH=$PWD/$OPS_FNAME
# Download ops
# -0 ~ download to filename indicated in URL
curl -0 $OPS_URL
sudo dpkg -i $OPS_FPATH

# Install python
pip install --upgrade openstudio


echo "Final versions"
print_version 
