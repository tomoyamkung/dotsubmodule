#!/bin/bash
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は The Silver Searcher をインストールするスクリプトである。
  The Silver Searcher は `yum` を使ってインストールする。

Usage:
  $(basename ${0}) [-h] [-v]

Options:
  -h print this
EOF
  exit 0
}

verbose=
while getopts hv OPT
do
  case "$OPT" in
    h) usage ;;
    v) verbose=true ;;
    \?) usage ;;
  esac
done

# 環境に `yum` を使って pcre-devel をインストールする
if [[ ! $(sudo yum list installed | grep pcre-devel) ]]; then
  [[ -n ${verbose} ]] && echo "install pcre-devel"
  sudo yum -y install pcre-devel
fi

# 環境に `yum` を使って xz-devel をインストールする
if [[ ! $(sudo yum list installed | grep xz-devel) ]]; then
  [[ -n ${verbose} ]] && echo "install xz-devel"
  sudo yum -y install xz-devel
fi

# 環境に `yum` を使って automake をインストールする
if [[ ! $(sudo yum list installed | grep automake) ]]; then
  [[ -n ${verbose} ]] && echo "install automake"
  sudo yum -y install automake
fi

# 環境に `yum` を使って the_silver_searcher をインストールする
if [[ ! $(sudo yum list installed | grep the_silver_searcher) ]]; then
  [[ -n ${verbose} ]] && echo "install the_silver_searcher"
  sudo yum -y install the_silver_searcher
fi

exit 0
