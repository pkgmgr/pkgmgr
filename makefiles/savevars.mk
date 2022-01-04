# -*- mode: makefile-gmake; -*-

_tmp_vars := $(.VARIABLES)

define _savevar
_pkgmgr_$(v) := $($(v))
_pkgmgr_VARIABLES += $(v)
endef

$(foreach v, $(filter-out .VARIABLES _tmp_vars,$(_tmp_vars)),\
	$(eval $(_savevar)))
