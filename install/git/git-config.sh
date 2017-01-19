git config --global push.default simple
git config --global core.autocrlf input
echo "*~
" > ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
git config --global rebase.autostash true
git config --global rebase.autosquash true

