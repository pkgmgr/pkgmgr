# -*- mode: makefile-gmake; -*-

empty   :=
space   := $(empty) $(empty)
squote  := '
# '

escsq = $(subst $(squote),'\$(squote)',$1)

quiet=quiet_

# each command should have a short version prefixed with quite_cmd_
# and a long version prefixed with just cmd_
echo-cmd = $(if $($(quiet)cmd_$(1)),\
	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(echo-why)';)

touch-cmd = touch $(BLDDIR)/BuildData/$$@

cmd = @set -e; $(echo-cmd) $(cmd_$(1))
