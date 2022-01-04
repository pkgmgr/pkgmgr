PKGNAME=	ld64
PKGVER=		609

DISTFILE=	$(PKGNAME)-$(PKGVER).tar.gz
MASTERSITE=	https://opensource.apple.com/tarballs/$(PKGNAME)

PKGROOT=	src/$(PKGNAME)-$(PKGVER)
SRCROOT=	$(PKGROOT)

USES=		xcodebuild
DEPS=		tapi CommonCrypto corecrypto

BUILD_TOOL=	xcodebuild

INSTALL_TARGET=	install

BUILD_ARTIFACT=	src/Build/Release/ld
INST_ARTIFACT=	$(DESTROOT)/Toolchains/$(TC_NAME).xctoolchain/usr/bin/ld
