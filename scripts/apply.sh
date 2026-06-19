#!/bin/bash
set -euo pipefail

CONFIG="$HOME/.config/kglobalshortcutsrc"
BACKUP="$CONFIG.cosmic-backup.$(date +%s)"

echo "Backing up current shortcuts to $BACKUP"
cp "$CONFIG" "$BACKUP"

t=$'\t'

apply_kwin() {
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "$1" "$2"
}

apply_ksmserver() {
    kwriteconfig6 --file kglobalshortcutsrc --group ksmserver --key "$1" "$2"
}

apply_plasmashell() {
    kwriteconfig6 --file kglobalshortcutsrc --group plasmashell --key "$1" "$2"
}

apply_service() {
    kwriteconfig6 --file kglobalshortcutsrc --group services --group "$1" --key _launch "$2"
}

echo "Setting KWin shortcuts..."

# Focus navigation (vim keys + arrows, keep KDE defaults)
apply_kwin "Switch Window Left" "Meta+H${t}Meta+Left${t}Meta+Alt+Left,Meta+Alt+Left,Switch to Window to the Left"
apply_kwin "Switch Window Down" "Meta+J${t}Meta+Down${t}Meta+Alt+Down,Meta+Alt+Down,Switch to Window Below"
apply_kwin "Switch Window Up" "Meta+K${t}Meta+Up${t}Meta+Alt+Up,Meta+Alt+Up,Switch to Window Above"
apply_kwin "Switch Window Right" "Meta+L${t}Meta+Right${t}Meta+Alt+Right,Meta+Alt+Right,Switch to Window to the Right"

# Window Pack (move window in direction)
apply_kwin "Window Pack Left" "Meta+Shift+H${t}Meta+Shift+Left,none,Move Window Left"
apply_kwin "Window Pack Down" "Meta+Shift+J${t}Meta+Shift+Down,none,Move Window Down"
apply_kwin "Window Pack Up" "Meta+Shift+K${t}Meta+Shift+Up,none,Move Window Up"
apply_kwin "Window Pack Right" "Meta+Shift+L${t}Meta+Shift+Right,none,Move Window Right"

# Clear Quick Tile arrows (conflicts with focus)
apply_kwin "Window Quick Tile Left" "none,none,Quick Tile Window to the Left"
apply_kwin "Window Quick Tile Right" "none,none,Quick Tile Window to the Right"
apply_kwin "Window Quick Tile Top" "none,none,Quick Tile Window to the Top"
apply_kwin "Window Quick Tile Bottom" "none,none,Quick Tile Window to the Bottom"

# Workspace switching
for i in 1 2 3 4; do
    apply_kwin "Switch to Desktop $i" "Meta+$i${t}Ctrl+F$i${t}Meta+F$i,Ctrl+F$i${t}Meta+F$i,Switch to Desktop $i"
done
for i in 5 6 7 8 9; do
    apply_kwin "Switch to Desktop $i" "Meta+$i,none,Switch to Desktop $i"
done

# Move window to workspace
for i in $(seq 1 9); do
    apply_kwin "Window to Desktop $i" "Meta+Shift+$i,none,Window to Desktop $i"
done

# Adjacent workspace (prev/next)
apply_kwin "Switch One Desktop to the Left" "Meta+Ctrl+H${t}Meta+Ctrl+Left,Meta+Ctrl+Left,Switch One Desktop to the Left"
apply_kwin "Switch One Desktop Down" "Meta+Ctrl+J${t}Meta+Ctrl+Down,Meta+Ctrl+Down,Switch One Desktop Down"
apply_kwin "Switch One Desktop Up" "Meta+Ctrl+K${t}Meta+Ctrl+Up,Meta+Ctrl+Up,Switch One Desktop Up"
apply_kwin "Switch One Desktop to the Right" "Meta+Ctrl+L${t}Meta+Ctrl+Right,Meta+Ctrl+Right,Switch One Desktop to the Right"

# Move window to adjacent workspace
apply_kwin "Window One Desktop to the Left" "Meta+Ctrl+Shift+H${t}Meta+Ctrl+Shift+Left,Meta+Ctrl+Shift+Left,Window One Desktop to the Left"
apply_kwin "Window One Desktop Down" "Meta+Ctrl+Shift+J${t}Meta+Ctrl+Shift+Down,Meta+Ctrl+Shift+Down,Window One Desktop Down"
apply_kwin "Window One Desktop Up" "Meta+Ctrl+Shift+K${t}Meta+Ctrl+Shift+Up,Meta+Ctrl+Shift+Up,Window One Desktop Up"
apply_kwin "Window One Desktop to the Right" "Meta+Ctrl+Shift+L${t}Meta+Ctrl+Shift+Right,Meta+Ctrl+Shift+Right,Window One Desktop to the Right"

# Window operations
apply_kwin "Window Close" "Meta+Q${t}Alt+F4,Alt+F4,Close Window"
apply_kwin "Window Maximize" "Meta+M${t}Meta+PgUp,Meta+PgUp,Maximize Window"
apply_kwin "Window Fullscreen" "Meta+F11,none,Make Window Fullscreen"
apply_kwin "Window Resize" "Meta+R,none,Resize Window"
apply_kwin "Kill Window" "Meta+Alt+Esc${t}Meta+Ctrl+Esc,Meta+Ctrl+Esc,Kill Window"

# Overview
apply_kwin "Overview" "Meta+W,Meta+W,Toggle Overview"

# Input source
apply_kwin "Switch to Next Keyboard Layout" "Meta+Space,none,Switch to Next Keyboard Layout"

echo "Setting session shortcuts..."
apply_ksmserver "Lock Session" "Meta+Esc${t}Screensaver${t}Meta+L,Screensaver${t}Meta+L,Lock Session"
apply_ksmserver "Log Out" "Meta+Shift+Esc${t}Ctrl+Alt+Del,Ctrl+Alt+Del,Show Logout Screen"

echo "Setting Plasma shell shortcuts..."
apply_plasmashell "activate application launcher" "Meta+A${t}Meta${t}Alt+F1,Meta${t}Alt+F1,Activate Application Launcher"

# Clear task manager Meta+1-9 bindings
for i in $(seq 1 9); do
    apply_plasmashell "activate task manager entry $i" "none,Meta+$i,Activate Task Manager Entry $i"
done

echo "Setting application launcher shortcuts..."
apply_service "org.kde.konsole.desktop" "Meta+T"
apply_service "org.kde.dolphin.desktop" "Meta+F"

BROWSER=$(xdg-settings get default-web-browser 2>/dev/null || echo "org.kde.firefox.desktop")
echo "Detected default browser: $BROWSER"
apply_service "$BROWSER" "Meta+B"

echo "Restarting kglobalaccel..."
systemctl --user restart plasma-kglobalacceld 2>/dev/null || {
    kquitapp6 kglobalaccel 2>/dev/null || true
    sleep 1
    kglobalaccel6 &>/dev/null &
    disown
}

echo "Done. Backup saved: $BACKUP"
