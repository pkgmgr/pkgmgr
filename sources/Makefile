# pm is derived from the following package managers

freebsd-ports_REPO=	https://git.freebsd.org/ports.git
freebsd-ports_DIR=	freebsd/ports

pkgsrc_REPO= 		https://github.com/NetBSD/pkgsrc.git
pkgsrc_DIR=		pkgsrc/pkgs

macports_REPO= 		https://github.com/macports/macports-ports.git
macports_DIR=		macports/ports

dports_REPO= 		https://github.com/DragonFlyBSD/DPorts.git
dports_DIR=		dports/ports

deltaports_REPO= 	https://github.com/DragonFlyBSD/DeltaPorts.git
deltaports_DIR=		deltaports

# port repositories to clone
REPOS += freebsd-ports

# make targets for port repositories
TARGETS = $(foreach r,$(REPOS),$(addsuffix /.git,$($(r)_DIR)))

all: $(TARGETS)

define clone-repo-template
$(1)/.git:
	git clone --depth 1 $(2) $(1)
endef

$(foreach r,$(REPOS),\
	$(eval $(call clone-repo-template,\
		$$($(r)_DIR), $$($(r)_REPO))))
