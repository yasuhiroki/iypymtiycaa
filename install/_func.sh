function is_osx() {
  [[ $(uname) =~ "Darwin" ]]
}

function is_debian() {
  [[ -e "/etc/debian_version" || -e "/etc/lsb-release" ]]
}
