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

using Gee;

namespace Document
{
    public class UndoHistory : GLib.Object
    {
        private Gee.LinkedList<Change?> _undo_history;
        
        struct Change {
            private Object target;
            private string property_name;
            private Value original_value;
            private Value modified_value;
        }
        
        private int _now;
        
        public UndoHistory ()
        {
            _now = -1; //nothing to undo
            _undo_history = new LinkedList<Change?>();
        }
        
        public void log_change(Object target, string property_name, Value val)
        {
            Change change = Change();
            change.target = target;
            change.property_name = property_name;
            change.original_value = Value(target.get_class().find_property(property_name).value_type);
            target.get_property(property_name, ref change.original_value);
            target.set_property(property_name, val);
            change.modified_value = val;
            
            _undo_history.add(change);
            _now++;
            
            // wipe future redos, if any
            while (_undo_history.size > _now + 1)
            {
                _undo_history.remove_at(_now+1);
//                debug("undo size: %d now:%d /n", _undo_history.size, _now);
            }
        }
        
        public void undo()
        {
            Change change = _undo_history.get(_now);
            change.target.set_property(change.property_name, change.original_value);
            _now--;
        }
        
        public void redo()
        {
            _now++;
            Change change = _undo_history.get(_now);
            change.target.set_property(change.property_name, change.modified_value);
        }
        
        public bool can_undo()
        {
            return (_now > -1);
        }
        
        public bool can_redo()
        {
            return (_now < _undo_history.size - 1);
        }
    }
}
