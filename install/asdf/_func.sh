function is_installed_asdf() {
  type asdf 1>/dev/null 2>&1 || {
    [ -d ~/.asdf ] && source ~/.asdf/asdf.sh
    type asdf 1>/dev/null 2>&1
  }
}

function default_install() {
  local lang="$1"
  local version="$2"
  local plugin_url="$3"

  asdf plugin-add ${lang} ${plugin_url}

  asdf install ${lang} ${version}
  asdf global  ${lang} ${version}
}

