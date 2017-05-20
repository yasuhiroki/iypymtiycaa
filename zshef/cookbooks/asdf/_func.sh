function my::asdf::is_installed() {
  local lang="$1"
  asdf list ${lang} >/dev/null 2>&1
}

function my::asdf::default_install() {
  local lang="$1"
  local version="$2"
  local plugin_url="$3"

  asdf plugin-add ${lang} ${plugin_url}
  if [ -f ~/.asdf/plugins/${lang}/bin/import-release-team-keyring ]; then
    bash ~/.asdf/plugins/${lang}/bin/import-release-team-keyring
  fi

  asdf install ${lang} ${version}
  asdf global  ${lang} ${version}
}

