#!/usr/bin/env zsh

function my::docker::language::init() {
  local docker_img="$1"
  local docker_run="$2"
  local docker_bin_dir="$3"
  local local_bin_dir="$4"

  : ${docker_img:?}
  : ${docker_run:?}
  : ${docker_bin_dir:?}
  test -d ${local_bin_dir:?}

  local bin_list=($(${=docker_run} ${=docker_img} ls --color=never -1 ${docker_bin_dir} | tr -d '\r' | xargs))
  for b in ${bin_list[@]}
  do
    echo "${docker_run} -v \$(pwd):\$(pwd) -w \$(pwd) ${docker_img} ${b} \${@}" > ${local_bin_dir}/${b}
    chmod 755 ${local_bin_dir}/${b}
  done
}

