PKGNAME=	apple-llvm
PKGVER=		12.0.0

DISTFILE=	$(PKGNAME)-$(PKGVER).tar.gz

MASTERSITE=	https://github.com/pkgmgr/$(PKGNAME)/archive/refs/tags
GITHUB_TAG=	$(PKGVER).tar.gz

PKGROOT=	src/$(PKGNAME)-$(PKGVER)
SRCROOT=	$(PKGROOT)/llvm

USES=		cmake make
DEPS=

CONFIG_TOOL=	cmake
BUILD_TOOL=	make

CONFIG_ARGS=	-G "Unix Makefiles" \
	-DCMAKE_INSTALL_PREFIX=$(HOME)/Developer \
	-DPACKAGE_VENDOR=Apple-esque \
	-DCLANG_VENDOR_UTI=gr.pkgm.apple-llvm \
	-DLLVM_VERSION_SUFFIX=-pkgmgr-pre-alpha \
	-DBUG_REPORT_URL="https\://github.com/pkgmgr/apple-llvm/issues" \
	-DLLVM_CREATE_XCODE_TOOLCHAIN=On \
	-DLLVM_ENABLE_PROJECTS="clang;libunwind;libcxx;libcxxabi" \
	-DCMAKE_BUILD_TYPE=MinSizeRel

CMAKE_CACHE= $(PKGROOT)/clang/cmake/caches/Apple-stage1.cmake
CMAKE_SRCROOT= $(SRCROOT)

INSTALL_TARGET=	install-xcode-toolchain
