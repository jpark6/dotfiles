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
THEMES=( $(find powerline -name '*.tmuxtheme' | sed 's|^powerline\/||' | sed 's|\.tmuxtheme$||'))
THEME_CNT=${#THEMES[@]}

RANDOM_THEME="${THEMES[RANDOM % $THEME_CNT + 1]}"

echo "🔀 Change Random Theme 🎲"
echo "🎰 Theme Name : $RANDOM_THEME ♣️"

case "$OSTYPE" in
  darwin*)
    sed -i "" "s|powerline\/.*\'|powerline\/$RANDOM_THEME\'|" $TMUX_FILE
    ;;
  *)
    sed -i "s|powerline\/.*\'|powerline\/$RANDOM_THEME\'|" $TMUX_FILE
    ;;
esac

tmux source-file ~/.tmux.conf
