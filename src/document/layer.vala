/*
** Copyright (C) 2011-2012 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
**
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation; either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

namespace Document
{
    public class Layer : GLib.Object, IDocumentElement
    {
        public string name {get;set;default=_("Layer1");}
        public bool locked {get;set;default=false;}
        public bool visible {get;set;default=true;}
        //public Image image; TODO create Image class
        public double opacity
        {
            get
            {
                return opacity;
            }
            
            set
            {
                opacity = value;
                
                if (value > 1) {
                    opacity = 1;
                } else if (value < 0) {
                    opacity = 0;
                }
            }
        }
        
        public Layer ()
        {
            opacity = 1;
            //image = TODO: initialize/link image here
        }
    }
}

