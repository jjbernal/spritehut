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

public class TestDocument : Object {
    public static void test_filename_default () {
        var document = new Document.Document();
        assert (document.filename == null);
    }
    
    public static void test_filename_set () {
        var document = new Document.Document();
        document.filename = "sprite.spritehut";
        assert (document.filename == "sprite.spritehut");
    }
    
    public static void test_treemodel_default () {
        var document = new Document.Document();
        assert (document.treemodel is Gtk.TreeModel);
    }
    
    public static void test_add () {
        var document = new Document.Document();
        var sprite = new Sprite();
        sprite.name = "Sprite1";
        var animation = new Animation();
        animation.name = "Animation1";
        var frame = new Frame();
        var layer = new Layer(64, 64, Imaging.Image.Mode.INDEXED);
        layer.name = "レイヤー１";
        
        Gtk.TreeIter iter;
        iter = document.add (sprite, null);
        iter = document.add (animation, iter);
        iter = document.add (frame, iter);
        iter = document.add (layer, iter);
    }
    
    public static void test_image_mode () {
        var document = new Document.Document();
        document.mode = Imaging.Image.Mode.INDEXED;
        assert (document.mode == Imaging.Image.Mode.INDEXED);
        
        document.mode = Imaging.Image.Mode.RGB;
        assert (document.mode == Imaging.Image.Mode.RGB);
        
        document.mode = Imaging.Image.Mode.RGBA;
        assert (document.mode == Imaging.Image.Mode.RGBA);
    }

    public static void add_tests()  {
        Test.add_func ("/document/document.filename default", test_filename_default);
        Test.add_func ("/document/document.filename set", test_filename_set);
        Test.add_func ("/document/document.treemodel is Gtk.TreeModel", test_treemodel_default);
        Test.add_func ("/document/document.add", test_add);
        Test.add_func ("/document/document.mode", test_image_mode);
    }
}
