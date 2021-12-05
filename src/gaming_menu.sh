#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_gaming_menu () {
	items=(
		"Install_Steam" "Install Steam game store" "ON"
		"Install_Heroic" "Install Heroic Epic Games launcher via DEB" "ON"
		"Install_Minigalaxy" "Install Minigalaxy GOG launcher via DEB" "ON"
		"Install_Lutris" "Install Lutris game manager via custom PPA" "ON"
		"Install_DOSBox" "Install DOSBox x86 emulator with DOS" "ON"
		"Install_Game_Data_Packager" "Install Game Data Packager" "ON"
		"Install_GameMode" "Install Game Mode" "ON"
		"Install_Mangohud" "Install Mangohud via custom PPA" "ON"
		"Install_vkBasalt" "Install vkBasalt via custom PPA" "OFF"
		"Install_GOverlay" "Install GOverlay via custom PPA" "ON"
		"Install_Protontricks" "Install Protontricks via PIP" "ON"
		"Install_Quake_3" "Install [io]Quake 3 via Game Data Packager" "ON"
	)
	generate_selection_menu "Gaming Options" "${items[@]}"
}


function install_steam () {
	sudo apt install steam -y
	
	# Check if a "Games" folder exists and add a Steam shortcut
	if [[ -d "$HOME/Games"  ]]; then
		ln -s "$HOME/.steam/debian-installation" "$HOME/Games/Steam"
	fi
	
	return 0
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

function install_lutris () {
	if add_ppa "ppa:lutris-team/lutris"; then
		sudo apt install lutris -y
		return 0
	else
		return 1
	fi
}

function install_dosbox () {
	sudo apt install dosbox -y
	
	return 0
}

function install_game_data_packager () {
	sudo apt install game-data-packager -y
	
	return 0
}


function install_gamemode () {
	sudo apt install gamemode -y
	
	return 0
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
		LAST_ERROR="Python-PIP is not installed, cannot download package"
		return 1
	fi
}

function install_quake_3 () {
	if bin_exists "game-data-packager"; then
		
		if bin_exists "gdebi"; then
			
			echo "Downloading Quake 3 demo game data..."
			
			# There's no way to say yes to all, so pip in y
			game-data-packager --gain-root-command sudo --install-method gdebi --no-search --verbose --no-compress -i quake3 <<< y
			# Since there's no way to actually know WHAT was download, we have to wildcard delete the deb :S
			rm -f quake3-*.deb
			
			echo
			echo "Installing ioQuake 3..."
			sudo apt install ioquake3 -y
			
			
			return 0
		else
			LAST_ERROR="GDebi is not installed, cannot extract DEB package"
			return 1
		fi
		return 0
	else
		LAST_ERROR="Game Data Packer is not installed, cannot download game data"
		return 1
	fi
}