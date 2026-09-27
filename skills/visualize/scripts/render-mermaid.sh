#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "usage: render-mermaid.sh <input.mmd> <output.png>" >&2
  exit 2
fi

in="$1"
out="$2"

if [ ! -f "$in" ]; then
  echo "input not found: $in" >&2
  exit 1
fi

mkdir -p "$(dirname "$out")"

if [ -z "${PUPPETEER_EXECUTABLE_PATH:-}" ]; then
  for c in chromium chromium-browser google-chrome google-chrome-stable; do
    if command -v "$c" >/dev/null 2>&1; then
      export PUPPETEER_EXECUTABLE_PATH="$(command -v "$c")"
      break
    fi
  done
fi

puppeteer_args=()
if [ "$(id -u)" = "0" ]; then
  cfg="$(mktemp)"
  printf '{"args":["--no-sandbox","--disable-setuid-sandbox"]}' > "$cfg"
  puppeteer_args=(-p "$cfg")
  trap 'rm -f "$cfg"' EXIT
fi

if command -v mmdc >/dev/null 2>&1; then
  mmdc -i "$in" -o "$out" "${puppeteer_args[@]}" --quiet
else
  npx -y @mermaid-js/mermaid-cli -i "$in" -o "$out" "${puppeteer_args[@]}" --quiet
fi

echo "rendered: $out"
