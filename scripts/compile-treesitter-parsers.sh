#!/bin/bash
# treesitter パーサーを手動コンパイル
# nvim-treesitter の tree-sitter build が Docker 内で動かないための回避策
# parsers.lua から正しいリビジョンを取得し、tree-sitter generate で ABI を合わせ、cc -shared でコンパイル

set -e

NVIM_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
PARSER_DIR="$NVIM_DATA/site/parser"
PARSERS_LUA="$NVIM_DATA/lazy/nvim-treesitter/lua/nvim-treesitter/parsers.lua"

LANGS="python javascript typescript tsx lua json yaml bash html css dockerfile vim vimdoc markdown markdown_inline terraform hcl"

[ -f "$PARSERS_LUA" ] || { echo "parsers.lua not found"; exit 1; }
which cc >/dev/null 2>&1 || { echo "cc not found"; exit 1; }

ABI=$(nvim --headless -c "lua io.write(tostring(vim.treesitter.language_version))" -c "qa" 2>&1 | tr -d '[:space:]')
[ -n "$ABI" ] || ABI=15

mkdir -p "$PARSER_DIR"

get_field() {
  grep -A15 "^  ${1} = {" "$PARSERS_LUA" | grep "${2} =" | head -1 | sed "s/.*'\(.*\)'.*/\1/"
}

for lang in $LANGS; do
  [ -f "$PARSER_DIR/$lang.so" ] && continue

  rev=$(get_field "$lang" "revision")
  url=$(get_field "$lang" "url")
  location=$(get_field "$lang" "location")
  [ -z "$rev" ] || [ -z "$url" ] && continue

  repo=$(echo "$url" | sed 's|https://github.com/||')
  workdir="/tmp/ts-$lang"
  rm -rf "$workdir" && mkdir -p "$workdir"

  echo -n "Compiling $lang... "
  if ! curl -sfL "https://github.com/$repo/archive/$rev.tar.gz" | tar xz --strip-components=1 -C "$workdir"; then
    echo "download failed"; rm -rf "$workdir"; continue
  fi

  srcdir="$workdir"
  [ -n "$location" ] && srcdir="$workdir/$location"

  # ABI を合わせるために parser.c を再生成
  if [ -f "$srcdir/src/grammar.json" ] && which tree-sitter >/dev/null 2>&1; then
    (cd "$srcdir" && tree-sitter generate --abi "$ABI" src/grammar.json 2>/dev/null) || true
  fi

  # ソースファイル検出・コンパイル
  src_files="$srcdir/src/parser.c"
  has_cc=false
  [ -f "$srcdir/src/scanner.c" ] && src_files="$src_files $srcdir/src/scanner.c"
  [ -f "$srcdir/src/scanner.cc" ] && { src_files="$src_files $srcdir/src/scanner.cc"; has_cc=true; }

  if $has_cc; then
    c++ -shared -fPIC -o "$PARSER_DIR/$lang.so" -I"$srcdir/src" $src_files -O2 2>/dev/null && echo "ok" || echo "failed"
  else
    cc -shared -fPIC -o "$PARSER_DIR/$lang.so" -I"$srcdir/src" $src_files -O2 2>/dev/null && echo "ok" || echo "failed"
  fi

  rm -rf "$workdir"
done
