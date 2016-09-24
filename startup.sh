#!/bin/sh
if [ $# -ne 1 ]
  then
    echo "Usage: ./startup.sh FILENAME"
    exit 1
fi

# Set vim config
(
cat <<'ENDVIMCONFIG'
set tabstop=4
set shiftwidth=4
set expandtab
colorscheme desert
ENDVIMCONFIG
) > ~/.vimrc

# Create 4G swap file
## Without this npm installs fail with 'KILLED'
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile   none    swap    sw    0   0' >> /etc/fstab

# Install NodeJS
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# Install Ember
npm install -g ember-cli
npm install -g bower
npm install -g phantomjs-prebuilt

# Create ember project
ember new $1
cd $1
ember server
