FROM "golang:rc-alpine"

ARG BUILD_PACKAGES="git"
ARG DEV_PACKAGES="gcc g++ make cmake"

RUN apk add --no-cache \
        ${BUILD_PACKAGES} \
        ${DEV_PACKAGES}

RUN true \
        && go get -u github.com/nsf/gocode \
        && go get -u github.com/alecthomas/gometalinter \
        && go get -u golang.org/x/tools/cmd/goimports \
        && go get -u golang.org/x/tools/cmd/guru \
        && go get -u golang.org/x/tools/cmd/gorename \
        && go get -u github.com/golang/lint/golint \
        && go get -u github.com/rogpeppe/godef \
        && go get -u github.com/kisielk/errcheck \
        && go get -u github.com/jstemmer/gotags \
        && go get -u github.com/klauspost/asmfmt/cmd/asmfmt \
        && go get -u github.com/fatih/motion \
        && go get -u github.com/fatih/gomodifytags \
        && go get -u github.com/zmb3/gogetdoc \
        && go get -u github.com/josharian/impl \
        && go get -u github.com/dominikh/go-tools/cmd/keyify

CMD ["go"]
