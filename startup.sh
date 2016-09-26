#!/bin/sh
if [ $# -ne 2 ]
then
    echo "Usage: ./startup.sh USERNAME FILENAME"
    exit 1
fi

if [ "$(id -u)" != "0" ]
then
  echo "Must be root to run this script."
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

# Create user
username="$1"
pass="$1"
grep -q "$username" /etc/passwd
if [ $? -eq 0 ] 
then    
    echo "User $username already exists."
else
    useradd -p `mkpasswd "$pass"` -d /home/"$username" -m -g users -s /bin/bash "$username"
    echo "$username  ALL=(ALL:ALL) ALL" >> /etc/sudoers
    echo "Account $username is setup as sudoer."
fi


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
ember new $2 --skip-npm
cd $2
npm install
bower install --allow-root
IP=`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
echo "########## To test the Ember server is working, navigate to: http://$IP:4200 ##########"
ember server
