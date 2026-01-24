#!/bin/sh
set -u

BASEDIR=$(dirname $0)
cd $BASEDIR

# ドットファイルのシンボリックリンク（既存の処理）
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = ".config" ] && continue  # .configは別処理
    ln -snfv ${PWD}/"$f" ~/
done

# .config 以下の処理
if [ -d ".config" ]; then
    mkdir -p ~/.config
    for dir in .config/*; do
        ln -snfv ${PWD}/"$dir" ~/.config/
    done
fi
