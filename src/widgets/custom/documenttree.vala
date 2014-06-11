/*
** Copyright © 2011-2014 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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
        
        public DocumentTree (MainWindow main_window, Builder builder) {
            window = main_window;
            
            treeview = new TreeView();
            treeview.headers_visible = false;
            treeview.reorderable = true;
            treeview.can_focus = true; 
            
            var add_menu = builder.get_object("document-add-menu") as Gtk.Menu;
            var add_toolbutton = builder.get_object("document-add-toolbutton") as MenuToolButton;
            add_toolbutton.set_menu (add_menu);
            
//            get the instance from the CellRenderer helper
            var cellrh = CellRendererHelper.get_instance();
            
            var name_renderer = new CellRendererText();
            name_renderer.edited.connect(on_edited);
            name_renderer.editable = true;
            
            var col = new TreeViewColumn ();
            col.set_cell_data_func(name_renderer, (CellLayoutDataFunc)cellrh.name_cell_data_func);
            col.pack_end (name_renderer, false);
            
            var thumbnail_renderer = new CellRendererPixbuf();
//            col.add_attribute (thumbnail_renderer, "thumbnail", 0);
//            var thumbnail_col = new TreeViewColumn ();
//            thumbnail_col.pack_end (thumbnail_renderer, false);
            
            col.set_cell_data_func(thumbnail_renderer, (CellLayoutDataFunc)cellrh.thumbnail_cell_data_func);
            col.pack_end (thumbnail_renderer, false);
            
            var visible_renderer = new CellRendererToggle();
            visible_renderer.toggled.connect(on_visible_toggled);
//            col.add_attribute (visible_renderer, "active", 0);
            
            col.set_cell_data_func(visible_renderer, (CellLayoutDataFunc)cellrh.visible_cell_data_func);
            col.pack_start (visible_renderer, false);
            
            var locked_renderer = new CellRendererToggle();
            locked_renderer.toggled.connect(on_locked_toggled);
//            col.add_attribute (locked_renderer, "active", 0);
            
            col.set_cell_data_func(locked_renderer, (CellLayoutDataFunc)cellrh.locked_cell_data_func);
            col.pack_start (locked_renderer, false);
            
//            treeview.append_column (thumbnail_col);
            treeview.append_column (col);
            treeview.set_rules_hint( true );
            
            var selection = treeview.get_selection ();
            selection.changed.connect (this.on_changed);
            selection.set_mode(SelectionMode.MULTIPLE);
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
        
        private void on_visible_toggled (string path) {
            TreeIter iter;
            IDocumentElement element;
            
            treeview.model.get_iter_from_string(out iter, path);
            treeview.model.get(iter, 0, out element);
            
            element.visible = !element.visible;
        }
        
        private void on_locked_toggled (string path) {
            TreeIter iter;
            IDocumentElement element;
            
            treeview.model.get_iter_from_string(out iter, path);
            treeview.model.get(iter, 0, out element);
            
            element.locked = !element.locked;
        }
        
        private void on_edited (string path, string new_text) {
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
        
        private void on_changed (Gtk.TreeSelection selection) {
            Gtk.TreeModel model;
            
            GLib.List row_list = selection.get_selected_rows(out model);
            
            if (row_list.length() > 0) {
                IDocumentElement el = null;
                
                row_list.foreach ((path) => {
                    Gtk.TreeIter iter = TreeIter();
                    
                    model.get_iter(out iter, (TreePath) path);
                    model.get(iter, 0, out el);
                    
//                    update iter
//                    el.iter = iter;
//                    print("Selected row: %s\n", el.name);
//                    print("Selected row: %s visible: %s\n", el.name, el.visible.to_string());
                    if (el is Document.Layer) {
                        window.document.active_layer = (Document.Layer) el;
                        
                    }
                    else if (el is Document.Frame) {
                        window.document.active_frame = (Document.Frame) el;
                    }
                    else if (el is Document.Animation) {
                        window.document.active_animation = (Document.Animation) el;
                        window.document.active_animation_iter = iter;
                    }
                    else if (el is Document.Sprite) {
                        window.document.active_sprite = (Document.Sprite) el;
                    }
                    
                    window.document.active_element = el;
                    window.document.active_element_iter = iter;
//                print("Active sprite: %s\n", ((window.document.active_sprite != null) ? window.document.active_sprite.name : "None"));
//                print("Active animation: %s\n", ((window.document.active_animation != null) ? window.document.active_animation.name : "None"));
//                print("Active frame: %s\n", ((window.document.active_frame != null) ? window.document.active_frame.name : "None"));
//                print("Active layer: %s\n", ((window.document.active_layer != null) ? window.document.active_layer.name : "None"));
                });
            }
        }
    }
}
