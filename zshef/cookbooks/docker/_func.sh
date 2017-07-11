#!/usr/bin/env zsh

function my::docker::language::init() {
  local docker_img="$1"
  local docker_run="$2"
  local bin_dir="$3"

  local tmpfile=$(mktemp)
  local bin_list=($(${=docker_run} ${=docker_img} ls --color=never -1 ${bin_dir} | tr -d '\r' | xargs))
  for b in ${bin_list[@]}
  do
    echo "alias $b='${=docker_run} -v \$(pwd):\$(pwd) -w \$(pwd) ${=docker_img} $b'" >> ${tmpfile}
  done
  cat ${tmpfile}
  rm -f ${tmpfile}
}

