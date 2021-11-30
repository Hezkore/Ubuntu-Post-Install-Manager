#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

function show_misc_menu () {
	items=( "Install_GIT" "Version control" "ON" \
	"Install_WGet" "Thingy" "OFF" \
	"Install_CURL" "Thingyasd" "ON" )
	generate_selection_menu "Hellur" "${items[@]}"
}