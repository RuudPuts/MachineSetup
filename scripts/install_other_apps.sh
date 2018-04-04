function install_other_app {
    filename=$(basename "$1")

    tmp_dir="tmp"

    mkdir -p $tmp_dir
    pushd $tmp_dir
        curl -o $filename $1
        install_app $filename
    popd

    rm -rf $tmp_dir
}

function install_app {
    extension="${1: -3}"
    echo "Installing $1"

    if [ $extension == "zip" ]; then
        install_zip $1
    elif [ $extension == "dmg" ]; then
        install_dmg $1
    elif [ $extension == "app" ]; then
        install_application "$1"
    elif [ $extension == "pkg" ]; then
        user_finish_installation "$1"
    else
        user_manual_installation
    fi
}

function install_zip {
    unzip $1
    install_interesting_file $(pwd)
}

function install_dmg {
    mount_dir="/Volumes/${1%.*}"
    hdiutil attach -mountpoint $mount_dir -noverify $1

    install_interesting_file $mount_dir

    hdiutil detach $mount_dir
}

function install_application {
    app=$(echo "$1" | awk '{print tolower($0)}')
    if [[ "$app" == "install"* ]]; then
        user_finish_installation "$1"
    else
        echo "Copying "$1" to ~/Applications"
        cp -r "$1" /Applications
    fi
}

function install_interesting_file {
    pushd $1
        pkg=$(find . -maxdepth 1 -name "*.pkg" -exec basename {} .po \;)
        app=$(find . -maxdepth 1 -name "*.app" -exec basename {} .po \;)

        if [ "$pkg" == *"pkg" ]; then
            install_app "$pkg"
        elif [ "$app" == *"app" ]; then
            install_app "$app"
        else
            user_manual_installation
        fi
    popd
}

function user_finish_installation {
    open "$1"
    wait_for_user "Please finish the installation by hand. When finished press enter to continue."
}

function user_manual_installation {
    open .
    wait_for_user "Unable to install $1 automatically, please install manually. When finished press enter to continue."
}

function wait_for_user {
    echo ""
    read -p " >> $1"
    echo -e "\n"
}
