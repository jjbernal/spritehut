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
using SpriteHut.Imaging;
using SpriteHut.FileIO;

public class TestSDLDrawing : Object {
    public static void test_draw_line_indexed () {
        IndexedImage image = new IndexedImage(64, 64, 8);
        
        // create and initialize palette
        image.palette = new Palette();
        image.palette.color_list.add({0, 0.1, 0, 0.0});
        image.palette.color_list.add({1, 0, 0, 1.0});
        image.palette.color_list.add({0, 1, 0, 1.0});
        image.palette.color_list.add({0, 0, 1, 1.0});
        image.palette.color_list.add({0, 0, 0, 0.51});
        
        var draw = new SDLDrawing();
        
        draw.line(image, 0, 0, 7, 15, image.palette.color_list[1]);
        draw.line(image, 15, 0, 7, 15, image.palette.color_list[2]);
        draw.line(image, 0, 15, 8, 0, image.palette.color_list[3]);
        draw.line(image, 15, 15, 8, 0, image.palette.color_list[4]);
        
        draw.ellipse(image, 16, 0, 63, 15, image.palette.color_list[1]);
        draw.ellipse(image, 32, 0, 63, 15, image.palette.color_list[2]);
        draw.ellipse(image, 48, 0, 63, 15, image.palette.color_list[3]);
        
        try {
            IImageWriter writer = new FreeImageWriter();
            writer.save(image, "imaging/testimages/drawing_8bpp.png");
        }
        catch (Error e) {
            assert_not_reached();
        }
    }
    
    public static void test_draw_rgba () {
        Image image = new RGBAImage (64, 64, 32);
        
        var draw = new SDLDrawing();
        
        RGBA red = {1, 0, 0, 0.9};
        RGBA green = {0, 1, 0, 0.9};
        RGBA blue = {0, 0, 1, 0.9};
        RGBA white = {1, 1, 1, 0.9};
        RGBA black = {0, 0, 0, 0.9};
        
        draw.line(image, 0, 0, 7, 15, red);
        draw.line(image, 15, 0, 7, 15, green);
        draw.line(image, 0, 15, 8, 0, blue);
        draw.line(image, 15, 15, 8, 0, black);
        
        draw.ellipse(image, 16, 0, 63, 15, red);
        draw.ellipse(image, 32, 0, 63, 15, green);
        draw.ellipse(image, 48, 0, 63, 15, blue);
        
        
        try {
            IImageWriter writer = new FreeImageWriter();
            writer.save(image, "imaging/testimages/drawing_32bpp.png");
        }
        catch (Error e) {
            assert_not_reached();
        }
    }
    
    public static void add_tests() {
        Test.add_func ("/imaging/SDLDrawing.draw_line() indexed", test_draw_line_indexed);
        Test.add_func ("/imaging/SDLDrawing.draw_line() indexed", test_draw_rgba);
    }
}
