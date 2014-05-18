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
using Document;

namespace Widgets
{
    public class MainWindow : Gtk.ApplicationWindow {
        public Gtk.MenuBar main_menubar;
        public Gtk.Toolbar main_toolbar;
        public Gtk.Statusbar main_statusbar;
        public Gtk.Builder builder;
        public Document.Document document {get;set;}

        private string default_title = _("Sprite Hut");
        private InfoBar main_infobar;
        private MainDock main_dock;

        public const GLib.ActionEntry[] actions = {
        /*{ "action name", cb to connect to "activate" signal, parameter type,
         initial state, cb to connect to "change-state" signal } */
            { "save", on_save },
            { "save-as", on_save_as },
            { "close", on_close },
            { "undo", on_undo },
            { "redo", on_redo },
            { "cut", on_cut },
            { "copy", on_copy },
            { "paste", on_paste },
            { "undo", on_undo },
            { "delete", on_delete },
            { "zoom-in", on_zoom_in},
            { "zoom-out", on_zoom_out},
            { "normal-size", on_normal_size},
            { "toggle-toolbar", on_toggle_toolbar, null, "true" },
            { "toggle-statusbar", on_toggle_statusbar, null, "true" }
        };
        
        public MainWindow (Gtk.Application app, Document.Document? doc)
        {
            Object (application: app, title: _("Sprite Hut") , type: Gtk.WindowType.TOPLEVEL);
            
            this.set_default_size (800, 600);
            this.icon_name = "spritehut";
            
            try
            {
                string main_window_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
                                             "mainwindow.ui", null );
                builder = new Builder ();
                builder.add_from_file (main_window_path);
                
//                builder.get_object ("main-window") as Gtk.ApplicationWindow;
                main_infobar = builder.get_object ("main-infobar") as Gtk.InfoBar;
                this.add_accel_group(builder.get_object ("main-accelgroup") as Gtk.AccelGroup);
                this.add_action_entries( actions, this);
                
                Box box = builder.get_object("main-box") as Box;
                box.reparent(this);
                
                main_toolbar = builder.get_object("main-toolbar") as Toolbar;
//                main_toolbar.get_style_context().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);
                main_statusbar = builder.get_object("main-statusbar") as Statusbar;
                main_statusbar.push(0, _("Ready"));

                main_dock = new MainDock(this);
                box.pack_start(main_dock, true, true, 0);
                
                document = doc;
                if (document != null)
                {
                    document.notify.connect(update_status);
                }
                
                this.delete_event.connect(on_window_delete); // redirect delete_event
                
                update_status();
                this.show_all ();

            } catch (Error e) {
                stderr.printf ("Could not load UI: %s\n", e.message);
            } 
        }
        
        //Window Statuses
        public void update_status(){
        
            if (document != null)
            {
                this.set_title((document.modified ? "*" : "" ) + document.name + " - " + default_title);
                ((SimpleAction) this.lookup_action("save")).set_enabled(document.modified);
                ((SimpleAction) this.lookup_action("save-as")).set_enabled(true);
                ((SimpleAction) this.lookup_action("redo")).set_enabled(document.undo_history.can_redo());
                ((SimpleAction) this.lookup_action("undo")).set_enabled(document.undo_history.can_undo());
//                TODO Update these actions depending on document status
                ((SimpleAction) this.lookup_action("cut")).set_enabled(false);
                ((SimpleAction) this.lookup_action("copy")).set_enabled(false);
                ((SimpleAction) this.lookup_action("paste")).set_enabled(false);
                ((SimpleAction) this.lookup_action("delete")).set_enabled(false);
//                TODO make these actions depend on current layer
                ((SimpleAction) this.lookup_action("zoom-in")).set_enabled(true);
                ((SimpleAction) this.lookup_action("zoom-out")).set_enabled(true);
                ((SimpleAction) this.lookup_action("normal-size")).set_enabled(true);
            }
            else // no document loaded
            {
                this.set_title(default_title);
                disable_all_actions();
            }
            
            //always on
            ((SimpleAction) this.lookup_action("toggle-toolbar")).set_enabled(true);
            ((SimpleAction) this.lookup_action("toggle-statusbar")).set_enabled(true);
        }

        private void disable_all_actions() {
            foreach (string action_name in this.list_actions())
            {
                ((SimpleAction) this.lookup_action(action_name)).set_enabled(false);
            }
        }
        
        public void set_busy_status(){
//        TODO disable all actions while doing long tasks e.g. loading or saving and inform the user
            disable_all_actions();
            main_infobar.show();
            
            //FIXME calling this async method breaks the app on file-quit if there are more than one main window
            nap.begin(2000);
        }
        
//      copied from  https://wiki.gnome.org/Projects/Vala/AsyncSamples to simulate a long process
        public async void nap (uint interval, int priority = GLib.Priority.DEFAULT) {
            GLib.Timeout.add (interval, () => {
//              nap.callback ();
                main_infobar.hide ();
                update_status();
              return false;
            }, priority);
            yield;
        }
//      
        // File action handlers
        public void on_save(SimpleAction action, Variant? parameter) {
            stdout.printf("Save Stub\n");
            //TODO really save the document
            document.modified = false;
            set_busy_status();
        }
        
        public void on_save_as(SimpleAction action, Variant? parameter) {
            FileChooserDialog fcd = new FileChooserDialog(null, null, FileChooserAction.SAVE, Stock.CANCEL, ResponseType.CANCEL,
                                      Stock.SAVE_AS, ResponseType.ACCEPT);
            if (fcd.run () == ResponseType.ACCEPT) {
//                open_file (file_chooser.get_filename ());
                stdout.printf("Saving to %s\n", fcd.get_filename ());
                
                //TODO really save the document
                document.modified = false;
            }
            
            fcd.destroy();
        }
        
        public void on_close(SimpleAction action, Variant? parameter) {

            close_intent();
        }
        
        public bool on_window_delete(Gdk.EventAny? event) {
            close_intent();
            
            return true;
        }
        
        public void close_intent() {
            if (document != null && document.modified)
            {
                MessageDialog md = new MessageDialog(null, DialogFlags.MODAL,MessageType.WARNING,ButtonsType.YES_NO,
                _("There are unsaved changes in this project. Close the window anyway?"));
                if (md.run() == ResponseType.YES) {
                    document.notify.disconnect(update_status);   // detach document from window
                    this.destroy();
                }
                md.destroy();
            }
            else
            {
                this.destroy();
            }
        }
        
        // Edit action handlers
        public void on_undo(SimpleAction action, Variant? parameter) {
            stdout.printf("Undo Stub\n");
        }
        
        public void on_redo(SimpleAction action, Variant? parameter) {
            stdout.printf("Redo Stub\n");
        }
        
        public void on_cut(SimpleAction action, Variant? parameter) {
            stdout.printf("Cut Stub\n");
        }
        
        public void on_copy(SimpleAction action, Variant? parameter) {
            stdout.printf("Copy Stub\n");
        }
        
        public void on_paste(SimpleAction action, Variant? parameter) {
            stdout.printf("Paste Stub\n");
        }
        
        public void on_delete(SimpleAction action, Variant? parameter) {
            stdout.printf("Delete Stub\n");
        }
        
        public void on_preferences(SimpleAction action, Variant? parameter) {
            stdout.printf("Preferences Stub\n");
        }
        
        // View action handlers
        public void on_zoom_in(SimpleAction action, Variant? parameter) {
            main_dock.active_canvas.zoom_in();
        }
        
        public void on_zoom_out(SimpleAction action, Variant? parameter) {
            main_dock.active_canvas.zoom_out();
        }
        
        public void on_normal_size(SimpleAction action, Variant? parameter) {
            main_dock.active_canvas.zoom_level = 1.0;
        }
        
        public void on_toggle_toolbar(SimpleAction action, Variant? parameter) {
            var active = action.get_state ().get_boolean ();
            action.set_state (new Variant.boolean (!active));
            main_toolbar.visible = !active;
            print("Toggled toolbar\n");
        }
        
        public void on_toggle_statusbar(SimpleAction action, Variant? parameter) {
            var active = action.get_state ().get_boolean ();
            action.set_state (new Variant.boolean (!active));
            main_statusbar.visible = !active;
            print("Toggled status bar \n");
        }
    }
}

