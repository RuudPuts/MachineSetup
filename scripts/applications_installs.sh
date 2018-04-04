#!/usr/bin/env bash

function login_appstore {
    if [ "$(mas account)" == "" ]; then
      mas signin $1 $2
    fi
}

function install_from_appstore {
    RESULTS=$(mas search "$1")
    ID=$(echo $RESULTS | awk '{print $1}')

    mas install $ID
}
