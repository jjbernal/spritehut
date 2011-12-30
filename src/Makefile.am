bin_PROGRAMS = spritehut
noinst_LTLIBRARIES = libdocument.la

libdocument_la_SOURCES = \
	document/idocumentelement.vala \
	document/layer.vala \
	document/frame.vala \
	document/animation.vala \
	document/sprite.vala

libdocument_la_VALAFLAGS = --library document -H document.h

spritehut_SOURCES = \
	spritehut.vala \
	spritehut-app.vala \
	controllers/main.vala \
	controllers/about.vala \
	widgets/mainwindow.vala \
	widgets/maindock.vala

INCLUDES = \
	-include config.h \
	$(SPRITE_HUT_CFLAGS) \
	-DLOCALEDIR=\""$(localedir)"\" \
	-DPKGDATADIR=\""$(pkgdatadir)"\" \
	-DPKGLIBDIR=\""$(pkglibdir)"\"

VALAFLAGS = \
	--vapidir=$(srcdir)/../vapi --pkg config \
	@SPRITE_HUT_PACKAGES@

spritehut_LDADD = \
	libdocument.la $(SPRITE_HUT_LIBS)

DIRS = document/*.c controllers/*.c widgets/*.c
CLEANFILES = *.h *.c $(DIRS) *.vapi *.stamp

#valencia options
BUILD_ROOT = 1
PROGRAM = spritehut

