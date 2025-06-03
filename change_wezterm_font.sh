#!/bin/bash

case "$OSTYPE" in
  darwin*)
    WEZTERM_FILE="/Users/jakepark/Repos/.settings/.wezterm.lua"
    ;;
  *)
    WEZTERM_FILE="/mnt/c/Users/banseok/.wezterm.lua"
    ;;
esac


# 현재 사용 가능한 font 목록 가져오기
FONTS=$(
wezterm ls-fonts --list-system \
  | awk -F '[(),]' '/Nerd Font/ && /wezterm.font/ { gsub(/"/, "", $2); if ($2 ~ / Nerd Font$/) { sub(/ Nerd Font$/, "", $2); print $2 } }' \
  | sort -u
  )

# 프리셋 목록이 비어있다면 종료
if [ -z "$FONTS" ]; then
  echo "❌ WezTerm Font 목록을 불러올 수 없습니다."
  exit 1
fi

# fzf 또는 select로 font 선택
if command -v fzf > /dev/null; then
  SELECTED=$(echo "$FONTS" | sed "s|\r||" | fzf --prompt="🌟 Select WezTerm Font: ")
else
  # 기본 select 메뉴
  echo "🌟 사용할 WezTerm Font를 선택하세요:"
  select opt in $FONTS; do
    SELECTED="$opt"
    break
  done
fi

# 선택한 font이 비어있으면 종료
if [ -z "$SELECTED" ]; then
  echo "❌ 선택이 취소되었습니다."
  exit 1
fi

# 적용
echo "✅ '$SELECTED' 폰트를 적용합니다."

case "$OSTYPE" in
  darwin*)
    sed -i "" "s|wezterm.font(\".*\",|wezterm.font(\"$SELECTED Nerd Font\",|" $WEZTERM_FILE
    ;;
  *)
    sed -i "s|wezterm.font(\".*\",|wezterm.font(\"$SELECTED Nerd Font\",|" $WEZTERM_FILE
    ;;
esac
