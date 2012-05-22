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

using Gdk;

namespace Imaging
{
/**
* An indexed image implementation of Image
*
* @since 0.1
*/
    public class RGBAImage : Imaging.Image
    {
        public uint8* pixel_data { get; set; }
        
        public Image.Mode mode {
            get
            {
                return Image.Mode.INDEXED;
            }
        }
        
        public RGBAImage (uint width, uint height, uint bpp=8)
        {
            base(width, height, bpp);
            pixel_data = new uint8[width*height];
        }
        
        public RGBAImage.from_pixel_data (uint width, uint height, uint bpp=8, uint8* pixel_data)
        {
            base(width, height, bpp);
            this.pixel_data = pixel_data;
        }
        
        ~RGBAImage () {
//            delete pixel_data;
        }
        
        public override uint8* get_pixel_data()
        {
            return pixel_data;
        }
        
        public override RGBA get_pixel_color(int x, int y)
        {
            RGBA rgba = RGBA();
            
            // get the color components
            uint bytes_per_pixel = bpp / 8;
            uint first_byte = (width*y+x)*bytes_per_pixel;
            uint8 b = pixel_data[first_byte];
            uint8 g = pixel_data[first_byte+1];
            uint8 r = pixel_data[first_byte+2];
            uint8 a = pixel_data[first_byte+3];
            
            rgba = Palette.rgba_from_components(r, g, b, a);
//            stdout.printf("\n(%d,%d):(%f %f %f %f)", x, y, rgba.red, rgba.green, rgba.blue, rgba.alpha);
            
            return rgba;
        }
        
        public override uint8 get_index(int x, int y)
        {
            return 0;
        }
    }
}
