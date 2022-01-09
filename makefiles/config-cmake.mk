# -*- mode: makefile-gmake; -*-

quiet_cmd_cmake = CONFIG	$(2)
      cmd_cmake = cd $(3) && $(CMAKE) $(4) $(5)

# 1. rule name: config-$(pkgname_PKGNAME)
# 2. config-deps(pkgname_USES)
# 3. pkgname_PKGNAME
# 4. pkgname_BUILD_DIR
# 5. pkgname_CONFIG_ARGS
# 6. pkgname_SRCROOT
define config-cmake-template
$(1): $(2)
	$(call cmd,cmake,$(3),$(4),$(5),$(6))
endef
