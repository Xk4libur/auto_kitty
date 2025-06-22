#!/usr/python3

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


# Move kitty.conf to .config/kitty
time.sleep(2)
print(Fore.YELLOW + "\n[+] Moving kitty.conf to .config/kitty...\n")
time.sleep(2)
kitty_conf_src = os.path.join(os.getcwd(), "kitty.conf")
kitty_conf_dst = os.path.expanduser("~/.config/kitty/")
kitty_conf_dst_file = os.path.join(kitty_conf_dst, "kitty.conf")
try:
    if os.path.exists(kitty_conf_src):
        os.makedirs(kitty_conf_dst, exist_ok=True)
        if not os.path.exists(kitty_conf_dst_file):
            shutil.move(kitty_conf_src, kitty_conf_dst_file)
            print(Fore.GREEN + "\n- 'kitty.conf' moved successfully. :)\n")
        else:
            print(Fore.YELLOW + "\n- 'kitty.conf' already exists in ~/.config/kitty/.\n")
    else:
        print(Fore.RED + "\n- 'kitty.conf' not found in the current directory.\n")
except PermissionError:
    print(Fore.RED + "\n- Permission denied. Try running the script with sudo.\n")
except Exception as e:
    print(Fore.RED + f"\n- Error moving 'kitty.conf': {e}\n")

# Move color.ini to .config/kitty
time.sleep(2)
print(Fore.YELLOW + "\n[+] Moving color.ini to .config/kitty...\n")
time.sleep(2)
color_ini_src = os.path.join(os.getcwd(), "color.ini")
color_ini_dst = os.path.expanduser("~/.config/kitty/")
try:
    if os.path.exists(color_ini_src):
        if not os.path.exists(color_ini_dst):
            os.makedirs(color_ini_dst, exist_ok=True)
            shutil.move(color_ini_src, color_ini_dst)
            print(Fore.GREEN + "\n- 'color.ini' moved successfully. :)\n")
        else:
            print(Fore.YELLOW + "\n- 'color.ini' already exists in ~/.config/kitty/.\n")
    else:
        print(Fore.RED + "\n- 'color.ini' not found in the current directory.\n")
except PermissionError:
    print(Fore.RED + "\n- Permission denied. Try running the script with sudo.\n")
except Exception as e:
    print(Fore.RED + f"\n- Error moving 'color.ini': {e}\n")