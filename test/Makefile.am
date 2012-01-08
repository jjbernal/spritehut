AM_CPPFLAGS = $(SPRITE_HUT_CFLAGS) -I$(top_srcdir)/src
BUILDDIR = $(top_builddir)/src

TESTS = \
	document-test \
	imaging-test

check_PROGRAMS = $(TESTS)

document_test_SOURCES = \
    document/layer_test.vala \
    document/frame_test.vala \
    document/animation_test.vala \
    document/sprite_test.vala \
    document/document_test.vala \
    document/undohistory_test.vala \
    document/main.vala
    
document_test_LDADD = $(BUILDDIR)/libdocument.la $(BUILDDIR)/libimaging.la $(SPRITE_HUT_LIBS)
document_test_VALAFLAGS = $(BUILDDIR)/document.vapi \
    $(BUILDDIR)/imaging.vapi \
    --vapidir=$(srcdir)/../vapi \
    --pkg config \
	@SPRITE_HUT_PACKAGES@    
	
imaging_test_SOURCES = \
    imaging/palette_test.vala \
    imaging/imaging_main.vala
    
imaging_test_LDADD = $(BUILDDIR)/libimaging.la $(SPRITE_HUT_LIBS)
imaging_test_VALAFLAGS = \
    $(BUILDDIR)/imaging.vapi \
    --vapidir=$(srcdir)/../vapi \
    --pkg config \
	@SPRITE_HUT_PACKAGES@

DIRS = document/*.c imaging/*.c
CLEANFILES = $(DIRS) *.c *.stamp test-report.xml test-report.html
