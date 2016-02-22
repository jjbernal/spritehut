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

using SpriteHut.Imaging;

public class TestCairoImage : Object {
    public static void test_get_pixel_color () {
        Image image = new CairoImage(16, 16, 8);
        image.palette = new Palette();
        
        Gdk.RGBA red = image.get_pixel_color(0,0);
        Gdk.RGBA green = image.get_pixel_color(0,15);
        Gdk.RGBA blue = image.get_pixel_color(15,0);
        Gdk.RGBA white = image.get_pixel_color(15,15);
        assert (red.to_string() == "#ff0000ff");
    }
    
    public static void test_to_rgba () {
        Image image = new CairoImage(16, 16, 8);
        Image rgba_copy = image.to_rgba();
        assert (image.mode == Image.Mode.RGBA);
    }

    public static void add_tests()  {
        Test.add_func ("/imaging/image.get_pixel_color(x , y)", test_get_pixel_color);
        //Test.add_func ("/imaging/image.to_rgba", test_to_rgba);
    }
}
