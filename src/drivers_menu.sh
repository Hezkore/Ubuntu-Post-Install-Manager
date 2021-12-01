#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_drivers_menu () {
	items=(
		"Add_GPU_PPA" "Add custom PPA repo with newer drivers" "OFF"
		"Install_Drivers" "Automatically install required Ubuntu drivers" "ON"
		"Patch_NvFBC" "Patch NVidia GPU drivers to remove NVENC and NvFBC limitations" "OFF"
	)
	generate_selection_menu "Miscellaneous Options" "${items[@]}"
}

function add_gpu_ppa () {
	if add_ppa "ppa:graphics-drivers/ppa"; then
		return 0
	else
		return 1
	fi
}

function install_drivers () {
	sudo echo "Checking for drives..."
	sudo ubuntu-drivers install
	sudo update
}

function patch_nvfbc () {
	if bin_exists "git"; then
		git clone https://github.com/keylase/nvidia-patch.git ~/nvidia-patch
		cd ~/nvidia-patch
		sudo ./patch-fbc.sh
		cd ..
		sudo rm -rf ~/nvidia-patch
		return 0
	else
		LAST_ERROR="Git is not installed, cannot clone Git repo key"
		return 1
	fi
}