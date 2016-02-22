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
using Gdk;

namespace SpriteHut.Utils
{
    public class PreferencesManager : Object
    {
    
        public void load()
        {
            var res_dir_helper = ResourceDirHelper.get_instance();
//            debug (res_dir_helper.user_dir["config"]);
//            debug (res_dir_helper.user_dir["data"]);
//            debug (res_dir_helper.user_dir["autosave"]);
//            debug (res_dir_helper.user_dir["backgrounds"]);
//            debug (res_dir_helper.user_dir["brushes"]);
//            debug (res_dir_helper.user_dir["plugins"]);
//            debug (res_dir_helper.user_dir["templates"]);
            res_dir_helper.make_directories_with_parents();
            
            // List xinput devices
            Gdk.Display display = Display.get_default ();
            Gdk.DeviceManager device_manager = display.get_device_manager();
            
            List<weak Gdk.Device> device_list = device_manager.list_devices (Gdk.DeviceType.SLAVE);
            
            foreach (Gdk.Device device in device_list) {
                if (device.input_source != InputSource.KEYBOARD) {
                    debug ("%s Source: %s Mode: %s", device.get_name(), device.input_source.to_string(), device.get_mode().to_string());
                    
                    
                    int axes = device.get_n_axes();
                    for (int i = 0; i < axes; ++i) {
                        debug ("Axis #%i: %s", i, device.get_axis_use(i).to_string());
                    }
                }
            }
        }
        
        public void save()
        {

        }
    }
}

