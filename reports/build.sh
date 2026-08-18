#!/usr/bin/env bash
# Typst 0.15+ 와 Noto Sans KR 폰트가 필요하다.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/us-30y-ai-capital-briefing.typ"
OUT="$ROOT/미국_30년물_금리_AI_자본전쟁_브리핑.pdf"

if ! command -v typst >/dev/null 2>&1; then
  echo "typst 가 PATH 에 없습니다. https://github.com/typst/typst/releases" >&2
  exit 1
fi

FONT_ARGS=()
if [[ -d "${FONT_PATH:-}" ]]; then
  FONT_ARGS+=(--font-path "$FONT_PATH")
elif [[ -d /tmp/fonts ]]; then
  FONT_ARGS+=(--font-path /tmp/fonts)
fi

typst compile "${FONT_ARGS[@]}" "$SRC" "$OUT"
echo "wrote $OUT"
