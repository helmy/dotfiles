#!/bin/bash
set -e

# Source: https://gist.github.com/davejamesmiller/1965569
ask() {
  while true; do
    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi
    read -p "$1 [$prompt] " REPLY </dev/tty
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac
  done
}

install_brew() {
  hash brew 2>/dev/null || {
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  }
  brew tap homebrew/bundle
  brew bundle
}

customize_macos() {
  hash dockutil || {
    echo "dockutil not installed. run install.sh brew first"
    exit 1
  }
  dockutil --remove all --no-restart
  dockutil --add /Applications/iTerm.app --no-restart
  dockutil --add /Applications/Google\ Chrome.app --no-restart
  killall Dock

}

usage() {
  echo -e "install.sh\n\tThis script will setup my mac mac just the way I like it\n"
  echo "Usage:"
  echo "  brew                        - install homebrew and install default applications"
  echo "  macos                       - setup macOS defaults and customize dock"
}

main() {
  local cmd=$1

  if [[ -z "$cmd" ]]; then
    usage
    exit 1
  fi

  if [[ $cmd == "brew" ]]; then
    install_brew
  elif [[ $cmd == "macos" ]]; then
    customize_macos
  fi

}

main "$@"
