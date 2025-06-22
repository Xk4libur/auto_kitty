#!/usr/bin/python3

import shutil
import os 
import time
from colorama import Fore, Style, init 
init(autoreset=True)

print(r""" 
    _         _          _      _   _                 
   / \  _   _| |_ ___   | | _(_) |_| |_ _   _ 
  / _ \| | | | __/ _ \  | |/ / | __| __| | | |
 / ___ \ |_| | || (_) | |   <| | |_| |_| |_| |
/_/   \_\__,_|\__\___/  |_|\_\_|\__|\__|\__, |
                                        |___/      made by xk4libur
""")

program_name = "kitty"
program_path = shutil.which(program_name)

shell_name = "zsh"
shell_path = shutil.which(shell_name)

# Check if zsh terminal is installed
time.sleep(2)
print(Fore.GREEN + f"\n[+] Checking if {shell_name} is installed...\n")
time.sleep(2)
if shell_path:
    print(Fore.YELLOW + f"\n- {shell_name} is already installed. :)\n")
else:
    print(Fore.RED + f"\n- {shell_name} is not installed. Install with 'sudo apt install zsh'\n")

# Check if kitty terminal is installed
time.sleep(2)
print(Fore.GREEN + "\n[+] Checking if kitty is installed...\n")
time.sleep(2)
if program_path:
    print(Fore.YELLOW + f"\n- {program_name} is already installed. :)\n")
else:
    print(Fore.RED + f"\n- {program_name} is not installed. Install with 'sudo apt install kitty'\n")

# Check if Fonts folder exists
time.sleep(2)
print(Fore.YELLOW + "\n[+] Checking if Fonts folder exists...\n")
time.sleep(2)
if not os.path.exists("/usr/share/fonts/"):
    print(Fore.RED + "\n- Fonts folder does not exist. Creating...\n")
    time.sleep(2)
    os.makedirs("/usr/share/fonts/")
    print(Fore.GREEN + "\n- Fonts folder created successfully. :)\n")
else:
    print(Fore.YELLOW + "\n- Fonts folder already exists. :)\n")

# Move fonts to Fonts folder
time.sleep(2)
print(Fore.YELLOW + "\n[+] Moving fonts to Fonts folder...\n")
time.sleep(2)

hack_font_src = os.path.join(os.getcwd(), "Hack")
hack_font_dst = "/usr/share/fonts/Hack"

try:
    if os.path.exists(hack_font_src):
        if not os.path.exists(hack_font_dst):
            shutil.move(hack_font_src, hack_font_dst)
            print(Fore.GREEN + "\n- 'Hack' folder moved successfully. :)\n")
        else:
            print(Fore.YELLOW + "\n- 'Hack' folder already exists in /usr/share/fonts/.\n")
    else:
        print(Fore.RED + "\n- 'Hack' folder not found in the current directory.\n")
except PermissionError:
    print(Fore.RED + "\n- Permission denied. Try running the script with sudo.\n")
except Exception as e:
    print(Fore.RED + f"\n- Error moving 'Hack' folder: {e}\n")

# Crear ~/.config/kitty/
home_config_dir = os.path.expanduser("~/.config/")
kitty_config_dir = os.path.join(home_config_dir, "kitty")

print(Fore.YELLOW + f"\n[+] Ensuring directory '{kitty_config_dir}' exists...\n")
time.sleep(2)
try:
    os.makedirs(kitty_config_dir, exist_ok=True)
    print(Fore.GREEN + f"\n- Directory '{kitty_config_dir}' created or already exists. :)\n")
except PermissionError:
    print(Fore.RED + f"\n- Permission denied while creating '{kitty_config_dir}'. Try running with sudo.\n")
    exit(1)
except Exception as e:
    print(Fore.RED + f"\n- Error creating '{kitty_config_dir}': {e}\n")
    exit(1)

# Función para mover archivos a ~/.config/kitty/
def move_file_to_kitty(file_name):
    src = os.path.join(os.getcwd(), file_name)
    dst = os.path.join(kitty_config_dir, file_name)

    time.sleep(2)
    print(Fore.YELLOW + f"\n[+] Moving {file_name} to ~/.config/kitty/...\n")
    time.sleep(2)

    try:
        if os.path.exists(src):
            if not os.path.exists(dst):
                shutil.move(src, dst)
                print(Fore.GREEN + f"\n- '{file_name}' moved successfully. :)\n")
            else:
                print(Fore.YELLOW + f"\n- '{file_name}' already exists in ~/.config/kitty/.\n")
        else:
            print(Fore.RED + f"\n- '{file_name}' not found in the current directory.\n")
    except PermissionError:
        print(Fore.RED + f"\n- Permission denied. Try running the script with sudo.\n")
    except Exception as e:
        print(Fore.RED + f"\n- Error moving '{file_name}': {e}\n")

# Mover kitty.conf y color.ini
move_file_to_kitty("kitty.conf")
move_file_to_kitty("color.ini")

