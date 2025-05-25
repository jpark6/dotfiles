#!/bin/bash

cd ~/.tmux/plugins/tmux-themepack

case "$OSTYPE" in
  darwin*)
    TMUX_FILE="/Users/jakepark/Repos/.settings/.tmux.conf"
    ;;
  *)
    TMUX_FILE="/mnt/d/Repos/.settings/.tmux.conf"
    ;;
esac
THEMES=( `find powerline -name '*.tmuxtheme' | sed 's|\.tmuxtheme$||'`)
THEME_CNT=${#THEMES[@]}

RANDOM_THEME="${THEMES[RANDOM % $THEME_CNT + 1]}"

echo "🔀 Change Random Theme 🎲"
echo "🎰 Theme Name : $RANDOM_THEME ♣️"

sed -i "" "s|powerline\/.*\'|$RANDOM_THEME\'|" $TMUX_FILE
