#!/usr/bin/python3

import shutil
import os 
import time
from colorama import Fore, init 
init(autoreset=True)

print(r""" 
    _         _          _      _   _                 
   / \  _   _| |_ ___   | | _(_) |_| |_ _   _ 
  / _ \| | | | __/ _ \  | |/ / | __| __| | | |
 / ___ \ |_| | || (_) | |   <| | |_| |_| |_| |
/_/   \_\__,_|\__\___/  |_|\_\_|\__|\__|\__, |
                                        |___/      made by xk4libur
""")

# --- Comprobaciones de dependencias ---
program_name = "kitty"
program_path = shutil.which(program_name)

shell_name = "zsh"
shell_path = shutil.which(shell_name)

time.sleep(2)
print(Fore.GREEN + f"\n[+] Checking if {shell_name} is installed...\n")
time.sleep(2)
if shell_path:
    print(Fore.YELLOW + f"\n- {shell_name} is already installed. :)\n")
else:
    print(Fore.RED + f"\n- {shell_name} is not installed. Install it with: sudo apt install zsh\n")

time.sleep(2)
print(Fore.GREEN + "\n[+] Checking if kitty is installed...\n")
time.sleep(2)
if program_path:
    print(Fore.YELLOW + f"\n- {program_name} is already installed. :)\n")
else:
    print(Fore.RED + f"\n- {program_name} is not installed. Install it with: sudo apt install kitty\n")

# --- Carpeta de fuentes local ---
fonts_dir = os.path.expanduser("~/usr/share/fonts/")
hack_font_dst = os.path.join(fonts_dir, "Hack")
hack_font_src = os.path.join(os.getcwd(), "Hack")

print(Fore.YELLOW + f"\n[+] Checking if fonts folder '{fonts_dir}' exists...\n")
time.sleep(2)
try:
    os.makedirs(fonts_dir, exist_ok=True)
    print(Fore.GREEN + f"\n- Directory '{fonts_dir}' is ready. :)\n")
except Exception as e:
    print(Fore.RED + f"\n- Failed to create fonts folder: {e}\n")
    exit(1)

# --- Mover fuente Hack ---
time.sleep(2)
print(Fore.YELLOW + "\n[+] Moving 'Hack' fonts to local fonts directory...\n")
time.sleep(2)
try:
    if os.path.exists(hack_font_src):
        if not os.path.exists(hack_font_dst):
            shutil.move(hack_font_src, hack_font_dst)
            print(Fore.GREEN + f"\n- 'Hack' folder moved to '{hack_font_dst}' successfully. :)\n")
        else:
            print(Fore.YELLOW + f"\n- 'Hack' folder already exists at '{hack_font_dst}'.\n")
    else:
        print(Fore.RED + "\n- 'Hack' folder not found in the current directory.\n")
except Exception as e:
    print(Fore.RED + f"\n- Error moving 'Hack' folder: {e}\n")

# --- Recargar caché de fuentes ---
print(Fore.YELLOW + "\n[+] Updating font cache...\n")
time.sleep(2)
os.system("fc-cache -f")

# --- Configuración de kitty ---
kitty_config_dir = os.path.expanduser("~/$USER/.config/kitty/")
print(Fore.YELLOW + f"\n[+] Ensuring directory '{kitty_config_dir}' exists...\n")
time.sleep(2)
try:
    os.makedirs(kitty_config_dir, exist_ok=True)
    print(Fore.GREEN + f"\n- Directory '{kitty_config_dir}' is ready. :)\n")
except Exception as e:
    print(Fore.RED + f"\n- Error creating '{kitty_config_dir}': {e}\n")
    exit(1)

# --- Función para mover archivos de configuración ---
def move_file_to_kitty(file_name):
    src = os.path.join(os.getcwd(), file_name)
    dst = os.path.join(kitty_config_dir, file_name)

    time.sleep(1)
    print(Fore.YELLOW + f"\n[+] Moving {file_name} to '{kitty_config_dir}'...\n")
    time.sleep(1)

    try:
        if os.path.exists(src):
            if not os.path.exists(dst):
                shutil.move(src, dst)
                print(Fore.GREEN + f"\n- '{file_name}' moved successfully. :)\n")
            else:
                print(Fore.YELLOW + f"\n- '{file_name}' already exists in kitty config folder.\n")
        else:
            print(Fore.RED + f"\n- '{file_name}' not found in the current directory.\n")
    except Exception as e:
        print(Fore.RED + f"\n- Error moving '{file_name}': {e}\n")

# --- Archivos de configuración ---
move_file_to_kitty("kitty.conf")
move_file_to_kitty("color.ini")
