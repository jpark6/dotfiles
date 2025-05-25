#!/bin/bash

case "$OSTYPE" in
  darwin*)
    LUA_FILE="/Users/jakepark/Repos/.settings/nvim/lua/config/plugins.lua"
    THEME_DIR="/Users/jakepark/.local/share/nvim/lazy/lualine.nvim/lua/lualine/themes"
    ;;
  *)
    LUA_FILE="/mnt/d/Repos/.settings/nvim/lua/config/plugins.lua"
    THEME_DIR="/mnt/d/.local/share/nvim/lazy/lualine.nvim/lua/lualine/themes"
    ;;
esac

THEME_CNT=`ls $THEME_DIR | wc -l`
echo $THEME_CNT

THEMES=()
while IFS= read -r line; do
  THEMES+=("$line")
done < <(ls $THEME_DIR)

RANDOM_THEME=`echo "${THEMES[RANDOM % $THEME_CNT + 1]}" | sed 's|\.lua$||'`

echo "🔀 Change nvim lualine Random Theme 🎲"
echo "🎰 Theme Name : $RANDOM_THEME ♣️"

sed -i "" "s|theme = \".*\"|theme = \"$RANDOM_THEME\"|" $LUA_FILE
