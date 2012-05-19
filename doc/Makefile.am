NULL =

SRC_DIR = $(top_srcdir)/src

VALADOC_FLAGS = \
	--pkg config @SPRITE_HUT_PACKAGES@ \
	-b $(SRC_DIR) \
	--vapidir=$(srcdir)/../vapi \
	--package-name=SpriteHut \
	$(SRC_DIR)/*.vala \
	$(SRC_DIR)/*/*.vala \
	--force

valadoc:
	$(VALADOC) \
		-o valadoc \
		$(VALADOC_FLAGS) \
		$(NULL)

devhelp:
	$(VALADOC) \
		-o devhelp \
		--doclet devhelp \
		$(VALADOC_FLAGS) \
		$(NULL)

gtkdoc:
	$(VALADOC) \
	-X --ignore-headers \
	-X $(top_srcdir)/src/config.h \
	-X $(top_srcdir)/src/controllers.h \
	-X $(top_srcdir)/src/document.h \
	-X $(top_srcdir)/src/imaging.h \
	-X $(top_srcdir)/src/widgets.h \
	-o gtkdoc \
	--doclet gtkdoc \
	$(VALADOC_FLAGS) \
	$(NULL)

clean-local:
	rm -rf valadoc devhelp gtkdoc

all: valadoc devhelp gtkdoc

EXTRA_DIST = \
index.wiki \
$(NULL)
