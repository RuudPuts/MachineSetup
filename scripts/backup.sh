function backup_ssh_config {
	TARGET="backup/ssh_keys"
  mkdir -p $TARGET

  cp ~/.ssh/id_rsa* $TARGET
	cp ~/.ssh/id_rsa*.pub $TARGET
	cp ~/.ssh/config $TARGET
}

function backup_keychains {
	TARGET="backup/keychains"
  mkdir -p $TARGET

	cp ~/Library/Keychains/*.keychain $TARGET
	cp ~/Library/Keychains/*.keychain-db $TARGET
}

function backup_alfred_preferences {
	TARGET="backup/alfred"
    mkdir -p $TARGET

    cp -r ~/Library/Application\ Support/Alfred\ 3 $TARGET
}

function backup_appstore_apps {
	echo "$(mas list)" > backup/appstore_apps.txt
}

function backup_gems {
	echo "$(gem list)" > backup/gems.txt
}

function backup_formulas {
	if [ -x "$(command -v brew)" ]; then
        echo "$(brew list)" > backup/formulas.txt
    fi
}

function backup_preference {
	TARGET="backup/preferences"
    mkdir -p $TARGET

	cp ~/Library/Preferences/$1 $TARGET
}

function restore_backup {
	restore_ssh_keys
	restore_keychains
	restore_preferences
	restore_alfred_prefrences
}

function restore_ssh_keys {
    TARGET=~/.ssh/
		mkdir -p $TARGET

    cp backup/ssh_keys/id_rsa* $TARGET
    cp backup/ssh_keys/id_rsa*.pub $TARGET
    cp backup/ssh_keys/config $TARGET
		chmod -R 400 $TARGET/id_rsa*
		chmod -R 444 $TARGET/id_rsa*.pub
}

function restore_keychains {
    cp -R backup/keychains ~/Library/Keychains
}

function restore_preferences {
	cp backup/preferences/* ~/Library/Preferences/
}

function restore_alfred_prefrences {
	cp -r backup/alfred/Alfred\ 3 ~/Library/Application\ Support/
}
