# -*- mode: makefile-gmake; -*-

build-dir = $(or $($(1)_BUILD_DIR),$(BLDDIR)/$(1))
src-dir = $(or $($(1)_SRCROOT),$($(1)_PKGROOT))
relpath = $(subst $(space),,$(foreach _,$(subst /, ,$(1)),../))

define append-var
$(1) += $(2)
endef
