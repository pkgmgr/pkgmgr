PKGNAME=	cmake
PKGVER=		3.22.0

DISTFILE=	$(PKGNAME)-$(PKGVER).tar.gz
MASTERSITE=	https://cmake.org/files/LatestRelease


PKGROOT=	src/$(PKGNAME)-$(PKGVER)
SRCROOT=	$(PKGROOT)

USES=		make
DEPS=

CONFIG_TOOL=	cmake-bootstrap
BUILD_TOOL=	make

#CONFIG_ARGS=	--prefix=<install_prefix>

INSTALL_TARGET=	install

BUILD_ARTIFACT=	bin/cmake
INST_ARTIFACT=	$(REL_PREFIX)/bin/cmake
