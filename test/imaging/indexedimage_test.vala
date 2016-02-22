/*
** Copyright © 2011-2012, 2016 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
**
** This file is part of Sprite Hut.
**
** Sprite Hut is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** Sprite Hut is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with Sprite Hut.  If not, see <http://www.gnu.org/licenses/>.
*/

using Gdk;
using FreeImage;
using SpriteHut.Imaging;

public class TestIndexedImage : Object {
    public static void text_header()
    {
        stdout.printf("\nIndexedImage TESTS\n");
        stdout.printf("====================\n");
    }
    
    public static void test_get_pixel_color_indexed () {
        // a dummy 2x2 32-bit BGRA image consisting formed by a red, green, blue and white pixel
        uint8* pixel_array = new uint8[4] {0, 1,
                                              2, 3};
        IndexedImage image = new IndexedImage.from_pixel_data(2, 2, 8, pixel_array);
        
        // create and initialize palette
        image.palette = new Palette();
        image.palette.color_list.add({1, 0, 0, 1.0});
        image.palette.color_list.add({0, 1, 0, 1.0});
        image.palette.color_list.add({0, 0, 1, 1.0});
        image.palette.color_list.add({1, 1, 1, 1.0});
        
        Gdk.RGBA red = image.get_pixel_color(0,0);
        Gdk.RGBA green = image.get_pixel_color(1,0);
        Gdk.RGBA blue = image.get_pixel_color(0,1);
        Gdk.RGBA white = image.get_pixel_color(1,1);
        
        assert (red.red == 1.0 && red.green == 0 && red.blue == 0);
        assert (green.red == 0 && green.green == 1 && green.blue == 0);
        assert (blue.red == 0 && blue.green == 0 && blue.blue == 1);
        assert (white.red == 1 && white.green == 1 && white.blue == 1);
    }

    public static void add_tests() {
        Test.message("IndexedImage TESTS");
        Test.add_func ("/imaging/IndexedImage.get_pixel_color(x , y) indexed image", test_get_pixel_color_indexed);
    }
}
