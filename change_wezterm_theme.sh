#!/bin/bash

case "$OSTYPE" in
  darwin*)
    WEZTERM_FILE="/Users/jakepark/Repos/.settings/.wezterm.lua"
    SCHEMES_FILE="/Users/jakepark/Repos/.settings/wezterm_color_scheme_list.txt"
    ;;
  *)
    WEZTERM_FILE="/mnt/d/Repos/.settings/.wezterm.lua"
    SCHEMES_FILE="/mnt/d/Repos/.settings/wezterm_color_scheme_list.txt"
    ;;
esac


# 현재 사용 가능한 scheme 목록 가져오기
SCHEMES=`cat $SCHEMES_FILE`

# 프리셋 목록이 비어있다면 종료
if [ -z "$SCHEMES" ]; then
  echo "❌ WezTerm Scheme 목록을 불러올 수 없습니다."
  exit 1
fi

# fzf 또는 select로 scheme 선택
if command -v fzf > /dev/null; then
  SELECTED=$(echo "$SCHEMES" | fzf --prompt="🌟 Select WezTerm Scheme: ")
else
  # 기본 select 메뉴
  echo "🌟 사용할 WezTerm Scheme을 선택하세요:"
  select opt in $SCHEMES; do
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

sed -i "" "s|config.color_scheme = '.*'|config.color_scheme = '$SELECTED'|" $WEZTERM_FILE
