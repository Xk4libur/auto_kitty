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
        echo -e "\n❌ Kitty is not installed. Ejecuta:\n\n Please install kitty with 'sudo apt install kitty'\n\ny and then execute this script from Kitty.\n"
        exit 1
    fi
}

ensure_using_kitty() {
    if [ -z "$KITTY_WINDOW_ID" ]; then
        echo -e "\n❌ Please execute this script from an Kitty terminal\n"
        exit 1
    else
        echo -e "\n✅ You have Kitty, fine.\n"
    fi
}

install_zsh() {
    echo -e "\n🔧 Installing Zsh...\n"
    sudo apt install -y zsh
    sudo apt install zsh-syntax-highlighting
}

install_fonts() {
    echo -e "\n🔤 Installing the Hack Nerd Fonts...\n"
    sudo mkdir -p /usr/share/fonts/Hack
    sudo mv -f ~/auto_kitty/Hack/* /usr/share/fonts/Hack/
    fc-cache -fv
}

configure_kitty() {
    echo -e "\n⚙️  Configuring Kitty...\n"
    mkdir -p ~/.config/kitty
   sudo mv -f ~/auto_kitty/kitty.conf ~/.config/kitty/
   sudo mv -f ~/auto_kitty/color.ini ~/.config/kitty/
}

install_powerlevel10k() {
    echo -e "\n🌟 Installing Powerlevel10k...\n"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

    if ! grep -q "powerlevel10k.zsh-theme" ~/.zshrc 2>/dev/null; then
        echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    fi

    sudo chsh -s /usr/bin/zsh "$USER"
    sudo chsh -s /usr/bin/zsh root

    echo -e "\n🔧 Configuring Powerlevel10k for root...\n"
    sudo bash -c '
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k
        echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> /root/.zshrc
    '
}

install_lsd_bat() {
    echo -e "\n📦 Installing lsd and bat...\n"
    sudo dpkg -i bat.deb lsd.deb || {
        echo -e "\n❌ Error al instalar los paquetes .deb. Verifica que existan y estén correctos.\n"
        exit 1
    }
}

link_zshrc_to_root() {
    echo -e "\n🔗 Making a link symbolic for .zshrc...\n"
    sudo rm -f /root/.zshrc
    sudo ln -s /home/"$USER"/.zshrc /root/.zshrc
}

add_aliases() {
    echo -e "\n➕ Adding alias to ~/.zshrc...\n"
    {
        echo "alias ls='lsd -l'"
        echo "alias cat='bat'"
    } >> ~/.zshrc
}

move_to_p10k(){
    echo -e "\n Moving the p10k...\n"
    {
        sudo cp ~/auto_kitty/.p10k-root_new.zsh /home/$USER/.p10k.zsh
        sudo cp ~/auto_kitty/.p10k-root_new.zsh /root/.p10k.zsh
        echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /home/$USER/.zshrc
        sudo bash -c 'echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /root/.zshrc'
        echo '[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh' >> /home/$USER/.zshrc
        sudo bash -c 'echo "[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh" >> /root/.zshrc'
    }
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
