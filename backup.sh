#!/usr/bin/env bash

source MachineSetup.config
source scripts/backup.sh
source scripts/install_tools.sh

function backup_preferences {
	for PREFERENCE in "${PREFERENCES[@]}"
	do
	   backup_preference "${PREFERENCE}"
	done
}

install_homebrew
install_formula "mas"

backup_ssh_config
backup_keychains
backup_preferences
backup_alfred_preferences
backup_appstore_apps
backup_formulas
backup_gems