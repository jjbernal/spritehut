bin_PROGRAMS = spritehut
noinst_LTLIBRARIES = \
    libimaging.la \
    libdocument.la \
    libfileio.la \
    libcore.la \
    libwidgets.la

common_flags = \
    --vapidir=$(srcdir)/../vapi --pkg config \
	@SPRITE_HUT_PACKAGES@

libimaging_la_SOURCES = \
    imaging/palette.vala \
	imaging/image.vala \
	imaging/indexedimage.vala \
	imaging/rgbaimage.vala \
	imaging/sdldrawing.vala

libimaging_la_VALAFLAGS = \
    --library imaging -H imaging.h \
    --cc=-I/usr/include/SDL \
    --pkg sdl --pkg sdl-gfx \
    $(common_flags)
    
libimaging_la_LDFLAGS = -lfreeimage -lSDLmain -lSDL_gfx
libimaging_la_LIBADD = \
    @LTLIBOBJS@
    
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
    

libfileio_la_SOURCES = \
    fileio/freeimagereader.vala \
    fileio/iimagereader.vala \
    fileio/errors.vala \
    fileio/iimagewriter.vala \
    fileio/freeimagewriter.vala \
    fileio/xmldocumentwriter.vala \
    fileio/imagesequencewriter.vala

libfileio_la_VALAFLAGS = \
    imaging.vapi document.vapi --library fileio -H fileio.h \
    --pkg libxml-2.0 \
    $(common_flags)

libfileio_la_LDFLAGS = -lfreeimage
libfileio_la_LIBADD = \
    @LTLIBOBJS@
    
libwidgets_la_SOURCES = \
    widgets/mainwindow.vala \
    widgets/maindock.vala \
    widgets/newdialog.vala \
    widgets/framesiconview.vala \
    widgets/canvascontroller.vala \
    widgets/custom/documenttree.vala \
    widgets/custom/canvas.vala \
    widgets/custom/treedragdesttreemodelfilter.vala \
    widgets/custom/cellrendererhelper.vala

libwidgets_la_VALAFLAGS = \
    imaging.vapi document.vapi core.vapi --library widgets -H widgets.h \
    $(common_flags)
    
libwidgets_la_LIBADD = \
    @LTLIBOBJS@
    

libcore_la_SOURCES = \
    core/AppConstants.vala \
    core/ResourceDirHelper.vala \
    core/PreferencesManager.vala

libcore_la_VALAFLAGS = \
    --library core -H core.h \
    $(common_flags)
    
libcore_la_LIBADD = \
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
    core.vapi imaging.vapi document.vapi fileio.vapi widgets.vapi \
	--vapidir=$(srcdir)/../vapi --pkg config \
	@SPRITE_HUT_PACKAGES@

spritehut_LDADD = \
	libwidgets.la libdocument.la libimaging.la libfileio.la libcore.la $(SPRITE_HUT_LIBS)

DIRS = core/*.c document/*.c widgets/*.c imaging/*.c fileio/*.c
CLEANFILES = *.h *.c $(DIRS) *.vapi *.stamp

#valencia options
BUILD_ROOT = 1
PROGRAM = spritehut

