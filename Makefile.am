# Makefile.am
ACLOCAL_AMFLAGS = -I m4

if ENABLE_DOC
    DOC_SUBDIR = \
    doc
endif

SUBDIRS = \
	data \
	src \
	vapi \
	po \
	test \
	$(DOC_SUBDIR)

EXTRA_DIST = \
	intltool-extract.in \
	intltool-merge.in \
	intltool-update.in

DISTCLEANFILES = \
	intltool-extract \
	intltool-merge \
	intltool-update
