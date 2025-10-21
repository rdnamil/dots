# post install
sudo systemctl enable bluetooth.service
mkdir -p ~/.config
mv -bf config/* ~/.config/
mkdir -p ~/.local
mv -bf local/* ~/.local/

# basic DE stuff
yay -S --needed --noconfirm \
niri xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring polkit-gnome xwayland-satellite xorg-xhost \
zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting \
ttf-jetbrains-mono-nerd libappindicator-gtk3 \
fuzzel ghostty kate brave-bin swww waypaper mission-center ristretto libreoffice-fresh obsidian qbittorrent piper obs-studio obs-vkcapture lib32-obs-vkcapture gparted gimp inkscape krita baobab bat cava ddcutil fastfetch haruna kdenlive networkmanager-dmenu-git swayidle hyprlock eza openrgb
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
git clone git@github.com:rdnamil/quickshell.git

# themeing
yay -S --needed --noconfirm nwg-look gtk-engine-murrine qt5ct-kde qt6ct-kde frameworkintegration frameworkintegration darkly plymouth plymouth-theme-bgrt-no-watermark
sudo plymouth-set-default-theme -R bgrt-no-watermark
sudo mv -bf grub /etc/default/grub
mkdir -p ~/.local/share/themes
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git catppuccin-theme
catppuccin-theme/themes/install.sh -l -d ~/.local/share/themes -c dark -t blue --tweaks macchiato
wget -qO- https://raw.githubusercontent.com/Bonandry/adwaita-plus/master/install.sh | sh

# gaming stuff
yay -S --needed --noconfirm gamescope gamemode lib32-gamemode mangohud lib32-mangohud game-devices-udev lutris steam steamcmd
sudo usermod -aG gamemode $USER

# drivers
nvidia-inst -po --no-dkms

# virt-manager
yay -S --needed --noconfirm qemu-desktop libvirt virt-manager swtpm
sudo usermod -aG libvirt $USER
sudo systemctl enable libvirtd.service

# timeshift
yay -S --needed --noconfirm timeshift timeshift-autosnap grub-btrfs
sudo mv -bf grub-btrfsd /etc/systemd/system/grub-btrfsd.service
sudo systemctl enable --now grub-btrfsd cronie.service

# cleanup
sudo grub-mkconfig -o /boot/grub/grub.cfg
cd ../
rm -rf dots
