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
using Gdl;

namespace Widgets
{
    public class MainDock : Gtk.Box {
        private DockMaster master;
        private DockLayout layout;
        private MainWindow window;
        public weak Widgets.Canvas active_canvas;
        
        public MainDock(MainWindow main_window)
        {
            window = main_window;
            Gdl.Dock dock = new Gdl.Dock();
            this.master = dock.master;

            /* ... and the layout manager */
            this.layout = new DockLayout(dock);

            /* create the dockbar */
            var dockbar = new DockBar (dock);
            dockbar.set_style (DockBarStyle.BOTH);
            
            this.pack_start(dockbar, false, true, 0);
            this.pack_start(dock, true, true, 0);
            
            /* the canvas dock */
            var canvas_dockitem = new DockItem.with_stock("canvas-dockitem", _("Canvas"), Gtk.Stock.STOP, DockItemBehavior.NO_GRIP |
                                              DockItemBehavior.CANT_ICONIFY | DockItemBehavior.LOCKED | DockItemBehavior.CANT_DOCK_CENTER);
            var canvas = new Canvas();
            active_canvas = canvas;//set as the active canvas so other widgets can control its zoom etc.
//            canvas.set_size_request(1000,800);
            var canvas_viewport = new Viewport(null, null);
            var scrolled_window = new ScrolledWindow(null, null);
//            canvas.set_size_request(400,400);
            scrolled_window.add(canvas_viewport);
            canvas_viewport.add(canvas);
            
            dock.add_item (canvas_dockitem, DockPlacement.TOP);
            canvas_dockitem.set_size_request(300,300);
            canvas_dockitem.expand = true;
//            canvas_dockitem.fill = true;
            canvas_dockitem.add(scrolled_window);
            canvas_dockitem.show();

            /* preview */
            var preview = add_dock_item(dock, "preview", _("Preview"), new TreeView(), canvas_dockitem,
            DockPlacement.RIGHT, 100, 100);

            // Palette
            var palette = add_dock_item(dock, "palette", _("Palette"), new TreeView(), preview,
            DockPlacement.BOTTOM, 100, 100);
            
            /* Tool box */
            var toolbox = add_dock_item(dock, "toolbox", _("Toolbox"), new TreeView(), canvas_dockitem,
            DockPlacement.LEFT, 50, 100);

            /* the color_picker dock */
            var color_picker = add_dock_item(dock, "color_picker", _("Color Picker"), new HSV(), toolbox,
            DockPlacement.BOTTOM, 50, 50);
            
            /* log me*/
            var document_treeview = new DocumentTree (window);
            
            // Document Tree
            var document_tree = add_dock_item(dock, "animations", _("Document Tree"), document_treeview, palette,
            DockPlacement.BOTTOM, 100, 100);
            
            // Frames
            var frames = add_dock_item(dock, "frames", _("Frames"), new TreeView(), canvas_dockitem,
            DockPlacement.BOTTOM, 200, 100);
        }
        
        private DockItem add_dock_item(Dock dock, string name, string id, Gtk.Widget? widget=null,
         DockItem? target=null, DockPlacement dock_placement=DockPlacement.NONE, 
         int req_width=0, int req_height=0, DockItemBehavior behavior=DockItemBehavior.NORMAL)
        {   
            var item = new DockItem(name, id, behavior);
            
            if (widget != null) {
                widget.set_size_request(req_width,req_height);
                item.add(widget);
            }
            dock.add_item (item, dock_placement);
            item.dock_to(target, dock_placement, -1);
            item.show();
            
            return item;
        }
    }
}

