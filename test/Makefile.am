AM_CPPFLAGS = $(SPRITE_HUT_CFLAGS) -I$(top_srcdir)/src
BUILDDIR = $(top_builddir)/src

TESTS = \
    core_test\
	data_test\
	imaging_test\
	fileio_test

check_PROGRAMS = $(TESTS)

core_test_SOURCES = \
    Core/TestSpriteHutApp.vala \
    Core/core_main.vala
    
core_test_LDADD = $(BUILDDIR)/libcore.la \
     $(BUILDDIR)/libgui.la \
     $(BUILDDIR)/libdata.la \
     $(BUILDDIR)/libimaging.la \
     $(BUILDDIR)/libutils.la \
     $(SPRITE_HUT_LIBS)
core_test_VALAFLAGS = $(BUILDDIR)/core.vapi \
    $(BUILDDIR)/gui.vapi \
    $(BUILDDIR)/data.vapi \
    $(BUILDDIR)/imaging.vapi \
    $(BUILDDIR)/utils.vapi \
    --vapidir=$(srcdir)/../vapi \
    --pkg config \
    @SPRITE_HUT_PACKAGES@
    
data_test_SOURCES = \
    Data/TestAnimation.vala \
    Data/TestDocument.vala \
    Data/TestFrame.vala \
    Data/TestLayer.vala \
    Data/TestSprite.vala \
    Data/TestUndoHistory.vala \
    Data/main.vala
    
data_test_LDADD = $(BUILDDIR)/libdata.la $(BUILDDIR)/libimaging.la $(SPRITE_HUT_LIBS)
data_test_VALAFLAGS = $(BUILDDIR)/data.vapi \
    $(BUILDDIR)/imaging.vapi \
    --vapidir=$(srcdir)/../vapi \
    --pkg config \
    @SPRITE_HUT_PACKAGES@
    
fileio_test_SOURCES = \
    FileIO/TestFreeImageReader.vala \
    FileIO/TestFreeImageWriter.vala \
    FileIO/TestImageSequenceWriter.vala \
    FileIO/TestXmlDocumentWriter.vala \
    FileIO/fileio_main.vala
    
fileio_test_LDADD = $(BUILDDIR)/libfileio.la $(BUILDDIR)/libdata.la $(BUILDDIR)/libimaging.la $(SPRITE_HUT_LIBS)
fileio_test_VALAFLAGS = $(BUILDDIR)/data.vapi \
    $(BUILDDIR)/imaging.vapi \
    $(BUILDDIR)/fileio.vapi \
    --vapidir=$(srcdir)/../vapi \
    --pkg config \
    @SPRITE_HUT_PACKAGES@
    
imaging_test_SOURCES = \
    Imaging/TestFreeImage.vala \
    Imaging/TestIndexedImage.vala \
    Imaging/TestMagickWand.vala \
    Imaging/TestPalette.vala \
    Imaging/TestRGBAImage.vala \
    Imaging/TestSDLDrawing.vala \
    Imaging/imaging_main.vala

imaging_test_LDADD = \
    $(BUILDDIR)/libimaging.la \
    $(BUILDDIR)/libfileio.la \
    $(BUILDDIR)/libdata.la \
    $(SPRITE_HUT_LIBS)
imaging_test_VALAFLAGS = \
    $(BUILDDIR)/imaging.vapi \
    $(BUILDDIR)/fileio.vapi \
    $(BUILDDIR)/data.vapi \
    --vapidir=$(srcdir)/../vapi \
    --pkg config \
    @SPRITE_HUT_PACKAGES@

DIRS = Core/*.c Data/*.c Imaging/*.c FileIO/*.c testfiles/output/* testimages/output/*
CLEANFILES = $(DIRS) *.c *.stamp test-report.xml test-report.html
