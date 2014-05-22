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
        private DocumentTree document_treeview;
        public weak Widgets.Canvas active_canvas;
        public Gtk.Builder builder;
        
        public MainDock(MainWindow main_window)
        {
            string main_dock_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
                                             "maindockwidgets.ui", null );
            builder = new Builder ();
            builder.add_from_file (main_dock_path);
            
            var toolbox_toolpalette = builder.get_object("toolbox-toolpalette") as ToolPalette;
            var frames_box = builder.get_object("frames-box") as Box;
            var document_box = builder.get_object("document-box") as Box;
            
            document_treeview = new DocumentTree(main_window);
            document_box.pack_start(document_treeview);
            document_box.show_all();
            
            var canvas_box = builder.get_object("canvas-box") as Box;
            var canvas_viewport = builder.get_object("canvas-viewport") as Viewport;
            
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
            canvas_viewport.add(canvas);
            active_canvas = canvas;//set as the active canvas so other widgets can control its zoom etc.
            
            dock.add_item (canvas_dockitem, DockPlacement.TOP);
            canvas_dockitem.set_size_request(400, 400);
            canvas_dockitem.expand = true;
//            canvas_dockitem.fill = true;
            canvas_dockitem.add(canvas_box);
            canvas_dockitem.show();

            /* preview */
            var preview = add_dock_item(dock, "preview", _("Preview"), new TreeView(), canvas_dockitem,
            DockPlacement.RIGHT, 100, 100);

            // Palette
            var palette = add_dock_item(dock, "palette", _("Palette"), new TreeView(), preview,
            DockPlacement.BOTTOM, 50, 100);
            
            /* Tool box */
            var toolbox = add_dock_item(dock, "toolbox", _("Toolbox"), toolbox_toolpalette, canvas_dockitem,
            DockPlacement.LEFT, 50, 300);
            toolbox.resize = false;

            /* the color_picker dock */
            var color_picker = add_dock_item(dock, "color_picker", _("Color Picker"), new HSV(), toolbox,
            DockPlacement.BOTTOM, 50, 50);
            
            // Document Tree
            var document_tree = add_dock_item(dock, "document-tree", _("Document Tree"), document_box, palette,
            DockPlacement.BOTTOM, 180, 150);
            // Frames
            var frames = add_dock_item(dock, "frames", _("Frames"), frames_box, canvas_dockitem,
            DockPlacement.BOTTOM, 400, 100);
            
            if (window.document != null) {
//                attach_model(window.document);
            }
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

