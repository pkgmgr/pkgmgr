# -*- mode: makefile-gmake; -*-

quiet_cmd_cmake = CONFIG	$(2)
      cmd_cmake = cd $(3) && $(CMAKE) $(4)

# 1. rule name: config-$(pkgname_PKGNAME)
# 2. config-deps(pkgname_USES)
# 3. pkgname_PKGNAME
# 4. pkgname_BUILD_DIR
# 5. pkgname_CONFIG_ARGS
# 6. pkgname_SRCROOT
define config-cmake-template
$(1): $(2)
	$(call cmd,cmake,$(3),$(4),$(5),$(6))
	$(touch-cmd)
endef

# look for special CMAKE_ variables

# CMAKE_CACHE
#
# appends CONFIG_ARGS with:
#    -C <rel-path-from-build-dir>/$(CMAKE_CACHE)
$(foreach p,$(PKGS),$(if $($(p)_CMAKE_CACHE),\
	$(eval $(call append-var,$(p)_CONFIG_ARGS,\
		-C $(call relpath,$(call build-dir,$(p)))$($(p)_CMAKE_CACHE)))))

# CMAKE_SRCROOT
#
# appends CONFIG_ARGS with:
#    <rel-path-from-build-dir>/$(SRCROOT)
#
# TODO: default when not defined
#    CMAKE_SRCROOT= $(SRCROOT)
$(foreach p,$(PKGS),$(if $($(p)_CMAKE_SRCROOT),\
	$(eval $(call append-var,$(p)_CONFIG_ARGS,\
		$(call relpath,$(call build-dir,$(p)))$($(p)_CMAKE_SRCROOT)))))
