/*
** Copyright © 2014, 2016 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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
using Gee;

namespace SpriteHut.Utils
{
    public class ResourceDirHelper : Object
    {
        public Map<string, string> user_dir {get;set;}
        private static ResourceDirHelper instance_;
        
        public static ResourceDirHelper get_instance() {
            if (instance_ == null) {
                instance_ = new ResourceDirHelper();
            }
            
            return instance_;
        }
        
        private static ResourceDirHelper() {
            user_dir = new HashMap<string, string> ();
            
            user_dir["autosave"] = Path.build_filename(Environment.get_user_data_dir(), Config.GETTEXT_PACKAGE, "autosave");
            user_dir["backgrounds"] = Path.build_filename(Environment.get_user_data_dir(), Config.GETTEXT_PACKAGE, "backgrounds");
            user_dir["brushes"] = Path.build_filename(Environment.get_user_data_dir(), Config.GETTEXT_PACKAGE, "brushes");
            user_dir["config"] = Path.build_filename(Environment.get_user_config_dir(), Config.GETTEXT_PACKAGE);
            user_dir["data"] = Path.build_filename(Environment.get_user_data_dir(), Config.GETTEXT_PACKAGE);
            user_dir["plugins"] = Path.build_filename(Environment.get_user_data_dir(), Config.GETTEXT_PACKAGE, "plugins");
            user_dir["templates"] = Path.build_filename(Environment.get_user_data_dir(), Config.GETTEXT_PACKAGE, "templates");
        }
        
        public bool make_directories_with_parents()
        {
            bool result = true;
             
            // make sure that all parent directories exist
            foreach (string directory in user_dir.values) {
                try {
                    File dir = File.new_for_path(directory);
                    if(!dir.query_exists(null)) {
                        result = dir.make_directory_with_parents(null);
                        message ("Creating user directory: %s\n", directory);
                    }
                } catch (Error e) {
                    warning (_("Could not create directory %s"), directory);
                    result = false;
                }
            }
            
            return result;
        }
    }
}

