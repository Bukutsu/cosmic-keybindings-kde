#!/bin/bash
set -e

# Directory to store reference files
REF_DIR="reference"
mkdir -p "$REF_DIR"

echo "Downloading latest Cosmic keybindings from GitHub..."
curl -s -o "$REF_DIR/cosmic_keybindings.ron" https://raw.githubusercontent.com/pop-os/cosmic-comp/master/data/keybindings.ron

echo "Downloading latest Krohnkite shortcuts from Codeberg..."
curl -s -o "$REF_DIR/krohnkite_shortcuts.qml" https://codeberg.org/anametologin/Krohnkite/raw/branch/master/res/shortcuts.qml

echo "Copying current system KGlobalShortcuts config..."
if [ -f "$HOME/.config/kglobalshortcutsrc" ]; then
    cp "$HOME/.config/kglobalshortcutsrc" "$REF_DIR/system_kglobalshortcutsrc"
else
    echo "Warning: ~/.config/kglobalshortcutsrc not found!"
fi

echo "Reference files updated successfully in $REF_DIR/:"
ls -lh "$REF_DIR"
