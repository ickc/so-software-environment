#!/usr/bin/env bash

ENV_PREFIX="${ENV_PREFIX:-so-conda}"
BASE_PREFIX="${BASE_PREFIX:-tmp}"
YYYYMMDD="${BASE_PREFIX:-$(date +'%Y%m%d')}"

FILENAME="$(echo "$BASE_PREFIX" | sed 's/\//_/g'))"
URL="https://github.com/ickc/so-software-environment/releases/download/$YYYYMMDD/$ENV_PREFIX.tar.gz"

cd /tmp || exit 1
wget "$URL"
tar -xzf "$FILENAME.tar.gz" -C "/$BASE_PREFIX"
