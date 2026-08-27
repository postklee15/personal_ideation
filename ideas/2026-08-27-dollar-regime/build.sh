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

typst compile "${FONT_ARGS[@]}" "$ROOT/dollar-regime-audit.typ" "$ROOT/달러_체제_가정_평가.pdf"
echo "wrote $ROOT/달러_체제_가정_평가.pdf"
