# -*- mode: makefile-gmake; -*-

quiet_cmd_config_sh = CONFIG	$(2)
      cmd_config_sh = cd $(3) && $(4)

define config-sh-template
$(1): $(2)
	$(call cmd,config_sh,$(3),$(4),$(5))
endef
