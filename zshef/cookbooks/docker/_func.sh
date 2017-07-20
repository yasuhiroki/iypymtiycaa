#!/usr/bin/env zsh

function my::docker::language::init() {
  local img="$1"
  local run_opt="$2"
  local bin_dir="$3"
  local local_bin_dir="$4"

  : ${img:?}
  : ${run_opt:?}
  : ${bin_dir:?}
  test -d ${local_bin_dir:?}

  local bin_list=($(docker run ${=run_opt} ${=img} ls --color=never -1 ${bin_dir} | tr -d '\r' | xargs))
  for b in ${bin_list[@]}
  do
    my::docker::bin::body \
        "${img}" \
        "${run_opt} -v \$(pwd -P):\$(pwd -P) -w \$(pwd -P)" \
        "${b} \"\${@}\"" > ${local_bin_dir}/${b}
    chmod 755 ${local_bin_dir}/${b}
  done
}

function my::docker::bin::body() {
  local img="$1"
  local run_opt="$2"
  local cmd="$3"
  : ${img:?}
  : ${run_opt:?}
  : ${cmd:?}
cat <<EOH
if [ -t 0 ]; then
  opt="-t"
else
  opt=""
fi
docker run ${run_opt} \${opt} ${img} ${cmd}
EOH
}

