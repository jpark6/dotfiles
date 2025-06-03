#!/bin/bash

case "$OSTYPE" in
  darwin*)
    ALACRITTY_FILE="/Users/jakepark/Repos/.settings/alacritty/alacritty.toml.macos"
    THEME_DIR="/Users/jakepark/Repos/.settings/alacritty/themes"
    ;;
  *)
    ALACRITTY_FILE="/mnt/d/Repos/.settings/alacritty/alacritty.toml.window"
    THEME_DIR="/mnt/d/Repos/.settings/alacritty/themes"
    ;;
esac

# 현재 사용 가능한 theme 목록 가져오기
THEMES=$(find "$THEME_DIR" -type f -name "*.toml" -exec basename {} \;)
# 프리셋 목록이 비어있다면 종료
if [ -z "$THEMES" ]; then
  echo "❌ Alacritty Theme 목록을 불러올 수 없습니다."
  exit 1
fi

# fzf 또는 select로 theme 선택
if command -v fzf > /dev/null; then
  SELECTED=$(echo "$THEMES" | fzf --prompt="🌟 Select Alacritty Theme: ")
else
  # 기본 select 메뉴
  echo "🌟 사용할 Alacritty Theme을 선택하세요:"
  select opt in $THEMES; do
    SELECTED="$opt"
    break
  done
fi

# 선택한 theme이 비어있으면 종료
if [ -z "$SELECTED" ]; then
  echo "❌ 선택이 취소되었습니다."
  exit 1
fi

# 적용
echo "✅ '$SELECTED' 테마를 적용합니다."

case "$OSTYPE" in
  darwin*)
    sed -i "" "s|themes\/.*\"|themes\/$SELECTED\"|" $ALACRITTY_FILE
    ;;
  *)
    sed -i "s|themes\/.*\"|themes\/$SELECTED\"|" $ALACRITTY_FILE
    ;;
esac
