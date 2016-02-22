bin_PROGRAMS = spritehut
noinst_LTLIBRARIES = \
    libimaging.la \
    libdata.la \
    libfileio.la \
    libutils.la \
    libgui.la \
    libcore.la

common_flags = \
    --vapidir=$(srcdir)/../vapi --pkg config \
	@SPRITE_HUT_PACKAGES@

libimaging_la_SOURCES = \
    Imaging/Image.vala \
    Imaging/IndexedImage.vala \
    Imaging/RGBAImage.vala \
    Imaging/Palette.vala \
    Imaging/SDLDrawing.vala

libimaging_la_VALAFLAGS = \
    --library imaging -H imaging.h \
    --cc=-I/usr/include/SDL \
    --pkg sdl --pkg sdl-gfx \
    $(common_flags)
    
libimaging_la_LDFLAGS = -lfreeimage -lSDLmain -lSDL_gfx
libimaging_la_LIBADD = \
    @LTLIBOBJS@
    
libdata_la_SOURCES = \
	Data/IDocumentElement.vala \
	Data/Layer.vala \
	Data/Frame.vala \
	Data/Animation.vala \
	Data/Sprite.vala \
	Data/Document.vala \
	Data/UndoHistory.vala \
	Data/BlankDocument.vala

libdata_la_VALAFLAGS = \
    imaging.vapi --library data -H data.h \
    $(common_flags)
    
libdata_la_LIBADD = \
    @LTLIBOBJS@
    

libfileio_la_SOURCES = \
    FileIO/FileError.vala \
    FileIO/FreeImageReader.vala \
    FileIO/FreeImageWriter.vala \
    FileIO/IImageReader.vala \
    FileIO/IImageWriter.vala \
    FileIO/ImageSequenceWriter.vala \
    FileIO/XmlDocumentWriter.vala

libfileio_la_VALAFLAGS = \
    imaging.vapi data.vapi --library fileio -H fileio.h \
    --pkg libxml-2.0 \
    $(common_flags)

libfileio_la_LDFLAGS = -lfreeimage
libfileio_la_LIBADD = \
    @LTLIBOBJS@
    
libgui_la_SOURCES = \
    Gui/MainDock.vala \
    Gui/MainWindow.vala \
    Gui/Controllers/CanvasController.vala \
    Gui/Controllers/FramesIconViewController.vala \
    Gui/Controllers/NewDialogController.vala \
    Gui/Custom/Canvas.vala \
    Gui/Custom/CellRendererHelper.vala \
    Gui/Custom/DocumentTree.vala \
    Gui/Custom/TreeDragDestTreeModelFilter.vala

libgui_la_VALAFLAGS = \
    imaging.vapi data.vapi utils.vapi --library gui -H gui.h \
    $(common_flags)
    
libgui_la_LIBADD = \
    @LTLIBOBJS@
    

libutils_la_SOURCES = \
    Utils/AppConstants.vala \
    Utils/ResourceDirHelper.vala \
    Utils/PreferencesManager.vala

libutils_la_VALAFLAGS = \
    --library utils -H utils.h \
    $(common_flags)
    
libutils_la_LIBADD = \
    @LTLIBOBJS@

libcore_la_SOURCES = \
    Core/SpritehutApp.vala

libcore_la_VALAFLAGS = \
    gui.vapi imaging.vapi utils.vapi data.vapi --library core -H core.h \
    $(common_flags)
    
libcore_la_LIBADD = \
    @LTLIBOBJS@

spritehut_SOURCES = \
    main.vala


AM_CPPFLAGS = \
	-include config.h \
	$(SPRITE_HUT_CFLAGS) \
	-DLOCALEDIR=\""$(localedir)"\" \
	-DPKGDATADIR=\""$(pkgdatadir)"\" \
	-DPKGLIBDIR=\""$(pkglibdir)"\"

spritehut_VALAFLAGS = \
    core.vapi utils.vapi imaging.vapi data.vapi fileio.vapi gui.vapi \
	--vapidir=$(srcdir)/../vapi --pkg config \
	@SPRITE_HUT_PACKAGES@

spritehut_LDADD = \
	libcore.la libgui.la libdata.la libimaging.la libfileio.la libutils.la $(SPRITE_HUT_LIBS)

DIRS = Core/*.c Utils/*.c Data/*.c Gui/*.c Gui/Custom/*.c Gui/Controllers/*.c Imaging/*.c FileIO/*.c
CLEANFILES = *.h *.c $(DIRS) *.vapi *.stamp

#valencia options
BUILD_ROOT = 1
PROGRAM = spritehut

