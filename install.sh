#!/bin/bash

cd /opt
sudo rm -rf evilTrust
sudo git clone https://github.com/s4vitar/evilTrust.git
cd evilTrust
sudo chmod +x evilTrust.sh
cd

cd
sudo echo "cd && cd /opt/evilTrust && sudo ./evilTrust.sh -m terminal" > eviltrust
sudo echo "cd && cd /opt/evilTrust && sudo ./evilTrust.sh -m gui" > eviltrustg
sudo chmod +x eviltrust
sudo chmod +x eviltrustg
sudo rm -rf /usr/local/bin/eviltrust
sudo rm -rf /usr/local/bin/eviltrustg
sudo mv eviltrust /usr/local/bin/
sudo mv eviltrustg /usr/local/bin/
cd

sudo apt-get -y update
sudo apt-get install -y php
sudo apt-get install -y dnsmasq
sudo apt-get install -y hostapd

sudo mkdir -p /usr/local/share/evilTrust/images
sudo cp images/evil.png /usr/local/share/evilTrust/images/
sudo chmod 644 /usr/local/share/evilTrust/images/evil.png

sudo wget https://raw.githubusercontent.com/dzh0ni/evilTrust/master/Install/crear_evilTrust_desktop.sh -O - | sudo bash && sudo rm -rf wget-log*