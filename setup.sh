#!/usr/bin/env bash

source MachineSetup.config

source scripts/backup.sh
source scripts/install_tools.sh
source scripts/setup_dev_folder.sh $DEV_DIRECTORY
source scripts/applications_installs.sh
source scripts/install_other_apps.sh
source setup_hooks.sh

function install_appstore_apps {
  login_appstore $APPSTORE_EMAIL $APPSTORE_PASSWORD

  for APP in "${APPS[@]}"; do install_from_appstore "${APP}"; done
}

function install_gems { for GEM in "${GEMS[@]}"; do install_gem "${GEM}"; done }
function install_formulas { for FORMULA in "${FORMULAS[@]}"; do install_formula "${FORMULA}"; done }
function install_cask_formulas { for FORMULA in "${CASK_FORMULAS[@]}"; do install_cask_formula "${FORMULA}"; done }
function install_other_apps { for APP in "${OTHER_APPS[@]}"; do install_other_app "${APP}"; done }

wait_for_user "Good to go, press enter to start"

restore_backup

pre_setup

echo "Installing Home-brew"
install_homebrew
echo "Installing rbenv"
install_rbenv $RUBY_VERSION
echo "Installing pip"
install_pip

echo "Installing Xcode $XCODE_VERSION"
install_xcode $XCODE_VERSION

install_formulas
install_gems

install_other_apps

install_zsh
install_powerline-shell

install_appstore_apps

# Setup for building
mkdir -p ~/Library/MobileDevice/Provisioning Profiles

# # Setup development folder
setup_dev_folder "${DEV_FOLDER}"

post_setup

wait_for_user "All done, press enter to log out"
osascript -e 'tell app "System Events" to log out'
