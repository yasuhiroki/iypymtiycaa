#!/bin/bash

type java >/dev/null || {
  echo "Plant UML need java"
  exit 1
}

mkdir -p ~/mybin

[ -e ~/mybin/plantuml.jar ] || {
  curl -sL 'http://downloads.sourceforge.net/project/plantuml/plantuml.jar?r=http%3A%2F%2Fja.plantuml.com%2Fdownload.html&ts=1459694959&use_mirror=jaist' -o ~/mybin/plantuml.jar
}

cat <<EOH > ~/mybin/plantuml
#!/bin/bash
java -jar \$HOME/mybin/plantuml.jar -config <(echo "skinparam defaultFontName serif") -tsvg \$@
EOH
chmod 755 ~/mybin/plantuml
