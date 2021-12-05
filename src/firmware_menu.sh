#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_firmware_menu () {
	if bin_exists "wget"; then
		if (whiptail --title "! WARNING !" --defaultno --yesno "These options can have devastating effects.\nContinue only if you know what you're doing.\n\nAre you sure you want to continue?" 0 0); then
				items=(
				"Install_XanMod" "Install XanMod Kernel" "OFF"
			)
			generate_selection_menu "Firmware Options" "${items[@]}"
		else
			return 0
		fi
	else
		whiptail --title "WGet Not Found" --msgbox "WGet must be installed to use this menu" 0 0
		return 1
	fi
}

function install_xanmod () {
	echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list
	wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/xanmod-kernel.gpg add -
	sudo apt update
	sudo apt install linux-xanmod -y
	NEEDS_RESTART=true
	
	return 0
}