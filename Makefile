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

PKGMGRROOT := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
# PMROOT := $(PKGMGRROOT)/..

export PKGMGRROOT

## Local Rules & Variables

phony += all
all:

BSROOT = bootstrap/
BS_TOOLCHAINS = Darwin/darwin19

phony += bootstrap-toolchains
bootstrap-toolchains:
	@for dir in $(BS_TOOLCHAINS); do \
		$(MAKE) -C $(BSROOT)$$dir; \
	done; true

.PHONY: phony
