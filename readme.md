# My dotfiles

This directory contains the dotfiles for my arch configuration

## Requirements

Ensure you have the following installed on your system

### Git and Stow

```sh
pacman -S git stow neovim
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```sh
git clone git@github.com/7ruedzn/dotfiles.git
cd dotfiles
```

then use GNU stow to create symlinks

```sh
stow .
```

### Yay (optional)
If you like AUR helper, make sure to install *yay*:
```bash
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

After that, you can install all the required packages
```sh
yay -S zsh tmux starship ripgrep zip unzip nvm exa openssh --noconfirm
```

Install NVM, a NodeJS Version Manager, so you can install other packages later on and also manages the node version on projects
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

Then install the LTS Node version with `nvm`
```bash
nvm install --lts
```

## Changing default shell

To change the default shell to zsh, do the following

```sh
chsh -s /bin/zsh
````

## Installing TPM

To use plugins with tmux, you will need TPM

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

then use the alias ```tmuxi``` to install all the provided plugins or use the following

```sh
~/.tmux/plugins/tpm/scripts/install_plugins.sh
```

## Generating ssh key

To generate a public and private key with ssh and rsa, do the following

```sh
ssh-keygen -t rsa
```

after the keys creating, add then on the repos you will need

## Terminal
I've been using *Ghostty*, so install it with the following
```bash
yay -S ghostty-git
```
