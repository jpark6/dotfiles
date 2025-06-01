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


# 현재 사용 가능한 theme 목록 가져오기
THEMES="gold
everforest
moon
coral
snow
forest
violet
redwine"

# 테마 목록이 비어있다면 종료
if [ -z "$THEMES" ]; then
  echo "❌ Tmux Power Theme 목록을 불러올 수 없습니다."
  exit 1
fi

# fzf 또는 select로 scheme 선택
if command -v fzf > /dev/null; then
  SELECTED=$(echo "$THEMES" | fzf --prompt="🌟 Select Tmux Power Theme: ")
else
  # 기본 select 메뉴
  echo "🌟 사용할 Tmux Power Theme를 선택하세요:"
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
echo "✅ '$SELECTED' 테마를 적용합니다."

case "$OSTYPE" in
  darwin*)
    sed -i "" "s|tmux_power_theme \'.*\'|tmux_power_theme \'$SELECTED\'|" $TMUX_FILE
    ;;
  *)
    sed -i "s|tmux_power_theme \'.*\'|tmux_power_theme \'$SELECTED\'|" $TMUX_FILE
    ;;
esac

tmux source-file ~/.tmux.conf
