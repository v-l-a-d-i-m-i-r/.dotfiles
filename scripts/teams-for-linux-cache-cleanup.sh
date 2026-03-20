#!/bin/bash
# Clear Electron/Chromium cache
pkill -f "teams-for-linux"
rm -rf ~/.config/teams-for-linux/Cache/*
rm -rf ~/.config/teams-for-linux/Partitions/teams-4-linux/Cache/*
rm -rf ~/.config/teams-for-linux/Partitions/teams-4-linux/IndexedDB/*
rm -rf ~/.config/teams-for-linux/Partitions/teams-4-linux/WebStorage/*
# Remove problematic token files
rm -f ~/.config/teams-for-linux/DIPS-wal
rm -f ~/.config/teams-for-linux/SharedStorage-wal
rm -f ~/.config/teams-for-linux/Cookies-journal
