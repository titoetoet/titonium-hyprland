#!/bin/sh

set -eu

screenshot_dir="$HOME/Pictures/Screenshots"
mkdir -p "$screenshot_dir"

timestamp=$(date '+%Y-%m-%d_%H-%M-%S-%N')
output="$screenshot_dir/Screenshot_$timestamp.png"

case "${1:-region}" in
	region)
		geometry=$(slurp) || exit 0
		[ -n "$geometry" ] || exit 0
		grim -g "$geometry" - | tee "$output" | wl-copy --type image/png
		;;
	fullscreen)
		grim - | tee "$output" | wl-copy --type image/png
		;;
	*)
		printf 'Usage: %s {region|fullscreen}\n' "$0" >&2
		exit 2
		;;
esac

notify-send "Screenshot saved" "$output"
