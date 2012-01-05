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

using Gtk;
using Cairo;
using Widgets;
using Controllers;

public class SpriteHut.App : Gtk.Application
{
	public App (string app_id, ApplicationFlags flags)
	{
	    GLib.Object (application_id: app_id, flags: flags);
	}
	
	public void on_app_activate()
	{
	    var main_window = new Widgets.MainWindow();
	    main_window.document = new Document.BlankDocument();
	    Controllers.Main main_controller = new Controllers.Main(main_window);
	    
	    this.add_window(main_window);
	}
}
