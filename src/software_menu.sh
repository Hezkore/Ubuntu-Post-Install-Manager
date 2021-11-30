#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_software_menu () {
	items=(
		"Remove_Snap" "Remove Snap store and software" "ON"
		"Install_Python3" "Install Python3 and Pip" "ON"
		"Install_Git" "Install Git version control" "ON"
	)
	generate_selection_menu "Install Software" "${items[@]}"
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