function setup_dev_folder {
    create_dev_directory $1
    install_device_console
}

function create_dev_directory {
    mkdir -p $1
}

function install_device_console {
    brew tap hbang/repo
    brew install deviceconsole --HEAD
}
