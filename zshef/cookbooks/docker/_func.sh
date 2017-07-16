#!/usr/bin/env zsh

function my::docker::language::init() {
  local img="$1"
  local run_opt="$2"
  local bin_dir="$3"
  local local_bin_dir="$4"

  local interactive_only_bin_list="$5"

  : ${img:?}
  : ${run_opt:?}
  : ${bin_dir:?}
  test -d ${local_bin_dir:?}

  local bin_list=($(docker run ${=run_opt} ${=img} ls --color=never -1 ${bin_dir} | tr -d '\r' | xargs))
  for b in ${bin_list[@]}
  do
    echo ${interactive_only_bin_list} | grep -sq ${b} && {
      echo "docker run ${run_opt} -t -v \$(pwd):\$(pwd) -w \$(pwd) ${img} ${b} \${@}" > ${local_bin_dir}/${b}
    } || {
      echo "docker run ${run_opt} -v \$(pwd):\$(pwd) -w \$(pwd) ${img} ${b} \${@}" > ${local_bin_dir}/${b}
    }
    chmod 755 ${local_bin_dir}/${b}
  done
}

