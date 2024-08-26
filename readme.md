# My dotfiles

This directory contains the dotfiles for my arch configuration

## Requirements

Ensure you have the following installed on your system

### Git and Stow

```
pacman -S git stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/7ruedzn/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```
