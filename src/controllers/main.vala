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

namespace Controllers
{
    class Main : Object {
        private Gtk.Window window;
        private Gtk.Toolbar main_toolbar;
        private Gtk.Statusbar main_statusbar;
    
        public Main ()
        {
            try
            {
                string main_window_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
										     "mainwindow.ui", null );
                var builder = new Builder ();
                builder.add_from_file (main_window_path);
                Gtk.UIManager ui_manager = new UIManager();    
                
                window = builder.get_object ("main-window") as Window;
                window.add_accel_group(ui_manager.get_accel_group());                           
                
                Gtk.ActionGroup file_ag = builder.get_object("file-actiongroup") as Gtk.ActionGroup;
                Gtk.ActionGroup edit_ag = builder.get_object("edit-actiongroup") as Gtk.ActionGroup;
                Gtk.ActionGroup view_ag = builder.get_object("view-actiongroup") as Gtk.ActionGroup;
                Gtk.ActionGroup help_ag = builder.get_object("help-actiongroup") as Gtk.ActionGroup;                
                
                ui_manager.insert_action_group(file_ag, 0);
                ui_manager.insert_action_group(edit_ag, 1);
                ui_manager.insert_action_group(view_ag, 2);
                ui_manager.insert_action_group(help_ag, 3);
                
                string ui_info =
                "<ui>
                  <menubar name='MenuBar' position='top'>
                    <menu action='file-action' position='top'>
                      <menuitem action='new-action'/>
                      <menuitem action='open-action'/>
                      <menuitem action='save-action'/>
                      <menuitem action='save-as-action'/>
                      <separator/>
                      <menuitem action='quit-action'/>
                    </menu>
                    <menu action='edit-action'>
                      <menuitem action='undo-action'/>
                      <menuitem action='redo-action'/>
                      <separator/>
                      <menuitem action='cut-action'/>
                      <menuitem action='copy-action'/>
                      <menuitem action='paste-action'/>
                      <separator/>
                      <menuitem action='preferences-action'/>
                    </menu>
                    <menu action='view-action'>
                      <menuitem action='toolbar-action'/>
                      <menuitem action='statusbar-action'/>
                    </menu>
                    <menu action='help-action'>
                      <menuitem action='help-contents-action'/>
                      <menuitem action='about-action'/>
                    </menu>
                  </menubar>
                  <toolbar  name='ToolBar'>
                    <toolitem action='open-action'/>
                    <toolitem action='quit-action'/>
                  </toolbar>
                </ui>";
                
                ui_manager.add_ui_from_string(ui_info, ui_info.length);
                
                Box box = builder.get_object("box1") as Box;
                
                box.pack_start(ui_manager.get_widget("/MenuBar"), false, true, 0);
                
                builder.connect_signals (this);
                             
                main_toolbar = builder.get_object("main-toolbar") as Toolbar;
                main_toolbar.get_style_context().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);
                
                main_statusbar = builder.get_object("main-statusbar") as Statusbar;
                
                window.show_all ();


            } catch (Error e) {
                stderr.printf ("Could not load UI: %s\n", e.message);
            } 
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
            main_toolbar.visible = sender.active;
        }
        
        [CCode (instance_pos = -1)]
        public void on_statusbar_toggle(ToggleAction sender) {
            main_statusbar.visible = sender.active;
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

