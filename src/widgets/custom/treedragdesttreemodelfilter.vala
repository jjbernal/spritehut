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
using Document;

namespace Widgets
{
    public class TreeDragDestTreeModelFilter: TreeModelFilter, TreeDragDest {
        public TreeDragDestTreeModelFilter(TreeModel tm, TreePath? root) {
            Object (child_model: tm, virtual_root: root);
        }
        
//        TreeDragDest methods
//        Asks the TreeDragDest to insert a row before the path dest, deriving the contents of the row from selection_data.
        public bool drag_data_received (TreePath filtered_dest_path, SelectionData selection_data) {
            var res = false;
            
            //TreeModel tree_model;
            //TreePath source_path;
            TreeStore treestore = (TreeStore) child_model; // we know it's a TreeStore
            var dest_path = convert_path_to_child_path(filtered_dest_path);
            
            if (dest_path != null) {
                res = treestore.drag_data_received(dest_path, selection_data);
            }
            else {
//            the filter path may be converted to null because it points after the last element, which is still valid
                if (filtered_dest_path.prev()) {
                    dest_path = convert_path_to_child_path(filtered_dest_path);
                    dest_path.next();
                    res = treestore.drag_data_received(dest_path, selection_data);
                }
            }
            
            return res;
        }
        
//        Determines whether a drop is possible before the given dest_path , at the same depth as dest_path.
        public bool row_drop_possible (TreePath filtered_dest_path, SelectionData selection_data) {
            var res = false;
            
            //TreeModel tree_model;
            //TreePath source_path;
            TreeStore treestore = (TreeStore) child_model; // we know it's a TreeStore
            TreePath dest_path = convert_path_to_child_path(filtered_dest_path);
            
            //TreePath tmp = dest_path.copy();
            
            if (dest_path != null) {
                res = treestore.row_drop_possible(dest_path, selection_data);
            }
            else {
                if (filtered_dest_path.prev()) {
                    dest_path = convert_path_to_child_path(filtered_dest_path);
                    dest_path.next();
                    res = treestore.row_drop_possible(dest_path, selection_data);
                }
            }
            
            return res;
        }
    }
}

