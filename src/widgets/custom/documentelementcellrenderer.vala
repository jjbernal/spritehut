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
using Cairo;
using Document;

namespace Widgets {
    public class DocumentElementCellRenderer : CellRendererText {
        // pango layout
        private Pango.Layout layout;
        /* element property set by the tree column */
        public IDocumentElement element { get; set;}

        public DocumentElementCellRenderer () {
//            GLib.Object (size_set: true, family_set: true);

            this.mode = CellRendererMode.EDITABLE;
            this.editable = true;
//            this.font_desc = base.font_desc;
//            this.attributes = base.attributes;
//            this.width = 50;
//            this.height = 20;
//            this.text = element.name;
        }
     
        public override void edited (string path, string new_text) {
            element.name = new_text;
        }
        
//        public new unowned CellEditable start_editing(Event event, Entry widget, string path, Gdk.Rectangle background_area,
//                                        Gdk.Rectangle cell_area, CellRendererState flags)
//        {
//            widget.text = element.name;
//            return base.start_editing(event, widget, path, background_area,
//                                        cell_area, flags);
//        }
        
        /* get_size method, always request a 50x50 area */
        public override void get_size (Widget widget, Gdk.Rectangle? cell_area,
                                       out int x_offset, out int y_offset,
                                       out int width, out int height)
        {
            /* Guards needed to check if the 'out' parameters are null */
            if (&x_offset != null) x_offset = 0;
            if (&y_offset != null) y_offset = 0;
            if (&width != null) width = this.width;
            if (&height != null) height = this.height;
        }

    //    public override void get_preferred_size (Widget widget, out Requisition minimum_size, out Requisition natural_size)
    //    {
    //        
    //    }

        /* render method (Context cr, Widget widget, Rectangle background_area, Rectangle cell_area, CellRendererState flags)*/
        public override void render (Context ctx, Widget widget,
                                     Gdk.Rectangle background_area,
                                     Gdk.Rectangle cell_area,
                                     CellRendererState flags)
        {
            this.text = element.name;
            base.render(ctx, widget, background_area, cell_area, flags);
//            Gdk.cairo_rectangle (ctx, background_area);
//            
//            if (element != null) {
//                if (this.layout == null) {
//                    this.layout = Pango.cairo_create_layout(ctx);
//                    layout.set_width(this.width);
//                    layout.set_height(this.height);
//                    layout.set_font_description(font_desc);
//                    layout.set_alignment(alignment);
//                    layout.set_attributes(attributes);
//                    layout.set_ellipsize(ellipsize);
//                }
//                
//                layout.set_text(element.name, element.name.length);
//                ctx.set_source_rgba (this.cell_background_rgba.red, this.cell_background_rgba.green,
//                                     this.cell_background_rgba.blue, this.cell_background_rgba.alpha);
//                ctx.fill ();
//                ctx.set_source_rgb(this.foreground_gdk.red, this.foreground_gdk.green, this.foreground_gdk.blue);
////                ctx.move_to(cell_area.x, cell_area.y);
//                int fontw, fonth;
//                this.layout.get_pixel_size (out fontw, out fonth);
////                debug("width:%d height: %d, fontw: %i fonth: %i\n", width, height, fontw, fonth);
//                ctx.move_to (cell_area.x,
//                    cell_area.y + ((height - fonth) / 2));
//                Pango.cairo_update_layout (ctx, this.layout);
//                Pango.cairo_show_layout (ctx, this.layout);
//            }
        }
    }
}
