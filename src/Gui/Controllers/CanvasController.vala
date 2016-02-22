/*
** Copyright © 2014, 2016 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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
using Cairo;
using SpriteHut.Data;

namespace SpriteHut.Gui
{
    public class CanvasController : Object {
        public MainWindow window {get;set;}
        public Canvas canvas;
        
        public CanvasController (MainWindow main_window, Builder builder) {
            window = main_window;
            
            canvas = new Canvas();
            canvas.mouse_over_canvas.connect(on_mouse_over_canvas);
        }
        
        public void update(ParamSpec pspec) {
//            warning ("Trying to update the iconview");
            attach_model(window.document);
        }
        public void attach_model(Document document) {
            if (document.active_layer != null && document.active_layer.image.cairo_surface != null) {
                canvas.canvas_surface = document.active_layer.image.cairo_surface;
            }
        }
        
        public void detach_model() {
            canvas.canvas_surface = null;
        }
        
        public void on_mouse_over_canvas(int x, int y) {
            window.main_statusbar.push(0, "(" + x.to_string() + ", " + y.to_string() + ")");
        }
    }
}
