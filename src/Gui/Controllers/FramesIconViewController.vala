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
using SpriteHut.Data;

namespace SpriteHut.Gui
{
    public class FramesIconViewController : Object {
        public MainWindow window {get;set;}
        public IconView iconview;
        private TreeDragDestTreeModelFilter active_animation_model;
        
        public FramesIconViewController (MainWindow main_window, Builder builder) {
            window = main_window;
            iconview = builder.get_object("frames-iconview") as IconView;
            iconview.reorderable = true;
            iconview.selection_mode = SelectionMode.MULTIPLE;
            
            //            get the instance from the CellRenderer helper
            var cellrh = CellRendererHelper.get_instance();
            
            var thumbnail_renderer = new CellRendererPixbuf();
//            var thumbnail_renderer = cellrh.thumbnail_renderer;
            var name_renderer = new CellRendererText();
            name_renderer.alignment = Pango.Alignment.CENTER;
            
            iconview.pack_start(thumbnail_renderer, true);
            iconview.pack_end(name_renderer, true);
            iconview.set_cell_data_func(thumbnail_renderer, (CellLayoutDataFunc)cellrh.thumbnail_cell_data_func);
            iconview.set_cell_data_func(name_renderer, (CellLayoutDataFunc)cellrh.name_cell_data_func);
            
            
        }
        
        public void update(ParamSpec pspec) {
//            warning ("Trying to update the iconview");
            attach_model(window.document.treemodel);
        }
        
        
        public void attach_model(TreeModel treemodel) {
            if (window.document.active_animation != null && window.document.active_element is Animation) {
                var path = treemodel.get_path(window.document.active_element_iter);
//                var path = new TreePath.from_string("0:0");
                active_animation_model = new TreeDragDestTreeModelFilter (treemodel, path); // virtual root is immutable, so create a new one every time
                iconview.set_model(active_animation_model);
            }
        }
        
        public void detach_model() {
            iconview.set_model(null);
        }
    }
}
