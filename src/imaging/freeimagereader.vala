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
using FreeImage;

namespace Imaging
{
    /**
    * FreeImage implementation of the IImageLoader interface
    *
    * @since 0.1
    */
    public class FreeImageReader : Object
    {
        /**
         * Loads an image from a file
         * 
         * @param filename The file name, including complete path  
         * @return An Image loaded from the specified file
         */
        public Image load (string filename)
        {
            Image? image = null;
            Bitmap? bitmap = generic_load(filename);
            
            if (bitmap != null) {
                ColorType color_type = bitmap.get_color_type();
                switch (color_type) {
                    case ColorType.PALETTE:
                        image = convert_to_indexed(ref bitmap);
                        break;
                    case ColorType.RGB:
                    case ColorType.RGBALPHA:
                        image = convert_to_rgba(ref bitmap);
                        break;
                }
            }
            
            return image;
        }
        
        private Image convert_to_rgba(ref Bitmap bitmap)
        {
            bitmap.flip_vertical();
            
            if (bitmap.get_bpp() < 32) {
                bitmap = bitmap.convert_to_32_bits();
            }
            
            uint8* pixel_array = bitmap.get_bits();
            
            Image image = new RGBAImage.from_pixel_data(bitmap.get_width(), bitmap.get_height(), bitmap.get_bpp(), pixel_array);
            
            return image;
        }
        
        private Image convert_to_indexed(ref Bitmap bitmap)
        {
            // copy bitmap data
            // save transparent index for later (is lost in conversion)
            int ti = -1;
            if (bitmap.is_transparent()){
                ti = bitmap.get_transparent_index();
            }
            
            bitmap.flip_vertical();
            if (bitmap.get_bpp() < 8) {
                bitmap = bitmap.convert_to_8_bits();
            }
            
            uint8* pixel_array = bitmap.get_bits();
            Image image = new IndexedImage.from_pixel_data(bitmap.get_width(), bitmap.get_height(), bitmap.get_bpp(), pixel_array);
            
            image.palette = new Palette();
            
            // copy palette
            RgbQuad *pal = bitmap.get_palette();
            uint num_colors = bitmap.get_colors_used();
            
            int i = 0;
            RGBA last_rgba = RGBA();
//            RGBA rgba = convert_rgbquad_to_rgba(pal[i]);
            RGBA rgba = Palette.rgba_from_components(pal[i].rgbRed, pal[i].rgbGreen, pal[i].rgbBlue, 255);
            // we stop adding colors when we find 2 consecutive equal ones
            do
            {
                image.palette.color_list.add(rgba);
                
                i++;
//                rgba = convert_rgbquad_to_rgba(pal[i]);
                rgba = Palette.rgba_from_components(pal[i].rgbRed, pal[i].rgbGreen, pal[i].rgbBlue, 255);
                
                last_rgba = image.palette.color_list[i-1];
            } while (last_rgba != rgba && i < num_colors);
            
            // finally, we set the transparent index, if present
            if (ti != -1) {
                RGBA transparent = image.palette.color_list[ti];
                transparent.alpha = 0;
                image.palette.color_list[ti] = transparent;
            }
            
            return image;
        }
        
//        private RGBA convert_rgbquad_to_rgba(RgbQuad orig)
//        {
//            RGBA dest = RGBA();
//            
//            int max_per_component = 255;
//            dest.red = (double) orig.rgbRed / (double) max_per_component;
//            dest.green = (double) orig.rgbGreen / max_per_component;
//            dest.blue = (double) orig.rgbBlue / max_per_component;
//            // 
//            dest.alpha = 1;
//            
//            return dest;
//        }
        
        /*
         * Translated from the FreeImage documentation
         */
        private Bitmap? generic_load(string filename, int flag = 0)
        {
            Format fif = Format.UNKNOWN;
            // check the file signature and deduce its format
            // (the second argument is currently not used by FreeImage)
            fif = FreeImage.get_file_type(filename);
            
            if (fif == Format.UNKNOWN) {
                // no signature ?
                // try to guess the file format from the file extension
                fif = FreeImage.get_format_from_filename(filename);
            }
            // check that the plugin has reading capabilities ...
            if ((fif != Format.UNKNOWN) && fif.supports_reading()) {
                // ok, let's load the file
                Bitmap dib = FreeImage.load(fif, filename, flag);
                // unless a bad file format, we are done !
                return dib;
            }
            return null;
        }
    }
}
