#!/bin/bash

# 현재 사용 가능한 preset 목록 가져오기
PRESETS=$(starship preset --list)

# 프리셋 목록이 비어있다면 종료
if [ -z "$PRESETS" ]; then
  echo "❌ starship preset 목록을 불러올 수 없습니다."
  exit 1
fi

# fzf 또는 select로 preset 선택
if command -v fzf > /dev/null; then
  # fzf 사용 가능하면
  SELECTED=$(echo "$PRESETS" | fzf --prompt="🌟 Select Starship Preset: ")
else
  # 기본 select 메뉴
  echo "🌟 사용할 Starship preset을 선택하세요:"
  select opt in $PRESETS; do
    SELECTED="$opt"
    break
  done
fi

# 선택한 preset이 비어있으면 종료
if [ -z "$SELECTED" ]; then
  echo "❌ 선택이 취소되었습니다."
  exit 1
fi

# 적용
echo "✅ '$SELECTED' 프리셋을 적용합니다..."

# preset 적용
starship preset "$SELECTED" > ~/.config/starship.toml

echo "✨ Starship preset '$SELECTED' 이(가) 적용되었습니다!"

