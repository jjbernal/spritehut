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
    public static void test_default_document () {
        var writer = new ImageSequenceWriter();
        Document doc = new BlankDocument();
        
        writer.save(doc, "fileio/testfiles/xmltest.xml");
        
        assert(FileUtils.test("fileio/testfiles/xmltest.xml", FileTest.EXISTS));
    }
    
    public static void test_complex_document () {
        var writer = new ImageSequenceWriter();
        Document doc = new Document();
        Gtk.TreeIter iter;

        Gtk.TreeIter sprite = doc.add((IDocumentElement) new Sprite(){name="a sprite"}, null);
            Gtk.TreeIter anim1 = doc.add((IDocumentElement) new Animation(){name="An animation of a sprite"}, sprite);
                Gtk.TreeIter frame10 = doc.add((IDocumentElement) new Frame(){name="0"}, anim1);
                Gtk.TreeIter frame11 = doc.add((IDocumentElement) new Frame(){name="1"}, anim1);
                    Gtk.TreeIter layer1 = doc.add((IDocumentElement) new Layer(64, 64, Image.Mode.INDEXED){name="Armor"}, frame11);
                    Gtk.TreeIter layer2 = doc.add((IDocumentElement) new Layer(64, 64, Image.Mode.INDEXED){name="Body"}, frame11);
            Gtk.TreeIter anim2 = doc.add((IDocumentElement) new Animation(){name="Another animation of a sprite"}, sprite);
                Gtk.TreeIter frame20 = doc.add((IDocumentElement) new Frame(){name="0"}, anim2);
                Gtk.TreeIter frame21 = doc.add((IDocumentElement) new Frame(){name="1"}, anim2);
                    Gtk.TreeIter layer = doc.add((IDocumentElement) new Layer(64, 64, Image.Mode.INDEXED){name="Hair"}, frame21);
                    layer = doc.add((IDocumentElement) new Layer(64, 64, Image.Mode.INDEXED){name="Head"}, frame21);
        Gtk.TreeIter sprite2;
        sprite2 = doc.add((IDocumentElement) new Sprite(){name="Another sprite"}, null);
            Gtk.TreeIter s2anim = doc.add((IDocumentElement) new Animation(){name="An animation of another sprite"}, sprite2);
                Gtk.TreeIter frame0 = doc.add((IDocumentElement) new Frame(){name="0"}, s2anim);
                    Gtk.TreeIter layer0 = doc.add((IDocumentElement) new Layer(64, 64, Image.Mode.INDEXED){name="A layer"}, frame0);
        
        writer.save(doc, "fileio/testfiles/xmltest_complex.xml");
        
        assert(FileUtils.test("fileio/testfiles/xmltest_complex.xml", FileTest.EXISTS));
    }
    
    public static void add_tests() {
        Test.add_func ("/fileio/ImageSequenceWriter save default document XML", test_default_document);
        Test.add_func ("/fileio/ImageSequenceWriter save complex document XML", test_complex_document);
    }
}
