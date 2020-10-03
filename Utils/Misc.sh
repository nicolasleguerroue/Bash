#!/bin/bash

echo -e "Start"

sudo apt-get install mplayer
mplayer tv:// -tv device=/dev/video1:width=1080:height=720

sudo pip3 install opencv-contrib-python
sudo pip3 install opencv-python-headless
sudo pip3 install opencv-python


#Opencv Python
pip3 install opencv-python

sudo apt-get install -y libopencv-dev