#!/bin/zsh
# yazi ポップアップ。終了時に、下のタイル済みペインを cd させる。
# popup 実行時は HERDR_PANE_ID が渡らないため HERDR_ACTIVE_PANE_ID を使う。
set -u

herdr_bin="${HERDR_BIN_PATH:-herdr}"
tmp=$(mktemp -t yazi-cwd.XXXXXX)
trap 'rm -f -- "$tmp"' EXIT

cd "${HERDR_ACTIVE_PANE_CWD:-$PWD}" 2>/dev/null || true
yazi --cwd-file="$tmp"

cwd=$(cat -- "$tmp" 2>/dev/null) || exit 0
[ -n "$cwd" ] || exit 0
[ "$cwd" = "${HERDR_ACTIVE_PANE_CWD:-}" ] && exit 0
[ -n "${HERDR_ACTIVE_PANE_ID:-}" ] || exit 0

"$herdr_bin" pane send-text "$HERDR_ACTIVE_PANE_ID" "cd \"$cwd\""
"$herdr_bin" pane send-keys "$HERDR_ACTIVE_PANE_ID" enter
