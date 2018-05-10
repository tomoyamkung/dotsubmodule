#!/bin/bash
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は FZF をインストールするスクリプトである。
    - [junegunn/fzf: A command-line fuzzy finder written in Go](https://github.com/junegunn/fzf)
  Github からソースコードを clone して ~/.fzf にインストールする。

Usage:
  $(basename ${0}) [-h]

Options:
  -h print this
EOF
  exit 0
}

while getopts hx OPT
do
  case "$OPT" in
    h) usage ;;
    \?) usage ;;
  esac
done

# 環境に FZF がインストールされている場合は処理を終了する
if [[ $(type fzf) ]]; then
  exit 1
fi

# GitHub からプロジェクトを clone してインストールスクリプトを実行する
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
sh ~/.fzf/install --all

exit 0
