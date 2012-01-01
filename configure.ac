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

pkg_modules="gtk+-3.0 >= 3.0 gmodule-2.0 >= 2.0 gdl-3.0 >= 2.80"
SPRITE_HUT_PACKAGES="--pkg gio-2.0 --pkg gtk+-3.0 --pkg gmodule-2.0 --pkg gdl-3.0"
PKG_CHECK_MODULES(SPRITE_HUT, [$pkg_modules])
AC_SUBST(SPRITE_HUT_CFLAGS)
AC_SUBST(SPRITE_HUT_LIBS)
AC_SUBST(SPRITE_HUT_PACKAGES)

GETTEXT_PACKAGE=spritehut
AC_DEFINE_UNQUOTED([GETTEXT_PACKAGE], ["$GETTEXT_PACKAGE"], [Gettext Package])
AC_SUBST(GETTEXT_PACKAGE)
AM_GNU_GETTEXT_VERSION([1.11])
AM_GLIB_GNU_GETTEXT

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
])
AC_OUTPUT
