PKGNAME=	twm
VERSION=	1.0.10
CATEGORIES=	x11 x11-wm
LICENSE=	X11

DESC=		Tab Window Manager for X11
LONG_DESC = \
    Twm is a window manager for the X Window System. It provides	\
    titlebars, shaped windows, several forms of icon management,	\
    user-defined macro functions, click-to-type and pointer-driven	\
    keyboard focus, and user-specified key and pointer button		\
    bindings.

HOMEPAGE=	https://www.x.org

PKGROOT=	src/x11-wm/twm
SRCROOT=	$(PKGROOT)

DEPS=		libXmu

BUILD_FLAVOR=	autotools
BUILD_STYLE=	make

INSTALL_TARGET=	install-strip

MAKE_ARTIFACT= 	src/twm
INST_ARTIFACT=	$(REL_PREFIX)/bin/twm
