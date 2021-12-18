DESTDIR ?=
PREFIX ?= $(HOME)
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man

PKG_CONFIG ?= pkg-config

# Allow users to override build settings without dirtying their trees
# For debugging, put this in local.mk:
#
#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
#
PM_LOCAL_CONFIG ?= local.mk
-include ${PM_LOCAL_CONFIG}

LIB_OBJS :=

PROGRAMS :=
PROGRAMS += clang
PROGRAMS += clang++
PROGRAMS += cpp
PROGRAMS += g++
PROGRAMS += gcc
PROGRAMS += ld

INST_PROGRAMS :=
INST_PROGRAMS += clang
INST_PROGRAMS += clang++
INST_PROGRAMS += cpp
INST_PROGRAMS += g++
INST_PROGRAMS += gcc
INST_PROGRAMS += ld
INST_MAN1 :=

#program-ldflags = -lc
LDFLAGS += -lc

all:

cflags = -fno-strict-aliasing
cflags += -Wall -Wwrite-strings

bindir := $(DESTDIR)$(BINDIR)
man1dir := $(DESTDIR)$(MANDIR)/man1

LIBS :=
OBJS := $(LIB_OBJS) $(EXTRA_OBJS) $(PROGRAMS:%=%.o)

# Pretty print
V := @
Q := $(V:1=)

all: $(PROGRAMS)

ldflags += $($(@)-ldflags) $(LDFLAGS)
ldlibs += $($(@)-ldlibs)  $(LDLIBS)
$(PROGRAMS): % : %.o $(LIBS)
	@echo "  LD      $@"
	$(Q)$(LD) $(ldflags) $^ $(ldlibs) -o $@

# libname.a: $(LIB_OBJS)
# 	@echo "  AR      $@"
# 	$(Q)$(AR) rcs $@ $^


cflags += $($(*)-cflags) $(CPPFLAGS) $(CFLAGS)
%.o: %.c
	@echo "  CC      $@"
	$(Q)$(CC) $(cflags) -c -o $@ $<


clean:
	@echo "  CLEAN"
	@rm -f *.[oa] .*.d $(PROGRAMS) version.h


install: install-bin install-man
install-bin: $(INST_PROGRAMS:%=$(bindir)/%)
install-man: $(INST_MAN1:%=$(man1dir)/%)

$(bindir)/%: %
	@echo "  INSTALL $@"
	$(Q)install -D        $< $@ || exit 1;
$(man1dir)/%: %
	@echo "  INSTALL $@"
	$(Q)install -D -m 644 $< $@ || exit 1;

.PHONY: FORCE
