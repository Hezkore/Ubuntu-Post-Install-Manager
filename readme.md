# Ubuntu Post-Install Manager
A simple script that helps you get started with Ubuntu and GNOME.

**Make sure to read everything below!**

![demo](https://github.com/Hezkore/Ubuntu-Post-Install-Manager/blob/master/extra/demo.png?raw=true)

## Requirements
### • X11 session
Ubuntu starts a Wayland session by default, *which is not supported*.\
If you don't know what this means, then just log out, click your user and click the cog in the lower right corner.\
Make sure **"Ubuntu on Xorg"** is selected and login as usual.\
![xorg](https://github.com/Hezkore/Ubuntu-Post-Install-Manager/blob/master/extra/xorg.jpg?raw=true)\
Wayland is the future for Linux and you may still use it.\
But some software - like IMWheel - does not work correctly in a Wayland session.

### • 20GB disk
Ubuntu takes up almost 10GB on a fresh install, and has a tendency to balloon up to 17GB.\
Make sure Ubuntu is installed to a disk greater than 20GB.\
That way the script has some space to work with.

### • 1024x768 resolution
Ubuntu doesn't work too well on resolutions lower than 1024x768.\
The ArcMenu GNOME extension also needs at least a height of 642 pixels, which is why the menu doesn't displayed at 800x600 or lower.

## How to install & run
Download the script by clicking the green **"Code ▼"** button here on GitHub, then click **"[Download Zip](https://github.com/Hezkore/Ubuntu-Post-Install-Manager/archive/refs/heads/master.zip)"** and save the file to disk.\
The file - named **"Ubuntu-Post-Install-Manager-master.zip"** - will most likely save to **"/home/[user]/Downloads/"**.\
Unpack the script by right clicking **"Ubuntu-Post-Install-Manager-master.zip"** and selecting **"Extract Here"**, which creates the folder **"Ubuntu-Post-Install-Manager-master"**.\
Double click the **"Ubuntu-Post-Install-Manager-master"** folder to enter it, then right click the file **"ubuntu_pim.sh"** and select the option **"Run as a Program"**.\
Follow the steps in order.

## Navigation & usage
Press the Up and Down arrow keys to move your selection up and down.\
Press TAB to move your selection between the two lower menu buttons.\
Press Space to toggle a option on or off in the customize menu.\
Press Enter to confirm your selection.

## Notes
You can run this script right after you've installed Ubuntu, or after you've updated Ubuntu and your drivers.\
Most efficient might be right after install, as the script will update Ubuntu and your drivers on its own.

I recommend doing all the steps in order, unless you know what you're doing.\
The default recommended options will install things a typical home computer might need.\
If you know what you're doing; you can deselect some of the items.\
*(Watch out! Some are vital system tools)*

When asked to enter your password in the terminal; you won't be able to see the password as you type.\
This is a security feature in Linux.

When installing the recommended software, you will be asked to enter your password in a popup screen twice.\
I recommend you stay by the computer until you've gotten past those two password popups.\
*(Removing Snap and installing Flatpak creates a password request popup)*

FireFox, Microsoft Edge and Google Chrome are all installed by default.\
You can uncheck the ones you don't want to install during step **"3. Software"**.\
If you find yourself without a browser; type `sudo apt install firefox` into a terminal to install FireFox.

If you don't like things starting automatically; I recommend you *NOT* check these options:
* Step **"7. Configuration"**
	* Uncheck "Configure Geary to check for incoming email"
	* Uncheck "Configure Telegram to run at start"
	* Uncheck "Configure Discord to run at start"
	* Uncheck "Configure Steam to run at start"

*(You can also disable these later by running the application **"Startup Applications"**)*

If the machine is made for gaming, I recommend reading the [Gaming](#gaming) section for some useful tips and guides.

If Steam, Discord, Telegram or Geary is set to run at start; a login screen will automatically appear for each application when you log in.\
They will stop appearing once you've signed in to the application.

If Steam does not start minimized after you've signed in; it means you've got **"Run Steam when my computer starts"** enabled in your Steam settings.\
This is not the script, but rather how Steam normally works.\
To fix this; disable **"Run Steam when my computer starts"** in Steam settings.\
You can run the script and check **"Configure Steam to run at start"** in step **"7. Configuration"** to have Steam start minimized at start.

## New Linux user information

GNOME is a desktop *(the G in GNOME is **not** silent)*.\
Some other popular desktops are KDE Plasma, XFCE and Cinnamon.\
A desktop is typically just a pack of applications *(like a settings manager application, text editor etc.)*, a taskbar *(if the desktop even uses one)* and a set of shortcut keys.\
Rendering is done using X11 or the newer Wayland.\
Windows/GUI are usually handled by the GTK or QT GUI toolkits.\
A Linux distro is *usually* just a specific package manager *(Apt in Debian/Ubuntu)*, a pre-defined desktop, extra applications, X11/Wayland already installed and configured, a login screen and a philosophy.\
With enough work, a Linux distro can do/become the same as any other Linux distro.\
And just because you're using the GNOME desktop does not mean you can't install any XFCE or Cinnamon desktop applications.\
For example, if you don't like the GNOME file browser Nautilus you can install the Cinnamon file browser Nemo.\
Linux itself is just a kernel.

If you're new to the GNOME file browser *(aka. Nautilus)* you'll quickly notice that clicking the current directory path at the top does nothing, you instead need to press **CTRL + L** to edit it.\
*(Good for copying or pasting paths)*

Directories and files in Linux are **case-sensitive**.\
The directory separator in Linux is `/` and **not a backwards slash** like on Windows.\
Put all your files in **"/home/[user]/"**.\
The `~` symbol is an alias of **"/home/[user]"**.\
The `.` symbol means "this directory", so running script in your current directory is done via `./<script>`.\
Files and folders starting with `.` are considered hidden.\
Press **Ctrl + H*** to toggle display of hidden files.\
Avoid putting things in your **"root"** folders, such as **"/usr/local/"**.\
Use **"~/.local/"** instead to prevent any system issues.\
For example, install fonts to **"~/.local/fonts/"** instead of **"/usr/local/fonts/"** *(unless you want them system-wide)*.

There's no such thing as executable filetypes in Linux.\
Instead they need the ***execute** file permission*.\
You can make any file executable by right clicking it and selecting properties, navigate to **"Permissions"** and check the **"Execute"** checkbox.\
Remember that even scripts files like **".sh"** require this permission!


The **"*Windows* key"**  is usually called the **"*Super* key"** in Linux.

Hold **Super** then click and hold your **left mouse button** to drag a window around without having to grab the window's title bar.\
Hold **Super** then click and hold the **right mouse button** to to resize a window without having to grab the window's edge.\
Note that **"Configure GNOME to resize with right mouse button"** in step **"7. Configuration"** needs to be checked for this to work, otherwise use the **middle mouse button** to resize the window.\
*(Learn to use these shortcuts!)*

If **"Configure GNOME keyboard shortcuts"** is checked in step **"7. Configuration"**, the following shortcuts are available:
* Flameshot capture screenshot area
	* **Shift + F1**
		* While capturing area >
			* **Ctrl + S** to save to ~/Pictures
			* **Ctrl + C** to copy to clipboard
* Open Nautilus *(files)*
	* **Super + E**
* Open Terminal
	* **Ctr + Alt + T**
	* **Super + T**
* Open System Monitor
	* **Ctrl + Alt + Delete**
	* **Ctrl + Shift + Escape**
* Play Quake 3 *(if **"Install  [io]Quake 3..."** is checked in step **"4. Gaming"**)*
	* **Super + Q**

There's no need to navigate the "start menu" when looking for applications.\
Press the **Super** key and start typing the applications name, then press **Enter**.\
If the application is not installed, GNOME will search for the application in Store and display any matching results.\
Press **Super** twice to display all applications.

After pressing **Super**, you can drag any window into a new desktop at the top of the screen.\
You can use the mouse scroll wheel on the taskbar to quickly switch  desktop.\
**Super + Alt + Lef/Right** also switches desktop.

Use the application **"GNOME-Software"** *(from step **"3. Software"**)* *(titled **"Software"**, usually referred to as GNOME store)* to install any extra software you might need.\
You can also uninstall software via the GNOME Store.\
Right click an application and select **"Show Details"** to quickly jump to the application's store page.\
*(Not every application has a store page)*

Updating software via the GNOME Store might result in a suggested reboot.\
GNOME does this to keep the user safe, but you can avoid the reboot by calling the following commands in the terminal `sudo apt update` *(looks for updates)* and `sudo apt upgrade` *(applies the update)*.\
You can also use **"Update APT software"** from step **"5. Updates"** to let the script call these commands for you.

If you manually remove applications, then watch out for the `--purge` flag.\
`--purge` will remove anything that depends on that application as well.\
`sudo apt remove python3` - **Safe**\
`sudo apt remove --purge python3` - **Not safe**

Linux is a multi-user OS and lets you start several sessions at the same time.\
You can use **CTRL + ALT + F1 - F6** to switch between them.\
**CTRL + ALT + F2** should be your standard graphical session, while **CTRL + ALT + F1** is your alternative session.\
*(Seems to be the other way around sometimes)*\
**CTRL + ALT + F3 - F6** are not graphical by default and instead starts in terminal mode.

Learning to use the **Terminal** is not required in Linux anymore.\
But using it helps a lot, is a faster than navigating menus and enables you to do so much more *(it's also really fun!)*.\
Some basic Terminal information:
* *TAB*
	* Auto complete any command, file or directory
	* Remember to use TAB a lot to save on key presses!
* *Ctrl + C*
	* Cancel application/command
* *Ctrl + Shift + C / V*
	* Copy / Paste
* *Ctrl + Shift + Up / Down*
	* Scroll upp / down
* `sudo <command>`
	* Stands for "super user do" and enables admin privileges to the command[s] following it *(so be careful running sudo commands you find online!)*
	* Example: `sudo nano <file>`
* `nano <file>`
	* Nano is a simple terminal based text editor
	* Press *Ctrl + X* to exit out of Nano
* `man <command>`
	* Show the manual for that command *(press Q to quit)*
	* Example: `man sudo`
	* You can usually do `<command> --help` to display a simpler manual
* `ls`
	* Lists directory content, like 'dir' in DOS
	* Use `ls -a` to display "all" the content, like hidden files and folders
* `cd <path>`
	* Change directory to an absolute or relative path
	* `cd ..` moves one directory back
	* `cd ~` moves to your home folder
* `mkdir <name>`
	* Make directory with a specific name
* `touch <file>`
	* If the file does not exist, the file is created *(basically create file)*
	* If the file exists, the file timestamp is updated
* `rm <file>`
	* Removes a file, but not a folder
	* Use `rm -r <folder>` to recursively remove a folder
* `mv <path1> <path2>`
	* Move a file or folder from path 1 to path 2
	* Use this command to rename files and folders
* `cp <path1> <path2>`
	* Copy path 1 file or folder to path 2
* `<command1> | <command2>`
	* Redirect *(pipe)* output of one command to the input of another command
	* Example: `ls ~ | grep -i doc`
		* This lists files in your home directory but pipes the data into the application "grep" with the "-i" flag for case-insensitive matches against the word "pic", which should display the folder "Documents"
	* Example: `ls ~ -R | more`
		* This lists every file and folder recursively in your home directory, but pipes the data into "more", which displays a "--More--" message when the text is about to scroll outside the terminals view and lets you press *Page Down* to scroll to the next page
* `whereis <command>`
	* Displays where the command binary is located on your hard drive
* `apt <options> <application>`
	* Apt is the package manager in Debian/Ubuntu and must be called via `sudo`
	* Example: `sudo apt install firefox`
	* Example: `sudo apt remove firefox`

## Gaming
Step **"4. Gaming"** is an optional step and safe to skip.

Wine *(from step **"3. Software"**)* and Proton *(part of Steam from step **"4. Gaming"**)* let's you run Windows software and games on Linux.\
Wine is commonly used applications, while Proton *(based on Wine)* is mainly used for games.\
They are not emulators *(Wine is an acronym for "Wine Is Not an Emulator")* but instead use Windows runtimes rewritten for Linux.

Visit [ProtonDB.com](https://www.protondb.com/) to find out if your favorite Steam games runs on Linux.\
Optionally, you can read more about Proton [here](https://www.gamingonlinux.com/2019/07/a-simple-guide-to-steam-play-valves-technology-for-playing-windows-games-on-linux/).

To enable Proton in Steam; start Steam and click:
* Steam >
	* Settings >
		* Steam Play >
			* "Enable Steam Play for supported titles"
			* "Enable Steam Play for all other titles"
		* Shader Pre-Caching >
			* "Enable Shader Pre-Caching"
			* "Allow background processing of Vulkan shaders"
		* *(recommended)*
			* Interface >
				* Change "Select which Steam window appears when the program starst." to "Library"
				* Disable "Run Steam when my computer starts" *(see [Notes](#notes)* for more info)
				* Disable "Notify me about additions or changes to my games, new releases, and upcoming releases."
			* Library >
				* "Low Bandwidth Mode"
				* "Low Performance Mode"

Adding a non-Steam game to Steam lets you use Proton with local games.\
You can also use Lutris *(from step **"4. Gaming"**)* to play locally installed games.

You can enable Game Mode in Steam by right clicking any game > Properties ... > Launch Options > Write `gamemoderun %command%`.\
I have not noticed any performance increase using Game Mode.

Use GOverlay *(from step **"4. Gaming"**)* to enable a in-game FPS counter, effects and many other things.\
Start the application **"GOverlay"** and check **"Global Enable"** in the MangoHud tab, and make sure the **"Hide"** checkbox is checked in the **"Visual"** section.\
Don't forget to click **"Save"** at the bottom of the window and restart/log out!\
You won't ever have to start GOverlay again.\
Press **Right Shift + F12** in Vulkan based games to toggle MangoHud *(from step **"4. Gaming"**)* on and off.