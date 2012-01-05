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

        /* element property set by the tree column */
        public IDocumentElement element { get; set;}

        public DocumentElementCellRenderer () {
//            GLib.Object ();
            new CellRendererText();

            this.mode = CellRendererMode.EDITABLE;
            this.editable = true;
            this.edited.connect(on_edited);
        }
     
        public void on_edited (string path, string new_text) {
            element.name = new_text;
        }
        
        /* get_size method, always request a 50x50 area */
        public override void get_size (Widget widget, Gdk.Rectangle? cell_area,
                                       out int x_offset, out int y_offset,
                                       out int width, out int height)
        {
            /* Guards needed to check if the 'out' parameters are null */
            if (&x_offset != null) x_offset = 0;
            if (&y_offset != null) y_offset = 0;
            if (&width != null) width = 50;
            if (&height != null) height = 18;
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
            Gdk.cairo_rectangle (ctx, background_area);
            if (element != null) {
                uint size = 14;
                TextExtents extents;

                ctx.set_source_rgba (this.cell_background_rgba.red, this.cell_background_rgba.green, this.cell_background_rgba.blue, this.cell_background_rgba.alpha);
                ctx.fill ();
                ctx.set_source_rgb(0.1, 0.1, 0.1);
                ctx.select_font_face("ubuntu", Cairo.FontSlant.NORMAL, 
                    Cairo.FontWeight.NORMAL);
                ctx.set_font_size(size);
                ctx.text_extents(element.name, out extents);
                ctx.move_to(cell_area.x, cell_area.y+cell_area.height/2-extents.y_bearing/2);
                ctx.show_text(element.name);
            }
        }
    }
}
