#!/bin/bash

set -euo pipefail

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
        echo -e "\n❌ Kitty no está instalado. Ejecuta:\n\n  sudo apt install kitty\n"
        exit 1
    fi
}

ensure_using_kitty() {
    if [ -z "${KITTY_WINDOW_ID:-}" ]; then
        echo -e "\n❌ Ejecuta este script desde una terminal Kitty\n"
        exit 1
    else
        echo -e "\n✅ Terminal Kitty detectada.\n"
    fi
}

install_zsh() {
    echo -e "\n🔧 Instalando Zsh...\n"
    sudo apt update
    sudo apt install -y zsh zsh-syntax-highlighting
}

install_fonts() {
    echo -e "\n🔤 Instalando las Hack Nerd Fonts...\n"
    sudo mkdir -p /usr/share/fonts/Hack
    if compgen -G "$HOME/auto_kitty4kali/Hack/*" > /dev/null; then
        sudo cp -f "$HOME/auto_kitty4kali/Hack/"* /usr/share/fonts/Hack/
        fc-cache -fv
    else
        echo -e "\n❌ No se encontraron fuentes en ~/auto_kitty4kali/Hack/\n"
        exit 1
    fi
}

configure_kitty() {
    echo -e "\n⚙️  Configurando Kitty...\n"
    mkdir -p "$HOME/.config/kitty"
    cp -f "$HOME/auto_kitty4kali/kitty.conf" "$HOME/.config/kitty/"
    cp -f "$HOME/auto_kitty4kali/color.ini" "$HOME/.config/kitty/"
}

install_powerlevel10k() {
    echo -e "\n🌟 Instalando Powerlevel10k...\n"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" 2>/dev/null || true

    if ! grep -q "powerlevel10k.zsh-theme" "$HOME/.zshrc" 2>/dev/null; then
        echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> "$HOME/.zshrc"
    fi

    sudo chsh -s /usr/bin/zsh "$USER" || true
    sudo chsh -s /usr/bin/zsh root || true

    echo -e "\n🔧 Configurando Powerlevel10k para root...\n"
    sudo bash -c '
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k 2>/dev/null || true
        if ! grep -q "powerlevel10k.zsh-theme" /root/.zshrc 2>/dev/null; then
            echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> /root/.zshrc
        fi
    '
}

install_lsd_bat() {
    echo -e "\n📦 Instalando lsd y bat...\n"
    if [[ -f bat.deb && -f lsd.deb ]]; then
        sudo dpkg -i bat.deb lsd.deb || {
            echo -e "\n❌ Error al instalar los paquetes .deb. Verifica que existan y estén correctos.\n"
            exit 1
        }
    else
        echo -e "\n❌ bat.deb o lsd.deb no encontrados en el directorio actual.\n"
        exit 1
    fi
}

link_zshrc_to_root() {
    echo -e "\n🔗 Enlazando .zshrc de root con el del usuario...\n"
    sudo rm -f /root/.zshrc
    sudo ln -s "/home/$USER/.zshrc" /root/.zshrc
}

add_aliases() {
    echo -e "\n➕ Agregando alias a ~/.zshrc...\n"
    grep -qxF "alias ls='lsd -l'" "$HOME/.zshrc" || echo "alias ls='lsd -l'" >> "$HOME/.zshrc"
    grep -qxF "alias cat='bat'" "$HOME/.zshrc" || echo "alias cat='bat'" >> "$HOME/.zshrc"
}

move_to_p10k(){
    echo -e "\n📁 Moviendo configuración de p10k...\n"
    sudo cp "$HOME/auto_kitty4kali/.p10k-root_new.zsh" "$HOME/.p10k.zsh"
    sudo cp "$HOME/auto_kitty4kali/.p10k-root_new.zsh" /root/.p10k.zsh

    if ! grep -q "zsh-syntax-highlighting.zsh" "$HOME/.zshrc"; then
        echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
    fi

    if ! sudo grep -q "zsh-syntax-highlighting.zsh" /root/.zshrc; then
        sudo bash -c 'echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /root/.zshrc'
    fi

    if ! grep -q '\.p10k\.zsh' "$HOME/.zshrc"; then
        echo '[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh' >> "$HOME/.zshrc"
    fi

    if ! sudo grep -q '\.p10k\.zsh' /root/.zshrc; then
        sudo bash -c 'echo "[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh" >> /root/.zshrc'
    fi
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
move_to_p10k
add_aliases

echo -e "\n✅ Instalación y configuración completadas. Reinicia la terminal para aplicar los cambios.\n"

