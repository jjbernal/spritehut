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

namespace Document
{
    public class Layer : IDocumentElement
    {
        static uint stamp = 1;
        
        private double _opacity;
        public Image image; //TODO create Image class
        
        public double opacity
        {
            get
            {
                return _opacity;
            }
            
            set
            {
                _opacity = value;
                
                if (value > 1) {
                    _opacity = 1;
                } else if (value < 0) {
                    _opacity = 0;
                }
            }
        }
        
        public Layer (uint width, uint height, Image.Mode mode)
        {
            opacity = 1;
            this.name = stamp_name(_("Layer"), ref stamp);
            //image = TODO: initialize/link image here
            switch (mode) {
                case Image.Mode.INDEXED:
                    image = new IndexedImage(width, height, 8);
                    break;
                case Image.Mode.RGBA:
                    image = new RGBAImage(width, height, 32);
                    break;
                default:
                    image = new RGBAImage(width, height, 32);
                    break;
            }
        }
    }
}

