#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_drivers_menu () {
	items=(
		"Add_GPU_PPA" "Add PPA repo with newer drivers" "OFF"
		"Install_Drivers" "Automatically install required Ubuntu drivers" "ON"
	)
	generate_selection_menu "Driver Options" "${items[@]}"
}

function add_gpu_ppa () {
	if add_ppa "ppa:graphics-drivers/ppa"; then
		return 0
	else
		return 1
	fi
}

function install_drivers () {
	echo "Run the GNOME application 'Additional Drivers' to see drivers in use"
	echo "Checking for new drives..."
	sudo ubuntu-drivers install
	
	return 0
}