# Generated automatically from Makefile.in by configure.
# Makefile.in generated automatically by automake 1.0 from Makefile.am

# Copyright (C) 1994, 1995, 1996 Free Software Foundation, Inc.
# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy, distribute and modify it.


SHELL = /bin/sh

srcdir = .
top_srcdir = ..
prefix = /usr
exec_prefix = 

bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/sbin
libexecdir = ${exec_prefix}/libexec
datadir = ${prefix}/share
sysconfdir = ${prefix}/etc
sharedstatedir = ${prefix}/com
localstatedir = ${prefix}/var
libdir = ${exec_prefix}/lib
infodir = ${prefix}/info
mandir = ${prefix}/man
includedir = ${prefix}/include
oldincludedir = /usr/include

pkgdatadir = $(datadir)/shadow
pkglibdir = $(libdir)/shadow
pkgincludedir = $(includedir)/shadow

top_builddir = ..

INSTALL = /usr/bin/ginstall -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_SCRIPT = @INSTALL_SCRIPT@
transform = s,x,x,

AUTOMAKE_OPTIONS = 1.0 foreign

noinst_HEADERS = defines.h dialup.h faillog.h getdef.h \
 groupio.h md5.h port.h prototypes.h \
 pwauth.h pwio.h rcsid.h sgroupio.h shadowio.h

# These files are unneeded for some reason, listed in
# order of appearance:
#
# sources which are not really needed (are they in libc???)
# sources for dbm support (not yet used)
# sources for LIBOBJS (which are normally in libc)
# sources for CRYPTOBJS
# misc header sources

EXTRA_DIST = \
grent.c pwent.c \
\
grdbm.c gsdbm.c pwdbm.c spdbm.c \
grpack.c gspack.c pwpack.c sppack.c \
\
mkdir.c rename.c rmdir.c strdup.c strstr.c \
putgrent.c putpwent.c putspent.c \
sgetgrent.c sgetpwent.c sgetspent.c \
\
md5.c md5crypt.c \
\
gshadow_.h shadow_.h lastlog_.h

# We build libshadow for our tools.

noinst_LIBRARIES = shadow

shadow_SOURCES = commonio.c dialchk.c dialup.c encrypt.c fputsx.c \
 getdef.c getpass.c groupio.c gshadow.c lockpw.c port.c \
 pwauth.c pwio.c rad64.c sgroupio.c shadow.c shadowio.c utent.c

shadow_LIBADD =  putgrent.o sgetgrent.o sgetpwent.o md5.o md5crypt.o

INCLUDES = -I$(top_srcdir)/lib
mkinstalldirs = $(top_srcdir)/mkinstalldirs
CONFIG_HEADER = ../config.h
LIBRARIES = $(noinst_LIBRARIES)

noinst_LIBFILES = libshadow.a

CC = gcc
LEX = @LEX@
YACC = @YACC@

DEFS = -DHAVE_CONFIG_H -I. -I$(srcdir) -I..
CPPFLAGS = 
CFLAGS = -O2 -Wall
LDFLAGS = -s
LIBS = 

COMPILE = $(CC) -c $(DEFS) $(INCLUDES) $(CPPFLAGS) $(CFLAGS)
LINK = $(CC) $(LDFLAGS) -o $@
shadow_OBJECTS = commonio.o dialchk.o dialup.o encrypt.o fputsx.o \
getdef.o getpass.o groupio.o gshadow.o lockpw.o port.o pwauth.o pwio.o \
rad64.o sgroupio.o shadow.o shadowio.o utent.o
EXTRA_shadow_SOURCES =
LIBFILES =  libshadow.a
AR = ar
RANLIB = ranlib
HEADERS = $(noinst_HEADERS)

DIST_COMMON = Makefile.am Makefile.in


PACKAGE = shadow
VERSION = 961025

DISTFILES = $(DIST_COMMON) $(SOURCES) $(BUILT_SOURCES) $(HEADERS) \
	$(TEXINFOS) $(INFOS) $(MANS) $(EXTRA_DIST) $(DATA)
DEP_DISTFILES = $(DIST_COMMON) $(SOURCES) $(BUILT_SOURCES) $(HEADERS) \
	$(TEXINFOS) $(INFO_DEPS) $(MANS) $(EXTRA_DIST) $(DATA)

TAR = tar
SOURCES = $(shadow_SOURCES)
OBJECTS = $(shadow_OBJECTS)

default: all


mostlyclean-noinstLIBRARIES:

clean-noinstLIBRARIES:
	rm -f $(noinst_LIBFILES)

distclean-noinstLIBRARIES:

maintainer-clean-noinstLIBRARIES:

.c.o:
	$(COMPILE) $<

mostlyclean-compile:
	rm -f *.o core

clean-compile:

distclean-compile:
	rm -f *.tab.c

maintainer-clean-compile:
$(shadow_OBJECTS): ../config.h

libshadow.a: $(shadow_OBJECTS) $(shadow_LIBADD)
	rm -f libshadow.a
	$(AR) cru libshadow.a $(shadow_OBJECTS) $(shadow_LIBADD)
	$(RANLIB) libshadow.a

ID: $(HEADERS) $(SOURCES)
	here=`pwd` && cd $(srcdir) && mkid -f$$here/ID $(SOURCES) $(HEADERS)

tags: TAGS

TAGS: $(HEADERS) $(SOURCES) $(TAGS_DEPENDENCIES)
	here=`pwd` && cd $(srcdir) && etags $(ETAGS_ARGS) $(SOURCES) $(HEADERS) -o $$here/TAGS

mostlyclean-tags:

clean-tags:

distclean-tags:
	rm -f TAGS ID

maintainer-clean-tags:

subdir = lib
distdir = $(top_builddir)/$(PACKAGE)-$(VERSION)/$(subdir)
distdir: $(DEP_DISTFILES)
	@for file in `cd $(srcdir) && echo $(DISTFILES)`; do \
	  test -f $(distdir)/$$file \
	  || ln $(srcdir)/$$file $(distdir)/$$file 2> /dev/null \
	  || cp -p $(srcdir)/$$file $(distdir)/$$file; \
	done
commonio.o: commonio.c rcsid.h prototypes.h faillog.h defines.h
dialchk.o: dialchk.c rcsid.h prototypes.h faillog.h defines.h dialup.h
dialup.o: dialup.c rcsid.h prototypes.h faillog.h defines.h dialup.h
encrypt.o: encrypt.c rcsid.h prototypes.h faillog.h defines.h
fputsx.o: fputsx.c defines.h rcsid.h
getdef.o: getdef.c rcsid.h prototypes.h faillog.h defines.h
getpass.o: getpass.c rcsid.h defines.h
groupio.o: groupio.c rcsid.h prototypes.h faillog.h defines.h \
 groupio.h
gshadow.o: gshadow.c
lockpw.o: lockpw.c rcsid.h prototypes.h faillog.h defines.h pwio.h \
 shadowio.h
mkdir.o: mkdir.c rcsid.h
port.o: port.c rcsid.h defines.h port.h
putgrent.o: putgrent.c prototypes.h faillog.h defines.h
putpwent.o: putpwent.c rcsid.h defines.h
putspent.o: putspent.c rcsid.h prototypes.h faillog.h defines.h
pwauth.o: pwauth.c rcsid.h prototypes.h faillog.h defines.h pwauth.h \
 getdef.h
pwio.o: pwio.c rcsid.h prototypes.h faillog.h defines.h pwio.h
rad64.o: rad64.c rcsid.h
rename.o: rename.c rcsid.h defines.h
rmdir.o: rmdir.c rcsid.h
sgetgrent.o: sgetgrent.c rcsid.h defines.h
sgetpwent.o: sgetpwent.c rcsid.h defines.h
sgetspent.o: sgetspent.c rcsid.h prototypes.h faillog.h defines.h
sgroupio.o: sgroupio.c rcsid.h prototypes.h faillog.h defines.h \
 sgroupio.h
shadow.o: shadow.c
shadowio.o: shadowio.c rcsid.h prototypes.h faillog.h defines.h \
 shadowio.h
strdup.o: strdup.c defines.h rcsid.h
strstr.o: strstr.c defines.h rcsid.h
utent.o: utent.c

info:

dvi:

check: all

installcheck:

install-exec: 

install-data: 

install: install-exec install-data all
	@:

uninstall: 

all: $(LIBFILES) $(HEADERS) Makefile

install-strip:
	$(MAKE) INSTALL_PROGRAM='$(INSTALL_PROGRAM) -s' install
installdirs:


mostlyclean-generic:
	test -z "$(MOSTLYCLEANFILES)" || rm -f $(MOSTLYCLEANFILES)

clean-generic:
	test -z "$(CLEANFILES)" || rm -f $(CLEANFILES)

distclean-generic:
	rm -f Makefile $(DISTCLEANFILES)
	rm -f config.cache config.log $(CONFIG_HEADER) stamp-h

maintainer-clean-generic:
	test -z "$(MAINTAINERCLEANFILES)" || rm -f $(MAINTAINERCLEANFILES)
	test -z "$(BUILT_SOURCES)" || rm -f $(BUILT_SOURCES)
mostlyclean:  mostlyclean-noinstLIBRARIES mostlyclean-compile \
		mostlyclean-tags mostlyclean-generic

clean:  clean-noinstLIBRARIES clean-compile clean-tags clean-generic \
		mostlyclean 

distclean:  distclean-noinstLIBRARIES distclean-compile distclean-tags \
		distclean-generic clean 
	rm -f config.status

maintainer-clean:  maintainer-clean-noinstLIBRARIES \
		maintainer-clean-compile maintainer-clean-tags \
		maintainer-clean-generic distclean 
	@echo "This command is intended for maintainers to use;"
	@echo "it deletes files that may require special tools to rebuild."

.PHONY: default mostlyclean-noinstLIBRARIES distclean-noinstLIBRARIES \
clean-noinstLIBRARIES maintainer-clean-noinstLIBRARIES \
mostlyclean-compile distclean-compile clean-compile \
maintainer-clean-compile tags mostlyclean-tags distclean-tags \
clean-tags maintainer-clean-tags distdir info dvi check installcheck \
install-exec install-data install uninstall all installdirs \
mostlyclean-generic distclean-generic clean-generic \
maintainer-clean-generic clean mostlyclean distclean maintainer-clean

.SUFFIXES:
.SUFFIXES: .c .o

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
