/*
** Copyright © 2016 Juan José Bernal Rodríguez <juanjose.bernal.rodriguez@gmail.com>
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

using SpriteHut.Core;
using SpriteHut.Utils;
using SpriteHut.Gui;
using Gtk;

public class TestSpriteHutApp : Object {
    public static void test_quit () {
        var app = new SpriteHutApp(SpriteHut.Utils.AppConstants.APP_ID, GLib.ApplicationFlags.FLAGS_NONE);
        string[] args={"spritehut"};
        //for (int i = 0; i < 2; ++i) {
            int result = app.run(args);
            app.quit();
        //}
    }

    public static void add_tests()  {
        Test.add_func ("/Data/SpriteHutAPP.quit() no segfault", test_quit);
    }
}
