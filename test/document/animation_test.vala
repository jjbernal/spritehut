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

public class TestAnimation : Object {
    public static void test_name_default () {
        var anim = new Document.Animation();
        assert (anim.name == "Animation1");
    }
    
    public static void test_name_set () {
        var anim = new Document.Animation();
        anim.name = "Animation1";
        assert (anim.name == "Animation1");
    }
    
    public static void test_fps_default () {
        var anim = new Document.Animation();
        assert (anim.fps == Animation.default_fps);
    }
    
    public static void test_fps_set () {
        var anim = new Document.Animation();
        anim.fps = -1;
        assert (anim.fps == 0);
    }
    
    public static void test_mirror_default () {
        var anim = new Document.Animation();
        assert (anim.mirror == Animation.Mirror.NONE);
    }
    
    public static void test_mirror_set () {
        var anim = new Document.Animation();
        anim.mirror = Animation.Mirror.VERTICAL;
        assert (anim.mirror == Animation.Mirror.VERTICAL);
    }
    
    public static void test_loop_default () {
        var anim = new Document.Animation();
        assert (anim.loop == Animation.Loop.NONE);
    }
    
    public static void test_loop_set () {
        var anim = new Document.Animation();
        anim.loop = Animation.Loop.REPEAT;
        assert (anim.loop == Animation.Loop.REPEAT);
    }

    public static void add_tests()  {
        Test.add_func ("/document/animation.name default", test_name_default);
        Test.add_func ("/document/animation.name set", test_name_set);
        Test.add_func ("/document/animation.fps default", test_fps_default);
        Test.add_func ("/document/animation.fps set", test_fps_set);
        Test.add_func ("/document/animation.mirror default", test_mirror_default);
        Test.add_func ("/document/animation.mirror set", test_mirror_set);
        Test.add_func ("/document/animation.loop default", test_loop_default);
        Test.add_func ("/document/animation.loop set", test_loop_set);
    }
}
