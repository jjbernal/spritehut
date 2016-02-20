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
using SpriteHut.AppConfig;

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
        private ProgressBar main_progressbar;
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
            { "toggle-statusbar", on_toggle_statusbar, null, "true" },
            { "paint-pencil", on_paint_pencil},
            { "paint-eraser", on_paint_eraser},
            { "paint-bucket", on_paint_pencil},
            { "paint-color-picker", on_paint_pencil},
            { "select-rectangular", on_paint_pencil},
            { "document-add", on_document_add},
            { "document-remove", on_document_remove},
            { "document-duplicate", on_document_duplicate},
            { "document-raise", on_document_raise},
            { "document-lower", on_document_lower},
        };
        
        public MainWindow (Gtk.Application app, Document.Document? doc)
        {
            Object (application: app, title: _("Sprite Hut") , type: Gtk.WindowType.TOPLEVEL);
            
            this.set_default_size (800, 600);
//            this.icon_name = "spritehut";
            set_default_icon_name("spritehut");
            
            try
            {
                string main_window_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
                                             "mainwindow.ui", null );
                builder = new Builder ();
                builder.add_from_file (main_window_path);
                
//                builder.get_object ("main-window") as Gtk.ApplicationWindow;
                main_infobar = builder.get_object ("main-infobar") as Gtk.InfoBar;
                main_progressbar = builder.get_object ("main-progressbar") as Gtk.ProgressBar;
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
                
                this.delete_event.connect(on_window_delete); // redirect delete_event
                
                
                this.show_all ();document = doc;
                if (document != null)
                {
                    document.notify.connect(update_status);
//                    document.undo_history.notify.connect(update_status);
                }
                main_dock.attach_model(document);
                update_status();

            } catch (Error e) {
                stderr.printf ("Could not load UI: %s\n", e.message);
            } 
        }
        
        //Window Statuses
        public void update_status(){
            this.sensitive = true;
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
                
                ((SimpleAction) this.lookup_action("document-add")).set_enabled(true);
                ((SimpleAction) this.lookup_action("document-remove")).set_enabled(true);
                ((SimpleAction) this.lookup_action("document-duplicate")).set_enabled(true);
                ((SimpleAction) this.lookup_action("document-raise")).set_enabled(true);
                ((SimpleAction) this.lookup_action("document-lower")).set_enabled(true);
                
            }
            else // no document loaded
            {
                this.set_title(default_title);
                disable_all_actions();
            }
            
            // always on
            ((SimpleAction) this.lookup_action("toggle-toolbar")).set_enabled(true);
            ((SimpleAction) this.lookup_action("toggle-statusbar")).set_enabled(true);
            // Refresh the window and widgets
            this.queue_draw();
        }

        private void disable_all_actions() {
            foreach (string action_name in this.list_actions())
            {
                ((SimpleAction) this.lookup_action(action_name)).set_enabled(false);
            }
        }
        
        public void set_busy_status(){
//            disable_all_actions();
            this.sensitive = false;
            main_infobar.show();
            
            
            //FIXME calling this async method breaks the app on file-quit if there are more than one main window
            nap.begin(2000);
            GLib.Timeout.add (100, fill_progressbar);
        }
        
        bool fill_progressbar () {
            double fraction = main_progressbar.get_fraction (); //get current progress
            fraction += 0.05; //increase by 10% each time this function is called

            main_progressbar.set_fraction (fraction);

            /* This function is only called by GLib.Timeout.add while it returns true; */
            return (fraction < 1.0);
        }
//      copied from  https://wiki.gnome.org/Projects/Vala/AsyncSamples to simulate a long process
        public async void nap (uint interval, int priority = GLib.Priority.DEFAULT) {
            GLib.Timeout.add (interval, () => {
                main_progressbar.fraction = 0;
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
            debug("Save Stub\n");
            //TODO really save the document
            document.modified = false;
            set_busy_status();
        }
        
        public void on_save_as(SimpleAction action, Variant? parameter) {
            FileChooserDialog fcd = new FileChooserDialog(_("Save as"), null, FileChooserAction.SAVE, 
                                    AppConstants.GTK_CANCEL, ResponseType.CANCEL,
                                    AppConstants.GTK_SAVE_AS, ResponseType.ACCEPT);
            if (fcd.run () == ResponseType.ACCEPT) {
//                open_file (file_chooser.get_filename ());
                debug("Saving to %s\n", fcd.get_filename ());
                
                //TODO actually save the document
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
            document.undo_history.undo();
//            nap(100);
            update_status();
        }
        
        public void on_redo(SimpleAction action, Variant? parameter) {
            document.undo_history.redo();
//            nap(100);
            update_status();
        }
        
        public void on_cut(SimpleAction action, Variant? parameter) {
            debug("Cut Stub\n");
        }
        
        public void on_copy(SimpleAction action, Variant? parameter) {
            debug("Copy Stub\n");
        }
        
        public void on_paste(SimpleAction action, Variant? parameter) {
            debug("Paste Stub\n");
        }
        
        public void on_delete(SimpleAction action, Variant? parameter) {
            debug("Delete Stub\n");
        }
        
        public void on_preferences(SimpleAction action, Variant? parameter) {
            debug("Preferences Stub\n");
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
        }
        
        public void on_toggle_statusbar(SimpleAction action, Variant? parameter) {
            var active = action.get_state ().get_boolean ();
            action.set_state (new Variant.boolean (!active));
            main_statusbar.visible = !active;
        }
        
//        paint tools
        public void on_paint_pencil(SimpleAction action, Variant? parameter) {
            debug ("Selected pencil\n");
        }
        
        public void on_paint_eraser(SimpleAction action, Variant? parameter) {
            debug ("Selected eraser\n");
        }
        
        public void on_document_add(SimpleAction action, Variant? parameter) {
            debug("Document add\n");
            
            if (document.active_element is Document.Layer) {
//            add a sibling Layer at the same level
                var layer = new Document.Layer(document.width, document.height, document.mode);
                document.add_sibling(layer, document.active_element_iter);
            }
            else if (document.active_element is Document.Frame) {
//            add a sibling Layer at the same level
                var frame = new Document.Frame();
                var frame_iter = document.add_sibling(frame, document.active_element_iter);
//                then some children
                var layer = new Document.Layer(document.width, document.height, document.mode);
                document.add(layer, frame_iter);
            }
            else if (document.active_element is Document.Animation) {
                var anim = new Document.Animation();
                var iter = document.add_sibling(anim, document.active_element_iter);
                
                var frame = new Document.Frame();
                iter = document.add(frame, iter);
                
                var layer = new Document.Layer(document.width, document.height, document.mode);
                document.add(layer, iter);
            }
            else if (document.active_element is Document.Sprite) {
                var sprite = new Document.Sprite();
                var iter = document.add_sibling(sprite, document.active_element_iter);
                
                var anim = new Document.Animation();
                iter = document.add(anim, iter);
                
                var frame = new Document.Frame();
                iter = document.add(frame, iter);
                
                var layer = new Document.Layer(document.width, document.height, document.mode);
                document.add(layer, iter);
            }
        }
        
        public void on_document_remove(SimpleAction action, Variant? parameter) {
            debug("Document remove\n");
        }
        
        public void on_document_duplicate(SimpleAction action, Variant? parameter) {
            debug("Document duplicate\n");
        }
        
        public void on_document_raise(SimpleAction action, Variant? parameter) {
            debug("Document raise\n");
        }
        
        public void on_document_lower(SimpleAction action, Variant? parameter) {
            debug("Document lower\n");
        }
    }
}

