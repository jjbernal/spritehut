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

using Document;

public class TestUndoHistory : Object {
    public static void test_log_change () {
        var undohist = new UndoHistory();
        var target = new Frame();
        assert (target.delay != 500);
        undohist.log_change(target,"delay", 500);
        assert (target.delay == 500);
    }
    
    public static void test_undo () {
        var undohist = new UndoHistory();
        var target = new Frame();
        var previous_value = target.delay;
        var modified_value = 100;
        
        undohist.log_change(target, "delay", modified_value);
        assert (target.delay == modified_value);
        
        undohist.undo();
        assert (target.delay == previous_value);
    }
    
    public static void test_redo () {
        var undohist = new UndoHistory();
        var target = new Frame();
        var previous_value = target.delay;
        var modified_value = 100;
        
        undohist.log_change(target, "delay", modified_value);
        assert (target.delay == modified_value);
        
        undohist.undo();
        assert (target.delay == previous_value);
        
        undohist.redo();
        assert (target.delay == modified_value);
    }
    
    public static void test_can_undo () {
        var undohist = new UndoHistory();
        assert (undohist.can_undo() == false);
        
        var target = new Frame();
        undohist.log_change(target,"delay", 500);
        assert (undohist.can_undo() == true);
        
        undohist.undo();
        assert (undohist.can_undo() == false);
    }
    
    public static void test_can_redo () {
        var undohist = new UndoHistory();
        assert (undohist.can_redo() == false);
        
        var target = new Frame();
        undohist.log_change(target,"delay", 500);
        assert (undohist.can_redo() == false);
        
        undohist.undo();
        assert (undohist.can_redo() == true);
        
        undohist.redo();
        assert (undohist.can_redo() == false);
    }
    
    public static void test_undo_multiple () {
        var undohist = new UndoHistory();
        var frame = new Frame();
        var previous_value = frame.delay;

        for (int i = 0; i < 10; i++) {
            undohist.log_change(frame, "delay", i);
            assert (frame.delay == i);
        }
        
        for (int i = 9; i >= 0; i--) {
            assert (frame.delay == i);
//            debug ("i:%u/n delay:%u", i, target.delay);
            undohist.undo();
        }
        
        assert (frame.delay == previous_value);
    }

    public static void add_tests()  {
        Test.add_func ("/document/document.log_change()", test_log_change);
        Test.add_func ("/document/document.undo()", test_undo);
        Test.add_func ("/document/document.redo()", test_redo);
        Test.add_func ("/document/document.can_undo()", test_can_undo);
        Test.add_func ("/document/document.can_redo()", test_can_redo);
        Test.add_func ("/document/document.undo() multiple", test_undo_multiple);
    }
}
