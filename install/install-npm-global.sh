#!/bin/bash

type npm  >/dev/null || exit 0

npm install -g npm
npm install -g eslint eslint-config-airbnb

echo '{
    "extends": "airbnb"
}' > ~/.eslintrc
