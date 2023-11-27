#!/usr/bin/env bash

ENV_PREFIX="${ENV_PREFIX:-so-conda}"
BASE_PREFIX="${BASE_PREFIX:-tmp}"
YYYYMMDD="${YYYYMMDD:-$(date +'%Y%m%d')}"
PYTHON_VERSION="${PYTHON_VERSION:-310}"

ENV_NAME="$ENV_PREFIX-py$PYTHON_VERSION-$YYYYMMDD"
FILENAME="$(echo "$BASE_PREFIX" | sed 's/\//_/g')_$ENV_NAME"
URL="https://github.com/ickc/so-software-environment/releases/download/$YYYYMMDD/$FILENAME.tar.gz"
PREFIX="/$BASE_PREFIX/$ENV_NAME"

cd /tmp || exit 1
wget "$URL"
mkdir -p "$PREFIX"
tar -xzf "$FILENAME.tar.gz" -C "$PREFIX"
echo "Usage: source $PREFIX/bin/activate $PREFIX"
