#!/bin/bash

################################################################################
# 403 - APT - ONE DRIVE ENABLE PER USER
################################################################################
#
# Job :     Enable OneDrive service and add extension for current user
#
# Author :  Armand CORBEAUX
# Date :    2023-11-08
#
# Impact :  user
#
# Inputs :  EXTENSION_URLS, EXTENSION_UUID
# Outputs : ~/.config/onedrive
#           ~/.local/share/gnome-shell/extensions
#
# More informations :
#           https://github.com/abraunegg/onedrive
#           https://github.com/diegstroyer/oneDrive
# Bugs :
#           This must be applied manually for each new user

EXTENSION_URLS=(
  "https://extensions.gnome.org/extension-data/onedrivediegomerida.com.v11.shell-extension.zip"
)

EXTENSION_UUID=(
  "onedrive@diegomerida.com"
)

# Add configuration to skip temporary files from sync
mkdir -p ~/.config/onedrive
echo "Remove a bunch of temporary files from sync with OneDrive client"
echo "skip_file = \"~*|.~*|*.tmp|*.swp|__*__|.venv|.vscode|log|logs\"" >> ~/.config/onedrive/config

# Enable OneDrive Service
systemctl --user enable onedrive

#Install OneDrive Gnome Desktop tray extension
for url in "${EXTENSION_URLS[@]}"; do
  gnome-extensions install "$url"
done

# enable extensions
for uuid in "${EXTENSION_UUID[@]}"; do
  gnome-extensions enable "$uuid"
done
