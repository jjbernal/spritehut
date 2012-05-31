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
using SDL;
using SDLGraphics;
using Gdk;
/**
* Imaging namespace
*/
namespace Imaging
{
    /**
     * SDL Drawing class
     *
     */
    public class SDLDrawing
    {
        public void line(Image image, int16 x1, int16 y1, int16 x2, int16 y2, RGBA rgba)
        {
            SDL.Surface dst = convert_to_sdl_surface(image);
            SDL.Color color = convert_to_sdl_color(rgba);
            
            SDLGraphics.Line.rgba(dst, x1, y1, x2, y2, color.r, color.g, color.b, color.unused);
            image.pixel_data = (uint8*) dst.pixels;
        }
        
        public void ellipse(Image image, int16 x1, int16 y1, int16 x2, int16 y2, RGBA rgba)
        {
            SDL.Surface dst = convert_to_sdl_surface(image);
            SDL.Color color = convert_to_sdl_color(rgba);
            
            int16 dx = (x2-x1)/2;
            int16 dy = (y2-y1)/2;
            
            int16 xc = x1 + dx;
            int16 yc = y1 + dy;
            
            SDLGraphics.Ellipse.outline_rgba(dst, xc, yc, dx, dy, color.r, color.g, color.b, color.unused);
            image.pixel_data = (uint8*) dst.pixels;
        }
        
        private SDL.Surface convert_to_sdl_surface(Image image)
        {
            int pitch = (int)(image.width * image.bpp/8);
            
            Surface dst = new Surface.from_RGB((void*) image.pixel_data, (int) image.width, (int) image.height, (int) image.bpp, pitch, (uint32)0x00ff0000, (uint32)0x0000ff00, (uint32)0x000000ff, (uint32)0xff000000);
            
            if (image.mode == Image.Mode.INDEXED) {
                SDL.Color[] colors = convert_to_sdl_palette(image.palette);
                dst.set_palette(PaletteFlags.LOGPAL, colors);
            }
            
            return dst;
        }
        
        private SDL.Color[] convert_to_sdl_palette(Imaging.Palette palette)
        {
            SDL.Color[] output = new SDL.Color[palette.color_list.size];
            int i = 0;
            foreach (RGBA rgba in palette.color_list)
            {
                output[i].r = convert_component(rgba.red);
                output[i].g = convert_component(rgba.green);
                output[i].b = convert_component(rgba.blue);
                output[i].unused = convert_component(rgba.alpha);
                i++;
            }
            
            return output;
        }
        
        private SDL.Color convert_to_sdl_color(RGBA rgba)
        {
            SDL.Color output = {
            convert_component(rgba.red),
            convert_component(rgba.green),
            convert_component(rgba.blue),
            convert_component(rgba.alpha)
            };
            
            return output;
        }
        
        private uchar convert_component(double component)
        {
            return (uchar) (component*255);
        }
    }
}
