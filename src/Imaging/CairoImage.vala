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

using Gdk;
using Cairo;

namespace SpriteHut.Imaging
{
    public class CairoImage: Image {
        public ImageSurface _cairo_surface;
        
        public CairoImage(int width, int height, int bpp)
        {
            base(width, height, bpp);
            this.width = width;
            this.height = height;
            this.bpp = bpp;
            _cairo_surface = new ImageSurface(Format.A8, width, height);
        }
        
        public override Image to_rgba()
        {
            int stride = (int) width*4;

            uint8 *indexed_data = _cairo_surface.get_data();
            uint8 *colored_data = new uint8[width*height*4];
            
            int i = 0;

//            debug("Primer color:%d", indexed_data[0]);

            int j = 0;
            
            for (i=0; i<width*height; i++)
            {
                colored_data[j] = (uint8) palette.color_list [indexed_data[i]].blue * 255;
                colored_data[j+1] = (uint8) palette.color_list[indexed_data[i]].green * 255;
                colored_data[j+2] = (uint8) palette.color_list[indexed_data[i]].red * 255;
                colored_data[j+3] = (uint8) palette.color_list[indexed_data[i]].alpha * 255;
                j=i*4;
            }
//            debug("Index at the end:%d", i);
//            debug("Color al final:%d", indexed_data[i]);
            
            Image rgba32_image = new CairoImage(width, height, 32);
//            rgba32_image._cairo_surface = new ImageSurface.for_data((uchar[]) colored_data, Format.ARGB32, width, height, stride);
            
            return rgba32_image;
        }
        public override uint* get_pixel_data() {
            return _cairo_surface.get_data();
        }
        
        public override RGBA get_pixel_color(int x, int y)
        {   
            uint8 index = get_index(x, y);
            
            return palette.color_list[index];
        }
        
        public override uint8 get_index(int x, int y)
        {
            uint8 *indexed_data = _cairo_surface.get_data();
            return *(indexed_data)+(uint8)(x*width)+(uint8)(y*height);
        }
    }
}
