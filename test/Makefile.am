AM_CPPFLAGS = $(SPRITE_HUT_CFLAGS) -I$(top_srcdir)/src
BUILDDIR = $(top_builddir)/src

TESTS = \
	data_test\
	imaging_test\
	fileio_test

check_PROGRAMS = $(TESTS)

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

DIRS = Data/*.c Imaging/*.c FileIO/*.c testfiles/output/* testimages/output/*
CLEANFILES = $(DIRS) *.c *.stamp test-report.xml test-report.html
