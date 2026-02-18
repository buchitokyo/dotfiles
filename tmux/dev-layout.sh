#!/bin/bash
# tmux 開発用レイアウト
# 左上: nvim / 右上: ccmanager / 左下: terminal / 右下: terminal

SESSION="${1:-dev}"
DIR="${2:-$(pwd)}"

# 既にセッションがあれば接続
tmux has-session -t "$SESSION" 2>/dev/null && exec tmux attach -t "$SESSION"

# 新規セッション（左上: nvim）
tmux new-session -d -s "$SESSION" -c "$DIR" -x "$(tput cols)" -y "$(tput lines)"
tmux send-keys -t "$SESSION" "nvim ." Enter

# 右上: ccmanager
tmux split-window -h -t "$SESSION" -c "$DIR"
tmux send-keys -t "$SESSION" "ccmanager" Enter

# 左下: terminal（左上ペインを分割）
tmux select-pane -t "$SESSION:.1"
tmux split-window -v -t "$SESSION" -c "$DIR"

# 右下: terminal（右上ペインを分割）
tmux select-pane -t "$SESSION:.2"
tmux split-window -v -t "$SESSION" -c "$DIR"

# レイアウト調整
tmux select-pane -t "$SESSION:.1"
tmux resize-pane -x 60%
tmux resize-pane -t "$SESSION:.1" -y 70%
tmux resize-pane -t "$SESSION:.2" -y 70%

# 左上（nvim）にフォーカス
tmux select-pane -t "$SESSION:.1"

# 接続
tmux attach -t "$SESSION"
