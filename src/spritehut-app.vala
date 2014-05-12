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
//using Cairo;
//using Widgets;

namespace Widgets {
    public class SpriteHutApp : Gtk.Application
    {
        AboutDialog about;
        
        /* Create the application actions. */
        const GLib.ActionEntry[] actions = {
            { "new", on_new },
            { "open", on_open },
            { "help", on_help },
            { "about", on_about },
            { "preferences", on_preferences },
            { "quit", on_quit }
        };
        
        void on_new (SimpleAction action, Variant? parameter) {
            NewDialog new_dialog = new NewDialog();
            
            int response = new_dialog.run();
            
            if (response == ResponseType.OK) {
                stdout.printf("Creating New Document: \nwidth: %uheight:  mode: \n", new_dialog.width());
                
                var document = new Document.BlankDocument();
                document.name = "Noname000.spritehut";
                
                var window = new Widgets.MainWindow(this, document);
                
                window.show();
            }
            
            new_dialog.destroy();
        }
        
        void on_open(SimpleAction action, Variant? parameter) {
            FileChooserDialog fcd = new FileChooserDialog(null, null, FileChooserAction.OPEN,Stock.CANCEL, ResponseType.CANCEL,
                                      Stock.OPEN, ResponseType.ACCEPT);
            if (fcd.run () == ResponseType.ACCEPT) {
    //                open_file (file_chooser.get_filename ());
                stdout.printf("Loading %s\n", fcd.get_filename ());
            }
            
            fcd.destroy();
        }
        
        void on_help(SimpleAction action, Variant? parameter) 
        {
            print ("You clicked \"Help contents\"\n");
        }
        
        void on_about(SimpleAction action, Variant? parameter) 
        {
            about.run();
            about.hide();
        }
        
        void on_preferences (SimpleAction action, Variant? parameter) {
            print ("You clicked \"Preferences\"\n");
        }

        void on_quit (SimpleAction action, Variant? parameter) {
            print ("You clicked \"Quit\"\n");
            foreach (Gtk.Window window in this.get_windows())
            {
                ((MainWindow) window).close_intent();
            }
//            this.quit ();  //**Bug #674090**
        }
        
        public SpriteHutApp (string app_id, ApplicationFlags flags)
        {
            Object (application_id: app_id, flags: flags);
        }
        
        public override void activate()
        {
            new Widgets.MainWindow(this, null).show();
        }
        
        protected override void startup () {
            base.startup ();
            
            this.add_action_entries (actions, this);
            
//            string main_window_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
//                                                 "mainmenubar.ui", null );
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
//            this.menubar = builder.get_object ("main-menubar") as MenuModel;
        }
        
    }
}

