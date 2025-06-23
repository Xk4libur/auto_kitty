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

    if [ $? -eq 0 ]; then
        echo -e "Kitty is already installed"
    else
        echo -e "Fist of all, install kitty (sudo apt install kitty) and then I will do the rest."
        exit 1
    fi
}


# Check if zsh is installed

zsh_checker() {
    which zsh > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo -e "Zsh is already installed"
    else
        echo -e "You must install zsh"
        exit 1
    fi
}

kitty_checker
zsh_checker

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

# Installing powerlevel10k
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