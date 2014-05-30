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

namespace Document
{
    public class Animation : GLib.Object, IDocumentElement
    {
//        IDocumentElement properties
        public string name {get;set;default=_("Animation1");}
        public Gdk.Pixbuf thumbnail {get;set;}
        
        public enum Mirror {
            NONE,
            HORIZONTAL,
            VERTICAL;
        }
        
        public enum Loop {
            NONE,
            REPEAT,
            PINGPONG;
        }
        
        public static double default_fps {get;set;default=25.0;}
        
        private double _fps;
        

        
        public double fps
        {
            get
            {
                return _fps;
            }
            
            set
            {
                if (value < 0)
                {
                    _fps = 0;
                }
                else
                {
                    _fps = value;
                }
            }
        }
        
        public Mirror mirror {get;set;default=Mirror.NONE;}
        public Loop loop {get;set;default=Loop.NONE;}
        
        public Animation ()
        {
            fps = Animation.default_fps;
        }
    }
}

