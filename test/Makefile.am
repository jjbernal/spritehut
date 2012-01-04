AM_CPPFLAGS = $(SPRITE_HUT_CFLAGS) -I$(top_srcdir)/src

TESTS = \
	document-test

check_PROGRAMS = $(TESTS)

document_test_SOURCES = \
    document/layer_test.vala \
    document/frame_test.vala \
    document/animation_test.vala \
    document/sprite_test.vala \
    document/palette_test.vala \
    document/document_test.vala \
    document/main.vala

LDADD = $(top_builddir)/src/libdocument.la $(SPRITE_HUT_LIBS)
VALAFLAGS = $(top_builddir)/src/document.vapi \
    --vapidir=$(srcdir)/../vapi \
    --pkg config \
	@SPRITE_HUT_PACKAGES@

DIRS = document/*.c
CLEANFILES = $(DIRS) *.c *.stamp test-report.xml test-report.html
