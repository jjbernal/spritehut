/*
** Copyright © 2016 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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

/*
 * Gtk helper functions
 */
namespace SpriteHut.Gui.GtkHelper {
   /*
    * Gtk.Builder helper function
    * 
    * @param string filename
    * The .ui filename, without base path.
    *
    * @param string widget_name
    * The Widget name
    *
    * @returns The resulting Gtk.Widget
    */
    public Gtk.Widget widget_from_filename_and_name(string filename, string widget_name) {
        
        string main_window_path = GLib.Path.build_filename( Config.PKGDATADIR,
                                     "ui", filename, null );
        var builder = new Builder ();
        
        try {
            builder.add_from_file (main_window_path);
        }
        catch (Error e) {
            error (_("Unable to load ui file: %s"), e.message);
        }
        
        var widget = builder.get_object (widget_name) as Gtk.Widget;
        
        return widget;
        
    }
    
   /*
    * Gtk.Dialog helper function
    * Sets the provided *dialog* as transient for *window*, runs it,
    * destroys it, and returns the response.
    *
    * @param Dialog dialog
    * The dialog to run
    *
    * @param Window window
    * The window to make the dialog transient for
    *
    * @returns The dialog Gtk.ResponseType
    */
    
    public int run_dialog(Dialog dialog, Window window) {
    
        dialog.set_transient_for(window);
        int response = dialog.run();
        dialog.destroy();
        
        return response;
    }
}
