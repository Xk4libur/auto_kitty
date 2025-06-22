#!/bin/bash

sudo apt install kitty zsh
mv ~/auto_kitty/Hack /usr/share/fonts/
mkdir -p ~/.config/kitty
mv ~/auto_kitty/kitty.conf ~/.config/kitty/
mv ~/auto_kitty/color.ini ~/.config/kitty/
