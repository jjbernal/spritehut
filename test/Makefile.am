AM_CPPFLAGS = $(SPRITE_HUT_CFLAGS) -I$(top_srcdir)/src

TESTS = \
	sprite-test \
	layer-test

check_PROGRAMS = $(TESTS)

sprite_test_SOURCES = \
    sprite_test.vala
layer_test_SOURCES = \
    layer_test.vala

LDADD = $(top_builddir)/src/libdocument.la $(SPRITE_HUT_LIBS)
VALAFLAGS = $(top_builddir)/src/document.vapi

CLEANFILES = *.c *.stamp test-report.xml test-report.html
