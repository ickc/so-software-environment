#!/usr/bin/env bash

BASE_PREFIX="${BASE_PREFIX:-tmp}"
ENV_PREFIX="${ENV_PREFIX:-so-conda}"
PYTHON_VERSION="${PYTHON_VERSION:-310}"
MKL="${MKL:-mkl}"
ARCH="${ARCH:-x86-64-v3}"
MPI="${MPI:-openmpi}"
YYYYMMDD="${YYYYMMDD:-$(date +'%Y%m%d')}"
PROGRAM="${PROGRAM:-zstd}"

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

case "$ENV_PREFIX" in
    so-conda)
        ENV_NAME="$ENV_PREFIX-py$PYTHON_VERSION-$YYYYMMDD"
        FILENAME="$(echo "$BASE_PREFIX" | sed 's/\//_/g')_$ENV_NAME"
        ;;
    so-pmpm)
        ENV_NAME="$ENV_PREFIX-py$PYTHON_VERSION-$MKL-$ARCH-$MPI-$YYYYMMDD"
        FILENAME="$(echo "$BASE_PREFIX" | sed 's/\//_/g')_$ENV_NAME"
        ;;
    *)
        echo "Unknown environment prefix: $ENV_PREFIX"
        exit 1
        ;;
esac
URL="https://github.com/ickc/so-software-environment/releases/download/$YYYYMMDD/$FILENAME.tar.$EXTENSION"
PREFIX="/$BASE_PREFIX/$ENV_NAME"

cd /tmp || exit 1
wget "$URL"
mkdir -p "$PREFIX"
# shellcheck disable=SC2086
tar --extract --$PROGRAM --file "$FILENAME.tar.$EXTENSION" --directory="$PREFIX"
rm -f /tmp/"$FILENAME.tar.$EXTENSION"
echo "Usage: source $PREFIX/bin/activate $PREFIX"
