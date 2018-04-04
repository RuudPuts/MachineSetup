#!/usr/bin/env bash

function path_zshrc() {
	echo -e "\nsource .bash_profile" >> ~/.zshrc
}

function copy_bash_profile() {
	touch ~/.bash_profile
	echo -e "\n$(cat configs/bash_profile.sh)" >> ~/.bash_profile
}

function copy_gemrc() {
	cp configs/gemrc.sh ~/.gemrc
}

# install.sh injections

function pre_setup {
	copy_bash_profile
	copy_gemrc
}

function post_setup {
	## iTerm

	# Font
	font_url="https://raw.githubusercontent.com/powerline/fonts/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf"

	fonts_dir="$HOME/Library/Fonts"
	mkdir -p $fonts_dir
	curl -o "$fonts_dir/Meslo LG M Regular for Powerline.ttf" $font_url

	# Theme
	open "configs/Solarized Dark.itermcolors"

	## Sublime

	sudo mkdir -p "/usr/local/bin/" && ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

	## Bash

	path_zshrc
}
