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
using Cairo;
using Gee;

namespace Widgets
{
    public class Canvas : DrawingArea {
        private static const double BRUSH_RADIUS = 2;
        public Cairo.ImageSurface canvas_surface = new Cairo.ImageSurface(Format.ARGB32, 64, 64);
        private Cairo.ImageSurface pixel_grid_surface;
        private Cairo.Pattern pixel_grid_pattern;
        private int img_left;
        private int img_top;
        private bool button_down = false;
        private static Gee.List<double?> zoom_steps = new ArrayList<double?>.wrap ({0.10, 0.12, 0.14, 0.25, 0.50, 1.0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 50, 75, 100, 180, 256},((a,b) => {
        return a==b;
    }));
        private int zoom_index = 5;
        
        private double _zoom_level = 1;
        
        public double zoom_level{
            get{
                return _zoom_level;
            }
            set{
                _zoom_level = value;
                zoom_index = zoom_steps.index_of(_zoom_level);
//                print ("Zoom index: %d\n", zoom_index);
                prepare_pixel_grid();
                update_size_request();
                var window = get_window();
                window.invalidate_rect(null, false); // ask for a redraw
            }
        }
        public bool enable_pixel_grid{get;set;default=true;}
        public double minimum_margin{get;set;default=100;}
        public Gdk.Cursor cursor{
            get {
                return _cursor;
            }
            set {
                var window = get_window ();
                _cursor = value;
                window.set_cursor(_cursor);
            }
        }
        private Gdk.Cursor _cursor;
        private Gdk.Cursor default_cursor;
        private Gdk.Cursor cursor_on_canvas;
        public signal void mouse_over_canvas(int x, int y);
        
        public Canvas () {
            add_events(Gdk.EventMask.BUTTON_PRESS_MASK |
//                        Gdk.EventMask.BUTTON_MOTION_MASK |
                        Gdk.EventMask.BUTTON_RELEASE_MASK |
                        Gdk.EventMask.POINTER_MOTION_MASK);
            
        }
        
        public override void realize(){
            base.realize();
            
            //            Paint the surface to white
//            canvas_surface ;
            Cairo.Context cr = new Cairo.Context (canvas_surface);
//            cr.set_source_rgba (1, 1, 1, 0.5); // pure white
//            cr.rectangle(0, 0, canvas_surface.get_width(), canvas_surface.get_height());
//            cr.paint();
//            cr.fill();
            prepare_pixel_grid();
            update_size_request();
            
            var window = get_window ();

            if (null == window) {
            print ("No window\n");
                return;
            }
            
//            zoom_level = 1.5;
            var region = window.get_clip_region ();
            // redraw the cairo canvas completely by exposing it
            window.invalidate_region (region, true);
            window.process_updates (true);
            
            
            // setup cursors for this widget
            default_cursor = window.get_cursor();
            cursor = default_cursor;
            
            cursor_on_canvas = new Cursor(Gdk.CursorType.CROSSHAIR);
        }
        
        public void zoom_in()
        {
            ++zoom_index;
            if (zoom_index < zoom_steps.size ) {
                zoom_level = zoom_steps[zoom_index];
            }
            else {
                zoom_level = zoom_steps.last();
                --zoom_index;
            }
            
            var window = get_window();
            window.invalidate_rect(null, false); // ask for a redraw
            prepare_pixel_grid();
            update_size_request();
        }
        
        public void zoom_out()
        {
            --zoom_index;
            if ( zoom_index > 0)
            {
                zoom_level = zoom_steps[zoom_index];
            }
            else {
                zoom_level = zoom_steps.first();
                ++zoom_index;
            }
            var window = get_window();
            window.invalidate_rect(null, false); // ask for a redraw
            prepare_pixel_grid();
            update_size_request();
        }
        
        private void prepare_pixel_grid()
        {
            if (_enable_pixel_grid && zoom_level >= 4) {
//            Prepare the pixel grid
                pixel_grid_surface = new ImageSurface(Format.ARGB32, (int) zoom_level, (int) zoom_level);
                Cairo.Context pixel_grid_cr = new Cairo.Context(pixel_grid_surface);
    //                pixel_grid_cr.set_antialias(Antialias.NONE); //Disable antialias por pixelated goodness
                
    //                draw two perpendicular lines
                pixel_grid_cr.set_source_rgba (0.2, 0.2, 0.2, 1);
                pixel_grid_cr.set_line_width (1);
                pixel_grid_cr.move_to((int) zoom_level, 0);
                pixel_grid_cr.line_to(0, 0);
                pixel_grid_cr.line_to(0, (int) zoom_level);
                pixel_grid_cr.stroke();

    //                convert to pattern
                pixel_grid_pattern = new Pattern.for_surface(pixel_grid_surface);
                pixel_grid_pattern.set_filter(Filter.NEAREST);
                pixel_grid_pattern.set_extend(Extend.REPEAT);
            }
        }
        private void update_size_request() {
            set_size_request((int) (canvas_surface.get_width()*zoom_level + minimum_margin), (int) (canvas_surface.get_height() * zoom_level + minimum_margin));
        }
        
        public override bool configure_event(Gdk.EventConfigure event)
        {
//            base.configure_event(event);
            update_size_request();
//            var window = get_window();
//            window.invalidate_rect(null, false); // ask for a redraw
            
            return true;
        }
         
        public override bool draw (Cairo.Context cr) {
            int width = get_allocated_width ();
            int height = get_allocated_height ();

            int canvas_width = (int) (canvas_surface.get_width() * zoom_level);
            int canvas_height = (int) (canvas_surface.get_height() * zoom_level);
            
            img_left = width / 2 - canvas_width / 2;
            img_top = height / 2 - canvas_height / 2;
            
//            Draw a dark gray rectangle as a background
            cr.set_source_rgba (0.5, 0.5, 0.5, 1);
            cr.set_antialias(Antialias.NONE); //Disable antialias for pixelated goodness
            cr.rectangle (0, 0,
                          width,
                          height);
            cr.set_line_width (5.0);
            cr.set_line_join (LineJoin.MITER);
            cr.fill();
            
//            draw a black 1 px frame around the image
            cr.set_source_rgba (0.2, 0.2, 0.2, 1); // near black
            cr.translate(img_left, img_top);
            cr.rectangle (0, 0,
                          canvas_width+1,
                          canvas_height+1);
            cr.set_line_width (2.0);
            cr.set_line_join (LineJoin.MITER);
            cr.stroke ();
            cr.save();
            
//            draw the image itself in the center
            
            cr.scale (zoom_level, zoom_level);
            cr.set_source_surface(canvas_surface, 0, 0); // set the image
            Pattern image_pattern = cr.get_source();
            image_pattern.set_filter(Filter.NEAREST); // No filter for pixelated output
            cr.paint();
            
            // draw the pixel grid, if active
            if (zoom_level >= 4 && enable_pixel_grid)
            {
//                now draw the pattern on the image
                cr.restore();
                cr.scale(1, 1);
                cr.set_source(pixel_grid_pattern);
//                cr.move_to(img_left+1,img_top+1);
//                cr.translate(img_left, img_top);
                cr.rectangle(0, 0,
                          canvas_width,
                          canvas_height);
                cr.fill();
            }
            
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
            Gdk.RGBA color = RGBA();
            color = {1,0,0,1};
            paintbrush_at(event.x, event.y, color);
            button_down = true;
//            print ("Device: %s X: %f Y: %f Pressure: %f\n", event.device.name, event.x, event.y, event.axes); //TODO
            return true;
        }

        /* Mouse button got released */
        public override bool button_release_event (Gdk.EventButton event) {
            Gdk.RGBA color = RGBA();
            color = {0,0,1,1};
            paintbrush_at(event.x, event.y, color);
            button_down = false;
            
            return true;
        }

        /* Mouse pointer moved over widget */
        public override bool motion_notify_event (Gdk.EventMotion event) {
//            print ("Motion event %d, %d \n", (int) event.x, (int) event.y);
            Gdk.RGBA color = RGBA();
            color = {0,0,0,1};
            if (button_down)
            {
                paintbrush_at(event.x, event.y, color);
            }
            
            debug ("Device: %s X: %f Y: %f Pressure: %f\n", Gtk.get_current_event_device().name, event.axes[0], event.axes[1], event.axes[2]); //TODO
            
            int widget_to_image_x = (int)((event.x - img_left)/zoom_level); // TODO look for a reason for the incorrect coordinates in the upper left corner
            int widget_to_image_y = (int)((event.y - img_top) / zoom_level);
            if (widget_to_image_x >= 0 &&
                widget_to_image_x < canvas_surface.get_width() &&
                widget_to_image_y >= 0 &&
                widget_to_image_y < canvas_surface.get_height()) {
//                print ("image coords %d, %d \n", widget_to_image_x, widget_to_image_y);
                mouse_over_canvas(widget_to_image_x, widget_to_image_y);
                cursor = cursor_on_canvas;
            }
            else {
//                change to default cursor when not exactly over canvas
                cursor = default_cursor;
            }
            
            return true;
        }
        
        private void paintbrush_at(double widget_x, double widget_y, RGBA color) {
            if (widget_x >= img_left && 
                widget_x < img_left + canvas_surface.get_width()*zoom_level && 
                widget_y >= img_top && 
                widget_x < img_left + canvas_surface.get_width()*zoom_level) {
                Cairo.Context canvas_cr = new Cairo.Context (canvas_surface);
                
//                canvas_cr.scale(zoom_level, zoom_level);
                canvas_cr.set_antialias(Antialias.NONE); //Disable antialias
                canvas_cr.set_source_rgba (color.red, color.green, color.blue, color.alpha);
//                canvas_cr.move_to (widget_x, widget_y/zoom_level);
                canvas_cr.arc((widget_x - img_left)/zoom_level, (widget_y - img_top) / zoom_level, BRUSH_RADIUS, 0, 2.0*Math.PI);
                
                canvas_cr.fill();
                
//                print ("event %d, %d \n", (int) widget_x, (int) widget_y);
                
                var window = get_window();
                Gdk.Rectangle rect = Gdk.Rectangle();
                rect.x = (int) (widget_x - zoom_level * 2 * BRUSH_RADIUS)-1;
                rect.y = (int) (widget_y - zoom_level * 2 * BRUSH_RADIUS)-1;
                rect.width = (int) (zoom_level * 4 * BRUSH_RADIUS);
                rect.height = (int) (zoom_level * 4 * BRUSH_RADIUS);
                window.invalidate_rect(null, false); // ask for a redraw
                
//                print ("rect %d, %d %d %d\n", rect.x, rect.y, rect.width, rect.height);
            }
        }
        
    }
}
