# Quickshell Arch Wayland Setup

> **Status**: Reference implementation for Arch Linux. Tailor to your hardware before daily use.

![topbar screenshot](assets/screens/topbar.png)
![bottom bar screenshot](assets/screens/bottombar.png)

## Features

- Dual bars (top + bottom) per monitor with automatic multi-monitor support.
- Works on **Hyprland** and **Niri**; runtime auto-detection via `scripts/wm-detect.sh`.
- Configuration panel overlay for on-the-fly tweaks.
- Notification panel backed by [swaync](https://github.com/ErikReider/SwayNotificationCenter).
- Rich system modules: CPU/GPU, RAM, disks, temps, fans, battery, network, VPN, audio, Bluetooth, media, microphone, brightness, keyboard layout, clipboard history, calendar/clock, systray, workspaces, active window title, launcher hooks, screenshots, lock/power menu, update checker.
- Systemd `--user` units and compositor snippets ensure reliable autostart.
- Symlink-friendly layout (GNU Stow). Chezmoi notes in [README](#chezmoi).
- JSON-based script ↔ QML communication for easy extension.

## Repository Layout

```text
REPO_ROOT/
├── install.sh          # idempotent installer
├── uninstall.sh        # safe cleanup
├── Makefile            # helper targets
├── scripts/            # shell helpers backing QML modules
├── systemd/user/       # user units for quickshell & swaync
├── .config/
│   ├── quickshell/     # QML, styles, panels
│   ├── hypr/           # Hyprland includes
│   └── niri/           # Niri KDL snippets
├── assets/             # icons and screenshots placeholders
└── fonts.txt           # font recommendations
```

## Prerequisites

- Arch Linux with a working Wayland environment
- [`yay`](https://github.com/Jguer/yay) AUR helper
- NetworkManager, PipeWire, BlueZ

## Installation

1. Clone the repo and enter it.
2. Review `fonts.txt` and install your preferred fonts.
3. Run the installer:
   ```bash
   make deps      # verifies required commands are available
   make install   # installs packages, stows configs, enables services
   ```
4. Log out/in or restart your compositor.

## Uninstall / Clean

```bash
make uninstall            # stop services and unstow
./uninstall.sh --remove   # additionally remove quickshell and swaync
```

## Autostart Options

- **systemd --user**: `quickshell.service` and `swaync.service`
- **Hyprland**: include `.config/hypr/includes/quickshell.conf`
- **Niri**: include `.config/niri/config.d/quickshell.kdl`

## Usage & Keybinds

| Action | Hyprland | Niri |
| ------ | -------- | ---- |
| Toggle notification panel | `$mod+N` | `Mod+N` |
| Toggle config panel | `$mod+C` | `Mod+C` |

Modules expose mouse actions:

- Scroll on audio/backlight to adjust volume/brightness.
- Left click audio to mute, middle click to open mixer.
- Left click updates to spawn `yay -Syu` in terminal.

## Customization

- Override theme colors in `.config/quickshell/styles/colors.json`.
- Adjust spacing/font tokens in `.config/quickshell/styles/tokens.qml`.
- Disable modules by editing the bar QML files and removing components.
- For Chezmoi users: replicate the directory structure under `~/.local/share/chezmoi` and manage with templates.

## Maintenance Workflow

```bash
git pull --rebase      # update repo
make link              # restow configs (or scripts/stow.sh)
```

Back up your `~/.config/quickshell` directory before large changes. To rollback, restore from git and restow.

## Troubleshooting

| Symptom | Probable Cause | Fix |
| ------- | -------------- | --- |
| Bar does not start | `quickshell` package missing | `yay -S quickshell` |
| No temperatures | `lm-sensors` not configured | Run `sudo sensors-detect` then `sensors` |
| Network module empty | NetworkManager not running | `systemctl enable --now NetworkManager` |
| Bluetooth icon off | `bluetoothctl` reports controller down | `sudo systemctl start bluetooth` |
| `niri msg` fails | Niri not running | ensure compositor is Niri |

## Performance Tuning

- Polling intervals are defined per module; adjust the `interval` property.
- Use `playerctl --follow` or DBus signals for event-driven updates (TODO).
- Cache heavy commands in `/tmp` if needed.

## Known Issues

- Systray support in Quickshell is experimental.
- Wayland security prevents global keylogging; clipboard history uses `wl-clipboard`.

## Security Notes

- All scripts run as the current user.
- Avoid running `install.sh` with `sudo`; it uses `yay` which elevates as needed.

## Chezmoi

While this repo uses GNU Stow, it can serve as a Chezmoi source. See the [Chezmoi docs](https://www.chezmoi.io/) for migration.

## License

[MIT](LICENSE)
