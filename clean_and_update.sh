#!/bin/bash

#Updating system via pacman
echo "Updating system with pacman..."
sudo pacman -Syu --noconfirm

# Updating AUR packages using yay
echo "Updating AUR packages with yay..."
yay -Syu --noconfirm

#Cleaning after updates
echo "Cleaning cached packages..."
sudo pacman -Scc --noconfirm
sudo yay -Sc --noconfirm

# Clean up temporary files and Cache
echo "Cleaning temporary files..."
sudo rm -rf /tmp/*
sudo systemd-tmpfiles --clean

# Clean up journalctl logs
echo "Cleaning journalctl logs..."
sudo journalctl --vacuum-time=7d --vacuum-size=100M


