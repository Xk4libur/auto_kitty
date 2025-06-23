#!/bin/bash

set -e

print_banner() {
    cat << "EOF"
    _         _          _    _ _   _         
   / \  _   _| |_ ___   | | _(_) |_| |_ _   _ 
  / _ \| | | | __/ _ \  | |/ / | __| __| | | |
 / ___ \ |_| | || (_) | |   <| | |_| |_| |_| |
/_/   \_\__,_|\__\___/  |_|\_\_|\__|\__|\__, |
                                        |___/      made by xk4libur
EOF
    echo
}

check_kitty_installed() {
    if ! command -v kitty >/dev/null 2>&1; then
        echo -e "\n❌ Kitty no está instalado. Ejecuta:\n\n  sudo apt install kitty\n\ny luego vuelve a ejecutar este script desde Kitty.\n"
        exit 1
    fi
}

ensure_using_kitty() {
    if [ -z "$KITTY_WINDOW_ID" ]; then
        echo -e "\n❌ Este script debe ejecutarse desde un terminal Kitty.\n"
        exit 1
    else
        echo -e "\n✅ Terminal Kitty detectado.\n"
    fi
}

install_zsh() {
    echo -e "\n🔧 Instalando Zsh...\n"
    sudo apt install -y zsh
}

install_fonts() {
    echo -e "\n🔤 Instalando Hack Nerd Fonts...\n"
    sudo mkdir -p /usr/share/fonts/Hack
    sudo mv -f ~/auto_kitty/Hack/* /usr/share/fonts/Hack/
    fc-cache -fv
}

configure_kitty() {
    echo -e "\n⚙️  Configurando Kitty...\n"
    mkdir -p ~/.config/kitty
    mv -f ~/auto_kitty/kitty.conf ~/.config/kitty/
    mv -f ~/auto_kitty/color.ini ~/.config/kitty/
}

install_powerlevel10k() {
    echo -e "\n🌟 Instalando Powerlevel10k...\n"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

    if ! grep -q "powerlevel10k.zsh-theme" ~/.zshrc 2>/dev/null; then
        echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    fi

    sudo chsh -s /usr/bin/zsh "$USER"
    sudo chsh -s /usr/bin/zsh root

    echo -e "\n🔧 Configurando Powerlevel10k para root...\n"
    sudo bash -c '
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k
        echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> /root/.zshrc
    '
}

install_lsd_bat() {
    echo -e "\n📦 Instalando lsd y bat...\n"
    sudo dpkg -i bat.deb lsd.deb || {
        echo -e "\n❌ Error al instalar los paquetes .deb. Verifica que existan y estén correctos.\n"
        exit 1
    }
}

link_zshrc_to_root() {
    echo -e "\n🔗 Enlazando configuración de zsh para root...\n"
    sudo rm -f /root/.zshrc
    sudo ln -s /home/"$USER"/.zshrc /root/.zshrc
}

add_aliases() {
    echo -e "\n➕ Añadiendo alias a ~/.zshrc...\n"
    {
        echo "alias ls='lsd -l'"
        echo "alias cat='bat'"
    } >> ~/.zshrc
}

# -------------------- EJECUCIÓN --------------------

print_banner
check_kitty_installed
ensure_using_kitty
install_zsh
install_fonts
configure_kitty
install_powerlevel10k
install_lsd_bat
link_zshrc_to_root
add_aliases

echo -e "\n✅ Instalación y configuración completadas. Reinicia la terminal para aplicar los cambios.\n"
