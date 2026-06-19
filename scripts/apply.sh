#!/bin/bash
set -euo pipefail

CONFIG="$HOME/.config/kglobalshortcutsrc"
BACKUP="$CONFIG.cosmic-backup.$(date +%s)"

echo "Backing up current shortcuts to $BACKUP"
cp "$CONFIG" "$BACKUP"

t=$'\t'

apply_kwin() {
    local key="$1"; shift
    local value="$1"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "$key" "$value"
}

apply_ksmserver() {
    local key="$1"; shift
    local value="$1"
    kwriteconfig6 --file kglobalshortcutsrc --group ksmserver --key "$key" "$value"
}

apply_plasmashell() {
    local key="$1"; shift
    local value="$1"
    kwriteconfig6 --file kglobalshortcutsrc --group plasmashell --key "$key" "$value"
}

apply_service() {
    local desktop="$1"; shift
    local value="$1"
    kwriteconfig6 --file kglobalshortcutsrc --group "services/$desktop" --key _launch "$value"
}

echo "Setting KWin shortcuts..."

# Focus navigation
apply_kwin "Switch to Window Left" "Meta+H${t}Meta+Left,none,Switch to Window Left"
apply_kwin "Switch to Window Down" "Meta+J${t}Meta+Down,none,Switch to Window Down"
apply_kwin "Switch to Window Up" "Meta+K${t}Meta+Up,none,Switch to Window Up"
apply_kwin "Switch to Window Right" "Meta+L${t}Meta+Right,none,Switch to Window Right"

# Move window in direction
apply_kwin "Window Pack Left" "Meta+Shift+H${t}Meta+Shift+Left,none,Window Pack Left"
apply_kwin "Window Pack Down" "Meta+Shift+J${t}Meta+Shift+Down,none,Window Pack Down"
apply_kwin "Window Pack Up" "Meta+Shift+K${t}Meta+Shift+Up,none,Window Pack Up"
apply_kwin "Window Pack Right" "Meta+Shift+L${t}Meta+Shift+Right,none,Window Pack Right"

# Workspace switching
for i in $(seq 1 9); do
    apply_kwin "Switch to Desktop $i" "Meta+$i,none,Switch to Desktop $i"
done

# Move window to workspace
for i in $(seq 1 9); do
    apply_kwin "Window to Desktop $i" "Meta+Shift+$i,none,Window to Desktop $i"
done

# Adjacent workspace navigation
apply_kwin "Switch One Desktop to the Left" "Meta+Ctrl+H${t}Meta+Ctrl+Left,none,Switch One Desktop to the Left"
apply_kwin "Switch One Desktop Down" "Meta+Ctrl+J${t}Meta+Ctrl+Down,none,Switch One Desktop Down"
apply_kwin "Switch One Desktop Up" "Meta+Ctrl+K${t}Meta+Ctrl+Up,none,Switch One Desktop Up"
apply_kwin "Switch One Desktop to the Right" "Meta+Ctrl+L${t}Meta+Ctrl+Right,none,Switch One Desktop to the Right"

# Move window to adjacent workspace
apply_kwin "Window One Desktop to the Left" "Meta+Shift+Ctrl+H${t}Meta+Shift+Ctrl+Left,none,Window One Desktop to the Left"
apply_kwin "Window One Desktop Down" "Meta+Shift+Ctrl+J${t}Meta+Shift+Ctrl+Down,none,Window One Desktop Down"
apply_kwin "Window One Desktop Up" "Meta+Shift+Ctrl+K${t}Meta+Shift+Ctrl+Up,none,Window One Desktop Up"
apply_kwin "Window One Desktop to the Right" "Meta+Shift+Ctrl+L${t}Meta+Shift+Ctrl+Right,none,Window One Desktop to the Right"

# Window operations
apply_kwin "Window Close" "Meta+Q,none,Window Close"
apply_kwin "Window Maximize" "Meta+M,none,Window Maximize"
apply_kwin "Window FullScreen" "Meta+F11,none,Window FullScreen"
apply_kwin "Window Resize" "Meta+R,none,Window Resize"
apply_kwin "Kill Window" "Meta+Alt+Escape,none,Kill Window"

# Overview
apply_kwin "Overview" "Meta+W,none,Toggle Overview"

# Input source switch
apply_kwin "Switch to Next Keyboard Layout" "Meta+Space,none,Switch to Next Keyboard Layout"

echo "Setting Plasma shell shortcuts..."
apply_plasmashell "show dashboard" "Meta+A,none,show dashboard"

# Clear Meta+1-9 task manager bindings
for i in $(seq 1 9); do
    apply_plasmashell "activate task manager entry $i" "none,none,Activate Task Manager Entry $i"
done

echo "Setting session shortcuts..."
apply_ksmserver "Lock Session" "Meta+Escape,none,Lock Session"
apply_ksmserver "Log Out" "Meta+Shift+Escape,none,Log Out"

echo "Setting application launcher shortcuts..."
apply_service "org.kde.konsole.desktop" "Meta+T,none,Open Terminal"
apply_service "org.kde.dolphin.desktop" "Meta+F,none,Open File Manager"

# Detect default browser
BROWSER=$(xdg-settings get default-web-browser 2>/dev/null || echo "org.kde.firefox.desktop")
echo "Detected default browser: $BROWSER"
apply_service "$BROWSER" "Meta+B,none,Open Web Browser"

echo "Restarting kglobalaccel to apply changes..."
systemctl --user restart plasma-kglobalacceld 2>/dev/null || {
    kquitapp6 kglobalaccel 2>/dev/null || true
    sleep 1
    kglobalaccel6 &>/dev/null &
    disown
}

echo "Done. Open System Settings > Keyboard > Shortcuts to verify."
echo "Backup saved: $BACKUP"
