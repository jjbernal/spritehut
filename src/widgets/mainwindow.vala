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

namespace Widgets
{
    public class MainWindow : Gtk.Window {
        public Gtk.Window window;
        public Gtk.Toolbar main_toolbar;
        public Gtk.Statusbar main_statusbar;
        public Gtk.Builder builder;
        public Document.Document document {get;set;}
        public Gtk.UIManager ui_manager;
        
        // custom signal to redirect delete event
        public signal bool close(MainWindow window, Document.Document doc);
    
        public MainWindow ()
        {
            Object(type: Gtk.WindowType.TOPLEVEL);
            
            try
            {
                string main_window_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
										     "mainwindow.ui", null );
                builder = new Builder ();
                builder.add_from_file (main_window_path);
                ui_manager = new UIManager();    
                
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
                    <toolitem action='new-action'/>
                    <toolitem action='open-action'/>
                    <toolitem action='save-action'/>
                    <separator/>
                    <toolitem action='undo-action'/>
                    <toolitem action='redo-action'/>
                    <separator/>
                    <toolitem action='cut-action'/>
                    <toolitem action='copy-action'/>
                    <toolitem action='paste-action'/>
                  </toolbar>
                </ui>";
                
                ui_manager.add_ui_from_string(ui_info, ui_info.length);
                
                Box box = builder.get_object("main-box") as Box;
                main_toolbar = ui_manager.get_widget("/ToolBar") as Toolbar;
                main_toolbar.get_style_context().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);
                
                main_statusbar = builder.get_object("main-statusbar") as Statusbar;
                
                box.pack_start(ui_manager.get_widget("/MenuBar"), false, true, 0);
                box.pack_start(ui_manager.get_widget("/ToolBar"), false, true, 0);
                MainDock main_dock = new MainDock(this);
                box.pack_start(main_dock, true, true, 0);
                
                window.delete_event.connect(() => {
                    return close(this, this.document);
                }); // redirect delete_event to custom close signal hack
                window.show_all ();


            } catch (Error e) {
                stderr.printf ("Could not load UI: %s\n", e.message);
            } 
        }
    }
}

