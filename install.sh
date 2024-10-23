#!/bin/bash

cd /opt
sudo rm -rf Kali-linux_drivers_and_tools_checker
sudo git clone https://github.com/JennValentine/Kali-linux_drivers_and_tools_checker.git
sudo chmod +x Kali-linux_drivers_and_tools_checker/*
cd Kali-linux_drivers_and_tools_checker
ls -lthas
cd 
sudo echo "cd /opt/Kali-linux_drivers_and_tools_checker && sudo ./kalilinuxdrivertools.sh" > kalilinuxdrivertools
sudo chmod +x kalilinuxdrivertools
sudo rm -rf /usr/local/bin/kalilinuxdrivertools
sudo mv kalilinuxdrivertools /usr/local/bin/
cd
