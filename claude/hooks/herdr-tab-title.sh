#!/bin/sh
# Claude Code の UserPromptSubmit フック
# 送信したプロンプトの先頭を herdr のタブ名に反映する。
#
# herdr が入れる ~/.claude/hooks/herdr-agent-state.sh は herdr 管理下で
# 再インストール時に上書きされるため、カスタム処理はこのファイルに分けている。
#
# 注意: UserPromptSubmit の stdout はモデルのコンテキストに注入されるので、
#       このスクリプトは絶対に標準出力へ何も書かない。
set -u

# herdr の外（素の Ghostty 等）では何もしない
[ "${HERDR_ENV:-}" = "1" ] || exit 0
[ -n "${HERDR_PANE_ID:-}" ] || exit 0
command -v herdr >/dev/null 2>&1 || exit 0
command -v python3 >/dev/null 2>&1 || exit 0

HERDR_HOOK_INPUT="$(cat 2>/dev/null)" || exit 0
[ -n "$HERDR_HOOK_INPUT" ] || exit 0
export HERDR_HOOK_INPUT

python3 - <<'PY' >/dev/null 2>&1
import json
import os
import subprocess

MAX_CHARS = 20

try:
    data = json.loads(os.environ.get("HERDR_HOOK_INPUT") or "{}")
except Exception:
    raise SystemExit(0)

# サブエージェントのプロンプトでタブ名を書き換えない
if data.get("agent_id"):
    raise SystemExit(0)

prompt = " ".join((data.get("prompt") or "").split())
if not prompt:
    raise SystemExit(0)
title = prompt[:MAX_CHARS]

pane_id = os.environ.get("HERDR_PANE_ID")
if not pane_id:
    raise SystemExit(0)

try:
    out = subprocess.run(
        ["herdr", "pane", "get", pane_id],
        capture_output=True, text=True, timeout=3,
    )
    tab_id = json.loads(out.stdout)["result"]["pane"]["tab_id"]
except Exception:
    raise SystemExit(0)

try:
    subprocess.run(
        ["herdr", "tab", "rename", tab_id, title],
        capture_output=True, timeout=3,
    )
except Exception:
    raise SystemExit(0)
PY

exit 0
