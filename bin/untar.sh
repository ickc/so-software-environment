#!/usr/bin/env bash

ENV_PREFIX="${ENV_PREFIX:-so-conda}"
BASE_PREFIX="${BASE_PREFIX:-tmp}"
YYYYMMDD="${YYYYMMDD:-$(date +'%Y%m%d')}"
PYTHON_VERSION="${PYTHON_VERSION:-310}"
PROGRAM="${PROGRAM:-xz}"

if [ "$PROGRAM" = "xz" ]; then
    EXTENSION="xz"
elif [ "$PROGRAM" = "zstd" ]; then
    EXTENSION="zst"
elif [ "$PROGRAM" = "gzip" ]; then
    EXTENSION="gz"
else
    echo "Unknown program: $PROGRAM"
    exit 1
fi

ENV_NAME="$ENV_PREFIX-py$PYTHON_VERSION-$YYYYMMDD"
FILENAME="$(echo "$BASE_PREFIX" | sed 's/\//_/g')_$ENV_NAME"
URL="https://github.com/ickc/so-software-environment/releases/download/$YYYYMMDD/$FILENAME.tar.$EXTENSION"
PREFIX="/$BASE_PREFIX/$ENV_NAME"

cd /tmp || exit 1
wget "$URL"
mkdir -p "$PREFIX"
tar --extract --$PROGRAM --file "$FILENAME.tar.$EXTENSION" --directory="$PREFIX"
echo "Usage: source $PREFIX/bin/activate $PREFIX"
