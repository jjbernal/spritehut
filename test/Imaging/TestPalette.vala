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

public class TestPalette : Object {
    public static void test_name_default () {
        var palette = new Palette();
        assert (palette.name == "Palette1");
    }
    
    public static void test_name_set () {
        var palette = new Palette();
        palette.name = "MyPalette";
        assert (palette.name == "MyPalette");
    }
    
    public static void test_is_gee_list () {
        var palette = new Palette();
        assert (palette.color_list is Gee.List);
    }

    public static void add_tests()  {
        Test.add_func ("/Imaging/palette.name default", test_name_default);
        Test.add_func ("/Imaging/palette.name set", test_name_set);
        Test.add_func ("/Imaging/palette.color_list is Gee.List", test_is_gee_list);
    }
}
