#!/usr/bin/env bash
# Typst 0.13+ 와 Noto Sans KR 폰트가 필요하다.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"

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

compile() {
  local src="$1"
  local out="$2"
  typst compile "${FONT_ARGS[@]}" "$src" "$out"
  echo "wrote $out"
}

compile "$ROOT/us-30y-ai-capital-briefing.typ" "$ROOT/미국_30년물_금리_AI_자본전쟁_브리핑.pdf"
compile "$ROOT/discussion-who-blinks.typ" "$ROOT/누가_먼저_항복하는가_후속논의.pdf"
compile "$ROOT/individual-investor-playbook.typ" "$ROOT/개인투자자_대응틀.pdf"
compile "$ROOT/crypto-unproductive-duration.typ" "$ROOT/가상화폐_생산성없는_자산의_시간.pdf"
compile "$ROOT/us-30y-ai-capital-combined.typ" "$ROOT/미국_30년물_금리_AI_자본전쟁_합본.pdf"
