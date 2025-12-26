# My dotfiles
This directory contains the dotfiles for my arch configuration
## Requirements
Ensure you have the following installed on your system
### Git and Stow
```sh
pacman -S git stow neovim
```
## Installation
### Generating ssh key
To generate a public and private key with ssh and rsa to clone the repo, do the following
```sh
ssh-keygen -t rsa
```
after creating the keys, add the public key the your github account.
### Cloning repo
Check out the dotfiles repo in your $HOME directory using git
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
yay -S zsh tmux starship waybar ghostty hyprshot hyprlock hypridle hyprpaper hyprpicker  cliphist wl-clip-persist btop ripgrep zip thunar tumbler rofi unzip less steam discord gnome-disk-utility nvm exa fzf jq gvfs pdfjs openssh zen-browser-bin wlrobs-hg obs-studio wireplumber xdg-desktop-portal-hyprland blueberry udiskie vlc vlc-plugin-ffmpeg ttf-jetbrains-mono-nerd 3.3.0-1 --noconfirm
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
## Spotify
If you need spotify, you can download with the following
```bash
yay -S spotify-launcher
```
### Customize spotify
You can customize your spotify with *spicetify*. Run the following to install the CLI:
```bash
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
```
After that, clone the *themes* repo from the official community:
```bash
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git
```
Copy the files into the *spicetify* themes folder:
```bash
cd spicetify-themes
cp -r * ~/.config/spicetify/Themes
```
Then choose the theme to apply. In this case, i'll choose rose-pine:
```bash
spicetify config current_theme Ziro
```
Choose the colorscheme. This theme has two variants:
```bash
# Light theme
spicetify config color_scheme rose-pine-dawn

# Dark theme
spicetify config color_scheme rose-pine-moon
```
Apply your changes:
```bash
spicetify apply
```
## Audio
To enable to manage audio devices, you can install the following:
```bash
yay -S pipewire pipewire-pulse pavucontrol
```
## Nvidia
These are the legacy drivers for my GTX 960:
```bash
yay -S nvidia-580xx-dkms nvidia-580xx-utils lib32-nvidia-580xx-utils
```
