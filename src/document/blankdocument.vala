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
            
//            FIXME Loading the icon just to show some pixbuf on the iconview
            string image_path = GLib.Path.build_filename( GLib.Path.DIR_SEPARATOR_S, "usr", "local", "share", "icons", "hicolor", "32x32",
                                             "apps", "spritehut.png", null );
            
            var sprite = new Sprite();
            sprite.thumbnail = new Gdk.Pixbuf.from_file(image_path);
            var animation = new Animation ();
            animation.thumbnail = new Gdk.Pixbuf.from_file(image_path);
            var frame = new Frame();
            frame.thumbnail = new Gdk.Pixbuf.from_file(image_path);
            var layer = new Layer();
            layer.thumbnail = new Gdk.Pixbuf.from_file(image_path);
            
            iter = add(sprite, null);
            iter = add(animation, iter);
            iter = add(frame, iter);
            iter = add(layer, iter);
            
            modified = false;
        }
    }
}

