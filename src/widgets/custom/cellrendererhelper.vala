/*
** Copyright © 2014 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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
    public class CellRendererHelper: Object {
        public CellRendererPixbuf pixbuf_renderer;
        public CellRendererText text_renderer;
        
        construct {
            pixbuf_renderer = new CellRendererPixbuf();
            text_renderer = new CellRendererText();
            
        }
        
        private static CellRendererHelper instance_;
        
        public static CellRendererHelper get_instance() {
            if (instance_ == null) {
                instance_ = new CellRendererHelper();
            }
            
            return instance_;
            
        }
        
        public void name_cell_data_func (CellRenderer cell, TreeModel tree_model, TreeIter iter) {
            IDocumentElement el;
            tree_model.get(iter, 0, out el);
            ((CellRendererText) cell).text = el.name;
        }

        public void thumbnail_cell_data_func (CellRenderer cell, TreeModel tree_model, TreeIter iter) {
            IDocumentElement el;
            tree_model.get(iter, 0, out el);
            ((CellRendererPixbuf) cell).pixbuf = el.thumbnail;
        }
        
        public void visible_cell_data_func (CellRenderer cell, TreeModel tree_model, TreeIter iter) {
            IDocumentElement el;
            tree_model.get(iter, 0, out el);
            ((CellRendererToggle) cell).active = el.visible;
        }
        
        public void locked_cell_data_func (CellRenderer cell, TreeModel tree_model, TreeIter iter) {
            IDocumentElement el;
            tree_model.get(iter, 0, out el);
            ((CellRendererToggle) cell).active = el.locked;
        }
    }
}

