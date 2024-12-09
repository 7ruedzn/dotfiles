# My dotfiles

This directory contains the dotfiles for my arch configuration

## Requirements

Ensure you have the following installed on your system

### Git and Stow

```sh
pacman -S git stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```sh
$ git clone git@github.com/7ruedzn/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```sh
$ stow .
```

after that, you can install all the required packages

```sh
$ yay -S zsh tmux starship ripgrep zip unzip nvm exa openssh --noconfirm
```

## Changing default shell

To change the default shell to zsh, do the following

```sh
$ chsh -s /bin/zsh
````
## Generating ssh key

To generate a public and private key with ssh and rsa, do the following

```sh
$ ssh-keygen -t rsa
```
after the keys creating, add then on the repos you will need
