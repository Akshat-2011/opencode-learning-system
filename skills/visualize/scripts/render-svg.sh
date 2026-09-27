#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "usage: render-svg.sh <input.svg> <output.png>" >&2
  exit 2
fi

in="$1"
out="$2"

if [ ! -f "$in" ]; then
  echo "input not found: $in" >&2
  exit 1
fi

mkdir -p "$(dirname "$out")"

if command -v rsvg-convert >/dev/null 2>&1; then
  rsvg-convert -o "$out" "$in"
elif command -v magick >/dev/null 2>&1; then
  magick -background none "$in" "$out"
elif command -v convert >/dev/null 2>&1; then
  convert -background none "$in" "$out"
else
  echo "no SVG renderer found (need rsvg-convert, magick, or convert)" >&2
  exit 1
fi

echo "rendered: $out"
