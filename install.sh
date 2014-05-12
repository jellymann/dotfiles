#!/bin/sh

DOTFILES="git gitconfig gitignore_global tmux tmux.conf tmuxinator vim vimrc zshrc"

for f in $DOTFILES; do
  cp -r "$HOME/dotfiles/.$f" "$HOME/.$f"
done
