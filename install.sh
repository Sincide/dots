#!/bin/bash

REPO_DIR="$HOME/dotfiles"
LOGFILE="$REPO_DIR/ARCH-POSTINSTALL-LOG.md"

log() {
    echo -e "$(date '+%F %T') | $*" | tee -a "$LOGFILE"
}

require_repo() {
    if [[ "$PWD" != "$REPO_DIR" ]]; then
        log "Please run this script from $REPO_DIR"
        exit 1
    fi
}

check_yay() {
    if ! command -v yay &>/dev/null; then
        read -rp "yay-bin is not installed. Install it now? [y/N] " ans
        if [[ $ans =~ ^[Yy]$ ]]; then
            sudo pacman -S --needed yay-bin || log "Failed to install yay-bin"
        else
            log "yay-bin missing; some packages may not install"
        fi
    fi
}

install_packages() {
    read -rp "Install packages? [y/N] " ans
    [[ $ans =~ ^[Yy]$ ]] || return

    pkgs=(
        hyprland waybar swww dunst rofi-wayland kitty fish brave-bin ollama claude-code cursor-bin
        ttf-jetbrains-mono ttf-fira-code-nerd
        mesa vulkan-radeon libva-mesa-driver
    )

    for pkg in "${pkgs[@]}"; do
        if yay -Qi "$pkg" &>/dev/null; then
            log "$pkg already installed"
            continue
        fi
        log "Installing $pkg"
        if yay -S --noconfirm "$pkg" >>"$LOGFILE" 2>&1; then
            log "$pkg installed"
        else
            log "Failed to install $pkg"
        fi
    done
}

link_config() {
    local dir=$1
    local src="$REPO_DIR/$dir"
    local dest="$HOME/.config/$dir"

    if [[ -e $dest && ! -L $dest ]]; then
        read -rp "$dest exists. Back up and replace with symlink? [y/N] " ans
        if [[ $ans =~ ^[Yy]$ ]]; then
            mv "$dest" "${dest}.bak" && log "Backed up $dest"
        else
            log "Skipped linking $dest"
            return
        fi
    fi
    mkdir -p "$(dirname "$dest")"
    ln -sfn "$src" "$dest"
    log "Linked $src -> $dest"
}

link_configs() {
    read -rp "Symlink configuration directories? [y/N] " ans
    [[ $ans =~ ^[Yy]$ ]] || return
    for d in hypr waybar swww dunst rofi kitty fish; do
        link_config "$d"
    done
}

enable_services() {
    read -rp "Enable common services (pipewire bluetooth)? [y/N] " ans
    [[ $ans =~ ^[Yy]$ ]] || return
    services=(pipewire bluetooth)
    for svc in "${services[@]}"; do
        if systemctl --user &>/dev/null; then
            target="--user $svc.service"
        else
            target="$svc.service"
        fi
        if systemctl is-enabled $target &>/dev/null; then
            log "$svc already enabled"
        else
            if sudo systemctl enable --now $svc.service >>"$LOGFILE" 2>&1; then
                log "Enabled $svc"
            else
                log "Failed to enable $svc"
            fi
        fi
    done
}

set_fish_default() {
    if ! grep -q "/fish" <<<"$SHELL"; then
        read -rp "Set fish as default shell? [y/N] " ans
        if [[ $ans =~ ^[Yy]$ ]]; then
            chsh -s /usr/bin/fish && log "Default shell changed to fish" || log "Failed to change shell"
            log "A reboot is recommended to apply the shell change."
        fi
    fi
}

main() {
    require_repo
    touch "$LOGFILE"
    log "Starting install script"
    check_yay
    install_packages
    link_configs
    enable_services
    set_fish_default
    log "Install script finished"
}

main "$@"
