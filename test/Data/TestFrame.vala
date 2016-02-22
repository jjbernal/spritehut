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

using SpriteHut.Data;

public class TestFrame : Object {
    public static void test_delay_default () {
        var frame = new Frame();
        assert (frame.delay == 0);
    }
    
    public static void test_delay_set () {
        var frame = new Frame();
        frame.delay = 1000;
        assert (frame.delay == 1000);
    }
    
    public static void test_delay_not_negative () {
        var frame = new Frame();
        frame.delay = -1;
        assert (frame.delay == 0);
    }
    
    public static void test_delta_x_default () {
        var frame = new Frame();
        assert (frame.delta_x == 0);
    }
    
    public static void test_delta_x_set () {
        var frame = new Frame();
        frame.delta_x = -1;
        assert (frame.delta_x == -1);
    }
    
    public static void test_delta_y_default () {
        var frame = new Frame();
        assert (frame.delta_y == 0);
    }
    
    public static void test_delta_y_set () {
        var frame = new Frame();
        frame.delta_y = -1;
        assert (frame.delta_y == -1);
    }

    public static void add_tests()  {
        Test.add_func ("/Data/Frame.delay default", test_delay_default);
        Test.add_func ("/Data/Frame.delay set", test_delay_set);
        Test.add_func ("/Data/Frame.delay >= 0", test_delay_not_negative);
        Test.add_func ("/Data/Frame.delta_x default", test_delta_x_default);
        Test.add_func ("/Data/Frame.delta_x set", test_delta_x_set);
        Test.add_func ("/Data/Frame.delta_y default", test_delta_y_default);
        Test.add_func ("/Data/Frame.delta_y set", test_delta_y_set);
    }
}
