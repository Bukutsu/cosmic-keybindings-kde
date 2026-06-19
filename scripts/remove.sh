#!/bin/bash
set -euo pipefail

if [ -f "$HOME/.config/kglobalshortcutsrc" ]; then
    echo "Checking for backups..."
    BACKUPS=$(ls -t "$HOME/.config/kglobalshortcutsrc.cosmic-backup."* 2>/dev/null || true)

    if [ -n "$BACKUPS" ]; then
        LATEST=$(echo "$BACKUPS" | head -1)
        echo "Restoring backup: $LATEST"
        cp "$LATEST" "$HOME/.config/kglobalshortcutsrc"
    else
        echo "No backup found. Reverting individual keys to defaults..."
        echo "You will need to re-apply KDE defaults via System Settings."
    fi

    echo "Restarting kglobalaccel..."
    systemctl --user restart plasma-kglobalacceld 2>/dev/null || {
        kquitapp6 kglobalaccel 2>/dev/null || true
        sleep 1
        kglobalaccel6 &>/dev/null &
        disown
    }

    echo "Done. Cosmic keybindings removed."
else
    echo "No kglobalshortcutsrc found. Nothing to do."
fi
