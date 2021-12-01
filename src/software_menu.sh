#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_software_menu () {
	items=(
		"Install_Drivers" "Install required Ubuntu drivers" "ON"
		"Remove_Snap" "Purge Snap store and software" "ON"
		"Install_GNOME-Software" "Install GNOME software store" "ON"
		"Install_Discover_Store" "Install KDE Discover software store" "OFF"
		"Install_Flatpak" "Enable Flatpak support" "ON"
		"Install_GDebi" "Install GDebi DEB unpacker" "ON"
		"Install_Curl" "Install cURL CLI tool" "ON"
		"Install_WGet" "Install WGet CLI tool" "ON"
		"Install_SPC" "Install software-properties-common" "ON"
		"Install_Git" "Install GIT" "ON"
		"Install_Build-Essential" "Install build-essential" "ON"
		"Install_CMake" "Install CMake make system" "ON"
		"Install_Ninja" "Install Ninja build system" "ON"
		"Install_Python3" "Install Python3 and Pip" "ON"
		"Install_Vim" "Install Vim CLI text editor" "ON"
		"Install_Emacs" "Install Emacs CLI text editor" "ON"
		"Install_Foliate" "Install Foliate EBook reader via custom PPA" "ON"
		"Install_Kdenlive" "Install Kdenlive video editor via custom PPA" "ON"
		"Install_Handbrake" "Install Handbrake video trimmer" "ON"
		"Install_Telegram" "Install Telegram messenger" "ON"
		"Install_Discord" "Install Discord messenger" "ON"
	)
	generate_selection_menu "Software" "${items[@]}"
}

function remove_snap () {
	sudo systemctl stop snapd.service
	sudo systemctl disable snapd.service
	snap remove --purge snap-store
	sudo apt autoremove --purge snapd gnome-software-plugin-snap -y
	sudo apt remove snapd -y
	sudo apt purge snapd -y
	sudo apt-mark hold snapd
	sudo rm -rf /var/cache/snapd/
	sudo rm -rf ~/snap
}

function install_python3 () {
	sudo apt install python3 -y
	sudo apt install python3-pip -y
	
	sudo python3 -m keyring --disable &> /dev/null
	python3 -m keyring --disable &> /dev/null
	
	pip install repolib
}

function install_git () {
	sudo apt install git -y
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

function install_discover_store () {
	sudo apt-get install -y discover
}

function install_flatpak () {
	sudo apt install gnome-software-plugin-flatpak -y
	sudo apt install flatpak -y
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

function install_gdebi () {
	sudo apt install gdebi-core -y
	sudo apt install gdebi -y
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

function install_spc () {
	sudo apt install software-properties-common -y
}

function install_drivers () {
	sudo echo "Checking for drives..."
	sudo ubuntu-drivers install
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
	else
		return 1
	fi
}

function install_kdenlive () {
	if add_ppa "ppa:kdenlive/kdenlive-stable"; then
		sudo apt install kdenlive -y
	else
		return 1
	fi
}

function install_handbrake () {
	sudo apt install handbrake -y
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