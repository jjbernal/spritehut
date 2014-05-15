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
using Cairo;

namespace Widgets
{
    public class Canvas : DrawingArea {
        private Cairo.ImageSurface canvas_surface;
        private int img_left;
        private int img_top;

        public Canvas () {
            add_events(Gdk.EventMask.BUTTON_PRESS_MASK |
//                        Gdk.EventMask.BUTTON_MOTION_MASK |
                        Gdk.EventMask.BUTTON_RELEASE_MASK |
                        Gdk.EventMask.POINTER_MOTION_MASK);
            var window = get_window ();

            if (null == window) {
            print ("No window\n");
                return;
            }
            
//            var region = window.get_clip_region ();
//            // redraw the cairo canvas completely by exposing it
//            window.invalidate_region (region, true);
//            window.process_updates (true);
            
        }
        
        public override bool configure_event(Gdk.EventConfigure event)
        {
//            Paint the surface to white
            canvas_surface = new Cairo.ImageSurface(Format.ARGB32, 200, 200);
            Cairo.Context cr = new Cairo.Context (canvas_surface);
            cr.set_source_rgb (1, 1, 1); // pure white
            cr.rectangle(0, 0, canvas_surface.get_width(), canvas_surface.get_height());
//            cr.paint();
            cr.fill();
            
            
            return false;
        }
         
        public override bool draw (Cairo.Context cr) {
            int width = get_allocated_width ();
            int height = get_allocated_height ();

            img_left = width / 2 - canvas_surface.get_width() / 2;
            img_top = height / 2 - canvas_surface.get_height() / 2;
            
            cr.set_source_rgba (0.5, 0.5, 0.5, 1);
//            cr.rectangle (BORDER_WIDTH, BORDER_WIDTH,
//                          width - 2 * BORDER_WIDTH,
//                          height - 2 * BORDER_WIDTH);
            cr.rectangle (0, 0,
                          width,
                          height);
            cr.set_line_width (5.0);
            cr.set_line_join (LineJoin.MITER);
//            cr.stroke ();
            cr.fill();
            
//            draw a black 1 px frame around the image
            cr.set_source_rgba (0, 0, 0, 1); // pure black
            cr.rectangle (img_left - 1, img_top - 1,
                          canvas_surface.get_width() + 2,
                          canvas_surface.get_height() + 2);
            cr.set_line_width (1.0);
            cr.set_line_join (LineJoin.MITER);
            cr.stroke ();
//            cr.fill();
                          
//            draw the image itself in the center
            cr.set_source_surface(canvas_surface,img_left , img_top); // set the image
            cr.paint();
            
            return true;
        }
        
        /*
         * This method gets called by Gtk+ when the actual size is known
         * and the widget is told how much space could actually be allocated.
         * It is called every time the widget size changes, for example when the
         * user resizes the window.
         */
        public override void size_allocate (Allocation allocation) {
            // The base method will save the allocation and move/resize the
            // widget's GDK window if the widget is already realized.
            base.size_allocate (allocation);
            
            int width = get_allocated_width ();
            int height = get_allocated_height ();
            
            //update image upper left coordinates
//            img_left = width / 2 - canvas_surface.get_width() / 2;
//            img_top = height / 2 - canvas_surface.get_height() / 2;

            // Move/resize other realized windows if necessary
        }
        
        /* Mouse button got pressed over widget */
        public override bool button_press_event (Gdk.EventButton event) {
            var window = get_window();
            Cairo.Context cr = Gdk.cairo_create(window);
            cr.set_source_rgba (0, 0, 0, 1); // pure black
            cr.move_to (event.x, event.y);
            cr.arc(event.x, event.y, 2.0, 0, 2.0*2.0*Math.PI);
//            cr.stroke();
            cr.fill();
            print ("%d, %d \n", (int) event.x - img_left, (int) event.y - img_top);
            
            return true;
        }

        /* Mouse button got released */
        public override bool button_release_event (Gdk.EventButton event) {
            // ...
            return false;
        }

        /* Mouse pointer moved over widget */
        public override bool motion_notify_event (Gdk.EventMotion event) {
//            print ("Motion event %d, %d \n", (int) event.x, (int) event.y);
            
            return true;
        }
    }
}
