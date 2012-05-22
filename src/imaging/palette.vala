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

using Gee;
using Gdk;

namespace Imaging
{
/**
* Palette class
* 
*
*/
    public class Palette : Object
    {
        public string name {get;set;default=_("Palette1");}
        public Gee.List<Gdk.RGBA?> color_list {get;set;}
        
        public Palette ()
        {
            base();
            color_list = new ArrayList<Gdk.RGBA?>();
        }
        
        /**
         * Helper method to get a Gdk.RGBA from 8bit components
         *
         */
        public static RGBA rgba_from_components(uint8 red, uint8 green, uint8 blue, uint8 alpha)
        {
            RGBA rgba = RGBA();
            
            uint8 max_per_component = 255;
            
            rgba.red = (double) red / max_per_component;;
            rgba.green = (double) green / max_per_component;
            rgba.blue = (double) blue / max_per_component;
            rgba.alpha = (double) alpha / max_per_component;
            
            return rgba;
        }
    }
}

