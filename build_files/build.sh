#!/bin/bash

# KDE Plasma Removal Script & Build script for Bazzite-Minimal - Created by tj5miniop
set -ouex pipefail

# Start by removing KDE plasma Desktop
echo "BUILD STAGE 1 -- Removing KDE Plasma Desktop..."
dnf5 -y group remove "KDE Plasma Desktop"

echo "BUILD STAGE -- Removing KDE-related packages and dependencies..."
dnf5 -y remove kf5-* kf6-* plasma-* plasma-login-manager breeze-*
dnf5 -y autoremove

# Clean up configuration files
echo "--> Cleaning up global KDE configurations..."
rm -rf /usr/share/KDE/

# Install Network Manager (just in case KDE uninstallation has wiped it)
dnf5 -y install NetworkManager

# install minimal COSMIC Desktop environment
echo "BUILD STAGE 3 -- Desktop Configuration..."
dnf5 -y install cosmic-session cosmic-applets cosmic-bg cosmic-comp cosmic-idle cosmic-launcher \
cosmic-notifications cosmic-osd cosmic-panel cosmic-workspaces cosmic-icon-theme \
cosmic-settings-daemon xdg-desktop-portal-cosmic cosmic-initial-setup

# Install Global Configuration for COSMIC
cp -r /ctx/system-files/* /

# enable LY 
dnf5 -y install ly
systemctl enable ly@tty1.service
