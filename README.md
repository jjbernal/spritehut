Sprite Hut
==========

Just a sprite editor GNU/linux. Written in vala.

More details in the functional specification (coming soon).

Supported platforms
-------------------
* GNU/linux

Dependencies
------------
* GTK+ >= 3.0
* GDL >= 3.0
* SDL >= 1.2
* MagickCore >= 6.0
* MagickWand >= 6.0
* gee-0.8 >= 0.10
* libxml-2.0 >= 2.6

How to build:
-------------
Run from CLI:

    ./autogen.sh
    make

To install into your system (mandatory for the app to work correctly as of this writing):

    make install

To build translations and execute tests (developers only):

    make check
