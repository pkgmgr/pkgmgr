# -*- mode: makefile-gmake; -*-

## Print variables defined in packages

# `phony' and `_defined_vars' are implicit in this makefile and as
# such they are included in `_defined_vars' elsewhere. PKG_VARS is
# private to the rule `print-pkg-vars' and does not need to be
# included in `_defined_vars' to be excluded from the printed pkg
# variables.
#
# The list of variables printed by this rule, sorted, and prefixed
# with `undefined' should be inserted into the body of
# `clear-pkg-vars' as defined in pkgmgr.mk
#
# Produce the list with the following command:
#
#   gmake -f Makefile.print-pkg-vars print-pkg-vars | sort | sed -e 's/^/undefine /'
#
# Pro-tip: on macOS pipe to `pbcopy'

## Kludge Explanation

# As noted in pkgmgr.mk the undefine directive can not be used with a
# list of variable or even in a loop. So we must produce this list of
# variables instead of using either of the forms below to undefine
# package variables.
#
# 1) Preferred form
#
#   undefine $(filter-out $(_defined_vars), $(.VARIABLES))
#
# 2) alternative form
#
#   $(foreach v,$(filter-out $(_defined_vars), $(.VARIABLES)),\
#    	undefine $(v))

phony += print-pkg-vars
print-pkg-vars: PKG_VARS = $(filter-out $(_defined_vars), $(.VARIABLES))
print-pkg-vars:
	@for v in $(PKG_VARS); do \
		echo $$v; \
	done; true
_defined_vars += print-pkg-vars
