#!/bin/bash
# tmux 開発用レイアウト
# 左上: nvim / 右上: claude / 左下: terminal / 右下: terminal

SESSION="${1:-dev}"
DIR="${2:-$(pwd)}"

# 既にセッションがあれば接続
tmux has-session -t "$SESSION" 2>/dev/null && exec tmux attach -t "$SESSION"

# 新規セッション（左上: nvim）
tmux new-session -d -s "$SESSION" -c "$DIR" -x "$(tput cols)" -y "$(tput lines)"
NVIM_PANE=$(tmux display-message -t "$SESSION" -p '#{pane_id}')
tmux send-keys -t "$NVIM_PANE" "nvim ." Enter

# 右上: claude（左を水平分割）
tmux split-window -h -t "$NVIM_PANE" -c "$DIR"
CC_PANE=$(tmux display-message -t "$SESSION" -p '#{pane_id}')
tmux send-keys -t "$CC_PANE" "claude" Enter

# 左下: terminal（左上ペインを垂直分割）
tmux split-window -v -t "$NVIM_PANE" -c "$DIR"

# 右下: terminal（右上ペインを垂直分割）
tmux split-window -v -t "$CC_PANE" -c "$DIR"

# レイアウト調整（左列60%幅、上段70%高さ）
tmux resize-pane -t "$NVIM_PANE" -x 60% -y 70%
tmux resize-pane -t "$CC_PANE" -y 70%

# 左上（nvim）にフォーカス
tmux select-pane -t "$NVIM_PANE"

# 接続
tmux attach -t "$SESSION"
