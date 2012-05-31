# configure.ac

AC_INIT([Sprite Hut],[0.1])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([src/spritehut.vala])
AC_CONFIG_HEADERS([config.h])

AM_INIT_AUTOMAKE([no-dist-gzip dist-bzip2])


# Enable silent rules is available
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AM_MAINTAINER_MODE

LT_INIT
AC_PROG_CC
AC_PROG_CC_STDC
AM_PROG_VALAC([0.14.0])
AC_PROG_INSTALL
IT_PROG_INTLTOOL([0.35])

pkg_modules="MagickCore >= 6.0 MagickWand >= 6.0 gee-1.0 >= 0.6.2.1 gtk+-3.0 >= 3.0 gmodule-2.0 >= 2.0 gdl-3.0 >= 2.80 sdl >= 1.2"
SPRITE_HUT_PACKAGES="--pkg freeimage --pkg MagickWand --pkg gee-1.0 --pkg gtk+-3.0 --pkg gmodule-2.0 --pkg gdl-3.0"
PKG_CHECK_MODULES(SPRITE_HUT, [$pkg_modules])
AC_SUBST(SPRITE_HUT_CFLAGS)
AC_SUBST(SPRITE_HUT_LIBS)
AC_SUBST(SPRITE_HUT_PACKAGES)

GETTEXT_PACKAGE=spritehut
AC_DEFINE_UNQUOTED([GETTEXT_PACKAGE], ["$GETTEXT_PACKAGE"], [Gettext Package])
AC_SUBST(GETTEXT_PACKAGE)
AM_GNU_GETTEXT_VERSION([1.11])
AM_GLIB_GNU_GETTEXT

AC_ARG_ENABLE(doc, AS_HELP_STRING([--enable-doc], [Enable documentation generation]), enable_doc=$enableval, enable_doc=no)
AM_CONDITIONAL(ENABLE_DOC, test x$enable_doc = xyes)

AS_IF([test "x$enable_doc" != xno],
[AC_PATH_PROG(VALADOC, valadoc, :)
AC_SUBST(VALADOC)
AS_IF([test "$VALADOC" = :],
[AC_MSG_ERROR([valadoc not found])])])

AC_CONFIG_FILES([
	Makefile
	data/spritehut.desktop.in
	data/Makefile
	data/icons/Makefile
	data/icons/16x16/Makefile
	data/icons/22x22/Makefile
	data/icons/24x24/Makefile
	data/icons/32x32/Makefile
	data/icons/48x48/Makefile
	data/icons/scalable/Makefile
	po/Makefile.in
	src/Makefile
	test/Makefile
	vapi/Makefile
	doc/Makefile
])
AC_OUTPUT
