#!/bin/bash

case "$OSTYPE" in
  darwin*)
    ALACRITTY_FILE="/Users/jakepark/Repos/.settings/alacritty/alacritty.toml.macos"
    THEME_DIR="/Users/jakepark/Repos/.settings/alacritty/themes"
    ;;
  *)
    ALACRITTY_FILE="/mnt/d/Repos/.settings/alacritty/alacritty.toml.macos"
    THEME_DIR="/mnt/d/Repos/.settings/alacritty/themes"
    ;;
esac

THEME_CNT=$(ls $THEME_DIR | wc -l)

THEMES=()
while IFS= read -r line; do
  THEMES+=("$line")
done < <(ls $THEME_DIR)

echo $THEMES[1]

RANDOM_THEME="${THEMES[RANDOM % $THEME_CNT + 1]}"

echo "🔀 Change Alacritty Random Theme 🎲"
echo "🎰 Theme Name : $RANDOM_THEME ♣️"

case "$OSTYPE" in
  darwin*)
    sed -i "" "s|themes\/.*\"|themes\/$RANDOM_THEME\"|" $ALACRITTY_FILE
    ;;
  *)
    sed -i "s|themes\/.*\"|themes\/$RANDOM_THEME\"|" $ALACRITTY_FILE
    ;;
esac
