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
		"Install_AppImage_Launcher" "Install AppImage Launcher via custom PPA" "ON"
		"Install_PulseAudio_Volume_Control" "Install PulseAudio Volume Control" "ON"
		"Install_Remote_Desktop" "Install Remmina VNC and remote desktop" "ON"
		"Install_Curl" "Install cURL CLI tool" "ON"
		"Install_Edge_Browser" "Install Microsoft Edge Browser via custom PPA" "ON"
		"Install_FireFox" "Install FireFox Browser" "ON"
		"Install_Chrome" "Install Chrome Browser via DEB" "ON"
		"Install_VSCode" "Install Visual Studio Code via custom PPA" "ON"
		"Install_GDebi" "Install GDebi DEB unpacker" "ON"
		"Install_Innoextract" "Install Innoextract" "ON"
		"Install_PPA_Purge" "Install PPA-Purge" "ON"
		"Install_WGet" "Install WGet CLI tool" "ON"
		"Install_SPC" "Install Software-Properties-Common" "ON"
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
		"Install_BlitzMax_NG" "Install BlitzMax NG" "ON"
		"Install_Meson" "Install Meson build system" "ON"
		"Install_CMake" "Install CMake make system" "ON"
		"Install_Ninja" "Install Ninja build system" "ON"
		"Install_Python3" "Install Python and Pip" "ON"
		"Install_D_Lang" "Install D Language and the DMD compiler" "ON"
		"Install_NodeJS" "Install NodeJS via custom PPA" "ON"
		"Install_Sublime_4" "Install Sublime Text 4 via custom PPA" "ON"
		"Install_Sublime_4_Dev" "Install Sublime Text 4 Dev via custom PPA" "OFF"
		"Install_Vim" "Install Vim CLI text editor" "ON"
		"Install_Emacs" "Install Emacs CLI text editor" "OFF"
		"Install_Foliate" "Install Foliate EBook reader via custom PPA" "ON"
		"Install_Kdenlive" "Install Kdenlive video editor via custom PPA" "ON"
		"Install_Video_Trimmer" "Install Video Trimmer via Flatpak" "ON"
		"Install_Handbrake" "Install Handbrake video trimmer" "ON"
		"Install_Krita" "Install Krita image editor via custom PPA" "ON"
		"Install_Inscape" "Install Inscape via custom PPA" "ON"
		"Install_Telegram" "Install Telegram messenger" "ON"
		"Install_Discord" "Install Discord messenger" "ON"
		"Install_Htop" "Install Htop system monitor" "ON"
		"Install_Nvtop" "Install Nvtop NVidia GPU monitor" "ON"
		"Install_Radeontop" "Install Radeontop Radeon GPU monitor" "ON"
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
		"Install_EXE_Thumbnailer" "Install EXE Thumbnailer" "ON"
		"Install_GNOME_Boxes" "Install GNOME Boxes" "OFF"
		"Install_VirtualBox" "Install VirtualBox" "ON"
		"Install_IMWheel" "Install custom IMWheel version" "ON"
		"Install_System_Monitoring_Center" "Install System Monitoring Center" "ON"
		"Install_PINCE" "Install PINCE memory inspector" "OFF"
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
	
	#sudo apt install python -y
}

function install_d_lang () {
	if bin_exists "wget"; then
		mkdir -p "$HOME/dlang" && wget https://dlang.org/install.sh -O "$HOME/dlang/install.sh"
		chmod +x "$HOME/dlang/install.sh"
		$HOME/dlang/install.sh install dmd
		source $(~/dlang/install.sh dmd -a)
		return 0
	else
		LAST_ERROR="WGet is not installed, cannot download installer"
		return 1
	fi
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

function install_innoextract () {
	sudo apt install innoextract -y
}

function install_ppa_purge () {
	sudo apt install ppa-purge -y
}

function install_appimage_launcher () {
	sudo add-apt-repository ppa:appimagelauncher-team/stable -y
	sudo apt install appimagelauncher -y
}

function install_pulseaudio_volume_control () {
	sudo apt install pavucontrol -y
}

function install_remote_desktop () {
	sudo apt install xrdp -y
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
	libxtst-dev \
	libxmu-dev
	
	# This needs to be a separate step as it doesn't always exist
	sudo apt install -y libsimde-dev
}

function install_blitzmax_ng () {
	if bin_exists "curl"; then
		if bin_exists "wget"; then
			if bin_exists "unzip"; then
				
				echo "Downloading latest BlitzMax NG version..."
				curl -s https://api.github.com/repos/bmx-ng/bmx-ng/releases \
				| grep -m 1 "browser_download_url.*BlitzMax_linux_.*.tar.xz" \
				| cut -d : -f 2,3 \
				| tr -d \" \
				| wget -O blitzmax.tar.xz -qi -
				
				echo
				echo "Extracting archive..."
				tar -xvf blitzmax.tar.xz -C "$HOME/"
				sudo rm -rf blitzmax.tar.xz
				
				# Check if BlitzMax folder was properly extracted
				if [[ -d "$HOME/BlitzMax"  ]]; then
					mv "$HOME/BlitzMax" "$HOME/.bmxng"
				else
					LAST_ERROR="Unable to extract BlitzMax NG"
					return 1
				fi
				
				mkdir -p "$HOME/.local/bin"
				
				# Check if BlitzMax bcc exists
				if [[ -f "$HOME/.bmxng/bin/bcc"  ]]; then
					ln -s "$HOME/.bmxng/bin/bcc" "$HOME/.local/bin/bcc"
				else
					LAST_ERROR="Unable to find BlitzMax NG bcc binary"
					return 1
				fi
				
				# Check if BlitzMax bmk exists
				if [[ -f "$HOME/.bmxng/bin/bmk"  ]]; then
					ln -s "$HOME/.bmxng/bin/bmk" "$HOME/.local/bin/bmk"
				else
					LAST_ERROR="Unable to find BlitzMax NG bmk binary"
					return 1
				fi
				
				# Check if BlitzMax MaxIDE exists
				if [[ -f "$HOME/.bmxng/MaxIDE"  ]]; then
					ln -s "$HOME/.bmxng/MaxIDE" "$HOME/.local/bin/MaxIDE"
					ln -s "$HOME/.bmxng/MaxIDE" "$HOME/.local/bin/maxide"
				else
					LAST_ERROR="Unable to find BlitzMax NG bmk binary"
					return 1
				fi
				
				# Add icon
				mkdir -p "$HOME/.local/share/icons"
				cp "$HOME/.bmxng/src/maxide/makeicons/source/Build-Run_16x.svg" "$HOME/.local/share/icons/blitzmax.svg"
				
				# Create desktop file
				echo
				echo "Creating BlitzMax NG .desktop file..."
				desktop="[Desktop Entry]
Exec=MaxIDE %F
Name=MaxIDE
Comment=BlitzMax NG IDE
Type=Application
Terminal=false
Icon=blitzmax
Categories=Utility;TextEditor;Development;IDE;
Keywords=bmx;blitzmax;ng;"
				echo -e "$desktop" > "$HOME/.local/share/applications/maxide.desktop"
			
				return 0
			else
				LAST_ERROR="UnZip is not installed, cannot extract DEB package"
				return 1
			fi
		else
			LAST_ERROR="WGet is not installed, cannot download DEB package"
			return 1
		fi
	else
		LAST_ERROR="cURL is not installed, cannot download DEB package"
		return 1
	fi
}

function install_spc () {
	sudo apt install software-properties-common -y
}

function install_sublime_4 () {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	# STABLE
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get install sublime-text -y
}

function install_sublime_4_dev () {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	# DEV
	echo "deb https://download.sublimetext.com/ apt/dev/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get install sublime-text -y
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

function install_video_trimmer () {
	if bin_exists "flatpak"; then
		flatpak install org.gnome.gitlab.YaLTeR.VideoTrimmer -y
		return 0
	else
		LAST_ERROR="Flatpak is not installed, cannot update Flatpak software"
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

function install_htop () {
	sudo apt install htop -y
}

function install_nvtop () {
	sudo apt install nvtop -y
}

function install_radeontop () {
	sudo apt install radeontop -y
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
		sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
		sudo rm -rf microsoft.gpg
		sudo apt update
		sudo apt install code -y
		
		# Look if Code exists
		if bin_exists "code"; then
			echo "Visual Studio Code installed successfully"
			return 0
		else
			# Remove the repo to avoid errors
			sudo rm -f "/etc/apt/sources.list.d/vscode.list"
				
			LAST_ERROR="Visual Studio Code was not installed"
			return 1
		fi
	else
		LAST_ERROR="cURL is not installed, cannot download key"
		return 1
	fi
}

function install_wine () {
	# I wonder if this is needed...
	#sudo dpkg --add-architecture i386
	
	# Install Wine & Winetricks
	sudo apt install --install-recommends wine -y
	sudo apt install winetricks -y
	
	# Make sure there's a desktop file created
	sudo cp /usr/share/doc/wine/examples/wine.desktop /usr/share/applications/wine.desktop
	
	# Add some extra stuff
	if bin_exists "wget"; then
		if bin_exists "wine"; then
				
			wget http://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi
			wine msiexec /i wine-gecko-2.47.1-x86_64.msi
			rm -f wine-gecko-2.47.1-x86_64.msi
			
			# I guess we don't need these either then
			#wget http://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi
			#wine msiexec /i wine-gecko-2.47.1-x86.msi
			#rm -f wine-gecko-2.47.1-x86.msi
			
			return 0
		else
			LAST_ERROR="Wine was not installed"
			return 1
		fi
	else
		LAST_ERROR="WGet is not installed, cannot download package"
		return 1
	fi
}

function install_exe_thumbnailer () {
	sudo apt install exe-thumbnailer -y
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
					LAST_ERROR="IMWheel did not install correctly"
					return 1
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

function install_system_monitoring_center () {
	if bin_exists "wget"; then
		if bin_exists "gdebi"; then
			wget -O ~/system-monitoring-center.deb https://sourceforge.net/projects/system-monitoring-center/files/latest/download
			sudo gdebi ~/system-monitoring-center.deb -n
			sudo rm -rf ~/system-monitoring-center.deb
			
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

function install_pince () {
	if bin_exists "git"; then
		git clone https://github.com/korcankaraokcu/PINCE.git "$HOME/.pince"
		cd "$HOME/.pince"
		sudo sh install_pince.sh <<< y
		cd ..
		
		# Create a cute little bin script so the user can call 'pince'
		binscript="#!/bin/bash
cd \"$HOME/.pince\" && ./PINCE.sh $@"
		echo -e "$binscript" > "$HOME/.local/bin/pince"
		sudo chmod u+x "$HOME/.local/bin/pince"
		
		# Take ownership of the folder
		sudo chown -R $USER "$HOME/.pince"
		
		# Create a .desktop file
		echo
		echo "Creating PINCE 3 .desktop file..."
		desktop="[Desktop Entry]
Exec=pince
Name=PINCE
Comment=PINCE memory inspector
Type=Application
Terminal=true
Categories=Utility;
Icon=memory"
		echo -e "$desktop" > "$HOME/.local/share/applications/pince.desktop"
		
		return 0
	else
		LAST_ERROR="Git is not installed, cannot clone Git repo"
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