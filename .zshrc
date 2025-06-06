# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#ZSH_THEME="spaceship"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git nvm)
export EDITOR='nvim'
# export MANPATH="/usr/local/man:$MANPATH"

# export ARCHFLAGS="-arch x86_64"

### Windows PATHS (Add paths that need to be used from windows in $PATH environment)###
export PATH="$PATH:/mnt/c/Users/vinicius.q.filipe/AppData/Local/Microsoft/WindowsApps"
export PATH="$PATH:/mnt/c/Users/Vis/vinicius.q.filipe/Local/Programs/Microsoft VS Code/bin"
export PATH="$PATH:/mnt/c/WINDOWS"
export PATH="$PATH:$HOME/.dotnet/tools"

# GO PATH
# export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# STARSHIP CONFIG CUSTOM PATH
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# ALIASES
alias vim="nvim"
alias tmuxs="tmux source ~/.config/tmux/tmux.conf"
alias tmuxc="nvim ~/.config/tmux/tmux.conf"
alias tmuxi="~/.tmux/plugins/tpm/scripts/install_plugins.sh"
alias nvimc="cd ~/.config/nvim"
alias zshc="nvim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias hostsc="nvim /mnt/c/Windows/System32/drivers/etc/hosts"
alias medicos="cd ~/projects/HP.Medico.FrontEnd/"
alias pacientes="cd ~/projects/HP.PortalPaciente.FrontEnd/"
alias design="cd ~/projects/HP.PrecisionCare.Design/"
alias passaporte="cd ~/projects/web-passaporte/"
alias apple-web="cd ~/projects/apple-watch-view/"
alias apple-api="cd ~/projects/apple-watch-puc-integration/"
alias desktop="cd ~/mnt/c/Users/vinicius.q.filipe/Desktop/"
alias downloads="cd /mnt/c/Users/vinicius.q.filipe/Downloads/"
alias windows="cd /mnt/c/"
alias ls="exa -1 --icons --across --all --git-ignore"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
#
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### End of Zinit's installer chunk

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --zsh)"
eval "$(starship init zsh)"

# Load Angular CLI autocompletion.
# source <(ng completion script)
#. "$HOME/.local/bin/env"

export PATH=$PATH:/home/visnicius/.spicetify

# Set FZF rose pine moon theme
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#232136,hl:#ea9a97
	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
	--color=border:#44415a,header:#3e8fb0,gutter:#232136
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
