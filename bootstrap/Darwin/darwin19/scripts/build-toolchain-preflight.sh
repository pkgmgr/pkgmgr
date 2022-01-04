#!/bin/sh

CHROOT_NAME=$1

BUILDROOT="$HOME/BuildRoots/$CHROOT_NAME"
BR_HOME="${BUILDROOT}/home"
BR_DISTFILES="${BR_HOME}/dist/files"
DISTFILES=bootstrap/Darwin/darwin19/dist/files

# copyfiles="CommonCrypto-60165.120.1.tar.gz \
#          apple-llvm-12.0.0.tar.gz \
#          cmake-3.22.0.tar.gz \
#          corecrypto-2020.tar.gz \
#          ld64-609.tar.gz \
#          make-4.3.tar.gz \
#          tapi-1100.0.11.tar.gz"

# mkdir -p "$BR_DISTFILES"

# for f in $copyfiles; do
#     cp "${DISTFILES}/${f}" "$BR_DISTFILES"
# done

base=bootstrap/Darwin/darwin19/
base=""
copyfiles="Makefile dist packages scripts"

for f in $copyfiles; do
    cp -r "${base}${f}" "$BR_HOME"
done

cp -r ../../../makefiles "$BR_HOME"
