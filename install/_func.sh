function is_osx() {
  [[ $(uname) =~ "Darwin" ]]
}

function is_debian() {
  [[ -e "/etc/debian_version" || -e "/etc/lsb-release" ]]
}

function update_rc() {
  local rc_file="$1"
  mkdir -p ~/.iypymtiycaa
  cp ${rc_file} ~/.iypymtiycaa/
}

function is_installed() {
  type ${1} >/dev/null 2>1
}

function backup_lotation() {
  local file="$1"
  [ -f ${file} ] && {
    for i in {9..1}; do
      [ -f ${file}.${i} ] && {
        cp ${file}.${i} ${file}.$((i+1))
      }
    done
    cp ${file} ${file}.1
  }
}
