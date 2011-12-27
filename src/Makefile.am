bin_PROGRAMS = spritehut

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
	$(SPRITE_HUT_LIBS)

#valencia options
BUILD_ROOT = 1
PROGRAM = spritehut
