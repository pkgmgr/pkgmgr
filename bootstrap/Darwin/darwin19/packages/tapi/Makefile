PKGNAME=	tapi
PKGVER=		1100.0.11

DISTFILE=	$(PKGNAME)-$(PKGVER).tar.gz
MASTERSITE=	https://opensource.apple.com/tarballs/$(PKGNAME)

PKGROOT=	src/$(PKGNAME)-$(PKGVER)
SRCROOT=	$(PKGROOT)

USES=		cmake make
DEPS=

CONFIG_TOOL=	cmake
BUILD_TOOL=	make

INSTALL_TARGET=	install

BUILD_ARTIFACT=	$(BUILDROOT)/usr/lib/libtapi.dylib
INST_ARTIFACT=	$(DESTROOT)/Toolchains/$(TC_NAME).xctoolchain/usr/lib/libtapi.dylib
