#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: t; tab-width: 4 -*-

clear

source src/common.sh
source src/misc.sh

TITLE="Ubuntu Post-Install Manager"

fetch_system_information
show_system_warnings

while :;do
	show_main_menu
done