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

/**
 * A helper class to store useful constant values across the app, such as
 * deprecated GTK+ stock strings.
 * 
 * This is to avoid magical strings, provide autocomplete and centralize them
 * all in case of typos.
 *
 */
namespace SpriteHut.AppConfig {
    public class AppConstants {
        // Sprite Hut constants
        public static const string APP_ID = "io.jjbernal.spritehut";
        public static const string APP_NAME = "Sprite Hut";
        
        // GTK+ 3 Deprecated constants
        public static const string GTK_CANCEL = "gtk-cancel";
        public static const string GTK_OPEN = "gtk-open";
        public static const string GTK_SAVE_AS = "gtk-save-as";
        public static const string GTK_STOP = "gtk-stop";
    }
}
