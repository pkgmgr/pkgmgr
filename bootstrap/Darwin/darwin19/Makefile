# -*- mode: makefile-gmake; -*-

## Initialization

# clear built-in rules and variable
MAKEFLAGS += -rR

# make version check
ifeq (4.2,$(lastword $(sort $(MAKE_VERSION) 4.2)))
$(error Requires GNU make v4.3 or higher)
endif

# local overrides
LOCAL_CONFIG ?= local.mk
-include $(LOCAL_CONFIG)

TCROOT := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

ifdef PKGMGRROOT
	PKGMGRROOT := $(PKGMGRROOT)/
else
	PKGMGRROOT := ../../../
endif

ifeq (/home,$(TCROOT))
undefine PKGMGRROOT
endif

## Config

PREFIXDIR=
SRCDIR=src
BLDDIR=build
SYMDIR=build
DSTDIR=

PREFIX=
SRCROOT=
BLDROOT=
SYMROOT=
DSTROOT=

CONFIG=
STYLE=
FLAVOR=
VARIANT=

CPPFLAGS=
CFLAGS=
CXXFLAGS=
LDFLAGS=

## Package management

# local pkgmgr config
PKGDIR = packages
PATCHDIR = patches
DISTFILESDIR = dist/files
SCRIPTSDIR  = scripts/

PKGMGR_MAKEFILES= $(PKGMGRROOT)makefiles/
PKGMGR_SCRIPTS=$(PKGMGRROOT)scripts/

# packages
-include $(PKGDIR)/index.mk

-include $(PKGMGR_MAKEFILES)savevars.mk
-include $(PKGMGR_MAKEFILES)pkgmgr.mk
-include $(PKGMGR_MAKEFILES)restorevars.mk

phony += all
all: enterchroot

noop:

-include $(PKGMGR_MAKEFILES)pkgmgr-vars.mk
-include $(PKGMGR_MAKEFILES)pkgmgr-cmd.mk
-include $(PKGMGR_MAKEFILES)download-distfiles.mk
-include $(PKGMGR_MAKEFILES)unpack-distfiles.mk
-include $(PKGMGR_MAKEFILES)pkgmgr-uses-rules.mk
-include $(PKGMGR_MAKEFILES)config-cmake.mk
-include $(PKGMGR_MAKEFILES)config-sh.mk
-include $(PKGMGR_MAKEFILES)build-make.mk
-include $(PKGMGR_MAKEFILES)pkgmgr-build-rules.mk

## Local rules and vars

CHROOT_NAME= build-toolchain
CHROOT_PREFLIGHT_SCRIPT= $(SCRIPTSDIR)build-toolchain-preflight.sh
CHROOT_RUN_SCRIPT= scripts/build-toolchain.sh
CHROOT_PATH= "/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin"

phony += enterchroot
enterchroot:
enterchroot: download-distfiles
	$(PKGMGR_SCRIPTS)darwin-chroot-alt enter $(CHROOT_NAME) \
		$(CHROOT_PREFLIGHT_SCRIPT) $(CHROOT_RUN_SCRIPT) \
		$(CHROOT_PATH)

phony += minimal-toolchain-distribution
minimal-toolchain-distribution:
	@echo $(apple-llvm_PKGROOT)

.PHONY: $(phony)
