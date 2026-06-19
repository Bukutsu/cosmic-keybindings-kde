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
apply_kwin "Switch to Window Left" "META+H${t}META+Left,none,Switch to Window Left"
apply_kwin "Switch to Window Down" "META+J${t}META+Down,none,Switch to Window Down"
apply_kwin "Switch to Window Up" "META+K${t}META+Up,none,Switch to Window Up"
apply_kwin "Switch to Window Right" "META+L${t}META+Right,none,Switch to Window Right"

# Move window in direction
apply_kwin "Window Pack Left" "META+Shift+H${t}META+Shift+Left,none,Window Pack Left"
apply_kwin "Window Pack Down" "META+Shift+J${t}META+Shift+Down,none,Window Pack Down"
apply_kwin "Window Pack Up" "META+Shift+K${t}META+Shift+Up,none,Window Pack Up"
apply_kwin "Window Pack Right" "META+Shift+L${t}META+Shift+Right,none,Window Pack Right"

# Workspace switching
for i in $(seq 1 9); do
    apply_kwin "Switch to Desktop $i" "META+$i,none,Switch to Desktop $i"
done

# Move window to workspace
for i in $(seq 1 9); do
    apply_kwin "Window to Desktop $i" "META+Shift+$i,none,Window to Desktop $i"
done

# Adjacent workspace navigation
apply_kwin "Switch One Desktop to the Left" "META+Ctrl+H${t}META+Ctrl+Left,none,Switch One Desktop to the Left"
apply_kwin "Switch One Desktop Down" "META+Ctrl+J${t}META+Ctrl+Down,none,Switch One Desktop Down"
apply_kwin "Switch One Desktop Up" "META+Ctrl+K${t}META+Ctrl+Up,none,Switch One Desktop Up"
apply_kwin "Switch One Desktop to the Right" "META+Ctrl+L${t}META+Ctrl+Right,none,Switch One Desktop to the Right"

# Move window to adjacent workspace
apply_kwin "Window One Desktop to the Left" "META+Shift+Ctrl+H${t}META+Shift+Ctrl+Left,none,Window One Desktop to the Left"
apply_kwin "Window One Desktop Down" "META+Shift+Ctrl+J${t}META+Shift+Ctrl+Down,none,Window One Desktop Down"
apply_kwin "Window One Desktop Up" "META+Shift+Ctrl+K${t}META+Shift+Ctrl+Up,none,Window One Desktop Up"
apply_kwin "Window One Desktop to the Right" "META+Shift+Ctrl+L${t}META+Shift+Ctrl+Right,none,Window One Desktop to the Right"

# Window operations
apply_kwin "Window Close" "META+Q,none,Window Close"
apply_kwin "Window Maximize" "META+M,none,Window Maximize"
apply_kwin "Window FullScreen" "META+F11,none,Window FullScreen"
apply_kwin "Window Resize" "META+R,none,Window Resize"
apply_kwin "Kill Window" "META+Alt+Escape,none,Kill Window"

# Overview
apply_kwin "ShowDesktopGrid" "META+W,none,ShowDesktopGrid"

# Input source switch
apply_kwin "Switch to Next Keyboard Layout" "META+Space,none,Switch to Next Keyboard Layout"

echo "Setting Plasma shell shortcuts..."
apply_plasmashell "show dashboard" "META+A,none,show dashboard"

# Clear Meta+1-9 task manager bindings
for i in $(seq 1 9); do
    apply_plasmashell "activate task manager entry $i" "none,none,Activate Task Manager Entry $i"
done

echo "Setting session shortcuts..."
apply_ksmserver "Lock Session" "META+Escape,none,Lock Session"
apply_ksmserver "Log Out" "META+Shift+Escape,none,Log Out"

echo "Setting application launcher shortcuts..."
apply_service "org.kde.konsole.desktop" "META+T,none,Open Terminal"
apply_service "org.kde.dolphin.desktop" "META+F,none,Open File Manager"

# Detect default browser
BROWSER=$(xdg-settings get default-web-browser 2>/dev/null || echo "org.kde.firefox.desktop")
echo "Detected default browser: $BROWSER"
apply_service "$BROWSER" "META+B,none,Open Web Browser"

echo "Restarting kglobalaccel to apply changes..."
systemctl --user restart plasma-kglobalacceld 2>/dev/null || {
    kquitapp6 kglobalaccel 2>/dev/null || true
    sleep 1
    kglobalaccel6 &>/dev/null &
    disown
}

echo "Done. Open System Settings > Keyboard > Shortcuts to verify."
echo "Backup saved: $BACKUP"
