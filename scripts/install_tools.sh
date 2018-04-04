function install_homebrew {
    if ! [ -x "$(command -v brew)" ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

function install_pip {
  if ! [ -x "$(command -v pip)" ]; then
      curl -fsSL https://bootstrap.pypa.io/get-pip.py | sudo /usr/bin/python
  fi
}

function install_rbenv {
    brew install rbenv
    touch "~/.bash_profile"
    echo "eval \"\$(rbenv init -)\"" >> ~/.bash_profile
    rbenv init -

    rbenv install $1
    rbenv global $1

    . ~/.bash_profile
}

function install_gem {
    gem install $1
}

function install_formula {
    if ! [ -x "$(command -v $1)" ]; then
        brew install $1
    fi
}

function install_cask_formula {
    if ! [ -x "$(command -v $1)" ]; then
        brew cask install $1
    fi
}

function install_xcode {
    export XCODE_INSTALL_USER=$APPSTORE_EMAIL
    export XCODE_INSTALL_PASSWORD=$APPSTORE_PASSWORD

    install_gem "xcode-install"
    xcversion install $1
    sudo xcodebuild -license accept
    sudo xcode-select -s /Applications/Xcode-$1.app/Contents/Developer
    DevToolsSecurity -enable

    unset XCODE_INSTALL_USER
    unset XCODE_INSTALL_PASSWORD
}

function install_zsh {
    wait_for_user "ZSH will now be installed, which also starts ZSH. Please type 'exit' to close ZSH and let the script conitnue. Press enter"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function install_powerline-shell {
    pushd ~
        git clone https://github.com/banga/powerline-shell .powerline-shell
        cd .powerline-shell
        sudo python setup.py install
    popd

    echo -e "\n$(cat configs/powerline-shell.sh)" >> ~/.zshrc
}
