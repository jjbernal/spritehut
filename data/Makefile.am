# Makefile.am

SUBDIRS = icons ui

desktopdir = $(datadir)/applications
desktop_in_files = spritehut.desktop.in
desktop_DATA = $(desktop_in_files:.desktop.in=.desktop)
@INTLTOOL_DESKTOP_RULE@

EXTRA_DIST = \
	$(desktop_in_files)

CLEANFILES = \
	$(desktop_DATA)
