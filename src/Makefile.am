bin_PROGRAMS = spritehut
noinst_LTLIBRARIES = libimaging.la libdocument.la libwidgets.la libcontrollers.la

common_flags = \
    --vapidir=$(srcdir)/../vapi --pkg config \
	@SPRITE_HUT_PACKAGES@

libimaging_la_SOURCES = \
    imaging/palette.vala \
	imaging/image.vala \
	imaging/cairoimage.vala

libimaging_la_VALAFLAGS = \
    --library imaging -H imaging.h \
    $(common_flags)	
    
libdocument_la_SOURCES = \
	document/idocumentelement.vala \
	document/layer.vala \
	document/frame.vala \
	document/animation.vala \
	document/sprite.vala \
	document/document.vala \
	document/undohistory.vala \
	document/blankdocument.vala

libdocument_la_VALAFLAGS = \
    imaging.vapi --library document -H document.h \
    $(common_flags)
    
libdocument_la_LIBADD = \
    @LTLIBOBJS@
    
libwidgets_la_SOURCES = \
    widgets/mainwindow.vala \
	widgets/maindock.vala \
	widgets/documentelementcellrenderer.vala \
	widgets/documenttree.vala

libwidgets_la_VALAFLAGS = \
    imaging.vapi document.vapi --library widgets -H widgets.h \
    $(common_flags)
    
libwidgets_la_LIBADD = \
    @LTLIBOBJS@

libcontrollers_la_SOURCES = \
    controllers/main.vala \
    controllers/about.vala

libcontrollers_la_VALAFLAGS = \
    imaging.vapi document.vapi widgets.vapi --library controllers -H controllers.h \
    $(common_flags)
    
libcontrollers_la_LIBADD = \
    @LTLIBOBJS@

spritehut_SOURCES = \
	spritehut.vala \
	spritehut-app.vala

AM_CPPFLAGS = \
	-include config.h \
	$(SPRITE_HUT_CFLAGS) \
	-DLOCALEDIR=\""$(localedir)"\" \
	-DPKGDATADIR=\""$(pkgdatadir)"\" \
	-DPKGLIBDIR=\""$(pkglibdir)"\"

spritehut_VALAFLAGS = \
    imaging.vapi document.vapi widgets.vapi controllers.vapi \
	--vapidir=$(srcdir)/../vapi --pkg config \
	@SPRITE_HUT_PACKAGES@

spritehut_LDADD = \
	libwidgets.la libcontrollers.la libdocument.la libimaging.la $(SPRITE_HUT_LIBS)

DIRS = document/*.c controllers/*.c widgets/*.c
CLEANFILES = *.h *.c $(DIRS) *.vapi *.stamp

#valencia options
BUILD_ROOT = 1
PROGRAM = spritehut

