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
using Imaging;
using FreeImage;
using Gdk;

namespace FileIO
{
    /**
    * FreeImage interface for saving image files
    */
    public class FreeImageWriter: Object, IImageWriter
    {
        /**
         * Saves an image to a file. Creates a file if needed.
         * 
         * @param image The Image to save to disk
         * @param filename The file name, including complete path
         */
        public void save (Image image, string filename) throws IOError {
            int pitch = (int)(image.width * image.bpp/8);
            Bitmap? bitmap = FreeImage.convert_from_raw_bits(image.pixel_data, (int) image.width, (int)image.height, pitch, (int)image.bpp, 0, 0, 0, true);
            
            if (image is IndexedImage) {
                uint8[] transparency_table = new uint8[image.palette.color_list.size];
                
                RgbQuad *pal = bitmap.get_palette();
                int i = 0;
                foreach (RGBA color in image.palette.color_list)
                {
                    pal[i].rgbRed = (uint8) (color.red * 255);
                    pal[i].rgbGreen = (uint8) (color.green * 255);
                    pal[i].rgbBlue = (uint8) (color.blue * 255);
                    transparency_table[i] = (uint8) (color.alpha * 255);
                    stdout.printf("\n(%u, %u, %u, %u)", pal[i].rgbRed, pal[i].rgbGreen, pal[i].rgbBlue, transparency_table[i]);
                    i++;
                }
                
                bitmap.set_transparency_table(transparency_table, image.palette.color_list.size);
                bitmap.set_transparent(true);
            }
            else if (image is RGBAImage) {
                //nothing extra to do
            }
            
            Format fif = FreeImage.get_format_from_filename(filename);
            
            if (!FreeImage.save(fif, bitmap, filename)) {
                throw new IOError.FILE_NOT_FOUND(_(@"Could not save $filename. Check that you have write permissions and there is enough free disk space"));
            }
        }
    }
}

