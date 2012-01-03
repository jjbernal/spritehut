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

using Document;

public class TestLayer : Object {
    public static void test_name_default () {
        var layer = new Document.Layer();
        assert (layer.name == "Layer1");
    }
    
    public static void test_name_set () {
        var layer = new Document.Layer();
        layer.name = "MyLayer";
        assert (layer.name == "MyLayer");
    }
    
    public static void test_visible_default () {
        var layer = new Document.Layer();
        assert (layer.visible == true);
    }
    
    public static void test_visible_set () {
        var layer = new Document.Layer();
        layer.visible = false;
        assert (layer.visible == false);
    }
    
    public static void test_locked_default () {
        var layer = new Document.Layer();
        assert (layer.locked == false);
    }
    
    public static void test_locked_set () {
        var layer = new Document.Layer();
        layer.locked = true;
        assert (layer.locked == true);
    }

    public static void test_opacity_default () {
        var layer = new Document.Layer();
        assert (layer.opacity == 1.0);
    }
    
    public static void test_opacity_set () {
        var layer = new Document.Layer();
        layer.opacity = 0.5;
        assert (layer.opacity == 0.5);
    }
    
    public static void test_opacity_equal_or_less_than_one () {
        var layer = new Document.Layer();
        layer.opacity = 1.1;
        assert (layer.opacity == 1.0);
    }
    
    public static void test_opacity_equal_or_greater_than_zero () {
        var layer = new Document.Layer();
        layer.opacity = -0.1;
        assert (layer.opacity == 0.0);
    }
    
    public static void add_tests() 
    {
        Test.add_func ("/document/layer.name default", test_name_default);
        Test.add_func ("/document/layer.name set", test_name_set);
        Test.add_func ("/document/layer.visible default", test_visible_default);
        Test.add_func ("/document/layer.visible set", test_visible_set);
        Test.add_func ("/document/layer.locked default", test_locked_default);
        Test.add_func ("/document/layer.locked set", test_locked_set);
        Test.add_func ("/document/layer.opacity default", test_opacity_default);
        Test.add_func ("/document/layer.opacity set", test_opacity_set);
        Test.add_func ("/document/layer.opacity <= 1", test_opacity_equal_or_less_than_one);
        Test.add_func ("/document/layer.opacity >= 0", test_opacity_equal_or_greater_than_zero);
    }
}
