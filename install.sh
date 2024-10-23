#!/bin/bash

cd /opt
sudo rm -rf Hacking-Wifi
sudo git clone git@github.com:AAAAAEXQOSyIpN2JZ0ehUQ/Hacking-Wifi.git
sudo chmod +x Hacking-Wifi/*
cd Hacking-Wifi
ls -ltha
cd 
sudo echo "cd /opt/Hacking-Wifi && sudo ./menu.sh" > hackingwifi
sudo chmod +x hackingwifi
sudo mv hackingwifi /usr/local/bin/
cd
