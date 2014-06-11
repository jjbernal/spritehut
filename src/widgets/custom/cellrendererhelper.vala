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
using Gdk;
using Document;

namespace Widgets
{
    public class CellRendererHelper: Object {
        public CellRendererPixbuf pixbuf_renderer;
        public CellRendererText text_renderer;
        private static Pixbuf layer_icon;
        private static Pixbuf frame_icon;
        private static Pixbuf animation_icon;
        private static Pixbuf sprite_icon;
        
        construct {
            pixbuf_renderer = new CellRendererPixbuf();
            text_renderer = new CellRendererText();
            var icon_size = 24;
            
            layer_icon = try_load_icon_from_theme("select-rectangular", icon_size);
            frame_icon = try_load_icon_from_theme("draw-eraser", icon_size);
            animation_icon = try_load_icon_from_theme("video-x-generic", icon_size);
            sprite_icon = try_load_icon_from_theme("spritehut", icon_size);
            
        }
        
        private Pixbuf try_load_icon_from_theme(string icon_name, int icon_size) {
            Pixbuf icon = null;
            
            try {
                icon = Gtk.IconTheme.get_default().load_icon(icon_name, icon_size, 0);
            }
            catch (Error e) {
                print (_("Error loading icon: %s\n"), e.message);
            }
            
            return icon;
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
            var cell_pixbuf = (CellRendererPixbuf) cell;
            if (el is Document.Layer) {
                cell_pixbuf.pixbuf = layer_icon;
            }
            else if (el is Document.Frame) {
                cell_pixbuf.pixbuf = frame_icon;
            }
            else if (el is Document.Animation) {
                cell_pixbuf.pixbuf = animation_icon;
            }
            else if (el is Document.Sprite) {
                cell_pixbuf.pixbuf = sprite_icon;
            }
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

