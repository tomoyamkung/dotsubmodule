#!/bin/bash
set -eu

function usage() {
  cat <<EOF
Description:
  $(basename ${0}) は yum を使ってパッケージをインストールするスクリプトである。
  'yum list installed' の実行結果に指定したパッケージが含まれていない場合のみインストールするようになっている。

Usage:
  $(basename ${0}) [-f][-h][-v]

Options:
  -f 'yum list installed' でインストールされているかを確認せずに 'yum install' を実行する
  -h print this
  -v 'yum list installed' した結果、パッケージがインストールされていたらその旨を出力する
EOF
}

force=
verbose=
while getopts fhv OPT
do
  case "${OPT}" in
    f) force=true
       ;;
    h) usage
       exit 1
       ;;
    v) verbose=true
       ;;
    \?) usage
        exit 1
        ;;
  esac
done

shift `expr ${OPTIND} - 1`
package_name="$1"

if [[ -n "${force}" ]]; then
  sudo yum -y install "${package_name}"
  exit 0
fi

if [[ $(sudo yum list installed | grep "${package_name}" > /dev/null) -eq 0 ]]; then
  [[ -n "${verbose}" ]] && echo "${package_name} was installed."
  exit 2
fi

sudo yum -y install "${package_name}"
exit 0
