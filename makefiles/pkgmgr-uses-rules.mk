# -*- mode: makefile-gmake; -*-

uses_tools = $(sort $(foreach p,$(PKGS),$($(p)_USES)))

uses_targets += $(sort $(foreach t,$(uses_tools),\
	$(if $(shell command -v $(t)),,install~$(t))))

#$(info uses_tools= $(uses_tools))
#$(info uses_targets= $(uses_targets))
