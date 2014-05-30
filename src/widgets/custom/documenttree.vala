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
    public class DocumentTree : Object {
        public TreeView treeview {get;set;}
        public Toolbar toolbar {get;set;}
        public MainWindow window {get;set;}
        public CellRendererPixbuf pixbuf_renderer = new CellRendererPixbuf();
    
        public DocumentTree (MainWindow main_window) {
            window = main_window;
            // subscribe to main document changes
//            window.notify["document"].connect(update);
//            this.destroy.connect(on_destroy);
            
            treeview = new TreeView();
            treeview.headers_visible = false;
            treeview.reorderable = true;

//            var renderer = new DocumentElementCellRenderer ();
            var renderer = new CellRendererText();
            renderer.editable = true;
//            renderer.treemodel = treeview.model;
            renderer.edited.connect(on_edited);
//            renderer.render.connect(on_render);
            var col = new TreeViewColumn ();
            
            
            col.set_cell_data_func(renderer, (CellLayoutDataFunc)text_cell_data_func);
            col.pack_end (renderer, true);
//            pixbuf_renderer = new CellRendererPixbuf();
            col.add_attribute (pixbuf_renderer, "pixbuf", 0);
//            var pixbuf_col = new TreeViewColumn ();
//            pixbuf_col.pack_start (pixbuf_renderer, true);
            
            col.set_cell_data_func(pixbuf_renderer, (CellLayoutDataFunc)pixbuf_cell_data_func);
            col.pack_start (pixbuf_renderer, true);
//            treeview.append_column (pixbuf_col);
            treeview.append_column (col);
            treeview.set_rules_hint( true );
            
//            this.pack_start(treeview, true, true, 0);
            var selection = treeview.get_selection ();
            selection.changed.connect (this.on_changed);
            
        }
        
        private void update(ParamSpec? pspec) {
            var model = treeview.model;
            treeview.set_model (null);
            treeview.set_model (model);
        }
        
        public void attach_model(TreeModel treemodel) {
            treeview.set_model (null);
            treeview.set_model (treemodel);
//            treemodel.notify.connect(treeview.columns_autosize);
        }
        
//        private void on_destroy(Object sender) {
//            treeview.set_model (null);
//        }
        private void on_edited (string path, string new_text) {
//            base.edited(path, new_text);
            TreeIter iter;
            IDocumentElement element;
            treeview.model.get_iter_from_string(out iter, path);
            treeview.model.get(iter, 0, out element);
//            print ("former text:%s now:%s path%s \n", element.name, new_text, path);
            
            //let's make this undoable
            window.document.undo_history.log_change(element, "name", new_text);
//            element.name = new_text;
            window.document.modified = true;
        }
//        TODO move to common class for widgets that depend on TreeModel
        public void text_cell_data_func (CellRenderer cell, TreeModel tree_model, TreeIter iter) {
            IDocumentElement el;
            tree_model.get(iter, 0, out el);
            ((CellRendererText) cell).text = el.name;
        }
//        TODO move to common class for widgets that depend on TreeModel
        public void pixbuf_cell_data_func (CellRenderer cell, TreeModel tree_model, TreeIter iter) {
            IDocumentElement el;
            tree_model.get(iter, 0, out el);
            ((CellRendererPixbuf) cell).pixbuf = el.thumbnail;
        }
//        public override void render (Context ctx, Widget widget,
//                                     Gdk.Rectangle background_area,
//                                     Gdk.Rectangle cell_area,
//                                     CellRendererState flags)
//        {
//            CellRendererText.render(ctx, widget, background_area, cell_area, flags);
//            this.text = element.name;
//        }
        
        private void on_changed (Gtk.TreeSelection selection) {
            Gtk.TreeModel model;
            Gtk.TreeIter iter;

            if (selection.get_selected (out model, out iter)) {
                IDocumentElement el;
                model.get(iter, 0, out el);
//                print("Selected row: %s\n", el.name);
                if (el is Document.Layer) {
                    window.document.active_layer = (Document.Layer) el;
                }
                else if (el is Document.Frame) {
                    window.document.active_frame = (Document.Frame) el;
                }
                else if (el is Document.Animation) {
                    window.document.active_animation = (Document.Animation) el;
                }
                else if (el is Document.Sprite) {
                    window.document.active_sprite = (Document.Sprite) el;
                }
//                print("Active sprite: %s\n", ((window.document.active_sprite != null) ? window.document.active_sprite.name : "None"));
//                print("Active animation: %s\n", ((window.document.active_animation != null) ? window.document.active_animation.name : "None"));
//                print("Active frame: %s\n", ((window.document.active_frame != null) ? window.document.active_frame.name : "None"));
//                print("Active layer: %s\n", ((window.document.active_layer != null) ? window.document.active_layer.name : "None"));
            }
        }
    }
}
