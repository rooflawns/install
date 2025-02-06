#!/bin/bash

# Ensure script runs with root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 
  exit 1
fi

# Update package database and install packages from the list
pacman -Syu --noconfirm
xargs -a packages.txt pacman -S --needed --noconfirm

