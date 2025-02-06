#!/bin/bash

# Ensure script runs with root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

# Update package database and install pacman packages
echo "Updating system and installing Pacman packages..."
pacman -Syu --noconfirm
xargs -a packages.txt pacman -S --needed --noconfirm

# Install Flatpak packages
echo "Installing Flatpak applications..."
if ! command -v flatpak &> /dev/null; then
  echo "Flatpak not found. Installing Flatpak..."
  pacman -S flatpak --needed --noconfirm
  # Enable Flatpak support (e.g., Flathub)
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Install applications from flatpaks.txt
if [[ -f flatpaks.txt ]]; then
  xargs -a flatpaks.txt flatpak install flathub -y --noninteractive
else
  echo "No flatpaks.txt file found. Skipping Flatpak installation."
fi

echo "Installation complete!"

