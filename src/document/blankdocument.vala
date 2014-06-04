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

namespace Document
{
    public class BlankDocument : Document
    {   
        public BlankDocument ()
        {
            base();
            
            width = 64;
            height = 64;
            
            TreeIter iter;
            
            var sprite = new Sprite();
            var animation = new Animation ();
            var frame = new Frame();
            var layer = new Layer();
            
            iter = add(sprite, null);
            iter = add(animation, iter);
            iter = add(frame, iter);
            iter = add(layer, iter);
            
            modified = false;
        }
    }
}

