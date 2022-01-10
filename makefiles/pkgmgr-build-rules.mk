# -*- mode: makefile-gmake; -*-

define config-noop-template
$(1): $(2)
endef

define build-noop-template
$(1): $(2)
endef

define install-noop-template
$(1): $(2)
endef

build-dir = $(or $($(1)_BUILD_DIR),$(BLDDIR)/$(1))
src-dir = $(or $($(1)_SRCROOT),$($(1)_PKGROOT))
relpath = $(subst $(space),,$(foreach _,$(subst /, ,$(1)),../))

pkg-deps = $(filter $(addprefix install~,$($(1)_USES)),$(uses_targets)) \
	$(addprefix install~,$($(1)_DEPS))

## Config rules

config-deps = $(call pkg-deps,$(1))
config-template = config-$(1)-template
config-rule-name = config~$($(1)_PKGNAME)
config-tool = $(or $(and $(firstword $(subst :, ,$($(1)_CONFIG_TOOL)))),noop)
config-tool-script = \
	$(call relpath,$(call build-dir,$(1)))$(call src-dir,$(1))/$(lastword \
		$(subst :, ,$($(1)_CONFIG_TOOL)))
config-args = $(if $(findstring :,$($(1)_CONFIG_TOOL)),\
	$(call config-tool-script,$(1))) \
	$($(1)_CONFIG_ARGS)

$(foreach p,$(PKGS),\
	$(eval $(call $(call config-template,$(call config-tool,$(p))),\
		$(call config-rule-name,$(p)),\
		$(call config-deps,$(p)),\
		$($(p)_PKGNAME),\
		$(call build-dir,$(p)),\
		$(call config-args,$(p)),\
		$(call src-dir,$(p)))))

## Build rules

# has config_tool var, then depend on config~pkgname
# turn the rest of the deps into install~depname
build-deps = $(call config-rule-name,$(1))
build-template = build-$(1)-template
build-rule-name = build~$($(1)_PKGNAME)
build-tool = $(or $($(1)_BUILD_TOOL),noop)

$(foreach p,$(PKGS),\
	$(eval $(call $(call build-template,$(call build-tool,$(p))),\
		$(call build-rule-name,$(p)),\
		$(call build-deps,$(p)),\
		$($(p)_PKGNAME),\
		$(call build-dir,$(p)),\
		$($(p)_BUILD_ARGS),\
		$($(p)_BUILD_TARGET))))

## Install rules

install-deps = $(call build-rule-name,$(1))
install-template = install-$(1)-template
install-rule-name = install~$($(1)_PKGNAME)
install-tool = $(or $($(1)_INSTALL_TOOL),$($(1)_BUILD_TOOL),noop)
install-target = $(or $($(1)_INSTALL_TARGET),install)

$(foreach p,$(PKGS),\
	$(eval $(call $(call install-template,$(call install-tool,$(p))),\
		$(call install-rule-name,$(p)),\
		$(call install-deps,$(p)),\
		$($(p)_PKGNAME),\
		$(call build-dir,$(p)),\
		$($(p)_INSTALL_ARGS),\
		$(call install-target,$(p)))))
