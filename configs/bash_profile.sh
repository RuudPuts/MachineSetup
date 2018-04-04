# aliasses
alias hue1="ssh PUTSRUUD@nlhued01.sgti.nl"
alias hue2="ssh PUTSRUUD@nlhued02.sgti.nl"
alias fusion="ssh jenkins@nlhued01.sgti.nl -p 9500"
alias ssd="ssh jenkins@nlhued01.sgti.nl -p 9510"
alias megatron="ssh jenkins@nlhued01.sgti.nl -p 9520"
alias mickey="ssh jenkins@nlhued01.sgti.nl -p 9530"

alias gh="cd ~/Projects/Hue/iOS-Play/Hue"
alias ghd="cd ~/Projects/Hue"
alias ghci="cd ~/Projects/Hue/HueAppCI"
alias gdwn="cd ~/Projects/Down/Down"

alias fl="bundle exec fastlane"
alias flb="fl build"
alias flba="fl build_appstore"

alias flbe="fl build_entertainment"
alias flbae="fl build_appstore_entertainment"

alias fldtr="fl download_translations type:release"
alias fldtd="fl download_translations type:development"

alias unlock_keychain="security unlock -p power96]red ~/Library/Keychains/Philips_Hue_2.0.keychain"

alias idb="ios-deploy -b"
alias flbi="unlock_keychain && flb && idb Artifacts/Hue_Internal.ipa"
alias xcp="xcode-select -p"

alias dk="docker"
alias dkr="docker run"
alias dkb="docker build"
alias dkk="docker kill"

alias QQ="sudo pkill /.*/"
alias ragequit="QQ"

xcs() {
  sudo xcode-select --switch /Applications/Xcode_$1.app/Contents/Developer
}

runfile() {
  while true
  do
    clear
    fswatch $1 | $2 $1
  done
}

dcp() {
  echo "Searching system log for $1"
  deviceconsole | grep ' $1\['
}
