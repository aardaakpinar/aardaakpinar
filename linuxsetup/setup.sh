#!/bin/bash
set -e

echo "==> Arch i3 otomatik kurulum başlıyor..."

# --------------------------------------------------
# SUDO KONTROL
# --------------------------------------------------
if ! command -v sudo >/dev/null; then
  echo "sudo bulunamadı."
  exit 1
fi

# --------------------------------------------------
# PACMAN GÜNCELLEME
# --------------------------------------------------
sudo pacman -Syu --noconfirm

# --------------------------------------------------
# TEMEL PAKETLER
# --------------------------------------------------
sudo pacman -S --noconfirm \
  xorg xorg-xrandr \
  ly feh kitty polybar ranger rofi \
  gimp libreoffice-still flameshot \
  fastfetch git base-devel

# --------------------------------------------------
# YAY KURULUMU
# --------------------------------------------------
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd "$HOME"
rm -rf /tmp/yay

# --------------------------------------------------
# LY
# --------------------------------------------------
sudo systemctl disable lightdm.service || true
sudo systemctl enable ly@tty2.service

# --------------------------------------------------
# FASTFETCH AUTOSTART (BASH)
# --------------------------------------------------
touch "$HOME/.bashrc"
grep -q fastfetch "$HOME/.bashrc" || echo "fastfetch" >> "$HOME/.bashrc"

# --------------------------------------------------
# CONFIG DOSYALARI
# --------------------------------------------------
cp -r "$HOME/linux/wallpapers" "$HOME/"

mkdir -p "$HOME/.config/i3"
cp "$HOME/linux/config/i3/config" "$HOME/.config/i3/config"

mkdir -p "$HOME/.config/polybar"
cp "$HOME/linux/config/polybar/config.ini" "$HOME/.config/polybar/"

mkdir -p "$HOME/.config/rofi/themes"
cp "$HOME/linux/config/rofi/config.rasi" "$HOME/.config/rofi/"
cp "$HOME/linux/config/rofi/themes/darker-than-black_v1.rasi" \
   "$HOME/.config/rofi/themes/"

mkdir -p "$HOME/.config/kitty"
cp "$HOME/linux/config/kitty.conf" "$HOME/.config/kitty/"

# --------------------------------------------------
# BİTTİŞ MESAJI
# --------------------------------------------------
echo "======================================"
echo " Kurulum tamamlandı 🎉"
echo " Yeniden başlat."
echo "======================================"