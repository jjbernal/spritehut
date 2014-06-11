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
using Gdk;

namespace Document
{
    public abstract class IDocumentElement : GLib.Object
    {
        public string name {get;set;}
        public Pixbuf thumbnail {get;set;}
        public bool visible {get;set;default=true;}
        public bool locked {get;set;default=false;}
        
        protected string stamp_name (string name, ref uint stamp) {
            string stamp_name = name + stamp.to_string();
            ++stamp;
            
            return stamp_name;
        }
    }
}
