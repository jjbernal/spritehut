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

namespace Controllers
{
    class About : Object
    {
        private Gtk.AboutDialog window;
    
        public About ()
        {
            try {
	            string about_window_path = GLib.Path.build_filename( Config.PKGDATADIR, "ui",
										     "aboutdialog.ui", null );
										     
                var builder = new Builder ();
                builder.add_from_file (about_window_path);
                
                
				builder.add_from_file(about_window_path);
				window = builder.get_object ("about-dialog") as Gtk.AboutDialog;
				
				builder.connect_signals (this);
                
            } catch (Error e) {
                stderr.printf ("Could not load UI: %s\n", e.message);
            } 
        }
        
        public void run () {
            window.run();
            window.destroy();
        }
    }
}

