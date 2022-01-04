# -*- mode: makefile-gmake; -*-

_defined_vars := $(.VARIABLES)
_defined_vars += _defined_vars

# NOTE: The undefine directive can not be used with a list of variable
# or even in a loop. I consider this a bug. See 'Kludge Explanation'
# in print-pkg-vars.mk
define clear-pkg-vars
ifeq (,$(findstring print-pkg-vars,$(MAKECMDGOALS)))
undefine BUILD_ARTIFACT
undefine BUILD_TOOL
undefine CONFIG_ARGS
undefine CONFIG_TOOL
undefine DEPS
undefine DISTFILE
undefine DIST_EXCEPTION
undefine GITHUB_TAG
undefine INSTALL_TARGET
undefine INST_ARTIFACT
undefine MASTERSITE
undefine METAPKG
undefine PKGNAME
undefine PKGROOT
undefine PKGVER
undefine SRCROOT
undefine USES
undefine VARIANTS
endif
endef
_defined_vars += clear-pkg-vars

define make-pkg-var
$(p)_$(v) := $($v)
_defined_vars += $(p)_$(v)
endef
_defined_vars += make-pkg-var

define make-pkg-vars
$(eval include $(PKGDIR)/$(p)/Makefile)
$(foreach v,$(filter-out $(_defined_vars), $(.VARIABLES)),\
	$(eval $(make-pkg-var)))
$(eval $(clear-pkg-vars))
endef
_defined_vars += make-pkg-vars

$(foreach p,$(PKGS),$(eval $(make-pkg-vars)))
