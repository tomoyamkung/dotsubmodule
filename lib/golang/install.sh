#!/bin/bash
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は golang をインストールするスクリプトである。

Usage:
  $(basename ${0}) [-h]

Options:
  -h print this
EOF
  exit 0
}

while getopts h OPT
do
  case "$OPT" in
    h) usage ;;
    \?) usage ;;
  esac
done

# 環境に golang がインストールされている場合は処理を終了する
if [[ $(type go 2&>1 /dev/null) ]]; then
  exit 1
fi

golang_binary=go.tar.gz
golang_binary_path=/tmp/${golang_binary}

# golang のバイナリが存在しなければダウンロードする
if [[ ! -f "${golang_binary_path}" ]]; then
  curl https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz -o "${golang_binary_path}"
fi
# golang のディレクトリが存在しなければアーカイブを解答する
if [[ ! -d /usr/local/go ]]; then
  sudo tar -C /usr/local/ -xzf "${golang_binary_path}"
fi
# ~/.bashrc に golang の設定がなければ追記する
if ! grep -q 'GOPATH' ~/.bashrc; then
  cat <<'EOF' >> ~/.bashrc
# golang settings
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
EOF
fi

exit 0
