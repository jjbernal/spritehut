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

using Gtk;
using Document;

namespace Widgets
{
    public class DocumentTree : Box {
        public TreeView treeview {get;set;}
        public Toolbar toolbar {get;set;}
        public MainWindow window {get;set;}
    
        public DocumentTree (MainWindow main_window) {
            window = main_window;
            // subscribe to main document changes
            window.notify["document"].connect(update_treemodel);
            this.destroy.connect(on_destroy);
            
            treeview = new TreeView();
            treeview.headers_visible = false;
            treeview.reorderable = true;

            var renderer = new DocumentElementCellRenderer ();
            var col = new TreeViewColumn ();
            col.pack_start (renderer, true);
            col.add_attribute (renderer, "element", 0);

            treeview.append_column (col);
            
            this.pack_start(treeview, true, true, 0);
            
            var selection = treeview.get_selection ();
            selection.changed.connect (this.on_changed);
        }
        
        private void update_treemodel(Object sender, ParamSpec pspec) {
            treeview.set_model (window.document.treemodel);
        }
        
        private void on_destroy(Object sender) {
            treeview.set_model (null);
        }
        
        private void on_changed (Gtk.TreeSelection selection) {
            Gtk.TreeModel model;
            Gtk.TreeIter iter;

            if (selection.get_selected (out model, out iter)) {
                IDocumentElement el;
                model.get(iter, 0, out el);
                print("Selected row: %s\n", el.name);
                if (el.get_type().is_a(typeof(Document.Layer))) {
//                    print("%s\n is a Layer", el.name);
                    window.document.active_layer = (Document.Layer) el;
                }
                else if (el.get_type().is_a(typeof(Document.Frame))) {
                    window.document.active_frame = (Document.Frame) el;
                }
                else if (el.get_type().is_a(typeof(Document.Animation))) {
                    window.document.active_animation = (Document.Animation) el;
                }
                else if (el.get_type().is_a(typeof(Document.Sprite))) {
                    window.document.active_sprite = (Document.Sprite) el;
                }
                print("Active sprite: %s\n", ((window.document.active_sprite != null) ? window.document.active_sprite.name : "None"));
                print("Active animation: %s\n", ((window.document.active_animation != null) ? window.document.active_animation.name : "None"));
                print("Active frame: %s\n", ((window.document.active_frame != null) ? window.document.active_frame.name : "None"));
                print("Active layer: %s\n", ((window.document.active_layer != null) ? window.document.active_layer.name : "None"));
            }
        }
    }
}
