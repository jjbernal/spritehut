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

namespace Widgets
{
    public class DocumentTree : Gtk.Box {
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
            
            string ui_info =
                "<ui>
                  <toolbar name='document-tree-toolbar'>
                    <toolitem action='add-action'/>
                    <toolitem action='remove-action'/>
                    <toolitem action='raise-action'/>
                    <toolitem action='lower-action'/>
                  </toolbar>
                </ui>";
            
            
//            window.ui_manager.add_ui_from_string(ui_info, ui_info.length);
//            toolbar = window.ui_manager.get_widget("/document-tree-toolbar") as Toolbar;
            this.pack_start(treeview, true, true, 0);
            this.pack_end(toolbar, false, true, 0);
        }
        
        private void update_treemodel(Object sender, ParamSpec pspec)
        {
            treeview.set_model (window.document.treemodel);
        }
        
        private void on_destroy(Object sender)
        {
            treeview.set_model (null);
        }
    }
}
