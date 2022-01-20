# -*- mode: makefile-gmake; -*-

define _restorevar
$(v) = $(_pkgmgr_$(v))
endef

$(foreach v,$(_pkgmgr_VARIABLES),$(eval $(_restorevar)))
