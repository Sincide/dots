# Dotfiles

These dotfiles provide a modular configuration for a Hyprland-based setup on Arch Linux. Clone this repository into `~/dotfiles` and run `install.sh` to set everything up.

## Structure
- `hypr/` - Hyprland window manager configuration
- `waybar/` - Status bar configurations (top and bottom)
- `swww/` - Wallpaper daemon configuration
- `dunst/` - Notification daemon
- `rofi/` - Rofi launcher configuration
- `kitty/` - Kitty terminal configuration
- `fish/` - Fish shell configuration

Each subdirectory contains a small README explaining the module. All configuration files are intended to be symlinked into `~/.config`. For example:

```bash
ln -s ~/dotfiles/kitty ~/.config/kitty
```

See `install.sh` for an automated installer that also handles packages and system services.

## TODO
- Expand configs as the system grows
- Add more themes and scripts
