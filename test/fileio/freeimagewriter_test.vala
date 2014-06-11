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

public class TestFreeImageWriter : Object {
    public static void test_save_indexed_1bit () {
        // checkerboard
        uint8[] pixel_array = new uint8[6] {0, 1,
                                              1, 0,
                                              0, 1};
        IndexedImage image = new IndexedImage.from_pixel_data(2, 3, 8, pixel_array);
        
        // create and initialize palette
        image.palette = new Palette();
        image.palette.color_list.add({0, 0, 0, 1.0});
        image.palette.color_list.add({1, 1, 1, 1.0});
        
        IImageWriter writer = new FreeImageWriter();
        
        try {
            writer.save(image, "imaging/testimages/saved_1bpp.png");
        }
        catch (Error e) {
            assert_not_reached();
        }
    }
    
    public static void test_save_indexed_4bit () {
        // not actually 4-bit...
        uint8[] pixel_array = new uint8[6] {0, 1,
                                              2, 3,
                                              4, 5};
        IndexedImage image = new IndexedImage.from_pixel_data(2, 3, 8, pixel_array);
        
        // create and initialize palette
        image.palette = new Palette();
        image.palette.color_list.add({1, 0, 0, 1.0});
        image.palette.color_list.add({0, 1, 0, 1.0});
        image.palette.color_list.add({0, 0, 1, 1.0});
        image.palette.color_list.add({1, 1, 1, 1.0});
        image.palette.color_list.add({0, 0, 0, 0.5});
        image.palette.color_list.add({1, 1, 1, 0.0});
        
        IImageWriter writer = new FreeImageWriter();
        
        try {
            writer.save(image, "imaging/testimages/saved_4bpp.png");
        }
        catch (Error e) {
            assert_not_reached();
        }
    }
    
    public static void test_save_indexed_8bit () {
        uint8[] pixel_array = new uint8[6] {0, 1,
                                              2, 3,
                                              4, 5};
        IndexedImage image = new IndexedImage.from_pixel_data(2, 3, 8, pixel_array);
        
        // create and initialize palette
        image.palette = new Palette();
        image.palette.color_list.add({1, 0, 0, 1.0});
        image.palette.color_list.add({0, 1, 0, 1.0});
        image.palette.color_list.add({0, 0, 1, 1.0});
        image.palette.color_list.add({1, 1, 1, 1.0});
        image.palette.color_list.add({0, 0, 0, 0.5});
        image.palette.color_list.add({1, 1, 1, 0.0});
        
        IImageWriter writer = new FreeImageWriter();
        
        try {
            writer.save(image, "imaging/testimages/saved_8bpp.png");
        }
        catch (Error e) {
            assert_not_reached();
        }
    }
    
    public static void test_save_rgb_24bit () {
        uint8[] pixel_array = new uint8[18] {0, 0, 255,
                                              0, 255, 0,
                                             255, 0, 0,
                                             255, 255, 255,
                                             0, 0, 0,
                                             0, 0, 0};
        
        Image image = new RGBAImage.from_pixel_data(2, 3, 24, pixel_array);
        IImageWriter writer = new FreeImageWriter();
        
        try {
            writer.save(image, "imaging/testimages/saved_24bpp.png");
        }
        catch (Error e) {
            assert_not_reached();
        }
    }
    
    public static void test_save_rgba_32bit () {
        uint8[] pixel_array = new uint8[24] {0, 0, 255, 255,
                                              0, 255, 0, 255,
                                             255, 0, 0, 255,
                                             255, 255, 255, 255,
                                             0, 0, 0, 128,
                                             0, 0, 0, 0};
        
        Image image = new RGBAImage.from_pixel_data(2, 3, 32, pixel_array);
        IImageWriter writer = new FreeImageWriter();
        
        try {
            writer.save(image, "imaging/testimages/saved_32bpp.png");
        }
        catch (Error e) {
            assert_not_reached();
        }
    }
    
    public static void test_save_fail (){
        uint8[] pixel_array = new uint8[24] {0, 0, 255, 255,
                                              0, 255, 0, 255,
                                             255, 0, 0, 255,
                                             255, 255, 255, 255,
                                             0, 0, 0, 255,
                                             0, 0, 0, 0};
        
        Image image = new RGBAImage.from_pixel_data(2, 3, 32, pixel_array);
        FreeImageWriter writer = new FreeImageWriter();
        
        try {
            // You shouldn't have permission to save anything in / (dont run this as root/admin)
            writer.save(image, "/notallowedhere.png");
        }
        catch (Error e) {
            assert(e is FileIO.IOError);
            stdout.printf(e.message);
        }
    }

    public static void add_tests() {
        Test.add_func ("/fileio/FreeImageWriter.save() indexed 1-bit", test_save_indexed_1bit);
        Test.add_func ("/fileio/FreeImageWriter.save() indexed 4-bit", test_save_indexed_4bit);
        Test.add_func ("/fileio/FreeImageWriter.save() indexed 8-bit", test_save_indexed_8bit);
        Test.add_func ("/fileio/FreeImageWriter.save() rgb 24-bit", test_save_rgb_24bit);
        Test.add_func ("/fileio/FreeImageWriter.save() rgba 32-bit", test_save_rgba_32bit);
        Test.add_func ("/fileio/FreeImageWriter.save() fail", test_save_fail);
    }
}
