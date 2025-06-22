#!/bin/bash

sudo apt install kitty zsh
sudo mv ~/auto_kitty/Hack /usr/share/fonts/
mkdir -p ~/.config/kitty
sudo mv ~/auto_kitty/kitty.conf ~/.config/kitty/
sudo mv ~/auto_kitty/color.ini ~/.config/kitty/
