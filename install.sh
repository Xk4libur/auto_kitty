#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Install kitty

function install_kitty() {
    echo -e "\n${greenColour}Installing kitty terminal and configuring kitty files ...${endColour}\n"
    sudo apt install kitty
    sudo mv ~/auto_kitty/Hack/* /usr/share/fonts/
    mkdir -p ~/.config/kitty
    cp ~/auto_kitty/kitty.conf ~/.config/kitty/
    cp ~/auto_kitty/color.ini ~/.config/kitty/
}

function install_additional_tools() {
    echo -e "\n${greenColour}Installing additional tools ...${endColour}\n"
    sudo dpkg -i ~/auto_kitty/bat.deb
    sudo dpkg -i ~/auto_kitty/lsd.deb
}

function remove_zshrc(){
    echo -e "\n${greenColour}Removing existing .zshrc file and linking to the new one ...${endColour}\n"
    sudo rm -f /root/.zshrc
    sudo ln -sf /home/$SUDO_USER/.zshrc /root/.zshrc
}


# Executing
install_kitty
install_additional_tools
remove_zshrc
echo -e "\n${greenColour}Kitty terminal and additional tools installed successfully!${endColour}\n"
echo -e "\n${greenColour}Please restart your terminal to apply the changes.${endColour}\n"


