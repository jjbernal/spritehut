/*
** Copyright (C) 2011-2012 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
**
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation; either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

using Document;

public class TestSprite : Object {
    public static void test_name_default () {
        var sprite = new Document.Sprite();
        assert (sprite.name == "Sprite1");
    }
    
    public static void test_name_set () {
        var sprite = new Document.Sprite();
        sprite.name = "MySprite";
        assert (sprite.name == "MySprite");
    }

    public static void main (string[] args) {
        Test.init (ref args);
        
        Test.add_func ("/document/sprite.name default", test_name_default);
        Test.add_func ("/document/sprite.name set", test_name_set);
        Test.run ();
    }
}
