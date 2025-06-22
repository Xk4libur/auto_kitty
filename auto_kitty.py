#!/usr/bin/python3

import subprocess
import os
import shutil

print(r""" 
    _         _          _      _   _                 
   / \  _   _| |_ ___   | | _(_) |_| |_ _   _ 
  / _ \| | | | __/ _ \  | |/ / | __| __| | | |
 / ___ \ |_| | || (_) | |   <| | |_| |_| |_| |
/_/   \_\__,_|\__\___/  |_|\_\_|\__|\__|\__, |
                                        |___/      made by xk4libur
""")



def run_command(command, use_sudo=False):
    if use_sudo:
        command = ["sudo"] + command
    subprocess.run(command, check=True)

def main():
    # Instalar kitty y zsh
    run_command(["apt", "install", "-y", "kitty"], use_sudo=True)
    run_command(["apt", "install", "-y", "zsh"], use_sudo=True)

    # Crear directorio de fuentes y mover la fuente Hack
    fonts_dir = "/usr/share/fonts/"
    run_command(["mkdir", "-p", fonts_dir])  # No necesita sudo si ya existe
    run_command(["mv", os.path.expanduser("~/auto_kitty/Hack"), fonts_dir], use_sudo=True)

    # Crear directorio de configuración de kitty
    kitty_config_dir = os.path.expanduser("~/.config/kitty")
    os.makedirs(kitty_config_dir, exist_ok=True)

    # Mover archivos de configuración
    run_command(["mv", os.path.expanduser("~/auto_kitty/kitty.conf"), kitty_config_dir], use_sudo=True)
    run_command(["mv", os.path.expanduser("~/auto_kitty/color.ini"), kitty_config_dir], use_sudo=True)


