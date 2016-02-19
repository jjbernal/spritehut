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
using Widgets;

namespace SpriteHut.Core {
    public class SpriteHutApp : Gtk.Application
    {
        private PreferencesManager preferences_man = new PreferencesManager();
        private AboutDialog about;
        private string default_document_name = _("Untitled");
        private static uint open_documents_in_this_session = 0;
        /* Create the application actions. */
        const GLib.ActionEntry[] actions = {
            { "new", on_new },
            { "open", on_open },
            { "help", on_help },
            { "about", on_about },
            { "preferences", on_preferences },
            { "quit", on_quit }
        };
        
        private Document.Document create_default_document()
        {
            var document = new Document.BlankDocument();
            ++open_documents_in_this_session;
            document.name = default_document_name + open_documents_in_this_session.to_string();
                
            return document;
        }
        
        void on_new (SimpleAction action, Variant? parameter) {
            NewDialog new_dialog = new NewDialog();
            
            int response = new_dialog.run();
            
            if (response == ResponseType.OK) {
                info("Creating New Document: \nwidth: %uheight:  mode: \n", new_dialog.width());
                
                var document = create_default_document();
                
                var window = new Widgets.MainWindow(this, document);
                
                window.show();
            }
            
            new_dialog.destroy();
        }
        
        void on_open(SimpleAction action, Variant? parameter) {
            FileChooserDialog fcd = new FileChooserDialog(_("Open"), null, FileChooserAction.OPEN,Stock.CANCEL, ResponseType.CANCEL,
                                      Stock.OPEN, ResponseType.ACCEPT);
            if (fcd.run () == ResponseType.ACCEPT) {
    //                open_file (file_chooser.get_filename ());
                info("Loading %s\n", fcd.get_filename ());
            }
            
            fcd.destroy();
        }
        
        void on_help(SimpleAction action, Variant? parameter) 
        {
            info ("You clicked \"Help contents\"\n");
        }
        
        void on_about(SimpleAction action, Variant? parameter) 
        {
            about.run();
            about.hide();
        }
        
        void on_preferences (SimpleAction action, Variant? parameter) {
            info ("You clicked \"Preferences\"\n");
        }

        void on_quit (SimpleAction action, Variant? parameter) {
            info ("You clicked \"Quit\"\n");
            foreach (Gtk.Window window in this.get_windows())
            {
                ((MainWindow) window).close_intent();
            }
//            this.quit ();
        }
        
        public SpriteHutApp (string app_id, ApplicationFlags flags)
        {
            Object (application_id: app_id, flags: flags);
        }
        
        public override void activate()
        {
            var document = create_default_document();
            new Widgets.MainWindow(this, document).show();
        }
        
        protected override void startup () {
            base.startup ();
            
            this.add_action_entries (actions, this);
            
            string main_window_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
                                                 "aboutdialog.ui", null );
                                                 
            var builder = new Builder ();
            
            try {
                builder.add_from_file (main_window_path);
            }
            catch (Error e) {
                error ("Unable to load file: %s", e.message);
            }
            
            about = builder.get_object ("about-dialog") as AboutDialog;

            add_accelerators();
            
            preferences_man.load();
        }
        
        private void add_accelerators(){
            add_accelerator("<Control><Shift>s", "win.save-as", null);
            add_accelerator("KP_Add", "win.zoom-in", null);
            add_accelerator("KP_Subtract", "win.zoom-out", null);
            add_accelerator("<Ctrl>0", "win.normal-size", null);
        }
        
    }
}

