# Titonium Hyprland Dotfiles & Configuration Guide

Comprehensive restoration guide, post-installation bootstrap, and configuration mapping for Arch Linux + Hyprland + Titonium Desktop.

---

## 1. Connect to Wi-Fi via Terminal

When first booting into a fresh install or TTY environment:

```bash
# 1. Scan available Wi-Fi networks
nmcli dev wifi list

# 2. Connect to your Wi-Fi network
nmcli dev wifi connect "YOUR_SSID" password "YOUR_PASSWORD"

# 3. Verify connectivity
nmcli general status
# or
ping -c 3 archlinux.org
```

---

## 2. Enable Chaotic-AUR (Pre-built Binaries Repository)

**Chaotic-AUR** provides pre-compiled binaries for AUR packages, allowing instant installations without compiling from source.

### Enable Chaotic-AUR in one step:

```bash
# 1. Receive Chaotic primary key
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

# 2. Install Chaotic Keyring and Mirrorlist
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# 3. Append repository configuration to /etc/pacman.conf
sudo tee -a /etc/pacman.conf << 'EOF'

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF

# 4. Refresh package databases
sudo pacman -Syu --noconfirm
```

### Key packages to install directly from Chaotic-AUR:
* **`yay`**: Install pre-compiled `yay` binary in seconds (`sudo pacman -S yay`).
* **`google-chrome`**: Official Google Chrome browser binary (`sudo pacman -S google-chrome`).

---

## 3. Configuration Map

Cross-reference table between repository backup files (`config/`, `home/`, `assets/`) and target system paths (`$HOME`):

### 🌟 Desktop Environment & Window Management

| Component | Repository Path | Target Path (`$HOME`) | Description |
| :--- | :--- | :--- | :--- |
| **Hyprland** | `config/hypr/hyprland.lua` | `~/.config/hypr/hyprland.lua` | Keybindings, monitors, animations, window rules, autostart |
| **Hypridle** | `config/hypr/hypridle.conf` | `~/.config/hypr/hypridle.conf` | Power management: 5m DPMS off, 15m system suspend |
| **Hyprlock** | `config/hypr/hyprlock.conf` | `~/.config/hypr/hyprlock.conf` | Lock screen aesthetics, blur passes, clock, auth input |
| **Hyprpaper** | `config/hypr/hyprpaper.conf` | `~/.config/hypr/hyprpaper.conf` | Multi-monitor wallpaper preloading and assignment |
| **Scripts** | `config/hypr/scripts/` | `~/.config/hypr/scripts/` | Helper scripts (`screenshot.sh`, `screenrecord.sh`) |
| **SwayNC** | `config/swaync/` | `~/.config/swaync/` | Notification daemon settings (`config.json`) and styling (`style.css`) |
| **Titonium Settings** | `config/titonium/settings.json` | `~/.config/titonium/settings.json` | Persistent user profile and desktop shell styling (theme, glass opacity, widgets, visualizer) |

---

### 💻 Terminal, Shell & CLI / TUI Tools

| Component | Repository Path | Target Path (`$HOME`) | Description |
| :--- | :--- | :--- | :--- |
| **Ghostty** | `config/ghostty/config` | `~/.config/ghostty/config` | Typography, background opacity, shaders, custom keybinds |
| **Kitty** | `config/kitty/kitty.conf` | `~/.config/kitty/kitty.conf` | Font settings, opacity, window padding, tab configuration |
| **Yazi** | `config/yazi/` | `~/.config/yazi/` | TUI file manager: UI/previews (`yazi.toml`), keymaps (`keymap.toml`) |
| **Zsh** | `home/.zshrc` | `~/.zshrc` | Interactive shell environment, aliases, PATH, plugins |

---

### 🎨 System Aesthetics, Input Method & Fonts

| Component | Repository Path | Target Path (`$HOME`) | Description |
| :--- | :--- | :--- | :--- |
| **Fcitx5** | `config/fcitx5/` | `~/.config/fcitx5/` | Vietnamese input method profile, engine configuration (`fcitx5-lotus`) |
| **GTK 3 & 4** | `config/gtk-3.0/`<br>`config/gtk-4.0/` | `~/.config/gtk-3.0/settings.ini`<br>`~/.config/gtk-4.0/settings.ini` | Dark theme preference, cursor theme, icon theme |
| **Fontconfig** | `config/fontconfig/fonts.conf` | `~/.config/fontconfig/fonts.conf` | System font priority mapping (Sans-serif, Serif, Monospace) |
| **Xsettingsd** | `config/xsettingsd/xsettingsd.conf` | `~/.config/xsettingsd/xsettingsd.conf` | GTK appearance synchronization for XWayland applications |
| **MIME Apps** | `config/mimeapps.list` | `~/.config/mimeapps.list` | Default file type handler associations |
| **Fonts** | `assets/fonts/` | `~/.local/share/fonts/` | Core fonts: `Apple Inc. Typeface` (SF Pro), `JetBrainsMono`, `Windows 11 UI Font`, `phosphor` |
| **Wallpapers** | `assets/wallpapers/` | `~/Pictures/Wallpapers/` | Desktop wallpaper collection managed by Hyprpaper |

---

### 📝 Code Editors & Tools

| Component | Repository Path | Target Path (`$HOME`) | Description |
| :--- | :--- | :--- | :--- |
| **Zed Editor** | `config/zed/settings.json` | `~/.config/zed/settings.json` | LSP configuration, editor fonts, autosave, format on save |
| **ChatGPT Desktop** | `config/chatgpt-flags.conf` | `~/.config/chatgpt-flags.conf` | Optimized Wayland startup flags for ChatGPT Desktop |

---

## 4. Quick Restoration Commands

After cloning this repository on a fresh installation:

```bash
# 1. Install base official packages
sudo pacman -S --needed hyprland hypridle hyprlock hyprpaper swaync ghostty kitty yazi zsh fastfetch fcitx5 fcitx5-gtk fcitx5-qt mpv wf-recorder grim slurp wl-clipboard

# 2. Install AUR / Chaotic packages
yay -S --needed fcitx5-lotus-bin google-chrome chatgpt-desktop zed quickshell-git

# 3. Refresh font cache after copying assets/fonts to ~/.local/share/fonts
fc-cache -fv ~/.local/share/fonts/
```
