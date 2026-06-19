# Cosmic Keybindings for KDE Plasma 6

Faithful port of [COSMIC desktop](https://system76.com/cosmic) keyboard shortcuts to KDE Plasma 6.

## Installation

### Option 1: Import scheme (GUI)

1. Download `scheme/cosmic.kksrc`
2. Open **System Settings → Keyboard → Shortcuts**
3. Click **Manage Schemes → Import Scheme...**
4. Select the file and apply

### Option 2: Manual import

Copy `scheme/cosmic.kksrc` directly into your KDE config:

```bash
cp scheme/cosmic.kksrc ~/.config/kglobalshortcutsrc
systemctl --user restart plasma-kglobalacceld
```

This replaces all your shortcuts. Back up first if needed:

```bash
cp ~/.config/kglobalshortcutsrc ~/.config/kglobalshortcutsrc.bak
```

### Option 3: Run script (CLI)

```bash
chmod +x scripts/apply.sh
./scripts/apply.sh
```

Backs up existing config and detects your default browser automatically.

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
| `Meta+Shift+Ctrl+H/Left` | Move window to previous workspace |
| `Meta+Shift+Ctrl+L/Right` | Move window to next workspace |
| `Meta+Shift+Ctrl+J/Down` | Move window to next workspace |
| `Meta+Shift+Ctrl+K/Up` | Move window to previous workspace |

### Window operations
| Shortcut | Action |
|---|---|
| `Meta+Q` | Close window |
| `Meta+M` | Maximize window |
| `Meta+F11` | Fullscreen window |
| `Meta+R` | Resize window |
| `Meta+Alt+Escape` | Kill window |

### System
| Shortcut | Action |
|---|---|
| `Meta+Escape` | Lock screen |
| `Meta+Shift+Escape` | Log out |
| `Meta+Space` | Switch keyboard layout |
| `Meta+A` | Application dashboard |
| `Meta+W` | Workspace overview |
| `Meta+F` | File manager (Dolphin) |
| `Meta+T` | Terminal (Konsole) |
| `Meta+B` | Web browser (default) |
| `Meta` (tap) | KRunner (KDE default) |
| `Meta+/` | KRunner (KDE default) |
| `Print` | Screenshot (KDE default) |

## Unmapped (no KDE equivalent)

These Cosmic shortcuts have no direct KDE equivalent and are omitted:

- `Super+y` — Toggle tiling (KDE lacks dynamic tiling)
- `Super+o` — Toggle orientation
- `Super+s` — Toggle stacking
- `Super+g` — Toggle window floating
- `Super+x` — Swap window in tiling tree
- `Super+u` / `Super+i` — Focus in/out of tiling tree
- `Super+0` — Last workspace
- `Super+Alt+{dir}` — Switch display/output

## License

MIT
