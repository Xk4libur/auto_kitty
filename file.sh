#!/bin/bash

cat << "EOF"
    _         _          _    _ _   _         
   / \  _   _| |_ ___   | | _(_) |_| |_ _   _ 
  / _ \| | | | __/ _ \  | |/ / | __| __| | | |
 / ___ \ |_| | || (_) | |   <| | |_| |_| |_| |
/_/   \_\__,_|\__\___/  |_|\_\_|\__|\__|\__, |
                                        |___/      made by xk4libur
EOF


# Check if kitty is installed

kitty_checker() {
    which kitty > /dev/null 2>&1

    if [ $? != 0 ]; then
        echo -e "\nFist of all, install kitty (sudo apt install kitty) and then use it to do the rest.\n"
        exit 1
    else
        echo ""
    fi
}

use_kitty(){
    if [ -n "$KITTY_WINDOW_ID" ]; then 
        echo -e "\nYou are using a Kitty terminal\n"
    else 
        echo -e "\nUse a Kitty terminal to do the rest\n"
        exit 1
    fi
}

kitty_checker
use_kitty


# Installing zsh
echo -e "\nInstalling zsh...\n"
sleep 2
sudo apt install zsh -y 

# Move Hack Nerd Fonts
echo -e "\nInstalling Hack Nerd Fonts...\n"
sudo mv ~/auto_kitty/Hack /usr/share/fonts/
sleep 2

# Create configuration files
echo -e "\nCreating the configuration files for kitty...\n"
mkdir -p ~/.config/kitty
sudo mv ~/auto_kitty/kitty.conf ~/.config/kitty/
sudo mv ~/auto_kitty/color.ini ~/.config/kitty/
sleep 2
kitty sh -c 'kitty @ close-window'

# Installing powerlevel10k
kitty
echo -e "\nInstalling p10k...\n"
sleep 2
cd
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
sudo chsh -s /usr/bin/zsh $USER
sudo chsh -s /usr/bin/zsh root
zsh
sudo su
cd /root
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
zsh

# Installing lsd and batcat
echo -e "\nInstalling lsd and batcat...\n"
sleep 2
sudo dpkg -i bat.deb lsd.deb

# Include batcat and lsd
echo "alias ls='lsd -l' > ~/home/$USER/.zshrc"
echo "alias cat='bat' > ~/home/$USER/.zshrc"