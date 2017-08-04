FROM "ruby:alpine"

# Refference: https://github.com/CenturyLinkLabs/alpine-rails/blob/master/Dockerfile
ARG BUILD_PACKAGES="curl-dev ruby-dev build-base git"
ARG DEV_PACKAGES="gcc g++ make cmake zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev icu-dev"
ARG RUBY_PACKAGES="ruby-io-console ruby-json yaml nodejs"

RUN apk add --no-cache \
        ${BUILD_PACKAGES} \
        ${DEV_PACKAGES} \
        ${RUBY_PACKAGES}

# Refference: http://qiita.com/celeron1ghz/items/a5f5e6932b666f425a07
RUN rm -f /usr/bin/mysql* /usr/lib/mysqld*

CMD ["irb"]
