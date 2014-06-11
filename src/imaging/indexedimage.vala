/*
** Copyright © 2011-2014 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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

namespace Imaging
{
/**
* An indexed image implementation of Image
*
* @since 0.1
*/
    public class IndexedImage : Imaging.Image
    {
        
        public override Image.Mode mode {
            get
            {
                return Image.Mode.INDEXED;
            }
        }
        
        public Palette palette {get;set;}
        
        private Cairo.ImageSurface _cairo_surface = null;
        public Cairo.ImageSurface cairo_surface{
            get {
                if (_cairo_surface == null) {
                    to_cairo_surface_RGBA();
                    return _cairo_surface;
                }
                else {
                    return _cairo_surface;
                }
            }
            set {
                _cairo_surface = value;
            }
        }
        
        
        public IndexedImage (uint width, uint height, uint bpp=8)
        {
            base(width, height, bpp);
            this.pixel_data = new uint8[width*height*bpp/8];
        }
        
        public IndexedImage.from_pixel_data (uint width, uint height, uint bpp=8, uint8* pixel_data)
        {
            base(width, height, bpp);
            this.pixel_data = pixel_data;
        }
        
        ~IndexedImage () {
//            delete pixel_data;
        }
        
        public override RGBA get_pixel_color(int x, int y)
        {
            RGBA rgba = RGBA();
            
            uint8 index = pixel_data[width*y+x];
            
            rgba = palette.color_list[index];
//            stdout.printf("\n%u:(%f %f %f %f)", index, rgba.red, rgba.green, rgba.blue, rgba.alpha);
            
            return rgba;
        }

        public override uint8 get_index(int x, int y)
        {
            return pixel_data[width*y+x];
        }
        
        private void to_cairo_surface_RGBA() {
            int stride = (int) width*4;

            uint8 *indexed_data = pixel_data;
            uint8 *colored_data = new uint8[width*height*4];
            
            int i = 0;
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
            
//            Image rgba32_image = new CairoImage(width, height, 32);
            _cairo_surface = new ImageSurface.for_data((uchar[]) colored_data, Format.ARGB32, (int) width, (int) height, stride);
            
//            return rgba32_image;
        }
    }
}
