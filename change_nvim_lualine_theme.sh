#!/bin/bash

case "$OSTYPE" in
  darwin*)
    LUA_FILE="/Users/jakepark/Repos/.settings/nvim/lua/config/plugins.lua"
    THEME_DIR="/Users/jakepark/.local/share/nvim/lazy/lualine.nvim/lua/lualine/themes"
    ;;
  *)
    LUA_FILE="/mnt/d/Repos/.settings/nvim/lua/config/plugins.lua"
    THEME_DIR="/home/ubuntu/.local/share/nvim/lazy/lualine.nvim/lua/lualine/themes"
    ;;
esac

# 현재 사용 가능한 theme 목록 가져오기
THEMES=`find "$THEME_DIR" -type f -name "*.lua" -exec basename {} .lua \; | sort`

# 프리셋 목록이 비어있다면 종료
if [ -z "$THEMES" ]; then
  echo "❌ LuaLine Theme 목록을 불러올 수 없습니다."
  exit 1
fi

# fzf 또는 select로 scheme 선택
if command -v fzf > /dev/null; then
  SELECTED=$(echo "$THEMES" | fzf --prompt="🌟 Select LuaLine Theme: ")
else
  # 기본 select 메뉴
  echo "🌟 사용할 LuaLine Theme을 선택하세요:"
  select opt in $THEMES; do
    SELECTED="$opt"
    break
  done
fi

# 선택한 scheme이 비어있으면 종료
if [ -z "$SELECTED" ]; then
  echo "❌ 선택이 취소되었습니다."
  exit 1
fi

# 적용
echo "✅ '$SELECTED' 프리셋을 적용합니다."

case "$OSTYPE" in
  darwin*)
    sed -i "" "s|theme = \".*\"|theme = \"$SELECTED\"|" $LUA_FILE
    ;;
  *)
    sed -i "s|theme = \".*\"|theme = \"$SELECTED\"|" $LUA_FILE
    ;;
esac
