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

//using Gtk;
using SpriteHut.Data;
using SpriteHut.FileIO;
using SpriteHut.Imaging;

public class TestImageSequenceWriter : Object {
    public static void test_single_image () {
        var writer = new ImageSequenceWriter();
        Document doc = new BlankDocument();
        //TODO write test
        assert(true);
    }
    
    public static void test_image_sequence () {
        var writer = new ImageSequenceWriter();
        Document doc = new Document();
        //TODO write test
        assert(true);
    }
    
    public static void add_tests() {
        Test.add_func ("/FileIO/ImageSequenceWriter save single image", test_single_image);
        Test.add_func ("/FileIO/ImageSequenceWriter save image sequence", test_image_sequence);
    }
}
