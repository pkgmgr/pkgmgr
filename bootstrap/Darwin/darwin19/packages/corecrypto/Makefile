PKGNAME=	corecrypto
PKGVER=		2020

DISTFILE=	$(PKGNAME)-$(PKGVER).tar.gz
DIST_EXCEPTION= You must download the corecrypto library from Apple	\
	for "evaluation." Renaming the package and creating a new	\
	tarball may be necessary.

PKGROOT=	src/$(PKGNAME)-$(PKGVER)
SRCROOT=	$(PKGROOT)

USES=		cmake make
DEPS=

#  CC=clang CXX=clang++ cmake -DCMAKE_INSTALL_PREFIX=$HOME/Developer/Toolchains/apple-clang-x86_64-apple-darwin19/usr ../corecrypto
CONFIG_TOOL=	cmake
BUILD_TOOL=	make

CONFIG_ARGS=	-DCMAKE_INSTALL_PREFIX=<install_prefix>

INSTALL_TARGET=	install

BUILD_ARTIFACT=	libcorecrypto_static.a
INST_ARTIFACT=	$(REL_PREFIX)/lib/libcorecrypto_static.a
