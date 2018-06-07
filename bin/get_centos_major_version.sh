#!/bin/bash
set -eu

function usage() {
  cat <<EOF
Description:
  $(basename ${0}) は CentOS のバージョンを出力するスクリプトである。
  -M オプションを指定するとメジャーバージョンだけを出力する。

Usage:
  $(basename ${0}) [-M][-h]

Options:
  -M メジャーバージョンだけを出力する
  -h print this
EOF
}

major=""
while getopts Mh OPT
do
  case "$OPT" in
    M) major=true
       ;;
    h) usage
       exit 1
       ;;
    \?) usage
        exit 1
        ;;
  esac
done

version=$(cat /etc/redhat-release | awk '{
  if(NF == 5) {  # CentOS 7.x の場合は 5 カラム出力
    print $4
  } else if(NF == 4) {  # CentOS 6.x の場合は 4 カラム出力
    print $3
  }
}')

if [[ -n "${major}" ]]; then  # メジャーバージョン指定
  echo "${version}" | cut -d"." -f1
else
  echo "${version}"
fi
exit 0
