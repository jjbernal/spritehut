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
using FileIO;
using Gdk;
using FreeImage;

public class TestFreeImageReader : Object {
    public static void test_load_indexed_1bit () {
        FreeImageReader reader = new FreeImageReader();
        
        Image image = reader.load("imaging/testimages/1bpp.png");
        
        assert(image.palette.color_list != null);
        
        Gdk.RGBA white = image.get_pixel_color(0,0);
        Gdk.RGBA black = image.get_pixel_color(1,0);
        
        assert (black.red == 0 && black.green == 0 && black.blue == 0);
        assert (white.red == 1 && white.green == 1 && white.blue == 1);
    }
    
    public static void test_load_indexed_4bit () {
        FreeImageReader reader = new FreeImageReader();
        
        Image image = reader.load("imaging/testimages/4bpp.png");
        
        assert(image.palette.color_list != null);
        
        Gdk.RGBA red = image.get_pixel_color(0,0);
        Gdk.RGBA green = image.get_pixel_color(15,0);
        Gdk.RGBA blue = image.get_pixel_color(0,15);
        Gdk.RGBA white = image.get_pixel_color(15,15);
        Gdk.RGBA transparent = image.get_pixel_color(1,0);
        
        assert (red.red == 1.0 && red.green == 0 && red.blue == 0);
        assert (green.red == 0 && green.green == 1 && green.blue == 0);
        assert (blue.red == 0 && blue.green == 0 && blue.blue == 1);
        assert (white.red == 1 && white.green == 1 && white.blue == 1);
        
        assert (transparent.alpha == 0);
//        int i = 0;
//        foreach (RGBA rgba in image.palette.color_list) {
//            stdout.printf("\ncolor %u:(%f %f %f %f)", i, rgba.red, rgba.green, rgba.blue, rgba.alpha);
//            i++;
//        }
    }
    
    public static void test_load_indexed_8bit () {
        FreeImageReader reader = new FreeImageReader();
        
        Image image = reader.load("imaging/testimages/8bpp.png");
        
        assert(image.palette.color_list != null);
        
        Gdk.RGBA red = image.get_pixel_color(0,0);
        Gdk.RGBA green = image.get_pixel_color(15,0);
        Gdk.RGBA blue = image.get_pixel_color(0,15);
        Gdk.RGBA white = image.get_pixel_color(15,15);
        Gdk.RGBA transparent = image.get_pixel_color(1,0);
        
        assert (red.red == 1.0 && red.green == 0 && red.blue == 0);
        assert (green.red == 0 && green.green == 1 && green.blue == 0);
        assert (blue.red == 0 && blue.green == 0 && blue.blue == 1);
        assert (white.red == 1 && white.green == 1 && white.blue == 1);
        
        assert (transparent.alpha == 0);
//        int i = 0;
//        foreach (RGBA rgba in image.palette.color_list) {
//            stdout.printf("\ncolor %u:(%f %f %f %f)", i, rgba.red, rgba.green, rgba.blue, rgba.alpha);
//            i++;
//        }
    }
    
    public static void test_load_rgb_24bit () {
        FreeImageReader reader = new FreeImageReader();
        
        Image image = reader.load("imaging/testimages/24bpp.png");
        
        Gdk.RGBA red = image.get_pixel_color(0,0);
        Gdk.RGBA green = image.get_pixel_color(15,0);
        Gdk.RGBA blue = image.get_pixel_color(0,15);
        Gdk.RGBA white = image.get_pixel_color(15,15);
        Gdk.RGBA transparent = image.get_pixel_color(1,0);
        
        assert (red.red == 1.0 && red.green == 0 && red.blue == 0);
        assert (green.red == 0 && green.green == 1 && green.blue == 0);
        assert (blue.red == 0 && blue.green == 0 && blue.blue == 1);
        assert (white.red == 1 && white.green == 1 && white.blue == 1);
        assert (transparent.alpha == 1);
    }
    
    public static void test_load_rgba_32bit () {
        FreeImageReader reader = new FreeImageReader();
        
        Image image = reader.load("imaging/testimages/32bpp.png");
        
        Gdk.RGBA red = image.get_pixel_color(0,0);
        Gdk.RGBA green = image.get_pixel_color(15,0);
        Gdk.RGBA blue = image.get_pixel_color(0,15);
        Gdk.RGBA white = image.get_pixel_color(15,15);
        Gdk.RGBA transparent = image.get_pixel_color(1,0);
        
        assert (red.red == 1.0 && red.green == 0 && red.blue == 0);
        assert (green.red == 0 && green.green == 1 && green.blue == 0);
        assert (blue.red == 0 && blue.green == 0 && blue.blue == 1);
        assert (white.red == 1 && white.green == 1 && white.blue == 1);
        assert (transparent.alpha == 0);
    }
    
    public static void test_load_fail (){
        FreeImageReader reader = new FreeImageReader();
        
        try {
            // this image does not actually exist
            Image image = reader.load("imaging/testimages/nonexistentimage.png");
        }
        catch (Error e) {
            assert(e is FileIO.IOError);
        }
    }

    public static void add_tests() {
        Test.add_func ("/fileio/FreeImageReader.load() indexed 1-bit", test_load_indexed_1bit);
        Test.add_func ("/fileio/FreeImageReader.load() indexed 4-bit", test_load_indexed_4bit);
        Test.add_func ("/fileio/FreeImageReader.load() indexed 8-bit", test_load_indexed_8bit);
        Test.add_func ("/fileio/FreeImageReader.load() rgb 24-bit", test_load_rgb_24bit);
        Test.add_func ("/fileio/FreeImageReader.load() rgba 32-bit", test_load_rgba_32bit);
        Test.add_func ("/fileio/FreeImageReader.load() fail", test_load_fail);
    }
}
