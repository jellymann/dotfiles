#!/bin/sh

DOTFILES="gitconfig gitignore_global tmux tmux.conf tmuxinator vimrc zshrc"

for f in $DOTFILES; do
  ln -s "$HOME/dotfiles/.$f" "$HOME/.$f"
done
