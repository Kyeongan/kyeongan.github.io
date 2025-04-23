#!/bin/bash

# 사용법: ./make_gif_5x.sh input.mov

INPUT="$1"
BASENAME=$(basename "$INPUT" .mov)
FPS=10
SCALE=1000
SPEED=5
PTS=$(awk "BEGIN{print 1/$SPEED}")

if [[ -z "$INPUT" ]]; then
  echo "❗ 사용법: $0 input.mov"
  exit 1
fi

echo "🎞️  입력 파일: $INPUT"
echo "⚡  ${SPEED}배속으로 GIF 생성 중..."
echo "🖼️  프레임: $FPS fps / 폭: ${SCALE}px"

# 팔레트 생성
ffmpeg -i "$INPUT" -filter_complex \
"[0:v]setpts=${PTS}*PTS,fps=${FPS},scale=${SCALE}:-1:flags=lanczos,palettegen" \
-y palette.png

# GIF 생성
ffmpeg -i "$INPUT" -i palette.png -filter_complex \
"[0:v]setpts=${PTS}*PTS,fps=${FPS},scale=${SCALE}:-1:flags=lanczos[x];[x][1:v]paletteuse" \
-y "${BASENAME}_${SPEED}x.gif"

# 정리
rm -f palette.png

echo "✅ 완료: ${BASENAME}_${SPEED}x.gif"