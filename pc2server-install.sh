#!/bin/bash

steamcmdInstall(){
	sudo apt-get install lib32gcc1;
	mkdir steamcmd
	cd steamcmd
	wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
	tar -xvzf steamcmd_linux.tar.gz
	cd ..
}

pc2Download(){
	echo "Steam need to check if you own the game before downloading the files.";
	echo "Neither of your username and password will be saved !";
	echo "Enter your Steam username : ";
	read username;
	echo "Enter your Steam password: ";
	read password;

	read -e -p "Path to download Procject Cars 2's server files : " -i "$HOME/PC2" directory;
	mkdir -p "$directory";
	steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login $username $password +force_install_dir $directory +app_update 413770 +quit
}

##Check if system compatible before install
compatible(){
	##Check if distribution is supported
	if [[ -z "$(uname -a | grep Ubuntu)" && -z "$(uname -a | grep Debian)" ]];then
		return 1
	fi
}

##Updates && Upgrades
updates(){
	echo "Installing updates !"
	sudo apt-get update;
	sudo apt-get upgrade;
}

main(){
	##call compatible to check if distro is either Debian or Ubuntu
	compatible
	if [ $? == 1 ]; then
		echo Distro not supported
		exit 1
	fi
	##call updates to upgrade the system
	updates
	steamcmdInstall
	pc2Download
}

main

echo "Successfully downloaded !";
