#!/bin/bash
set -e

dockutil --remove all --no-restart
dockutil --add /Applications/iTerm.app --no-restart
dockutil --add /Applications/Google\ Chrome.app --no-restart

killall Dock

