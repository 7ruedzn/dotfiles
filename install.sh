#!/bin/bash

set -e

echo "🚀 Iniciando configuração do sistema com dotfiles..."

# 1. Pacotes essenciais
echo "📦 Instalando Git, Stow e Neovim..."
sudo pacman -Syu --noconfirm git stow neovim

# 2. SSH key
echo "🔑 Verificando chave SSH..."
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
    echo "👉 Chave SSH gerada. Adicione a seguinte chave pública ao GitHub:"
    cat ~/.ssh/id_rsa.pub
    read -p "Pressione ENTER após adicionar a chave no GitHub..."
fi

# 3. Clonando dotfiles
echo "📁 Clonando repositório de dotfiles..."
cd ~
if [ ! -d ~/dotfiles ]; then
    git clone git@github.com/7ruedzn/dotfiles.git
fi
cd ~/dotfiles

# 4. Aplicando Stow
echo "🔗 Criando symlinks com stow..."
stow .

# 5. Instalando yay
if ! command -v yay &> /dev/null; then
    echo "💡 Instalando yay (AUR helper)..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# 6. Instalando pacotes via yay
echo "📦 Instalando pacotes com yay..."
yay -S --noconfirm zsh tmux starship waybar ghostty btop ripgrep zip thunar tumbler rofi unzip less \
    steam discord gnome-disk-utility nvm exa fzf jq gvfs pdfjs openssh zen-browser-bin \
    wlrobs-hg obs-studio wireplumber xdg-desktop-portal-hyprland blueberry udiskie vlc \
    vlc-plugin-ffmpeg spotify-launcher ttf-jetbrains-mono-nerd pipewire pipewire-pulse pavucontrol \
    cliphist wl-clip-persist hyprland hyprpicker hyprlock hyprpaper hypridle hyprshot go

# 7. Instalando NVM e Node
echo "📦 Instalando NVM e Node LTS..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    source ~/.bashrc || source ~/.zshrc || true
fi
source "$NVM_DIR/nvm.sh"
nvm install --lts

# 8. Mudando shell padrão para ZSH
echo "🐚 Mudando shell padrão para ZSH..."
chsh -s /bin/zsh

# 9. Instalando TPM (Tmux Plugin Manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "🔌 Instalando TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

# 10. Spicetify para customizar Spotify
echo "🎵 Instalando e configurando Spicetify..."
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git
mkdir -p ~/.config/spicetify/Themes
cp -r spicetify-themes/* ~/.config/spicetify/Themes
rm -rf spicetify-themes

spicetify config current_theme Ziro
spicetify config color_scheme rose-pine-moon
spicetify apply

echo "✅ Configuração finalizada!"
echo "💡 Reinicie seu sistema para aplicar todas as configurações (como Hyprland e ZSH)."
