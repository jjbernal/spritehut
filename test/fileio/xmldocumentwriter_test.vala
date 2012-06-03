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
using FileIO;
using Gtk;

public class TestXmlDocumentWriter : Object {
    public static void test_default_document () {
        var writer = new XmlDocumentWriter();
        Document.Document doc = new BlankDocument();
        
        writer.save(doc, "fileio/testfiles/xmltest.xml");
        
        assert(FileUtils.test("fileio/testfiles/xmltest.xml", FileTest.EXISTS));
    }
    
    public static void test_complex_document () {
        var writer = new XmlDocumentWriter();
        Document.Document doc = new Document.Document();
        TreeIter iter;

        TreeIter sprite = doc.add((IDocumentElement) new Sprite(){name="a sprite"}, null);
            TreeIter anim1 = doc.add((IDocumentElement) new Animation(){name="An animation of a sprite"}, sprite);
                TreeIter frame10 = doc.add((IDocumentElement) new Document.Frame(){name="0"}, anim1);
                TreeIter frame11 = doc.add((IDocumentElement) new Document.Frame(){name="1"}, anim1);
                    TreeIter layer1 = doc.add((IDocumentElement) new Layer(){name="Armor"}, frame11);
                    TreeIter layer2 = doc.add((IDocumentElement) new Layer(){name="Body"}, frame11);
            TreeIter anim2 = doc.add((IDocumentElement) new Animation(){name="Another animation of a sprite"}, sprite);
                TreeIter frame20 = doc.add((IDocumentElement) new Document.Frame(){name="0"}, anim2);
                TreeIter frame21 = doc.add((IDocumentElement) new Document.Frame(){name="1"}, anim2);
                    TreeIter layer = doc.add((IDocumentElement) new Layer(){name="Hair"}, frame21);
                    layer = doc.add((IDocumentElement) new Layer(){name="Head"}, frame21);
        TreeIter sprite2;
        sprite2 = doc.add((IDocumentElement) new Sprite(){name="Another sprite"}, null);
            TreeIter s2anim = doc.add((IDocumentElement) new Animation(){name="An animation of another sprite"}, sprite2);
                TreeIter frame0 = doc.add((IDocumentElement) new Document.Frame(){name="0"}, s2anim);
                    TreeIter layer0 = doc.add((IDocumentElement) new Layer(){name="A layer"}, frame0);
        
        writer.save(doc, "fileio/testfiles/xmltest_complex.xml");
        
        assert(FileUtils.test("fileio/testfiles/xmltest_complex.xml", FileTest.EXISTS));
    }
    
    public static void add_tests() {
        Test.add_func ("/fileio/XmlDocumentWriter save default document XML", test_default_document);
        Test.add_func ("/fileio/XmlDocumentWriter save complex document XML", test_complex_document);
    }
}
