# Makefile.am

SUBDIRS = icons

# ui data
uidir = $(pkgdatadir)/ui
ui_DATA = \
    ui/mainwindow.ui \
    ui/mainmenubar.ui \
    ui/maindockwidgets.ui \
    ui/aboutdialog.ui \
    ui/newdocumentdialog.ui

desktopdir = $(datadir)/applications
desktop_in_files = spritehut.desktop.in
desktop_DATA = $(desktop_in_files:.desktop.in=.desktop)
@INTLTOOL_DESKTOP_RULE@

EXTRA_DIST = \
	$(desktop_in_files) \
	$(ui_DATA)

CLEANFILES = \
	$(desktop_DATA)
