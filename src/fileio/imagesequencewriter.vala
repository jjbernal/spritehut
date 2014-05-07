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
using Document;
using Xml;
using Gtk;
using Gee;

namespace FileIO
{
    /**
    * Image Sequence Writer
    */
    public class ImageSequenceWriter : Object
    {
        /**
         * Saves document frames to an image sequence
         * 
         * @param document The document to save frames from
         * @param filename The file name, including complete path. This includes the text pattern for the images e.g: "%s_%a_%f.png" produces a sequence like "sprite1_anim1_000.png", "sprite1_anim1_001.png" and so on
         * @param anims The animations to export. By default all animations will be exported
         * @param pattern The text pattern for the exported image files.
         */
         
        public void save (Document.Document document, string pattern, Animation[] anims = null) throws IOError{
            //foreach anim in anims do write each frame using pattern
        }
    }
}
