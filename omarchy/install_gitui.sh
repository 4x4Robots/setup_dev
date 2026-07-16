#!/usr/bin/env bash

echo "Installing gitui (a terminal -ui for git)..."

# Use package manager to install Brave
sudo pacman -S gitui

# Deinstall lazygit
echo "Removing lazygit..."
sudo pacman -R lazygit
omarchy-tui-remove lazygit

