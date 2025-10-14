# post install
sudo systemctl enable bluetooth.service
sudo systemctl enable cronie.service
mv -bf config/* ~/.config/
mv -bf local/* ~/.local/

# basic DE stuff
yay -S \
niri xdg-desktop-portal-gnome gnome-keyring xwayland-sattelite \
zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting \
fuzzel ghostty kate brave-bin swww waypaper mission-center ristretto libreoffice-fresh obsidian qbittorrent piper obs-studio obs-vkcapture lib32-obs-vkcapture gparted gimp kden-live inkscape krita baobab bat cava ddcutil fastfetch haruna kdenlive networkmanager-dmenu-git swayidle hyprlock ttf-jetbrains-mono-nerd unrar unzip exo
mv -bf zshrc ~/.zshrc
systemctl --user enable app-com.mitchellh.ghostty.service

# greeter
yay -S --needed --noconfirm greetd greetd-tuigreet
sudo mv -bf greetd.conf /etc/greetd/config.toml
sudo mv -bf greetd.pam /etc/pam.d/greetd
sudo systemctl enable greetd.service

# thunar
yay -S --needed --noconfirm thunar gvfs gvfs-mtp gvfs-smb sshfs thunar-archive-plugin ark thunar-media-tags-plugin thunar-shares-plugin thunar-volman tumbler ffmpegthumbnailer libgsf tumbler-extra-thumbnailers raw-thumbnailer webp-pixbuf-loader
export USERSHARES_DIR="/var/lib/samba/usershares"
export USERSHARES_GROUP="sambashare"
sudo mkdir -p ${USERSHARES_DIR}
sudo groupadd -r ${USERSHARES_GROUP}
sudo chown root:${USERSHARES_GROUP} ${USERSHARES_DIR}
sudo chmod 1770 ${USERSHARES_DIR}
sudo usermod -aG ${USERSHARES_GROUP} $USER
sudo mv -bf smb.conf /etc/samba/smb.conf
sudo systemctl enable smb.service nmb.service

# kanata
yay -S --needed --noconfirm kanata
sudo groupadd -r uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
sudo mv -bf 99-input.rules /etc/udev/rules.d/99-input.rules

# quickshell
yay -S --needed --noconfirm quickshell-git brightnessctl songrec
git clone https://github.com/rdnamil/quickshell ~/.config/quickshell

# themeing
yay -S --needed --noconfirm nwg-look gtk-engine-murrine qt5ct-kde qt6ct-kde darkly
mkdir -p ~/.local/share/themes
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git catppuccin-theme
catppuccin-theme/themes/install.sh -l -d ~/.local/share/themes -c dark -t blue --tweaks macchiato
mkdir -p ~/.local/share/icons
git clone https://github.com/Bonandry/adwaita-plus.git
mv -bf adwaita-plus/Adwaita++-Colorful adwaita-plus/Adwaita++-Dark-Colorful adwaita-plus/Adwaita++-Dark adwaita-plus/Adwaita++-Light ~/.local/share/icons

# gaming stuff
yay -S --needed --noconfirm gamescope gamemode lib32-gamemode mangohud lib32-mangohud game-devices-udev lutris steam steamcmd
usermod -aG gamemode $USER

# drivers
nvidia-inst -po --no-dkms

# timeshift
yay -S --needed --noconfirm timeshift timeshift-autosnap grub-btrfs
sudo mv -bf grub-btrfsd /etc/systemd/system/grub-btrfsd.service
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo systemctl enable --now grub-btrfsd

# cleanup
cd ../
rm -rf dots
