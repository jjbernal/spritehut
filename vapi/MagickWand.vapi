/* Continued from the vapi in Caméléon
 * 
 */
 
[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename = "ImageMagick/wand/MagickWand.h")]
namespace ImageMagick {
    [CCode (cname="ImageType",type_id="ImageType", cheader_filename = "ImageMagick/magick/image.h")]
    public enum ImageType {
        [CCode (cname="UndefinedType")]
        UNDEFINEDTYPE,
        [CCode (cname="BilevelType")]
        BILEVEL,
        [CCode (cname="GrayscaleType")]
        GRAYSCALE,
        [CCode (cname="GrayscaleMatteType")]
        GRAYSCALEMATTE,
        [CCode (cname="PaletteType")]
        PALETTE,
        [CCode (cname="PaletteMatteType")]
        PALETTEMATTE,
        [CCode (cname="TrueColorType")]
        TRUECOLOR,
        [CCode (cname="TrueColorMatteType")]
        TRUECOLORMATTE,
        [CCode (cname="ColorSeparationType")]
        COLORSEPARATION,
        [CCode (cname="ColorSeparationMatteType")]
        COLORSEPARATIONMATTE,
        [CCode (cname="OptimizeType")]
        OPTIMIZE,
        [CCode (cname="PaletteBilevelMatteType")]
        PALETTEBILEVELMATTE
    }
        
    [Compact]
    [CCode (cname="ChannelType", type_id="ChannelType", cheader_filename = "ImageMagick/magick/magick-config.h")]
    public enum ChannelType {
          UndefinedChannel, RedChannel = 0x0001, GrayChannel = 0x0001, CyanChannel = 0x0001,
          GreenChannel = 0x0002, MagentaChannel = 0x0002, BlueChannel = 0x0004, YellowChannel = 0x0004,
          AlphaChannel = 0x0008, OpacityChannel = 0x0008, MatteChannel = 0x0008, BlackChannel = 0x0020,
          [CCode (cname="IndexChannel", type_id="IndexChannel")]
          IndexChannel = 0x0020,
          AllChannels = 0xff, DefaultChannels = (AllChannels &~ OpacityChannel)
    }
        [Compact]
        [CCode (cname="MagickWand", free_function="DestroyMagickWand", cheader_filename = "ImageMagick/wand/MagickWand.h")]
        public class Wand {
//            extern WandExport ExceptionType;
            
            /* Module magick-wand Methods */
            [CCode (cname="ClearMagickWand")]
            public void clear();
            
            [CCode (cname="CloneMagickWand")]
            public Wand clone();
            
            [CCode (cname="IsMagickWand")]
            public bool is_magick_wand();
            
            [CCode (cname="MagickClearException")]
            public bool clear_exception();
            
            [CCode (cname="MagickGetException")]
//            public string get_exception(ref ExceptionType severity);
            
            [CCode (cname="MagickGetExceptionType")]
//            public ExceptionType get_exception_type();
            
            /* Initialization Methods */
            [CCode (cname="MagickWandGenesis")]
            public static void Genesis();
            
            [CCode (cname="MagickWandTerminus")]
            public static void Terminus();
 
            [CCode (cname="NewMagickWand")]
            public Wand();
            
            /* Module magick-image Methods */
            [CCode (cname="MagickReadImage")]
            public bool read_image(string filename);
 
            [CCode (cname="MagickGetImageWidth")]
            public ulong get_image_width();
                 
            [CCode (cname="MagickGetImageHeight")]
            public ulong get_image_height();
                
            [CCode (cname="MagickGetSize")]
            public bool get_size(ref ulong width, ref ulong height);
            
            [CCode (cname="MagickGetImageColormapColor")]
            public bool get_image_colormap_color(ulong index, PixelWand color);
            
            [CCode (cname="MagickSetImageColormapColor")]
            public bool set_image_colormap_color(ulong index, PixelWand color);
            
            [CCode (cname="MagickGetImageColors")]
            public ulong get_image_colors();
            
            [CCode (cname="MagickWriteImage")]
            public bool write_image(string filename);
            
            
//            [CCode (cname="MagickGetImageColorspace")]
//            public ColorSpace get_image_colorspace();
            
            [CCode (cname="MagickGetImageType")]
            public ImageType get_image_type();
            
//            [CCode (cname="")]
//            public (string filename);
            [CCode (cname="MagickExportImagePixels")]
            public bool export_image_pixels (ulong x, ulong y, ulong columns,
                ulong rows, string map, int storage, void* pixels);
                
            [CCode (cname="MagickImportImagePixels")]
            public bool import_image_pixels(ulong x, ulong y, ulong columns, ulong rows, string map, int storage, void *pixels);
            
            [CCode (cname="MagickDisplayImage")]
            public bool display_image (string server_name);
            
            [CCode (cname="MagickOpaquePaintImage")]
            public bool opaque_paint_image(PixelWand target,PixelWand fill, double fuzz, bool invert);
            
            [CCode (cname="MagickNewImage")]
            public bool new_image(ulong columns, ulong rows, PixelWand background);
            
            [CCode (cname="MagickClutImage")]
            public bool clut_image(Wand clut_wand);
            
            [CCode (cname="MagickGetImagePixelColor")]
            public bool get_image_pixel_color(ulong x,ulong y, PixelWand color);
            
            [CCode (cname="MagickSeparateImageChannel")]
            public bool separate_image_channel(ChannelType channel);
            
            [CCode (cname="MagickSetImageFormat")]
            public bool set_image_format(string format);
            
            [CCode (cname="MagickSetImageDepth")]
            public bool set_image_depth(uint8 depth);
            
            [CCode (cname="MagickSetImageType")]
            public bool set_image_type(ImageType image_type);
        }
        
        [Compact]
        [CCode (cname="PixelWand", free_function="DestroyPixelWand")]
        public class PixelWand {
            [CCode (cname="NewPixelWand")]
            public PixelWand();
            
            [CCode (cname="PixelGetRed")]
            public double get_red();
            
            [CCode (cname="PixelGetGreen")]
            public double get_green();
            
            [CCode (cname="PixelGetBlue")]
            public double get_blue();
            
            [CCode (cname="PixelGetAlpha")]
            public double get_alpha();
            
             [CCode (cname="PixelSetRed")]
            public void set_red(double amount);
            
            [CCode (cname="PixelSetGreen")]
            public void set_green(double amount);
            
            [CCode (cname="PixelSetBlue")]
            public void set_blue(double amount);
            
            [CCode (cname="PixelSetAlpha")]
            public void set_alpha(double amount);
            
            [CCode (cname="PixelGetIndex")]
            public ulong get_index();
            
            [CCode (cname="PixelSetIndex")]
            public void set_index(ulong index);
            
            [CCode (cname="PixelGetColorAsString")]
            public string get_color_as_string();
            
            [CCode (cname="PixelGetBlackQuantum")]
            public uint8 get_black_quantum(PixelWand wand);
        }
}
