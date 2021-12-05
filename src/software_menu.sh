#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_software_menu () {
	items=(
		"Remove_Snap" "Purge Snap store and software" "ON"
		"Install_APT_HTTPS" "Install APT HTTPS support" "ON"
		"Install_GNOME-Software" "Install GNOME software store" "ON"
		"Install_GNOME_Shell_Ext_Support" "Install GNOME shell extension support" "ON"
		"Install_GNOME_Ext_Installer" "Install GNOME extension installer" "ON"
		"Install_Discover_Store" "Install KDE Discover software store" "OFF"
		"Install_Curl" "Install cURL CLI tool" "ON"
		"Install_Edge_Browser" "Install Microsoft Edge Browser via custom PPA" "ON"
		"Install_FireFox" "Install FireFox Browser" "ON"
		"Install_Chrome" "Install Chrome Browser via DEB" "ON"
		"Install_VSCode" "Install Visual Studio Code via custom PPA" "ON"
		"Install_GDebi" "Install GDebi DEB unpacker" "ON"
		"Install_PPA_Purge" "Install PPA-Purge" "ON"
		"Install_WGet" "Install WGet CLI tool" "ON"
		"Install_SPC" "Install software-properties-common" "ON"
		"Install_Flatpak" "Enable Flatpak support" "ON"
		"Install_Blender" "Install Blender via Flatpak" "ON"
		"Install_Audacity" "Install Audacity via Flatpak" "ON"
		"Install_Bitwarden" "Install Bitwarden via Flatpak" "ON"
		"Install_Git" "Install GIT" "ON"
		"Install_Homebrew" "Enable Homebrew support" "ON"
		"install_GitHub_CLI" "Install GitHub CLI via Homebrew" "ON"
		"Install_DConf" "Install DConf editor" "ON"
		"Install_Tweaks" "Install GNOME Tweaks" "ON"
		"Install_UnZip" "Install UnZip" "ON"
		"Install_Build-Essential" "Install build-essential" "ON"
		"Install_Build_Depend" "Install common build dependencies" "ON"
		"Install_Meson" "Install Meson build system" "ON"
		"Install_CMake" "Install CMake make system" "ON"
		"Install_Ninja" "Install Ninja build system" "ON"
		"Install_Python3" "Install Python3 and Pip" "ON"
		"Install_NodeJS" "Install NodeJS via custom PPA" "ON"
		"Install_Vim" "Install Vim CLI text editor" "ON"
		"Install_Emacs" "Install Emacs CLI text editor" "ON"
		"Install_Foliate" "Install Foliate EBook reader via custom PPA" "ON"
		"Install_Kdenlive" "Install Kdenlive video editor via custom PPA" "ON"
		"Install_Handbrake" "Install Handbrake video trimmer" "ON"
		"Install_Krita" "Install Krita image editor via custom PPA" "ON"
		"Install_Inscape" "Install Inscape via custom PPA" "ON"
		"Install_Telegram" "Install Telegram messenger" "ON"
		"Install_Discord" "Install Discord messenger" "ON"
		"Install_Steam" "Install Steam game store" "ON"
		"Install_Heroic" "Install Heroic Epic Games launcher via DEB" "ON"
		"Install_Minigalaxy" "Install Minigalaxy GOG launcher via DEB" "ON"
		"Install_Lutris" "Install Lutris game manager via custom PPA" "ON"
		"Install_DOSBox" "Install DOSBox x86 emulator with DOS" "ON"
		"Install_Htop" "Install Htop system monitor" "ON"
		"Install_Nvtop" "Install Nvtop NVidia GPU monitor" "ON"
		"Install_Radeontop" "Install Radeontop Radeon GPU monitor" "ON"
		"Install_GameMode" "Install Game Mode" "ON"
		"Install_Mangohud" "Install Mangohud via custom PPA" "ON"
		"Install_vkBasalt" "Install vkBasalt via custom PPA" "OFF"
		"Install_GOverlay" "Install GOverlay via custom PPA" "ON"
		"Install_Flameshot" "Install Flameshot screenshot tool" "ON"
		"Install_Spotify" "Install Spotify music player via custom PPA" "ON"
		"Install_Audacious" "Install Audacious music player" "ON"
		"Install_Lollypop" "Install Lollypop music player" "ON"
		"Remove_Rhythmbox" "Remove Rhythmbox music player" "ON"
		"Install_VLC" "Install VLC media player" "ON"
		"Install_Kodi" "Install Kodi media player" "ON"
		"Install_OBS" "Install OBS Studio via custom PPA" "ON"
		"Install_OBS_NvFBC_Plugin" "Install OBS Studio NvFBC plugin for NVidia cards" "ON"
		"Install_Wine" "Install Wine and Winetricks" "ON"
		"Install_Protontricks" "Install Protontricks via PIP" "ON"
		"Install_GNOME_Boxes" "Install GNOME Boxes" "OFF"
		"Install_VirtualBox" "Install VirtualBox" "ON"
		"Install_IMWheel" "Install custom IMWheel version" "ON"
		"Remove_Thunderbird" "Remove Thunderbird" "ON"
		"Install_Geary" "Install Geary email client" "ON"
		"Remove_KDE_Connect" "Remove KDE Connect" "ON"
	)
	generate_selection_menu "Software Options" "${items[@]}"
}

function remove_snap () {
	killall GeckoMain
	sudo systemctl stop snapd.service
	echo -ne '\007' # Beep sound
	sudo systemctl disable snapd.service
	snap remove --purge snap-store
	sudo apt autoremove --purge snapd gnome-software-plugin-snap -y
	sudo apt remove snapd -y
	sudo apt purge snapd -y
	sudo apt-mark hold snapd
	sudo rm -rf /var/cache/snapd/
	sudo rm -rf ~/snap
}

function install_apt_https () {
	sudo apt install apt-transport-https -y
}

function install_python3 () {
	sudo apt install python3 -y
	sudo apt install python3-pip -y
	
	sudo python3 -m keyring --disable &> /dev/null
	python3 -m keyring --disable &> /dev/null
	
	pip install repolib
}

function install_nodejs () {
	if bin_exists "curl"; then
		curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
		sudo apt install -y nodejs
		return 0
	else
		LAST_ERROR="cURL is not installed, cannot download key"
		return 1
	fi
}

function install_git () {
	sudo apt install git -y
}

function install_meson () {
	sudo apt install meson -y
}

function install_cmake () {
	sudo apt install cmake -y
}

function install_ninja () {
	sudo apt install ninja-build -y
}

function install_gnome-software () {
	sudo apt install gnome-software -y
}

function install_gnome_shell_ext_support () {
	sudo apt install gnome-shell-extensions -y
}

function install_gnome_ext_installer () {
	if bin_exists "wget"; then
		sudo wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
		sudo chmod +x gnome-shell-extension-installer
		sudo mv gnome-shell-extension-installer /usr/bin/
		return 0
	else
		LAST_ERROR="WGet is not installed, cannot download package"
		return 1
	fi
}

function install_discover_store () {
	sudo apt-get install -y discover
}

function install_flatpak () {
	sudo apt install gnome-software-plugin-flatpak -y
	sudo apt install flatpak -y
	echo -ne '\007' # Beep sound
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

function install_blender () {
	if bin_exists "flatpak"; then
		flatpak install org.blender.Blender -y
		return 0
	else
		LAST_ERROR="Flatpak is not installed, cannot update Flatpak software"
		return 1
	fi
}

function install_audacity () {
	if bin_exists "flatpak"; then
		flatpak install org.audacityteam.Audacity -y
		return 0
	else
		LAST_ERROR="Flatpak is not installed, cannot update Flatpak software"
		return 1
	fi
}

function install_bitwarden () {
	if bin_exists "flatpak"; then
		flatpak install bitwarden -y
		return 0
	else
		LAST_ERROR="Flatpak is not installed, cannot update Flatpak software"
		return 1
	fi
}

function install_homebrew () {
	if bin_exists "curl"; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" <<< \n
		echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/$USER/.profile
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
		return 0
	else
		LAST_ERROR="cURL is not installed, cannot download installer"
		return 1
	fi
}

function install_github_cli () {
	brew install gh
}

function install_dconf () {
	sudo apt install dconf-editor -y
}

function install_tweaks () {
	sudo apt install gnome-tweaks -y
}

function install_unzip () {
	sudo apt-get install unzip -y
}

function install_gdebi () {
	# Core
	sudo apt install gdebi-core -y
	# And GUI
	sudo apt install gdebi -y
}

function install_ppa_purge () {
	sudo apt install ppa-purge -y
}

function install_curl () {
	sudo apt install curl -y
}

function install_wget () {
	sudo apt install wget -y
}

function install_build-essential () {
	sudo apt install build-essential -y
}

function install_build_depend () {
	sudo apt install -y \
	ffmpeg \
	g++ \
	sassc \
	libx11-xcb-dev \
	libavutil-dev \
	libavformat-dev \
	libavdevice-dev \
	libavcodec-dev \
	libavfilter-dev \
	libdrm-dev \
	libx11-dev \
	libxext-dev \
	libxrandr-dev \
	libxcursor-dev \
	libxi-dev \
	libxinerama-dev \
	libxss-dev \
	libgl-dev \
	libgl1-mesa-dev \
	libglu1-mesa-dev \
	libdbus-1-dev \
	libudev-dev \
	libaudio-dev \
	libasound2-dev \
	libfreetype6-dev \
	libxpm-dev \
	libxft-dev \
	libxxf86vm-dev \
	libpulse-dev \
	libopenal-dev \
	libwebkit2gtk-4.0-dev \
	libgtk-3-dev \
	libobs-dev \
	libsimde-dev \
	libxtst-dev \
	libxmu-dev
}

function install_spc () {
	sudo apt install software-properties-common -y
}

function install_vim () {
	sudo apt install vim -y
}

function install_emacs () {
	sudo apt install emacs -y
}

function install_foliate () {
	if add_ppa "ppa:apandada1/foliate"; then
		sudo apt install foliate -y
		return 0
	else
		return 1
	fi
}

function install_kdenlive () {
	if add_ppa "ppa:kdenlive/kdenlive-stable"; then
		sudo apt install kdenlive -y
		return 0
	else
		return 1
	fi
}

function install_handbrake () {
	sudo apt install handbrake -y
}

function install_krita () {
	if add_ppa "ppa:kritalime/ppa"; then
		sudo apt install krita -y
		return 0
	else
		return 1
	fi
}

function install_inscape () {
	if add_ppa "ppa:inkscape.dev/stable"; then
		sudo apt install inkscape -y
		return 0
	else
		return 1
	fi
}

function install_telegram () {
	sudo apt install telegram-desktop -y
}

function install_discord () {
	if bin_exists "wget"; then
		if bin_exists "gdebi"; then
			wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
			sudo gdebi ~/discord.deb -n
			sudo rm -rf ~/discord.deb
			return 0
		else
			LAST_ERROR="GDebi is not installed, cannot extract DEB package"
			return 1
		fi
		return 0
	else
		LAST_ERROR="WGet is not installed, cannot download DEB package"
		return 1
	fi
}

function install_steam () {
	sudo apt install steam -y
	
	# Check if a "Games" folder exists and add a Steam shortcut
	if [[ -d "$HOME/Games"  ]]; then
		ln -s "$HOME/.steam/debian-installation" "$HOME/Games/Steam"
	fi
}

function install_lutris () {
	if add_ppa "ppa:lutris-team/lutris"; then
		sudo apt install lutris -y
		return 0
	else
		return 1
	fi
}

function install_heroic () {
	if bin_exists "curl"; then
		if bin_exists "wget"; then
			if bin_exists "gdebi"; then
				
				echo "Downloading latest DEB..."
				curl -s https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest \
				| grep "browser_download_url.*deb" \
				| cut -d : -f 2,3 \
				| tr -d \" \
				| wget -O heroic.deb -qi -
				
				echo "Extracting DEB..."
				sudo gdebi heroic.deb -n
				sudo rm -rf heroic.deb
				
				if bin_exists "heroic"; then
					echo "Heroic installed successfully"
					return 0
				else
					LAST_ERROR="Heroic was not installed"
					return 1
				fi
			else
				LAST_ERROR="GDebi is not installed, cannot extract DEB package"
				return 1
			fi
			return 0
		else
			LAST_ERROR="WGet is not installed, cannot download DEB package"
			return 1
		fi
	else
		LAST_ERROR="cURL is not installed, cannot download DEB package"
		return 1
	fi
}

function install_minigalaxy () {
	if bin_exists "curl"; then
		if bin_exists "wget"; then
			if bin_exists "gdebi"; then
				
				echo "Downloading latest DEB..."
				curl -s https://api.github.com/repos/sharkwouter/minigalaxy/releases/latest \
				| grep "browser_download_url.*deb" \
				| cut -d : -f 2,3 \
				| tr -d \" \
				| wget -O minigalaxy.deb -qi -
				
				echo "Extracting DEB..."
				sudo gdebi minigalaxy.deb -n
				sudo rm -rf minigalaxy.deb
				
				if bin_exists "minigalaxy"; then
					echo "Minigalaxy installed successfully"
					return 0
				else
					LAST_ERROR="Minigalaxy was not installed"
					return 1
				fi
			else
				LAST_ERROR="GDebi is not installed, cannot extract DEB package"
				return 1
			fi
			return 0
		else
			LAST_ERROR="WGet is not installed, cannot download DEB package"
			return 1
		fi
	else
		LAST_ERROR="cURL is not installed, cannot download DEB package"
		return 1
	fi
}

function install_dosbox () {
	sudo apt install dosbox -y
}

function install_htop () {
	sudo apt install htop -y
}

function install_nvtop () {
	sudo apt install nvtop -y
}

function install_radeontop () {
	sudo apt install radeontop -y
}

function install_gamemode () {
	sudo apt install gamemode -y
}

function install_mangohud () {
	if add_ppa "ppa:flexiondotorg/mangohud"; then
		sudo apt install mangohud -y
		return 0
	else
		return 1
	fi
}

function install_vkbasalt () {
	if add_ppa "ppa:flexiondotorg/mangohud"; then
		sudo apt install vkbasalt -y
		return 0
	else
		return 1
	fi
}

function install_goverlay () {
	if add_ppa "ppa:flexiondotorg/mangohud"; then
		sudo apt install goverlay -y
		return 0
	else
		return 1
	fi
}

function install_flameshot () {
	sudo apt install flameshot -y
}

function install_spotify () {
	if bin_exists "curl"; then
		curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
		echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
		sudo apt update
		sudo apt install spotify-client -y
		return 0
	else
		LAST_ERROR="cURL is not installed, cannot download key"
		return 1
	fi
}

function install_audacious () {
	sudo apt install audacious -y
}

function install_lollypop () {
	sudo apt install lollypop -y
}

function remove_rhythmbox () {
	sudo apt remove rhythmbox -y
}

function install_vlc () {
	sudo apt install vlc -y
}

function install_kodi () {
	sudo apt install kodi -y
}

function install_obs () {
	if add_ppa "ppa:obsproject/obs-studio"; then
		sudo apt install obs-studio -y
		return 0
	else
		return 1
	fi
}

function install_obs_nvfbc_plugin () {
	if bin_exists "git"; then
		if bin_exists "meson"; then
			if bin_exists "ninja"; then
				git clone https://gitlab.com/fzwoch/obs-nvfbc.git ~/obs-nvfbc.git
				cd ~/obs-nvfbc.git
				meson build
				ninja -C build
				cd build
				mkdir -p ~/.config/obs-studio/plugins/nvfbc/bin/64bit
				mv nvfbc.so ~/.config/obs-studio/plugins/nvfbc/bin/64bit/
				cd ..
				sudo rm -rf ~/obs-nvfbc.git
				return 0
			else
				LAST_ERROR="Ninja is not installed, cannot build project"
				return 1
			fi
		else
			LAST_ERROR="Meson is not installed, cannot build project"
			return 1
		fi
	else
		LAST_ERROR="Git is not installed, cannot clone Git repo key"
		return 1
	fi
}

function install_edge_browser () {
	if bin_exists "curl"; then
		curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
		sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
		sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
		sudo rm -f microsoft.gpg
		sudo apt update
		sudo apt install microsoft-edge-stable -y
		
		# Attempt to make Edge less annoying
		mkdir -p "$HOME/.config/microsoft-edge"
		touch "$HOME/.config/microsoft-edge/First Run"
		
		# Look if Edge exists
		if bin_exists "microsoft-edge"; then
			echo "Microsoft Edge installed successfully"
			return 0
		else
			# One last try...
			if bin_exists "microsoft-edge-stable"; then
				echo "Microsoft Edge installed successfully"
				return 0
			else
				# Remove the repo to avoid errors
				sudo rm -f "/etc/apt/sources.list.d/microsoft-edge.list"
				
				LAST_ERROR="Microsoft Edge was not installed"
				return 1
			fi
		fi
	else
		LAST_ERROR="cURL is not installed, cannot download key"
		return 1
	fi
}

function install_firefox () {
	sudo apt install firefox -y
}

function install_chrome () {
	if bin_exists "wget"; then
		echo "Downloading latest DEB..."
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
		echo "Extracting DEB..."
		sudo dpkg -i google-chrome-stable_current_amd64.deb
		rm -f google-chrome-stable_current_amd64.deb
	else
		LAST_ERROR="WGet is not installed, cannot download DEB package"
		return 1
	fi
}

function install_vscode () {
	if bin_exists "curl"; then
		curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
		sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
		sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/code.list'
		sudo rm -rf microsoft.gpg
		sudo apt update
		sudo apt install code -y
		
		# Look if Code exists
		if bin_exists "code"; then
			echo "Visual Studio Code installed successfully"
			return 0
		else
			# Remove the repo to avoid errors
			sudo rm -f "/etc/apt/sources.list.d/code.list"
				
			LAST_ERROR="Visual Studio Code was not installed"
			return 1
		fi
	else
		LAST_ERROR="cURL is not installed, cannot download key"
		return 1
	fi
}

function install_wine () {
	sudo apt install --install-recommends wine -y
	sudo apt install winetricks -y
	# Make sure there's a desktop file created
	sudo cp /usr/share/doc/wine/examples/wine.desktop /usr/share/applications/wine.desktop
}

function install_protontricks () {
	if bin_exists "pip"; then
		pip install protontricks
		
		if bin_exists "protontricks"; then
			echo "Protontricks installed successfully"
			return 0
		else
			LAST_ERROR="Protontricks was not installed"
			return 1
		fi
	else
		LAST_ERROR="PIP is not installed, cannot download package"
		return 1
	fi
}

function install_gnome_boxes () {
	sudo apt install gnome-boxes -y
}

function install_virtualbox () {
	sudo apt install virtualbox -y
}

function install_imwheel () {
	if bin_exists "wget"; then
		if bin_exists "git"; then
			if bin_exists "make"; then
				git clone https://github.com/ajh3/imwheel-exclude-patched.git "$HOME/imwheel"
				cd "$HOME/imwheel"
				./configure
				make
				sudo cp imwheel /usr/local/bin/imwheel
				sudo mv imwheel /usr/bin/
				cd ..
				sudo rm -rf $HOME/imwheel
				
				if bin_exists "imwheel"; then
					echo "IMWheel installed successfully"
				else
					echo "IMWheel did not install successfully!"
					return 0
				fi
				
				return 0
			else
				LAST_ERROR="Make is not installed, cannot build project"
				return 1
			fi
		else
			LAST_ERROR="Git is not installed, cannot clone Git repo key"
			return 1
		fi
	else
		LAST_ERROR="WGet is not installed, cannot download package"
		return 1
	fi
}

function remove_thunderbird () {
	sudo apt remove thunderbird -y
}

function install_geary () {
	sudo apt install geary -y
}

function remove_kde_connect () {
	killall kdeconnectd
	sudo apt autoremove --purge kdeconnect -y
}