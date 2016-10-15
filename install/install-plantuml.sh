type java >/dev/null || {
  echo "Plant UML need java"
  exit 1
}

wget 'http://downloads.sourceforge.net/project/plantuml/plantuml.jar?r=http%3A%2F%2Fja.plantuml.com%2Fdownload.html&ts=1459694959&use_mirror=jaist' -O plantuml.jar

mkdir -p ~/mybin
mv plantuml.jar ~/mybin

cat <<EOH > ~/mybin/plantuml
#!/bin/bash
java -jar \$HOME/mybin/plantuml.jar -tsvg \$@
EOH
chmod 755 ~/mybin/plantuml

# install graphviz
. $(dirname $0)/install-graphviz.sh
