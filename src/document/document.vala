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
    public class Document : GLib.Object, IDocumentElement
    {
        private TreeStore _treemodel;
        private UndoHistory _undo_history;
        
        public uint32 last_id {get;set;default=0;}
        public string? filename {get;set;default=null;}
        public bool modified {get;set;default=false;}
        public string name {get;set;}
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
        public Imaging.Palette active_palette {get;set;}
        
        public UndoHistory undo_history {
            get {return _undo_history;}
        }
        
        public Document ()
        {
            _treemodel = new TreeStore (1, typeof (IDocumentElement));
            this.treemodel.row_changed.connect(on_modified);
            this.treemodel.row_deleted.connect(on_modified);
            this.treemodel.row_inserted.connect(on_modified);
            this.treemodel.rows_reordered.connect(on_modified);
            _undo_history = new UndoHistory ();
        }
        
        public TreeIter add (IDocumentElement elem, TreeIter? parent)
        {
            TreeIter iter;
            treemodel.append(out iter, parent);
            treemodel.set(iter, 0, elem, -1);
            elem.notify.connect(on_modified);
            
            return iter;
        }
        
        public void on_modified()
        {
            this.modified = true;
        }
    }
}

