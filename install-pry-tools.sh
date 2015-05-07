gems="pry pry-nav"
if ruby -v | awk '{print }' | grep -sq 1.9 ; then
    gems="$gems pry-debugger"
else
    gems="$gems pry-byedebug"
fi
gem install $gems
