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
using FreeImage;

namespace SpriteHut.Imaging
{
    public class FreeImageImage : Imaging.Image
    {
        private FreeImage.Bitmap _bitmap;

        public FreeImageImage (int width, int height, int bpp)
        {
            base(width, height, bpp);
//            int bpp = (mode == Mode.INDEXED) ? 8 : 32 ;
            _bitmap = new FreeImage.Bitmap(width, height, bpp);
        }
        
        public FreeImageImage.from_pixel_data (int width, int height, int bpp, uint8* pixel_data)
        {
            base(width, height, bpp);
//            int pitch = ((((bpp * width) + 31) / 32) * 4);
            int pitch = bpp/8 * width;
            _bitmap = FreeImage.convert_from_raw_bits(pixel_data, width, height, pitch, bpp, 0, 0, 0, true);
        }
        
        public override uint8* get_pixel_data()
        {
            return _bitmap.get_bits();
        }

        public override RGBA get_pixel_color(int x, int y)
        {
            RGBA rgba = RGBA();
            
            switch (mode) {
                case Mode.INDEXED:
                    uint8 index = 0;
                    _bitmap.get_pixel_index(x, this.height-1-y, ref index);
                    rgba = palette.color_list[index];
                    stdout.printf("%u:(%f %f %f %f)\n", index, rgba.red, rgba.green, rgba.blue, rgba.alpha);
                    break;
                case Mode.RGB:
                    break;
                case Mode.RGBA:
                    RgbQuad rgbquad = RgbQuad();
                    _bitmap.get_pixel_color(x, this.height-1-y, ref rgbquad);
                    rgba = convert_rgbquad_to_rgba(rgbquad);
                    break;
            }
            
            return rgba;
        }

        private RGBA convert_rgbquad_to_rgba(RgbQuad orig)
        {
            RGBA dest = RGBA();

            int max_per_component = 255;
            dest.red = (double) orig.rgbRed / (double) max_per_component;
            dest.green = (double) orig.rgbGreen / max_per_component;
            dest.blue = (double) orig.rgbBlue / max_per_component;
            dest.alpha = (double) orig.rgbReserved / max_per_component;

            return dest;
        }

        public override uint8 get_index(int x, int y)
        {
            uint8 index = 0;
            _bitmap.get_pixel_index(x, y, ref index);
            return index;
        }

        public override Image to_rgba()
        {
            Image converted = new FreeImageImage(width, height, 32);
            converted.has_alpha = true;
//            converted._bitmap = _bitmap.convert_to_32_bits();
            return converted;
        }
    }
}
