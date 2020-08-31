#!/usr/bin/env bash
#########################################################
# Source https://mailinabox.email/ https://github.com/mail-in-a-box/mailinabox
# Updated by cryptopool.builders-OLD-VERSION for crypto use...
# This script is intended to be ran from the multipool installer
#########################################################

if [ -z "${TAG}" ]; then
	TAG=v1.26
fi

# Clone the MultiPool repository if it doesn't exist.
if [ ! -d $HOME/multipool/daemon_builder ]; then
	echo Downloading MultiPool Daemon Builder Installer ${TAG}. . .
	git clone \
		-b ${TAG}  \
		https://github.com/Original-Tasty/multipool_coin_builder \
		$HOME/multipool/daemon_builder \
		< /dev/null 2> /dev/null

	echo
fi

# Change directory to it.
cd $HOME/multipool/daemon_builder

# Update it.
sudo chown -R $USER $HOME/multipool/install/.git/
if [ "${TAG}" != `git describe --tags` ]; then
	echo Updating Daemon Builder Installer to ${TAG} . . .
	git fetch  --force --prune origin tag ${TAG}
	if ! git checkout -q ${TAG}; then
		echo "Update failed. Did you modify something in `pwd`?"
		exit
	fi
	echo
fi

# Start setup script.
cd $HOME/multipool/daemon_builder
source install.sh
