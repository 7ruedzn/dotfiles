#!/bin/bash
set -eo pipefail

# --- Variáveis Configuráveis ---
DOTFILES_REPO_USER="7ruedzn"
DOTFILES_REPO_NAME="dotfiles"
DOTFILES_REPO_URL_SSH="git@github.com:${DOTFILES_REPO_USER}/${DOTFILES_REPO_NAME}.git"

# --- Funções Auxiliares ---
command_exists() {
    command -v "$1" &>/dev/null
}

# --- FASE 2: Lógica Interativa de Setup do SSH ---
interactive_ssh_setup() {
    echo "--- FASE 2: Configuração Interativa da Chave SSH ---"

    if [ -f ~/.ssh/id_ed25519 ]; then
        echo "✅ Chave SSH (~/.ssh/id_ed25519) já encontrada."
    else
        echo "🔑 Nenhuma chave SSH encontrada. Gerando uma nova..."
        read -p "Digite o endereço de e-mail associado à sua conta do GitHub: " github_email
        ssh-keygen -t ed25519 -C "$github_email" -f ~/.ssh/id_ed25519 -N ""
        echo "✅ Nova chave SSH gerada com sucesso!"
    fi

    echo -e "\n------------------------- SUA CHAVE PÚBLICA -------------------------"
    cat ~/.ssh/id_ed25519.pub
    echo "---------------------------------------------------------------------"

    # Copia para o clipboard, se possível
    if [ -n "${WAYLAND_DISPLAY:-}" ] && command_exists wl-copy; then
        cat ~/.ssh/id_ed25519.pub | wl-copy
        echo -e "\n✅ Chave pública copiada para o clipboard (usando wl-copy)."
    elif [ -n "${DISPLAY:-}" ] && command_exists xclip; then
        cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
        echo -e "\n✅ Chave pública copiada para o clipboard (usando xclip)."
    else
        echo -e "\n📋 Não foi possível copiar para o clipboard. Por favor, copie manualmente."
    fi

    echo -e "\n Instruções:"
    echo "1. A chave acima já deve estar no seu clipboard."
    echo "2. Abra o seguinte URL no seu navegador: https://github.com/settings/keys"
    echo "3. Adicione a nova chave SSH à sua conta."
}

# --- FASE 3: Funções de Instalação Automatizada ---

clone_dotfiles() {
    echo "📁 Clonando o repositório de dotfiles via SSH..."
    if [ ! -d "$HOME/dotfiles" ]; then
        git clone "${DOTFILES_REPO_URL_SSH}" "$HOME/dotfiles"
    else
        echo "   -> O diretório ~/dotfiles já existe. Pulando a clonagem."
    fi
}

apply_stow() {
    echo "🔗 Aplicando symlinks com o Stow..."
    (cd ~/dotfiles && stow . --adopt)
}

install_aur_helper() {
    if ! command_exists yay; then
        echo "💡 Instalando 'yay'..."
        sudo pacman -S --noconfirm --needed base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && makepkg -si --noconfirm)
        rm -rf /tmp/yay
    else
        echo "   -> 'yay' já está instalado."
    fi
}

install_all_other_packages() {
    echo "📦 Instalando todos os outros pacotes com 'yay'..."
    yay -S --noconfirm --needed \
        zsh tmux starship waybar ghostty btop ripgrep zip thunar tumbler rofi unzip less \
        steam discord gnome-disk-utility exa fzf jq gvfs pdfjs openssh zen-browser-bin \
        wlrobs-hg obs-studio wireplumber xdg-desktop-portal-hyprland blueberry udiskie \
        vlc vlc-plugin-ffmpeg spotify-launcher ttf-jetbrains-mono-nerd pipewire \
        pipewire-pulse pavucontrol cliphist wl-clip-persist hyprland hyprpicker hyprlock \
        hyprpaper hypridle hyprshot go
}

install_nvm_and_node() {
    echo "📦 Instalando NVM e Node.js..."
    export NVM_DIR="$HOME/.nvm"

    if [ ! -d "$NVM_DIR" ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    fi

    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
    fi
    if [ -s "$NVM_DIR/bash_completion" ]; then
        source "$NVM_DIR/bash_completion"
    fi

    if command_exists nvm; then
        nvm install --lts
        nvm use --lts
    else
        echo "❌ NVM não pôde ser carregado corretamente." >&2
        exit 1
    fi

    # Adiciona sourcing no .zshrc para sessões futuras
    # grep -q 'NVM_DIR' ~/.zshrc || {
    #     echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
    #     echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
    #     echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc
    # }
}

change_default_shell() {
    echo "🐚 Alterando o shell padrão para ZSH..."
    if [ "$(basename "$SHELL")" != "zsh" ]; then
        chsh -s /usr/bin/zsh
    fi
}

install_tmux_plugin_manager() {
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        echo "🔌 Instalando o TPM..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
}


setup_spicetify() {
    echo "🎵 Instalando e configurando o Spicetify...";

    if ! command_exists spicetify; then
        curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh;
    fi;

    # Corrigir o caminho do Spotify se o Spotify foi instalado via spotify-launcher
    SPOTIFY_PATH="$HOME/.local/share/spotify-launcher/install/usr/share/spotify"
    CONFIG_FILE="$HOME/.config/spicetify/config-xpui.ini"

    if [ -f "$CONFIG_FILE" ]; then
        echo "🔧 Ajustando configuração do Spicetify..."
        # Altera a linha do spotify_path no arquivo de configuração
        sed -i "s|^spotify_path =.*|spotify_path = $SPOTIFY_PATH|" "$CONFIG_FILE"
        echo "✅ Caminho do Spotify ajustado no config-xpui.ini"
    else
        echo "❌ Não foi possível encontrar o arquivo de configuração do Spicetify ($CONFIG_FILE)"
        exit 1
    fi

    spicetify backup apply
    spicetify config current_theme Ziro
    spicetify config color_scheme rose-pine-moon
    spicetify apply
}

# Função Principal ---
main() {
    echo "🚀 Iniciando a configuração completa do sistema..."

    echo "--- FASE 1: Instalando dependências mínimas para o setup ---"
    sudo pacman -Syu --noconfirm --needed git stow wl-clipboard xclip

    interactive_ssh_setup

    echo "--- FASE 3: Continuando com a instalação automatizada ---"
    clone_dotfiles
    apply_stow
    install_aur_helper
    install_all_other_packages
    install_nvm_and_node
    change_default_shell
    install_tmux_plugin_manager
    setup_spicetify

    echo -e "\n✅ Configuração finalizada com sucesso!"
    echo "💡 Por favor, REINICIE seu sistema para que todas as alterações tenham efeito."
}

main "$@"

