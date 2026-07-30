#!/bin/bash
# herdr 開発用レイアウト（旧 tmux/dev-layout.sh）
# 左上: nvim / 右上: claude / 左下: shell / 右下: shell
#
# 使い方:
#   dev-layout.sh [DIR] [LABEL]
# herdr の外から実行した場合は、レイアウトを組んだうえでクライアントを起動する。
set -euo pipefail   # pipefail 必須: herdr ... | jq のパイプで herdr のエラーを埋もらせない

DIR="${1:-$PWD}"
DIR="$(cd "$DIR" && pwd)"
LABEL="${2:-$(basename "$DIR")}"
HERDR="${HERDR_BIN_PATH:-herdr}"

command -v jq >/dev/null || { echo "dev-layout.sh: jq が必要です" >&2; exit 1; }

# ID を取り出しつつ、空や null なら即エラーにする
pane_id() {
  local id
  id=$(jq -r "$1")
  [ -n "$id" ] && [ "$id" != "null" ] || { echo "dev-layout.sh: pane id を取得できません ($1)" >&2; return 1; }
  printf '%s' "$id"
}

# ソケット API を使うにはサーバが必要。herdr の外から実行された場合は起動していない
# ことがある。
#
# 判定に `herdr status server` は使わない。あれは常に exit 0 を返すうえ、サーバが
# ビジーなときは稼働中でも "not running" を返す（偽陰性）。実際の API 呼び出しの
# 終了コード（疎通 0 / 不通 1）で判定するのが確実。
api_reachable() {
  "$HERDR" workspace list >/dev/null 2>&1
}

if ! api_reachable; then
  # nohup + disown でスクリプトのプロセスグループから切り離す。
  # そうしないとスクリプト終了時にサーバが巻き込まれ、作成直後のレイアウトが失われる。
  nohup "$HERDR" server >/dev/null 2>&1 &
  disown || true
  ok=""
  for _ in $(seq 1 50); do
    if api_reachable; then ok=1; break; fi
    sleep 0.2
  done
  [ -n "$ok" ] || { echo "dev-layout.sh: herdr server に接続できません" >&2; exit 1; }
fi

# 同名ワークスペースが既にあればフォーカスするだけ（旧 has-session 相当）
existing=$("$HERDR" workspace list \
  | jq -r --arg l "$LABEL" '.result.workspaces[]? | select(.label == $l) | .workspace_id' \
  | head -n 1)

if [ -n "$existing" ]; then
  "$HERDR" workspace focus "$existing" >/dev/null
else
  root=$("$HERDR" workspace create --cwd "$DIR" --label "$LABEL" \
    | pane_id '.result.root_pane.pane_id')

  # 右上: claude（左列を 60% に）
  cc=$("$HERDR" pane split "$root" --direction right --ratio 0.6 --no-focus \
    | pane_id '.result.pane.pane_id')
  # 左下 / 右下: shell（上段を 70% に）
  "$HERDR" pane split "$root" --direction down --ratio 0.7 --no-focus >/dev/null
  "$HERDR" pane split "$cc"   --direction down --ratio 0.7 --no-focus >/dev/null

  # シェルの起動を待ってからコマンドを流す
  sleep 1
  "$HERDR" pane run "$root" "nvim ."
  "$HERDR" pane run "$cc"   "claude"
  # --no-focus で分割したので、フォーカスは左上（nvim）に残っている
fi

# herdr の外から呼ばれた場合はクライアントにアタッチ
[ "${HERDR_ENV:-}" = "1" ] || exec "$HERDR"
