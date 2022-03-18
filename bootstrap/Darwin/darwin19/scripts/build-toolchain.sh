#!/bin/sh

noop(){ true ; }
info() { echo "$1" ; }
warn() { echo "Warning: $1" ; }
fatal() {
    echo "Error: $1"
    exit 1
}

if [ -x /usr/local/bin/make ]; then
    info "GNU Make already installed, skipping"
else
    info "Build and install GNU Make"
    mkdir -p src build/make || fatal "could not make src & build/make dirs"
    tar xf dist/files/make-4.3.tar.gz -C src || fatal "cound not unpack make-4.3.tar.gz"
    cd build/make && ../../src/make-4.3/configure && make install
    cd - > /dev/null || fatal "cd - failed"
fi

/usr/local/bin/make -rR minimal-toolchain-distribution
