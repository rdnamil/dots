#!/bin/sh

# move to current directory if not already
cd "$(dirname "$0")" || exit

# post EndeavourOS install
	#enable bluetooth
sudo systemctl enable bluetooth.service
	# create folders
mkdir -p ~/.config
mkdir -p ~/.local
mkdir -p ~/Templates
	# move user folders
mv -bf config/* ~/.config
mv -bf local/* ~/.local
mv -bf templates/* ~/Templates
mv -bf zshrc ~/.zshrc
sudo mv -bf bin/* /usr/local/bin

# basic DE stuff
	# install 'niri' and basic pkgs
yay -S --needed --noconfirm \
niri xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring polkit-gnome xwayland-satellite xorg-xhost \
zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting \
ttf-jetbrains-mono-nerd libappindicator-gtk3 \
ghostty kate brave-bin swww waypaper mission-center ristretto libreoffice-fresh obsidian qbittorrent piper obs-studio obs-vkcapture lib32-obs-vkcapture partitionmanager gimp inkscape krita baobab bat ddcutil fastfetch haruna kdenlive networkmanager-dmenu-git swayidle hyprlock eza openrgb zoxide wl-clipboard wl-clip-persist inotify-tools playerctl sunsetr-bin oversteer new-lg4ff-dkms-git okular legcord

	# niri config
git clone https://github.com/rdnamil/niri ~/.config/niri

	# enable ghostty service
systemctl --user enable app-com.mitchellh.ghostty.service

# greeter
	# install 'greetd' and 'tuigreet'
yay -S --needed --noconfirm greetd greetd-tuigreet

	# move configs
sudo mv -bf greetd.conf /etc/greetd/config.toml
sudo mv -bf greetd.pam /etc/pam.d/greetd

	# enable greetd service
sudo systemctl enable greetd.service

# thunar
	#install thunar
yay -S --needed --noconfirm thunar

	# install plugins
yay -S --needed --noconfirm gvfs gvfs-mtp gvfs-smb sshfs thunar-archive-plugin ark thunar-media-tags-plugin thunar-shares-plugin thunar-volman tumbler ffmpegthumbnailer libgsf tumbler-extra-thumbnailers raw-thumbnailer webp-pixbuf-loader gnome-disk-utility

	# shares setup
		# install deps
yay -S --needed --noconfirm samba

		# setup usershares
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
	# install 'kanata'
yay -S --needed --noconfirm kanata

	# create and add user to 'input' and 'uinput' groups
sudo groupadd -r uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

# cava
	# downgrade deps
sudo downgrade --latest --prefer-cache --ignore never autoconf-archive=1:2021.02.19-4 autoconf=2.71-4 -- --noconfirm

	# install cava
yay -S --needed --noconfirm cava-git

# quickshell
	# install 'quickshell' and misc deps
yay -S --needed --noconfirm quickshell brightnessctl songrec

	# clone qs config
git clone https://github.com/rdnamil/quickshell.git ~/.config/quickshell

# themeing
	# install themeing tools and deps
yay -S --needed --noconfirm nwg-look gtk-engine-murrine qt5ct-kde qt6ct-kde frameworkintegration darkly plymouth plymouth-theme-bgrt-no-watermark

	# create themes folder
mkdir -p ~/.local/share/themes

	# clone catppuccin gtk theme
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git catppuccin-theme
catppuccin-theme/themes/install.sh -l -d ~/.local/share/themes -c dark -t blue --tweaks macchiato
		# overwite with custom gtk-dark.css
mkdir -p ~/.local/share/themes/Catppuccin-Blue-Dark-Macchiato/gtk-3.0
mv -bf gtk-dark.css ~/.local/share/themes/Catppuccin-Blue-Dark-Macchiato/gtk-3.0/gtk-dark.css

	# install 'adwaita++' and 'papirus' icon themes
wget -qO- https://raw.githubusercontent.com/Bonandry/adwaita-plus/master/install.sh | sh
wget -qO- https://git.io/papirus-icon-theme-install | sh

	# plymouth
		# set plymouth theme
sudo plymouth-set-default-theme -R bgrt-no-watermark

		# edit grub kernal parameters to show splash on boot
sudo sed -i -E "s|^( *GRUB_CMDLINE_LINUX_DEFAULT=)(['\"])(.*)(['\"])|\1\2\3 quiet splash\4|" /etc/default/grub

# gaming
	# install drivers
for arg in "$@"; do
	case "$arg" in
		--amd)
			yay -S --needed --noconfirm mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon
			;;
		--nvidia)
			nvidia-inst -po --no-dkms
			;;
		--intel)
			yay -S --needed --noconfirm mesa lib32-mesa vulkan-intel lib32-vulkan-intel
	esac

	yay -S --needed --noconfirm vulkan-tools
done

	# install gaming utils
yay -S --needed --noconfirm gamescope gamemode lib32-gamemode mangohud lib32-mangohud game-devices-udev  jre-openjdk protontricks

	# add user to 'gamemode' group
sudo usermod -aG gamemode $USER

	# install launchers
yay -S --needed --noconfirm lutris steam steamcmd prismlauncher heroic-games-launcher-bin

# virt-manager
	#install 'qemu' and deps
yay -S --needed --noconfirm qemu-desktop libvirt virt-manager swtpm

	# add user to 'libvirt' group
sudo usermod -aG libvirt $USER

	# enable libvirt daemon service
sudo systemctl enable libvirtd.service

# timeshift
	# install 'timeshift' and utils
yay -S --needed --noconfirm timeshift timeshift-autosnap grub-btrfs

	# create and enable grub-btrfs daemon service
sudo mv -bf grub-btrfsd /etc/systemd/system/grub-btrfsd.service
sudo systemctl enable --now grub-btrfsd cronie.service

# cleanup
	# update grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

	# change directory and remove 'dots' dir
cd ../
rm -rf dots

# restart
reboot
