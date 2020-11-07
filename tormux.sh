#!/bin/bash

install_tor(){
	printf "updating apt data\n"
	sleep 3
	apt update
	
	printf "upgrading aplications\n"
	sleep 3
	apt upgrade
	
	printf "installing tor, privoxy and obfs4socks\n"
	apt install tor privoxy obfs4proxy
	[[ ! $(apt list tor | grep tor) ]] && printf " there is something wrong, tor is not installed\n" && exit 1 || printf "tor is installed\n" 
	[[ ! $(apt list obfs4proxy | grep obfs4proxy) ]] && printf " there is something wrong, obfs4proxy is not installed\n" && exit 1 || printf "obfs4proxy is installed\n" 
	[[ ! $(apt list privoxy | grep privoxy) ]] && printf " there is something wrong, privoxy is not installed\n" && exit 1 || printf "privoxy is installed\n"
	sleep 3

	back_up_config=/data/data/com.termux/files/usr/etc/tor/torrc.bak
	tor_config=/data/data/com.termux/files/usr/etc/tor/torrc

	[ ! -f "$back_up_config" ] && printf "Backing up the tor original config file\n" && cp "$tor_config" "$back_up_config"
	sleep 3

	printf "Getting storage access for termux\n"
	sleep 3
	termux-setup-storage

	printf "Config tor and add obfs bridges\n"

	[ ! -d ~/.tormux ] && printf "Creating tormux directory\n" && mkdir ~/.tormux
	sleep 3
	
	curl -L https://raw.githubusercontent.com/mhdzli/tormux/main/obfs4.txt -o ~/storage/downloads/obfs.txt

	curl -L https://raw.githubusercontent.com/mhdzli/tormux/main/tormuxconfig -o ~/.tormux/tormuxconfig
}


obfs_update(){
	sed -e '/^[[:space:]]*$/d' -e 's/^/Bridge /' ~/storage/downloads/obfs.txt > ~/.tormux/obfs

	cat "$back_up_config" ~/.tormux/tormuxconfig ~/.tormux/obfs > "$tor_config"

	printf "Run 'tor &' and check if you can connect to tor network\n"
}

[[ "$1" == "install" ]] && install_tor && obfs_update

[[ "$1" == "update" ]] && obfs_update

