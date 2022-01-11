# -*- mode: makefile-gmake; -*-

quiet_cmd_make = BUILD	$(2)
      cmd_make = $(MAKE) -C $(3) $(4) $(5)

# 1. rule name: build-$(pkgname_PKGNAME)
# 2. build-deps(pkgname_DEPS)
# 3. pkgname_PKGNAME
# 4. pkgname_BUILD_DIR
# 5. pkgname_BUILD_ARGS
# 6. build target
define build-make-template
$(1): $(2)
	$(call cmd,make,$(3),$(4),$(5),$(6))
	$(touch-cmd)
endef

quiet_cmd_make_install = INSTALL	$(2)
      cmd_make_install = $(MAKE) -C $(3) $(4) $(5)

# 1. rule name
# 2. install-deps
# 3. pkgname
# 4. build dir
# 5. install args
# 6. install target
define install-make-template
$(1): $(2)
	$(call cmd,make_install,$(3),$(4),$(5),$(6))
	$(touch-cmd)
endef
