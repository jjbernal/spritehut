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
using Xml;
using Gtk;
using Gee;

namespace FileIO
{
    /**
    * XML Document Writer
    */
    public class XmlDocumentWriter : Object
    {
        /**
         * Saves a document to a XML file. Creates a file if needed.
         * 
         * @param image The Image to save to disk
         * @param filename The file name, including complete path
         */
         struct Node {
                public TreeIter tree_iter;
                public bool visited;
            }
        public void save (Document.Document document, string filename) throws IOError{
            Xml.TextWriter writer = new Xml.TextWriter.filename (filename);
            writer.set_indent (true);
            writer.set_indent_string ("\t");

            writer.start_document ();
            
            writer.write_comment(" Created with Sprite Hut ");
            writer.start_element ("spritehut");
            writer.write_attribute ("version", "0.1");
//            write_element(writer, document);
            
            TreeIter? iter;
            
            IDocumentElement elem = null;
            
            LinkedList<Node?> stack = new LinkedList<Node?>();
            
//            document.treemodel.get_iter_first(out iter);
            // push top nodes in reverse order
            int n = document.treemodel.iter_n_children(null);
            while (n > 0) {
                document.treemodel.iter_nth_child (out iter, null, n-1);
                stack.offer_head(Node(){tree_iter=iter, visited=false});
                n--;
            }
            
            while (stack.size > 0)
            {
                Node node = stack.poll_head();
                document.treemodel.get(node.tree_iter, 0, out elem);
                
                if (node.visited)
                {
                    writer.end_element(); // current xml element
                }
                else 
                {
                    node.visited = true;
                    stack.offer_head(node);
                    write_element(writer, elem);
                    if (document.treemodel.iter_has_child(node.tree_iter)) {
                        TreeIter child;
                        int n_children = document.treemodel.iter_n_children(node.tree_iter);

                        while (n_children > 0){ //push children in reverse order
                            document.treemodel.iter_nth_child (out child, node.tree_iter, n_children-1);
                            stack.offer_head(Node(){tree_iter=child, visited=false});
                            n_children--;
                        }
                    }
                }
            }
            
            writer.end_element(); // spritehut xml element

            writer.end_document();
            writer.flush(); // end document
        }
        
        private void write_element(TextWriter writer, IDocumentElement elem)
        {
            string elem_name = elem.get_class().get_type().name().down();
            writer.start_element(elem_name[8:elem_name.length]); // strip namespace before class name
            ParamSpec[] properties=elem.get_class().list_properties();
            
            foreach (ParamSpec prop in properties) {
                string name = prop.name;
                Type type = prop.value_type;
                Value val = Value(type);
                elem.get_property(name, ref val);
                
                if (!prop.value_defaults(val)) // write only if property's value isn't default
                {
                    Value val2str = Value(typeof(string));
                    val.transform(ref val2str);
                    
                    writer.write_attribute (name, val2str.get_string());
                }
            }
        }
    }
}
