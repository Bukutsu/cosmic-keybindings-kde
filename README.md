# Cosmic Keybindings for KDE Plasma 6

Faithful port of [COSMIC desktop](https://system76.com/cosmic) keyboard shortcuts to KDE Plasma 6.

## Installation

### Recommended: Run script (CLI)

```bash
chmod +x scripts/apply.sh
./scripts/apply.sh
```

Backs up existing config and detects your default browser automatically.

### Alternative: Import scheme (GUI)

1. Download `scheme/cosmic.kksrc`
2. Open **System Settings → Keyboard → Shortcuts**
3. Click **Manage Schemes → Import Scheme...**
4. Select the file and apply

**Known limitation:** KDE's scheme import is buggy for application launcher shortcuts (Konsole, Dolphin, browser). Use the script above for full coverage.

Do not copy `scheme/cosmic.kksrc` directly to `~/.config/kglobalshortcutsrc`; KDE import schemes and the live shortcut config use different formats. For headless installs, use `scripts/apply.sh`.

### Remove

```bash
./scripts/remove.sh
```

Restores from backup if available.

## Mapping

### Window focus (vim-style)
| Shortcut | Action |
|---|---|
| `Meta+H` / `Meta+Left` | Focus window left |
| `Meta+J` / `Meta+Down` | Focus window down |
| `Meta+K` / `Meta+Up` | Focus window up |
| `Meta+L` / `Meta+Right` | Focus window right |

### Move window in direction
| Shortcut | Action |
|---|---|
| `Meta+Shift+H` / `Meta+Shift+Left` | Move window left |
| `Meta+Shift+J` / `Meta+Shift+Down` | Move window down |
| `Meta+Shift+K` / `Meta+Shift+Up` | Move window up |
| `Meta+Shift+L` / `Meta+Shift+Right` | Move window right |

### Workspaces
| Shortcut | Action |
|---|---|
| `Meta+1` through `Meta+9` | Switch to workspace 1-9 |
| `Meta+Shift+1` through `Meta+Shift+9` | Move window to workspace 1-9 |
| `Meta+Ctrl+H` / `Meta+Ctrl+Left` | Previous workspace |
| `Meta+Ctrl+L` / `Meta+Ctrl+Right` | Next workspace |
| `Meta+Ctrl+J` / `Meta+Ctrl+Down` | Next workspace |
| `Meta+Ctrl+K` / `Meta+Ctrl+Up` | Previous workspace |
| `Meta+Ctrl+Shift+H/Left` | Move window to previous workspace |
| `Meta+Ctrl+Shift+L/Right` | Move window to next workspace |
| `Meta+Ctrl+Shift+J/Down` | Move window to next workspace |
| `Meta+Ctrl+Shift+K/Up` | Move window to previous workspace |

### Displays
| Shortcut | Action |
|---|---|
| `Meta+Alt+H` / `Meta+Alt+Left` | Switch to display left |
| `Meta+Alt+J` / `Meta+Alt+Down` | Switch to display below |
| `Meta+Alt+K` / `Meta+Alt+Up` | Switch to display above |
| `Meta+Alt+L` / `Meta+Alt+Right` | Switch to display right |
| `Meta+Shift+Alt+H` / `Meta+Shift+Alt+Left` | Move window to display left |
| `Meta+Shift+Alt+J` / `Meta+Shift+Alt+Down` | Move window to display below |
| `Meta+Shift+Alt+K` / `Meta+Shift+Alt+Up` | Move window to display above |
| `Meta+Shift+Alt+L` / `Meta+Shift+Alt+Right` | Move window to display right |

### Window operations
| Shortcut | Action |
|---|---|
| `Meta+Q` | Close window |
| `Meta+M` | Maximize window |
| `Meta+F11` | Fullscreen window |
| `Meta+R` | Resize window |
| `Meta+Alt+Escape` | Kill window |
| `Alt+Tab` / `Meta+Tab` | Switch window |
| `Alt+Shift+Tab` / `Meta+Shift+Tab` | Switch window backward |
| `Meta+=` / `Meta++` / `Meta+.` | Zoom in |
| `Meta+-` / `Meta+,` | Zoom out |

### System
| Shortcut | Action |
|---|---|
| `Meta+Escape` | Lock screen |
| `Meta+Shift+Escape` | Log out |
| `Meta+Space` | Switch input source / keyboard layout |
| `Meta+A` | Application Launcher |
| `Meta+W` | Toggle Overview |
| `Meta+F` | File manager (Dolphin) |
| `Meta+T` | Terminal (Konsole) |
| `Meta+B` | Web browser (default) |
| `Meta+Alt+S` | Toggle screen reader |
| `Meta` (tap) | KRunner |
| `Meta+/` | KRunner |
| `Print` | Screenshot (KDE default) |
| `Volume Up/Down/Mute` | Audio volume controls |
| `Microphone Mute` | Toggle microphone mute |
| `Media Play/Previous/Next` | Media playback controls |
| `Monitor Brightness Up/Down` | Display brightness controls |
| `Power Off` | Power off action |
| `Touchpad Toggle` / `Meta+Ctrl+Touchpad Toggle` | Toggle touchpad |

## Unmapped (no KDE equivalent)

These Cosmic shortcuts have no direct KDE equivalent and are omitted:

- `Super+y` — Toggle tiling (KDE lacks dynamic tiling)
- `Super+o` — Toggle orientation
- `Super+s` — Toggle stacking
- `Super+g` — Toggle window floating
- `Super+x` — Swap window in tiling tree
- `Super+u` / `Super+i` — Focus in/out of tiling tree
- `Super+0` — Last workspace
- `Super+Shift+0` — Move window to last workspace
- `Super+Shift+r` — Resize window inward
- KDE Quick Tile actions — COSMIC does not bind quick tiling; `Super+Arrow` is focus navigation

## License

MIT
