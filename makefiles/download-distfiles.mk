# -*- mode: makefile-gmake; -*-

download_targets = $(foreach p,$(PKGS),\
	$(if $(findstring undefined,$(origin $(p)_METAPKG)),\
		$(addprefix $(DISTFILESDIR)/,$($(p)_DISTFILE))))

phony += download-distfiles
download-distfiles: $(download_targets)

# $(DISTFILESDIR):
# 	mkdir -p $(DISTFILESDIR)

# 1. distfile path
# 2. distfiles dir
# 3. distfile download url
define download-distfile-template
$(1):
	cd $(2) && curl -JLO $(3)
endef

# 1. distfile path
# 2. distfile exception
define distfile-exception-template
$(1):
	@echo "";
	@echo $(2) | fold -sw 72
	@echo ""
	@false
endef

package-url = $($(1)_MASTERSITE)/$(or $($(1)_GITHUB_TAG),$($(1)_DISTFILE))

$(foreach p,$(PKGS),\
	$(if $(findstring undefined,$(origin $(p)_DIST_EXCEPTION)),\
		$(eval $(call download-distfile-template,\
			$(DISTFILESDIR)/$($(p)_DISTFILE),\
			$(DISTFILESDIR),\
			$(call package-url,$(p)))),\
		$(eval $(call distfile-exception-template,\
			$(DISTFILESDIR)/$($(p)_DISTFILE),\
			$($(p)_DIST_EXCEPTION)))))
