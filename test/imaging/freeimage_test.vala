/*
** Copyright © 2011-2012 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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

using Imaging;
using FreeImage;

public class TestFreeImage : Object {
    public static void test_init () {
        FreeImage.initialise();
        FreeImage.de_initialise();
    }
    
    public static void test_get_version () {
//        FreeImage.initialise();
        stdout.printf("FreeImage version: %s ", FreeImage.get_version());
//        FreeImage.de_initialise();
    }
    
    public static void test_get_copyright () {
//        FreeImage.initialise();
        stdout.printf("Copyright message: %s ", FreeImage.get_copyright_message());
//        FreeImage.de_initialise();
    }
    
    public static void test_allocate () {
        Bitmap bitmap = new Bitmap(640, 480, 8);
        stdout.printf("Image type: %u ", bitmap.get_image_type());
    }
    
    public static void test_load () {
        Bitmap bitmap = FreeImage.load(Format.GIF, "imaging/indexed.gif", 0);
        assert (bitmap != null);
    }
    
    public static void test_save () {
        Bitmap bitmap = FreeImage.load(Format.GIF, "imaging/indexed.gif", 0);
        assert (bitmap != null);
        bool saved = FreeImage.save(Format.PNG, bitmap, "imaging/indexed_fi.png");
        assert (saved == true);
    }
    
    public static void test_image_type () {
        Bitmap bitmap = FreeImage.load(Format.GIF, "imaging/indexed.gif", 0);
        stdout.printf("Image type: %u ", bitmap.get_image_type());
    }
    
    public static void test_colors_used () {
        Bitmap bitmap = FreeImage.load(Format.PNG, "imaging/indexed_mw.png", 0);
        stdout.printf("Colors used: %u ", bitmap.get_colors_used());
    }
    
    public static void test_get_bpp () {
        Bitmap bitmap = FreeImage.load(Format.PNG, "imaging/indexed_mw.png", 0);
        stdout.printf("BPP: %u ", bitmap.get_bpp());
    }
    
    public static void test_get_width () {
        Bitmap bitmap = FreeImage.load(Format.PNG, "imaging/indexed.png", 0);
        stdout.printf("width: %u ", bitmap.get_width());
    }
    
    public static void test_get_height () {
        Bitmap bitmap = FreeImage.load(Format.PNG, "imaging/indexed.png", 0);
        stdout.printf("height: %u ", bitmap.get_height());
    }
    
    public static void test_get_palette () {
        Bitmap bitmap = FreeImage.load(Format.GIF, "imaging/indexed.gif", 0);
        RgbQuad* palette = bitmap.get_palette();
        
        for(int i = 0; i < bitmap.get_colors_used(); i++ ) {
            stdout.printf("Color %i: (%u,%u,%u) ", i, palette[i].rgbRed, palette[i].rgbGreen, palette[i].rgbBlue);
        }
    }
    
     public static void test_get_bits () {
        Bitmap bitmap = FreeImage.load(Format.PNG, "imaging/indexed_mw.png", 0);
        uint8* pixels = bitmap.get_bits();
        
        // loop flipped on y axis because FreeImage loads images vertically inverted
        for(int y = (int) bitmap.get_height()/2-1; y >= 0; y-- ) {
            for(int x = 0; x < bitmap.get_width()/2; x++ ) {
                stdout.printf("%x ", *(pixels+x+y*bitmap.get_width()/2));
            }
            stdout.printf("\n");
        }
    }

    public static void add_tests()  {
        Test.add_func ("/imaging/FreeImage.Initialise();FreeImage.DeInitialise();", test_init);
        Test.add_func ("/imaging/FreeImage.get_version", test_get_version);
        Test.add_func ("/imaging/FreeImage.get_copyright_message", test_get_copyright);
        Test.add_func ("/imaging/FreeImage Image.allocate()", test_allocate);
        Test.add_func ("/imaging/FreeImage Image.load()", test_load);
        Test.add_func ("/imaging/FreeImage Image.save()", test_save);
        Test.add_func ("/imaging/FreeImage Image.get_image_type()", test_image_type);
        Test.add_func ("/imaging/FreeImage Image.get_colors_used()", test_colors_used);
        Test.add_func ("/imaging/FreeImage Image.get_bpp()", test_get_bpp);
        Test.add_func ("/imaging/FreeImage Image.get_width()", test_get_width);
        Test.add_func ("/imaging/FreeImage Image.get_height()", test_get_height);
        Test.add_func ("/imaging/FreeImage Image.get_palette()", test_get_palette);
        Test.add_func ("/imaging/FreeImage Image.get_palette()", test_get_bits);
    }
}
