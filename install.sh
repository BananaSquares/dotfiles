#!/usr/bin/env bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ${homedir}/dotfiles
# and installs bun
# oh and also spaceship(Oh my ZSH theme)
############################


homedir=$HOME

# dotfiles directory
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPTR=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
dotfiledir=$(dirname "$SCRIPTR")
# list of files/folders to symlink in ${homedir}
files="bash_profile bashrc bash_prompt aliases private zshrc"

# change to the dotfiles directory
echo "Changing to the ${dotfiledir} directory"
cd ${dotfiledir}
echo "...done"

# create symlinks (will overwrite old dotfiles)
for file in ${files}; do
    echo "Creating symlink to $file in home directory."
    ln -sf ${dotfiledir}/.${file} ${homedir}/.${file}
done

# Install Bun
curl https://bun.sh/install | bash
#Install Powerline Fonts(requirement for Spaceship
sudo apt-get install fonts-powerline
# Set ZSH_CUSTOM
ZSH_CUSTOM="$HOME./oh-my-zsh/custom"
# Install Spaceship
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# Symlink theme to ZSH_CUSTOM
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
