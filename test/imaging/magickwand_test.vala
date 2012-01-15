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
using ImageMagick;

        
public class TestMagickWand : Object {
    public static void test_indexed () {
        
        Wand wand = new Wand();
//        Wand.Genesis();
        ulong width, height, num_colors;
        assert (wand.read_image("imaging/indexed.png") == true); //loading succesful;
        wand.display_image("");
        
        width = wand.get_image_width();
        height = wand.get_image_height();
        num_colors = wand.get_image_colors();
        debug("width: %lu", width);
        debug("height: %lu", height);
        debug("#colors: %lu", num_colors);
        
        PixelWand color = new PixelWand();
        for (int i = 0; i < 256; i++) {
            
            wand.get_image_colormap_color(i, color);
//            debug("Color index %i: (%f, %f, %f, %f)", i, color.get_red(), color.get_green(), color.get_blue(), color.get_alpha() );
            debug("Color index %i: %s", i, color.get_color_as_string());
//            wand.set_image_colormap_color(i, color);
        }
        
        // Changing colors
        PixelWand target = new PixelWand();
        target.set_blue(1.0);
        
        color.set_red(1.0);
        color.set_green(1.0);
        color.set_blue(0.0);
        color.set_alpha(0.5);
        
        wand.get_image_pixel_color(15,15, color);
        debug("Color at 15,15 : %s Index at 15,15: %lu", color.get_color_as_string(), color.get_index());
        var color2 = new PixelWand();
        wand.get_image_pixel_color(0,0, color2);
        debug("Color at 0,0 :%s Index at 0,0: %lu", color2.get_color_as_string(), color2.get_index()); 
//        wand.set_image_colormap_color(1, color);
//        color.set_index(1);
//        debug ("color index:%lu", color.get_index());
//        wand.opaque_paint_image(target, color, 0, false);
//        wand.clut_image(wand);
        wand.separate_image_channel(ChannelType.IndexChannel);
        wand.display_image("");
        
        ImageType image_type = wand.get_image_type();
        
        debug("Image type: %s",image_type.to_string());
        wand.write_image("imaging/indexed.gif");
        
//        uint8* pixels = new uint8[width*height*4];
        uint8* pixels = new uint8[width*height];
//        assert (wand.export_image_pixels(0,0, wand.get_image_width(), wand.get_image_height(), "RGBA", 1/*CharPixel*/, pixels) == true);
        assert (wand.export_image_pixels(0,0, wand.get_image_width(), wand.get_image_height(), "K", 1/*CharPixel*/, pixels) == true);
        
        debug("Before:\n");
//        debug("pixels.length: %u", len(pixels));
        for (int i=0; i < height; i++)
        {
            for (int j=0; j < width; j++) {
                stdout.printf("%u ", pixels[j+i*width]);
            }
            stdout.printf("\n");
        }
        
        Wand wand2 = new Wand();
        wand2.new_image(width, height, color);
        
        for (int i=0; i < num_colors; i++)
        {
            pixels[i] = (uint8) i;
        }
        
        debug("After:\n");
        for (int i=0; i < height; i++)
        {
            for (int j=0; j < width; j++) {
                stdout.printf("%u ", pixels[j+i*width]);
            }
            stdout.printf("\n");
        }
//        assert (wand2.import_image_pixels(0, 0, wand.get_image_width(), wand.get_image_height(), "RGBA", 1, pixels) == true);
        assert (wand2.import_image_pixels(0, 0, wand.get_image_width(), wand.get_image_height(), "K", 1, pixels) == true);
        debug("#colors wand2: %lu", wand2.get_image_colors() );
        wand2.clut_image(wand);
        
        wand2.display_image("");
        delete pixels;
//        debug("Image type: %s", image_type.to_string());
//        Wand.Terminus();
    }
    
    public static void test_to_rgba () {
        Image image = new CairoImage(16, 16);
        Image rgba_copy = image.to_rgba();
        assert (image.mode == Image.Mode.RGBA);
    }

    public static void add_tests()  {
        Test.add_func ("/imaging/Wand.get_pixel(x, y)", test_indexed);
        //Test.add_func ("/imaging/image.to_rgba", test_to_rgba);
    }
}
