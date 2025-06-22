#!/usr/python3

import shutil 
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

