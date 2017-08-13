#!/usr/bin/env zsh

function my::local::tmp::dir::osx() {
    echo "/private/var/folders/1d/yhbvtw1n5tnf4fxgwjb_wpzw0000gn/T"
}

function my::docker::tmp::dir::osx() {
    echo "/var/folders/1d/yhbvtw1n5tnf4fxgwjb_wpzw0000gn/T"
}

function my::docker::build() {
    local dist_name="$1"
    local base_dir="${${(%):-%N}:A:h}/cookbooks/${dist_name}"
    local image_name="$2"
    local dockerfile="${3:-Dockerfile}"
    (
    cd ${base_dir}
    docker build --file ${dockerfile} -t ${image_name} .
    )
}

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
        my::docker::bin::create \
            "${img}" \
            "$(_my::docker::bin::option "${run_opt}")" \
            "${local_bin_dir}" \
            "${b}" \
            "${b}"
    done
}

function my::docker::bin::create() {
    local img="$1"
    local run_opt="$2"
    local local_bin_dir="$3"
    local bin_file="$4"
    : ${bin_file:?}
    local cmd="$5"
    : ${cmd:?}

    mkdir -p ${local_bin_dir:?} >& /dev/null

    _my::docker::bin::body \
        "${img}" \
        "${run_opt}" \
        "${cmd}"     > ${local_bin_dir}/${bin_file}
    chmod 755          ${local_bin_dir}/${bin_file}
}

function _my::docker::bin::option() {
    local opt=(\
        "${1}" \
        "-v $(my::local::tmp::dir::osx):$(my::docker::tmp::dir::osx)" \
        "-v \$(pwd -P):\$(pwd -P)" \
        "-w \$(pwd -P)" \
    )
    echo ${opt[@]}
}

function _my::docker::bin::body() {
    local img="$1"
    local run_opt="$2"
    local cmd="$3"
    : ${img:?}
    : ${run_opt:?}
    : ${cmd:?}
    cat <<EOH
#!/usr/bin/env zsh

if [ -t 0 ]; then
  opt="-t"
else
  opt=""
fi
docker run ${=run_opt} \${=MY_DOCKER_OPT} \${opt} ${img} ${cmd} \${=@}
EOH
}
