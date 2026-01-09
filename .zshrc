plugins=(git nvm)
export EDITOR='nvim'
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export PATH="$PATH:/mnt/c/Users/vinicius.q.filipe/AppData/Local/Microsoft/WindowsApps"
export PATH="$PATH:/mnt/c/Users/Vis/vinicius.q.filipe/Local/Programs/Microsoft VS Code/bin"
export PATH="$PATH:/mnt/c/WINDOWS"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:/usr/local/go/bin"
export PATH=$PATH:/home/visnicius/.spicetify
export PATH=/home/vinicius/.opencode/bin:$PATH

alias ls="exa -1 --icons --across --all --git-ignore"
alias vim="nvim"
alias nvim-ks='NVIM_APPNAME="nvim-kickstart" nvim'
alias tmuxs="tmux source ~/.tmux.conf"
alias tmuxc="nvim ~/.tmux.conf"
alias tmuxi="~/.tmux/plugins/tpm/scripts/install_plugins.sh"
alias nvimc="cd ~/.config/nvim && vim"
alias lsplog="nvim /home/vinicius/.local/state/nvim/lsp.log"
alias zshc="nvim ~/.zshrc"
alias zshs="source ~/.zshrc"
alias hostsc="nvim /mnt/c/Windows/System32/drivers/etc/hosts"
alias medicos="cd ~/projects/HP.Medico.FrontEnd/"
alias pacientes="cd ~/projects/HP.PortalPaciente.FrontEnd/"
alias design="cd ~/projects/HP.PrecisionCare.Design/"
alias strapi="cd ~/projects/HP.PrecisionCare.PerguntasFrequentes.Strapi/"
alias perguntas="cd ~/projects/HP.Feature.PerguntasFrequentes.FrontEnd/"
alias plataforma="cd ~/projects/HP.PrecisionCare.FrontEnd/"
alias passaporte="cd ~/projects/web-passaporte/"
alias apple-web="cd ~/projects/apple-watch-view/"
alias apple-api="cd ~/projects/apple-watch-puc-integration/"
alias desktop="cd ~/mnt/c/Users/vinicius.q.filipe/Desktop/"
alias downloads="cd /mnt/c/Users/vinicius.q.filipe/Downloads/"
alias windows="cd /mnt/c/"
alias eventos="cd ~/projects/web-envio-eventos/ && nvim"
alias prettierd-reset="pkill -9 -f prettierd; rm -rf ~/.cache/run/.prettierd && echo 'prettierd resetado com sucesso'"

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#232136,hl:#ea9a97
	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
	--color=border:#44415a,header:#3e8fb0,gutter:#232136
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

# yazi wrapper (alias with y). q to change cwd and Q to stay on the same cwd
  function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# HOOKS
chpwd() {
  ls
}


# Load Angular CLI autocompletion.
source <(ng completion script)

# bun completions
[ -s "/home/vinicius/.bun/_bun" ] && source "/home/vinicius/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
