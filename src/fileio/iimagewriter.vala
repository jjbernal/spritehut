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

namespace FileIO
{
    /**
    * FreeImage interface for saving image files
    */
    public interface IImageWriter : Object
    {
        /**
         * Saves an image to a file. Creates a file if needed.
         * 
         * @param image The Image to save to disk
         * @param filename The file name, including complete path
         */
        public abstract void save (Image image, string filename) throws IOError;
    }
}

