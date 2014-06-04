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

namespace Document
{
    public class Frame : GLib.Object, IDocumentElement
    {
//        IDocumentElement properties
        public string name {get;set;default=_("Frame1");}
        public Gdk.Pixbuf thumbnail {get;set;}
        public bool visible {get;set;default=true;}
        public bool locked {get;set;default=false;}
//        public Gtk.TreeIter iter {get;set;}
        
        private uint _delay;
        
        public uint delay {
            get
            {
                return _delay;
            }
            set
            {
                if ((int) value >= 0)
                {
                    _delay = value;
                }
                else
                {
                    _delay = 0;
                }
            }
        }
        
        public int delta_x {get;set;default=0;}
        public int delta_y {get;set;default=0;}
        
        public Frame() {
//            FIXME Loading the icon just to show some pixbuf on the iconview
            this.thumbnail = Gtk.IconTheme.get_default().load_icon("draw-eraser", 32, 0);
        }
        
    }
}

