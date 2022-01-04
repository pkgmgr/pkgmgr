# -*- mode: makefile-gmake; -*-

unpack_targets = $(foreach p,$(PKGS),\
	$(if $(findstring undefined,$(origin $(p)_METAPKG)),\
		$($(p)_PKGROOT)))

phony += unpack-distfiles
unpack-distfiles: $(unpack_targets)

# 1. package root
# 2. relative path to distfile
# 3. src file directory
define unpack-distfile-template
$(1):
	tar xf $(2) -C $(3)
endef

$(foreach p,$(PKGS),\
	$(if $(findstring undefined,$(origin $(p)_METAPKG)),\
		$(eval $(call unpack-distfile-template,\
			$($(p)_PKGROOT),\
			$(DISTFILESDIR)/$($(p)_DISTFILE),\
			src))))
