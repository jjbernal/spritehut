/*
** Copyright © 2011-2012, 2016 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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
using SpriteHut.AppConfig;

namespace Widgets
{
    public class MainDock : Gtk.Box {
        private DockMaster master;
        private DockLayout layout;
        private MainWindow window;
        private DocumentTree document_treeview;
        private FramesIconViewController frames_controller;
        private CanvasController canvas_controller;
        
        public weak Widgets.Canvas active_canvas;
        public Gtk.Builder builder;
        
        public MainDock(MainWindow main_window)
        { 
            window = main_window;
            
            // set up the path
            string main_dock_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
                                             "maindockwidgets.ui", null );
            builder = new Builder ();
            
            // load the ui file
            try {
                builder.add_from_file (main_dock_path);
            }
            catch (Error e) {
                error (_("Unable to load ui file: %s"), e.message);
            }
            
            var toolbox_toolpalette = builder.get_object("toolbox-toolpalette") as ToolPalette;
            var frames_box = builder.get_object("frames-box") as Box;
//            var frames_iconview = builder.get_object("frames-iconview") as IconView;
            frames_controller = new FramesIconViewController(main_window, builder);
//            frames_box.pack_start(frames_controller.iconview);
            
            var document_box = builder.get_object("document-box") as Box;
            var document_scrolledwindow = builder.get_object("document-scrolledwindow") as ScrolledWindow;
            
            document_treeview = new DocumentTree(main_window, builder);
            document_scrolledwindow.add(document_treeview.treeview);
            document_box.show_all();
            
            var canvas_box = builder.get_object("canvas-box") as Box;
            var canvas_viewport = builder.get_object("canvas-viewport") as Viewport;
            
            ColorChooserWidget palette_colorchooser = new ColorChooserWidget();
            Gdk.RGBA[] colors = new Gdk.RGBA[3];
            colors[0] = {0, 0, 0, 0};
            colors[1] = {0, 0, 0, 1};
            colors[2] = {1, 1, 1, 1};
            palette_colorchooser.add_palette(Orientation.VERTICAL, 6, colors) ;
            
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
            var canvas_dockitem = new DockItem.with_stock("canvas-dockitem", _("Canvas"), AppConstants.GTK_STOP, DockItemBehavior.NO_GRIP |
                                              DockItemBehavior.CANT_ICONIFY | DockItemBehavior.LOCKED | DockItemBehavior.CANT_DOCK_CENTER);
            canvas_controller = new CanvasController(window, builder);
            
            canvas_viewport.add(canvas_controller.canvas);
            active_canvas = canvas_controller.canvas;//set as the active canvas so other widgets can control its zoom etc.
            
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
            var palette = add_dock_item(dock, "palette", _("Palette"), palette_colorchooser, preview,
            DockPlacement.BOTTOM, 50, 100);
            
            /* Tool box */
            var toolbox = add_dock_item(dock, "toolbox", _("Toolbox"), toolbox_toolpalette, canvas_dockitem,
            DockPlacement.LEFT, 50, 150);
            toolbox.resize = false;
            
            // Document Tree
            DockItem document_tree;
            document_tree = add_dock_item(dock, "document-tree", _("Document Tree"), document_box, palette,
            DockPlacement.BOTTOM, 180, 150);
            
            // Frames
            DockItem frames;
            frames = add_dock_item(dock, "frames", _("Frames"), frames_box, canvas_dockitem,
            DockPlacement.BOTTOM, 400, 100);
            
        }
        
        
        public void attach_model(Document.Document document) {
            document_treeview.attach_model(document.treemodel);
            // TODO modify Document to set iter for active elements
            frames_controller.attach_model(document.treemodel);
//            document.notify.connect(document_treeview.attach_model);
            document.notify.connect(frames_controller.update);
            document.notify.connect(canvas_controller.update);
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

