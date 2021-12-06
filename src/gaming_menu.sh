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
		"Install_Quake_3_Hi-Res_Textures" "Install Hi-Res Textures for Quake 3" "ON"
		"Install_Quake_3_CFG" "Install custom high quality Quake 3 config" "ON"
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
	if bin_exists "wget"; then
		if bin_exists "unzip"; then
			if bin_exists "game-data-packager"; then
				if bin_exists "gdebi"; then
					
					q3dir="$HOME/.q3a"
					
					# Make sure the Q3 dir exists
					echo "Quake 3 directory $q3dir"
					mkdir -p "$q3dir"
					
					echo
					echo "Downloading Quake 3 demo game data..."
					# There's no way to say yes to all, so pipe in y
					game-data-packager --gain-root-command sudo --install-method gdebi --no-search --verbose --no-compress -i quake3 <<< y
					
					echo
					echo "Extracting Quake 3 demo game data..."
					# Since there's no way to actually know WHAT was download, we have to wildcard delete the deb :S
					rm -f quake3-*.deb
					
					echo
					echo "Relocating Quake 3 demo game data..."
					# Move the data from /usr/share/games/quake3-demo-data/demoq3 to our Q3 dir
					sudo mv -f "/usr/share/games/quake3-demo-data/demoq3/" "$q3dir/baseq3/"
					
					# Take ownership of the game data
					sudo chown -R $USER "$q3dir/baseq3"
					
					echo
					echo "Downloading latest patch data..."
					# Use the patch data as our base
					wget -O patch.zip https://files.ioquake3.org/quake3-latest-pk3s.zip
					
					echo
					echo "Extracting patch data..."
					unzip -o -d "$q3dir" patch.zip
					# Rename the patch dir to Quake 3
					sudo cp -rf "$q3dir/quake3-latest-pk3s/baseq3" "$q3dir"
					sudo cp -rf "$q3dir/quake3-latest-pk3s/missionpack" "$q3dir"
					sudo rm -rf "$q3dir/quake3-latest-pk3s"
					rm -f patch.zip
					
					# Take ownership of the patch data
					sudo chown -R $USER "$q3dir"
					
					echo
					echo "Downloading ioQuake 3..."
					#sudo apt install ioquake3 -y # We want a newer version than this!
					wget -O q3-linux.zip https://files.ioquake3.org/Linux.zip
					
					echo
					echo "Extracting ioQuake 3..."
					# First zip
					unzip -o q3-linux.zip
					sudo rm -rf q3-linux.zip
					# Nested zip
					unzip -o -d "$q3dir" release-linux*.zip
					sudo rm -rf release-linux*.zip
					
					# Create a bogus CD Key for the demo
					sudo echo -e "aaaaaaaaaaaaaaaa" > "$q3dir/baseq3/q3key"
					
					# Create a cute little bin script so the user can call 'quake3'
					binscript="#!/bin/bash
cd \"$HOME/.q3a\" && ./ioquake3.x86_64"
					sudo echo -e "$binscript" > "$HOME/.local/bin/quake3 $@"
					sudo chmod u+x "$HOME/.local/bin/quake3"
					
					# Check if a "Games" folder exists and add a Quake 3 shortcut
					if [[ -d "$HOME/Games"  ]]; then
						ln -s "$q3dir" "$HOME/Games/Quake 3"
					fi
					
					# Download Quake 3 icon
					echo
					echo "Downloading Quake 3 icon..."
					wget -O "$HOME/.local/share/icons/quake3.svg" https://iconarchive.com/download/i106244/papirus-team/papirus-apps/quake-3.svg
					
					# Create a .desktop file
					echo
					echo "Creating Quake 3 .desktop file..."
					desktop="[Desktop Entry]
Exec=quake3
Name=Quake 3
Comment=Quake 3 Arena
Type=Application
Terminal=false
Categories=Game;
Icon=quake3"
					sudo echo -e "$desktop" > "$HOME/.local/share/applications/quake3.desktop"
					
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
		else
			LAST_ERROR="UnZip is not installed, cannot extract game data"
			return 1
		fi
	else
		LAST_ERROR="WGet is not installed, cannot download game"
		return 1
	fi
}

function install_quake_3_hi-res_textures () {
	if bin_exists "wget"; then
		if bin_exists "unzip"; then
			echo "Downloadin high-resolution textures..."
			wget -O xcsv_hires.zip https://files.ioquake3.org/xcsv_hires.zip
			
			echo "Extracting textures to ~/.q3a/baseq3"
			unzip -o -d "$HOME/.q3a/baseq3" xcsv_hires.zip
			
			sudo rm -rf xcsv_hires.zip
			
			return 0
		else
			LAST_ERROR="UnZip is not installed, cannot extract game data"
			return 1
		fi
	else
		LAST_ERROR="WGet is not installed, cannot download game data"
		return 1
	fi
}

function install_quake_3_cfg () {
	
	cfg="bind p \"quit\"
bind b \"addbot random 5\"
bind mouse2 \"+zoom\"
bind CTRL \"+movedown\"
bind e \"weapnext\"
bind q \"weapprev\"
bind r \"weapon 5\"
bind f \"weapon 7\"

seta name "${USER^}"

set sensitivity \"1.8\"

seta cg_fov \"115\"
set cg_shadows \"1\"
set cg_autoswitch \"0\"
set cg_zoomfov \"38\"
set cg_zoomScaling \"0\"
set cg_zoomSensitivity \"1.35\"
set cg_crosshairSize \"20\"
set cg_drawCrosshair \"5\"
set cg_gunCorrectFOV \"1\"
set cg_visibleBleeding \"1\"
set cg_oldRail \"0\"
set cg_oldRocket \"0\"
set cg_oldPlasma \"0\"
set cg_smoke_sg \"1\"

set cl_mouseAccel \"0\"
set cl_mouseAccelStyle \"0\"
set cl_mouseAccelOffset \"0\"
set cl_allowdownload \"1\"
set cl_renderer \"opengl2\"

set com_maxfps \"125\"
set com_maxfpsUnfocused \"24\"
set com_maxfpsMinimized \"10\"
set com_hunkMegs \"256\"
set com_zoneMegs \"128\"
set com_soundMegs \"64\"

set s_muteWhenMinimized \"1\"
set s_muteWhenUnfocused \"1\"
set s_musicvolume \"1.0\"
set s_volume \"1.0\"

seta r_dlightMode \"1\"
seta r_sunlightMode \"2\"
seta r_drawSunRays \"1\"
seta r_mode \"-2\"
seta r_noborder \"1\"
seta r_fullscreen \"1\"
seta r_shadowFilter \"2\"
seta r_shadowBlur \"1\"
seta r_allowExtensions \"1\"
seta r_allowSoftwareGL \"0\"
seta r_ext_multisample \"8\"
seta r_ext_framebuffer_multisample \"8\"
seta r_colorbits \"32\"
seta r_depthbits \"24\"
seta r_detailTextures \"1\"
seta r_drawsun \"1\"
seta r_dynamicLight \"1\"
seta r_ext_compiled_vertex_array \"1\"
seta r_ext_compressed_textures \"0\"
seta r_ext_multitexture \"1\"
seta r_ext_texture_filter_anisotropic \"1\"
seta r_ext_max_anisotropy \"16\"
seta r_fastsky \"0\"
seta r_finish \"1\"
seta r_flares \"1\"
seta r_ignoreGLErrors \"1\"
seta r_lodbias \"-2\"
seta r_picmip \"0\"
seta r_roundImagesDown \"1\"
seta r_smp \"1\"
seta r_stencilbits \"16\"
seta r_subdivisions \"1\"
seta r_swapInterval \"0\"
seta r_texturebits \"32\"
seta r_textureMode \"GL_LINEAR_MIPMAP_LINEAR\"
seta r_vertexlight \"0\""
	
	# Write the config
	echo "Writing Quake 3 config to $HOME/.q3a/baseq3/..."
	sudo mkdir -p "$HOME/.q3a/baseq3/"
	sudo echo -e "$cfg" > "$HOME/.q3a/baseq3/q3config.cfg"
	
	return 0
}