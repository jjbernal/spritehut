/*
** Copyright © 2011-2014, 2016 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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

namespace SpriteHut.Gui
{
    public class NewDialogController : Object
    {
        public Gtk.Dialog window;
        private Gtk.Adjustment width_adjustment;
        private Gtk.Adjustment height_adjustment;
        private Gtk.ComboBox mode_combobox;
        //private Imaging.Image.Mode mode;
    
        public NewDialogController ()
        {
            try {
                string about_window_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
                                             "newdocumentdialog.ui", null );
                 
                var builder = new Builder ();
                
                builder.add_from_file(about_window_path);
                window = builder.get_object ("new-document-dialog") as Gtk.Dialog;
                width_adjustment = builder.get_object ("width-adjustment") as Gtk.Adjustment;
                height_adjustment = builder.get_object ("height-adjustment") as Gtk.Adjustment;
                mode_combobox = builder.get_object ("mode-combobox") as Gtk.ComboBox;
                
                
                builder.connect_signals (this);
                
            } catch (Error e) {
                stderr.printf ("Could not load UI: %s\n", e.message);
            } 
        }
        
        public int run()
        {
            int response = window.run();
            
            return response;
        }
        
        public void destroy()
        {
            window.destroy();
        }
        
        public uint width () {
            return (uint) width_adjustment.value;
        }
    }
}

