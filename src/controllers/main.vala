/*
** Copyright (C) 2011 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
**
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation; either version 2 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

using Gtk;
using Widgets;

namespace Controllers
{
    public class Main : Object {
        
        private Widgets.MainWindow window;
        
        public Main(MainWindow win)
        {
            this.window = win;
            window.builder.connect_signals(this);
        }
        
        // File action handlers
        [CCode (instance_pos = -1)]
        public void on_new(Object sender) {
            stdout.printf("New Stub\n");
        }

        [CCode (instance_pos = -1)]
        public void on_open(Object sender) {
            stdout.printf("Open Stub\n");
        }

        [CCode (instance_pos = -1)]
        public void on_save(Object sender) {
            stdout.printf("Save Stub\n");
        }
        
        [CCode (instance_pos = -1)]
        public void on_save_as(Object sender) {
            stdout.printf("Save as Stub\n");
        }

        [CCode (instance_pos = -1)]
        public void on_quit(Object sender) {
            MessageDialog md = new MessageDialog(null, DialogFlags.MODAL,MessageType.WARNING,ButtonsType.YES_NO, "Are you sure?");
            md.ref_sink();
            int response = md.run();
            if (response == ResponseType.YES) {
                stdout.printf("Close Stub\n");
                Gtk.main_quit();
            } else {
                md.destroy();
            }
        }
        
        // Edit action handlers
        [CCode (instance_pos = -1)]
        public void on_undo(Object sender) {
            stdout.printf("Undo Stub\n");
        }
        
        [CCode (instance_pos = -1)]
        public void on_redo(Object sender) {
            stdout.printf("Redo Stub\n");
        }

        [CCode (instance_pos = -1)]
        public void on_cut(Object sender) {
            stdout.printf("Cut Stub\n");
        }
        
        [CCode (instance_pos = -1)]
        public void on_copy(Object sender) {
            stdout.printf("Copy Stub\n");
        }
        
        [CCode (instance_pos = -1)]
        public void on_paste(Object sender) {
            stdout.printf("Paste Stub\n");
        }
        
        [CCode (instance_pos = -1)]
        public void on_preferences(Object sender) {
            stdout.printf("Preferences Stub\n");
        }
        
        // View action handlers
        [CCode (instance_pos = -1)]
        public void on_toolbar_toggle(ToggleAction sender) {
            window.main_toolbar.visible = sender.active;
        }
        
        [CCode (instance_pos = -1)]
        public void on_statusbar_toggle(ToggleAction sender) {
            window.main_statusbar.visible = sender.active;
        }
        
        // Help action handlers
        [CCode (instance_pos = -1)]
        public void on_help_contents(Object sender) 
        {
            stdout.printf("Help Contents Stub\n");
        }
        
        [CCode (instance_pos = -1)]
        public void on_about(Object sender) 
        {
            // Create the about controller
            Controllers.About about_controller = new About();
            about_controller.run();
        }
        
        // Paint tool handlers
        public void on_tool_change(RadioAction current) {
            stdout.printf("%s Selected\n", current.get_name());
        }
    }
}

