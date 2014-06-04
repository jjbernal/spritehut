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
using Imaging;

namespace Document
{
    public class Document : GLib.Object
    {
//        IDocumentElement properties
//        TODO It doesn't make a lot of sense for Document to implement this interface
        public string name {get;set;}
        
        private TreeStore _treemodel;
        private UndoHistory _undo_history;
        public enum ColumnType {
            IDOCUMENTELEMENT,
            N_COLUMNS
        }
        public uint32 last_id {get;set;default=0;}
        public string? filename {get;set;default=null;}
        public bool modified {get;set;default=false;}
        
        public Gtk.TreeStore treemodel
        {
            get
            {
                return _treemodel;
            }
        }
        
        public struct metadata
        {
            public string author;
            public string license;
            public string title;
        }
        public uint width {get;set;}
        public uint height {get;set;}
        public Sprite active_sprite {get;set;}
        public Animation active_animation {get;set;}
        public Frame active_frame {get;set;}
        public Layer active_layer {get;set;}
        public IDocumentElement active_element {get;set;} // for cases when the active element doesn't matter e.g. creating new elements in treemodel
        public TreeIter active_animation_iter {get;set;}
        public TreeIter active_element_iter {get;set;}
        
        public Imaging.Palette active_palette {get;set;}
        
        public UndoHistory undo_history {
            get {return _undo_history;}
        }
        
        public Document ()
        {
            _treemodel = new TreeStore (ColumnType.N_COLUMNS, typeof (IDocumentElement));
            this.treemodel.row_changed.connect(on_row_changed);
            this.treemodel.row_deleted.connect(on_row_deleted);
            this.treemodel.row_inserted.connect(on_row_inserted);
            this.treemodel.rows_reordered.connect(on_rows_reordered);
            _undo_history = new UndoHistory ();
        }
        
        public TreeIter add (IDocumentElement elem, TreeIter? parent)
        {
//        TODO autolog Change in undo history
            TreeIter iter;
            treemodel.append(out iter, parent);
            treemodel.set(iter, 0, elem, -1);
//            elem.iter = iter;
            elem.notify.connect(on_modified);
            
            return iter;
        }
        
        public TreeIter add_sibling(IDocumentElement elem, TreeIter sibling) {
            TreeIter? parent;
//             = null;
            if (!treemodel.iter_parent(out parent, sibling)) {
                parent = null;
            }
            
            
            TreeIter iter = add(elem, parent);
            
            return iter;
        }
        
        public void on_modified()
        {
            this.modified = true;
        }
        
        public void on_row_changed(TreePath path, TreeIter iter)
        {
            this.modified = true;
            IDocumentElement element;
            treemodel.get(iter, ColumnType.IDOCUMENTELEMENT, out element);
            active_element_iter = iter;
//            element.iter = iter;
//            print ("changed %s with iter.stamp %d in %s with iter.stamp %d \n", element.name, element.iter.stamp, path.to_string(), iter.stamp);
            print ("Changed %s in %s\n", element.name, path.to_string());
        }
        
        public void on_row_deleted(TreePath path)
        {
            this.modified = true;
            IDocumentElement element;
//            treemodel.get(iter, ColumnType.IDOCUMENTELEMENT, out element);

            print ("deleted in %s\n", path.to_string());
            
        }
        
        public void on_row_inserted(TreePath path, TreeIter iter)
        {
            this.modified = true;
            IDocumentElement element;
            treemodel.get(iter, ColumnType.IDOCUMENTELEMENT, out element);
//            active_element_iter = iter;
//            element.iter = iter;
//            print ("Inserted %s in \n", element.name);
            print ("inserted an element in %s with iter.stamp %d \n", path.to_string(), iter.stamp);
            
        }
        
        public void on_rows_reordered(TreePath path, TreeIter? iter, void* new_order)
        {
            this.modified = true;
            IDocumentElement element;
            treemodel.get(iter, ColumnType.IDOCUMENTELEMENT, out element);
//            element.iter = iter;
            print ("reordered %s in \n", element.name);
            
        }
    }
}

