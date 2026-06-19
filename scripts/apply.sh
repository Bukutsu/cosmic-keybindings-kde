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

apply_kaccess() {
    kwriteconfig6 --file kglobalshortcutsrc --group kaccess --key "$1" "$2"
}

apply_krunner() {
    kwriteconfig6 --file kglobalshortcutsrc --group krunner --key "$1" "$2"
}

apply_keyboard_layout() {
    kwriteconfig6 --file kglobalshortcutsrc --group "KDE Keyboard Layout Switcher" --key "$1" "$2"
}

apply_kmix() {
    kwriteconfig6 --file kglobalshortcutsrc --group kmix --key "$1" "$2"
}

apply_mediacontrol() {
    kwriteconfig6 --file kglobalshortcutsrc --group mediacontrol --key "$1" "$2"
}

apply_powerdevil() {
    kwriteconfig6 --file kglobalshortcutsrc --group org_kde_powerdevil --key "$1" "$2"
}

apply_desktop_shortcut() {
    kwriteconfig6 --file kglobalshortcutsrc --group services --group "$1" --key "$2" "$3"
}

apply_service() {
    kwriteconfig6 --file kglobalshortcutsrc --group services --group "$1" --key _launch "$2"
}

echo "Setting KWin shortcuts..."

# Focus navigation (vim keys + arrows, keep KDE defaults)
apply_kwin "Switch Window Left" "Meta+H${t}Meta+Left,Meta+Alt+Left,Switch to Window to the Left"
apply_kwin "Switch Window Down" "Meta+J${t}Meta+Down,Meta+Alt+Down,Switch to Window Below"
apply_kwin "Switch Window Up" "Meta+K${t}Meta+Up,Meta+Alt+Up,Switch to Window Above"
apply_kwin "Switch Window Right" "Meta+L${t}Meta+Right,Meta+Alt+Right,Switch to Window to the Right"

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

# Switch output/display
apply_kwin "Switch to Screen to the Left" "Meta+Alt+H${t}Meta+Alt+Left,none,Switch to Screen to the Left"
apply_kwin "Switch to Screen Below" "Meta+Alt+J${t}Meta+Alt+Down,none,Switch to Screen Below"
apply_kwin "Switch to Screen Above" "Meta+Alt+K${t}Meta+Alt+Up,none,Switch to Screen Above"
apply_kwin "Switch to Screen to the Right" "Meta+Alt+L${t}Meta+Alt+Right,none,Switch to Screen to the Right"

# Move window to output/display
apply_kwin "Window One Screen to the Left" "Meta+Shift+Alt+H${t}Meta+Shift+Alt+Left,none,Move Window One Screen to the Left"
apply_kwin "Window One Screen Down" "Meta+Shift+Alt+J${t}Meta+Shift+Alt+Down,none,Move Window One Screen Down"
apply_kwin "Window One Screen Up" "Meta+Shift+Alt+K${t}Meta+Shift+Alt+Up,none,Move Window One Screen Up"
apply_kwin "Window One Screen to the Right" "Meta+Shift+Alt+L${t}Meta+Shift+Alt+Right,none,Move Window One Screen to the Right"

# Window operations
apply_kwin "Window Close" "Meta+Q${t}Alt+F4,Alt+F4,Close Window"
apply_kwin "Window Maximize" "Meta+M${t}Meta+PgUp,Meta+PgUp,Maximize Window"
apply_kwin "Window Fullscreen" "Meta+F11,none,Make Window Fullscreen"
apply_kwin "Window Resize" "Meta+R,none,Resize Window"
apply_kwin "Kill Window" "Meta+Alt+Esc${t}Meta+Ctrl+Esc,Meta+Ctrl+Esc,Kill Window"
apply_kwin "Edit Tiles" "none,none,Toggle Tiles Editor"
apply_kwin "Walk Through Windows" "Alt+Tab${t}Meta+Tab,Alt+Tab,Walk Through Windows"
apply_kwin "Walk Through Windows (Reverse)" "Alt+Shift+Tab${t}Meta+Shift+Tab,Alt+Shift+Tab,Walk Through Windows (Reverse)"

# Zoom
apply_kwin "view_zoom_in" "Meta+=${t}Meta++${t}Meta+.,Meta++${t}Meta+=,Zoom In"
apply_kwin "view_zoom_out" "Meta+-${t}Meta+\\,,Meta+-,Zoom Out"

# Overview
apply_kwin "Overview" "Meta+W,Meta+W,Toggle Overview"

# KDE's KWin action with this name is not the active Plasma 6 layout switcher.
apply_kwin "Switch to Next Keyboard Layout" "none,none,Switch to Next Keyboard Layout"

echo "Setting session shortcuts..."
apply_ksmserver "Lock Session" "Meta+Esc${t}Screensaver${t}Meta+L,Screensaver${t}Meta+L,Lock Session"
apply_ksmserver "Log Out" "Meta+Shift+Esc${t}Ctrl+Alt+Del,Ctrl+Alt+Del,Show Logout Screen"

echo "Setting accessibility shortcuts..."
apply_kaccess "Toggle Screen Reader On and Off" "Meta+Alt+S,Meta+Alt+S,Toggle Screen Reader On and Off"

echo "Setting KRunner shortcuts..."
apply_krunner "Run Command" "Meta${t}Meta+/${t}Alt+Space${t}Alt+F2,Alt+F2,Run Command"
apply_service "org.kde.krunner.desktop" "Meta${t}Search${t}Meta+/${t}Alt+Space${t}Alt+F2"

echo "Setting keyboard layout shortcuts..."
apply_keyboard_layout "Switch to Next Keyboard Layout" "Meta+Space,Meta+Alt+K,Switch to Next Keyboard Layout"
apply_keyboard_layout "Switch to Last-Used Keyboard Layout" "none,Meta+Alt+L,Switch to Last-Used Keyboard Layout"

echo "Setting hardware/media shortcuts..."
apply_kmix "increase_volume" "Volume Up,Volume Up,Increase Volume"
apply_kmix "decrease_volume" "Volume Down,Volume Down,Decrease Volume"
apply_kmix "mute" "Volume Mute,Volume Mute,Mute"
apply_kmix "mic_mute" "Microphone Mute,Microphone Mute,Mute Microphone"
apply_mediacontrol "playpausemedia" "Media Play,Media Play,Play/Pause media playback"
apply_mediacontrol "previousmedia" "Media Previous,Media Previous,Media playback previous"
apply_mediacontrol "nextmedia" "Media Next,Media Next,Media playback next"
apply_powerdevil "Increase Screen Brightness" "Monitor Brightness Up,Monitor Brightness Up,Increase Screen Brightness"
apply_powerdevil "Decrease Screen Brightness" "Monitor Brightness Down,Monitor Brightness Down,Decrease Screen Brightness"
apply_powerdevil "PowerOff" "Power Off,Power Off,Power Off"
apply_powerdevil "powerProfile" "none,none,Switch Power Profile"
apply_desktop_shortcut "org.kde.touchpadshortcuts.desktop" "ToggleTouchpad" "Touchpad Toggle${t}Meta+Ctrl+Touchpad Toggle,Touchpad Toggle${t}Meta+Ctrl+Touchpad Toggle,Enable Touchpad"

echo "Setting Plasma shell shortcuts..."
apply_plasmashell "activate application launcher" "Meta+A${t}Alt+F1,Meta${t}Alt+F1,Activate Application Launcher"

# Clear task manager Meta+1-9 bindings (both current and default)
for i in $(seq 1 9); do
    apply_plasmashell "activate task manager entry $i" "none,none,Activate Task Manager Entry $i"
done

echo "Setting application launcher shortcuts..."
apply_service "org.kde.konsole.desktop" "Meta+T"
apply_service "org.kde.dolphin.desktop" "Meta+F"

BROWSER=$(xdg-settings get default-web-browser 2>/dev/null || true)
if [ -z "$BROWSER" ]; then
    BROWSER="org.kde.firefox.desktop"
fi
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
