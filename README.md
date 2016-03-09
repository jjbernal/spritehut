[![Build Status](https://travis-ci.org/jjbernal/spritehut.svg?branch=master)](https://travis-ci.org/jjbernal/spritehut)
[![Stories in Ready](https://badge.waffle.io/jjbernal/spritehut.png?label=ready&title=Ready)](https://waffle.io/jjbernal/spritehut)
Sprite Hut
==========
Just a sprite editor. Written in vala.

Released under the GPL v3 license. See [COPYING](COPYING) for details.

Check out the [wiki](https://github.com/jjbernal/spritehut/wiki) for more information.

Supported platforms
-------------------
* GNU/linux

Dependencies
------------
* GTK+ >= 3.0
* GDL >= 3.0
* gee-0.8 >= 0.10
* SDL-GFX >= 1.2
* MagickCore >= 6.0
* MagickWand >= 6.0
* FreeImage >= 3.15
* libxml-2.0 >= 2.6

And recent autotools and autogen versions.

If you are a ubuntu user, you can add the Vala Team PPA by running:

    sudo add-apt-repository ppa:vala-team/ppa
    sudo apt-get update

Then you can install all the required packages by issuing the following command:

    sudo apt-get install gnome-common libglib2.0-dev libgtk-3-dev \
        libvala-0.30-dev valac-0.30 valac-0.30-vapi gobject-introspection \
        libgee-0.8-dev libsdl1.2-dev libsdl-gfx1.2-dev libgdl-3-dev \
        libxml2-dev libmagickcore-dev libmagickwand-dev libfreeimage-dev

 NOTE: Although the 0.20 version of the valac Vala compiler works fine, it's recommended
 that you get updated versions from the Vala team PPA


How to build:
-------------
First run autogen.sh once from a fresh code base:

    ./autogen.sh

Then to build:

    make

To install into your system (mandatory for the app to work correctly as of this writing):

    make install

To uninstall:

    make uninstall

To build translations and execute tests (developers only):

    make check
