/* gdl-3.0.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "Gdl", gir_namespace = "Gdl", gir_version = "3", lower_case_cprefix = "gdl_")]
namespace Gdl {
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_get_type ()")]
	public class Dock : Gdl.DockObject, Atk.Implementor, Gtk.Buildable {
		public weak Gdl.DockObject root;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public Dock ();
		public void add_floating_item (Gdl.DockItem item, int x, int y, int width, int height);
		public void add_item (Gdl.DockItem item, Gdl.DockPlacement place);
		public void xor_rect (Gdk.Rectangle rect);
		public void xor_rect_hide ();
		[NoAccessorMethod]
		public string default_title { owned get; set; }
		[NoAccessorMethod]
		public bool floating { get; construct; }
		[NoAccessorMethod]
		public int floatx { get; set construct; }
		[NoAccessorMethod]
		public int floaty { get; set construct; }
		[NoAccessorMethod]
		public int height { get; set construct; }
		[NoAccessorMethod]
		public int width { get; set construct; }
		public virtual signal void layout_changed ();
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_bar_get_type ()")]
	public class DockBar : Gtk.Box, Atk.Implementor, Gtk.Buildable, Gtk.Orientable {
		public weak Gdl.Dock dock;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public DockBar (Gdl.Dock dock);
		public Gtk.Orientation get_orientation ();
		public Gdl.DockBarStyle get_style ();
		public void set_orientation (Gtk.Orientation orientation);
		public void set_style (Gdl.DockBarStyle style);
		[NoAccessorMethod]
		public Gdl.DockBarStyle dockbar_style { get; set construct; }
		[NoAccessorMethod]
		public Gdl.DockMaster master { owned get; set; }
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_item_get_type ()")]
	public class DockItem : Gdl.DockObject, Atk.Implementor, Gtk.Buildable {
		public weak Gtk.Widget child;
		public int dragoff_x;
		public int dragoff_y;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public DockItem (string name, string long_name, Gdl.DockItemBehavior behavior);
		public void bind (Gtk.Widget dock);
		public void dock_to (Gdl.DockItem? target, Gdl.DockPlacement position, int docking_param);
		public void hide_grip ();
		public void hide_item ();
		public void iconify_item ();
		public void @lock ();
		public void notify_deselected ();
		public void notify_selected ();
		public void preferred_size (Gtk.Requisition req);
		public void set_default_position (Gdl.DockObject reference);
		public virtual void set_orientation (Gtk.Orientation orientation);
		public void set_tablabel (Gtk.Widget tablabel);
		public void show_grip ();
		public void show_item ();
		public void unbind ();
		public void unlock ();
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public DockItem.with_stock (string name, string long_name, string stock_id, Gdl.DockItemBehavior behavior);
		[NoAccessorMethod]
		public Gdl.DockItemBehavior behavior { get; set; }
		[NoAccessorMethod]
		public bool locked { get; set; }
		[NoAccessorMethod]
		public Gtk.Orientation orientation { get; set construct; }
		[NoAccessorMethod]
		public int preferred_height { get; set; }
		[NoAccessorMethod]
		public int preferred_width { get; set; }
		[NoAccessorMethod]
		public bool resize { get; set; }
		public signal void deselected ();
		public virtual signal void dock_drag_begin ();
		public virtual signal void dock_drag_end (bool cancelled);
		public virtual signal void dock_drag_motion (int x, int y);
		public signal void selected ();
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_item_button_image_get_type ()")]
	public class DockItemButtonImage : Gtk.Widget, Atk.Implementor, Gtk.Buildable {
		public Gdl.DockItemButtonImageType image_type;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public DockItemButtonImage (Gdl.DockItemButtonImageType image_type);
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_item_grip_get_type ()")]
	public class DockItemGrip : Gtk.Container, Atk.Implementor, Gtk.Buildable {
		public weak Gdk.Window title_window;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public DockItemGrip (Gdl.DockItem item);
		public void hide_handle ();
		public void set_label (Gtk.Widget label);
		public void show_handle ();
		public Gdl.DockItem item { construct; }
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_layout_get_type ()")]
	public class DockLayout : GLib.Object {
		[CCode (has_construct_function = false)]
		public DockLayout (Gdl.Dock dock);
		public void attach (Gdl.DockMaster master);
		public void delete_layout (string name);
		public bool is_dirty ();
		public bool load_from_file (string filename);
		public bool load_layout (string name);
		public void run_manager ();
		public void save_layout (string name);
		public bool save_to_file (string filename);
		[NoAccessorMethod]
		public bool dirty { get; }
		[NoAccessorMethod]
		public Gdl.DockMaster master { owned get; set; }
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_master_get_type ()")]
	public class DockMaster : GLib.Object {
		public weak Gdl.DockObject controller;
		public int dock_number;
		public weak GLib.HashTable<void*,void*> dock_objects;
		public weak GLib.List<void*> toplevel_docks;
		[CCode (has_construct_function = false)]
		protected DockMaster ();
		public void add (Gdl.DockObject object);
		public void remove (Gdl.DockObject object);
		public void set_controller (Gdl.DockObject new_controller);
		[NoAccessorMethod]
		public string default_title { owned get; set; }
		[NoAccessorMethod]
		public int locked { get; set; }
		[NoAccessorMethod]
		public Gdl.SwitcherStyle switcher_style { get; set; }
		public virtual signal void layout_changed ();
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_notebook_get_type ()")]
	public class DockNotebook : Gdl.DockItem, Atk.Implementor, Gtk.Buildable {
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public DockNotebook ();
		[NoAccessorMethod]
		public int page { get; set; }
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_object_get_type ()")]
	public class DockObject : Gtk.Container, Atk.Implementor, Gtk.Buildable {
		public Gdl.DockObjectFlags flags;
		public int freeze_count;
		public bool reduce_pending;
		[CCode (has_construct_function = false)]
		protected DockObject ();
		public void bind (GLib.Object master);
		public virtual bool child_placement (Gdl.DockObject child, Gdl.DockPlacement placement);
		public virtual bool dock_request (int x, int y, Gdl.DockRequest request);
		public void freeze ();
		public bool is_bound ();
		public bool is_compound ();
		public static unowned string nick_from_type (GLib.Type type);
		public virtual void present (Gdl.DockObject child);
		public virtual void reduce ();
		public virtual bool reorder (Gdl.DockObject child, Gdl.DockPlacement new_position, GLib.Value other_data);
		public static GLib.Type set_type_for_nick (string nick, GLib.Type type);
		public void thaw ();
		public static GLib.Type type_from_nick (string nick);
		public void unbind ();
		[NoAccessorMethod]
		public string long_name { owned get; set construct; }
		[NoAccessorMethod]
		public Gdl.DockMaster master { owned get; set construct; }
		[NoAccessorMethod]
		public string name { owned get; construct; }
		[NoAccessorMethod]
		public string stock_id { owned get; set construct; }
		[HasEmitter]
		public virtual signal void detach (bool recursive);
		[HasEmitter]
		public virtual signal void dock (Gdl.DockObject requestor, Gdl.DockPlacement position, GLib.Value other_data);
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_paned_get_type ()")]
	public class DockPaned : Gdl.DockItem, Atk.Implementor, Gtk.Buildable {
		public bool position_changed;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public DockPaned (Gtk.Orientation orientation);
		[NoAccessorMethod]
		public uint position { get; set; }
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_param_get_type ()")]
	public class DockParam {
		[CCode (has_construct_function = false)]
		protected DockParam ();
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_placeholder_get_type ()")]
	public class DockPlaceholder : Gdl.DockObject, Atk.Implementor, Gtk.Buildable {
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public DockPlaceholder (string name, Gdl.DockObject object, Gdl.DockPlacement position, bool sticky);
		public void attach (Gdl.DockObject object);
		[NoAccessorMethod]
		public bool floating { get; construct; }
		[NoAccessorMethod]
		public int floatx { get; construct; }
		[NoAccessorMethod]
		public int floaty { get; construct; }
		[NoAccessorMethod]
		public int height { get; set construct; }
		[NoAccessorMethod]
		public Gdl.DockObject host { owned get; set; }
		[NoAccessorMethod]
		public Gdl.DockPlacement next_placement { get; set; }
		[NoAccessorMethod]
		public bool sticky { get; construct; }
		[NoAccessorMethod]
		public int width { get; set construct; }
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_dock_tablabel_get_type ()")]
	public class DockTablabel : Gtk.Bin, Atk.Implementor, Gtk.Buildable {
		public bool active;
		public uint drag_handle_size;
		public Gdk.EventButton drag_start_event;
		public weak Gdk.Window event_window;
		public bool pre_drag;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public DockTablabel (Gdl.DockItem item);
		public void activate ();
		public void deactivate ();
		[NoAccessorMethod]
		public Gdl.DockItem item { owned get; set; }
		public virtual signal void button_pressed_handle (Gdk.Event event);
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_preview_window_get_type ()")]
	public class PreviewWindow : Gtk.Window, Atk.Implementor, Gtk.Buildable {
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public PreviewWindow ();
		public void update (Gdk.Rectangle rect);
	}
	[CCode (cheader_filename = "gdl/gdl.h", type_id = "gdl_switcher_get_type ()")]
	public class Switcher : Gtk.Notebook, Atk.Implementor, Gtk.Buildable {
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public Switcher ();
		public int insert_page (Gtk.Widget page, Gtk.Widget tab_widget, string label, string tooltips, string stock_id, int position);
		[NoAccessorMethod]
		public Gdl.SwitcherStyle switcher_style { get; set; }
	}
	[CCode (cheader_filename = "gdl/gdl.h", has_type_id = false)]
	public struct DockRequest {
		public weak Gdl.DockObject applicant;
		public weak Gdl.DockObject target;
		public Gdl.DockPlacement position;
		public Cairo.RectangleInt rect;
		public GLib.Value extra;
	}
	[CCode (cheader_filename = "gdl/gdl.h", cprefix = "GDL_DOCK_BAR_")]
	public enum DockBarStyle {
		ICONS,
		TEXT,
		BOTH,
		AUTO
	}
	[CCode (cheader_filename = "gdl/gdl.h", cprefix = "GDL_DOCK_ITEM_BEH_")]
	[Flags]
	public enum DockItemBehavior {
		NORMAL,
		NEVER_FLOATING,
		NEVER_VERTICAL,
		NEVER_HORIZONTAL,
		LOCKED,
		CANT_DOCK_TOP,
		CANT_DOCK_BOTTOM,
		CANT_DOCK_LEFT,
		CANT_DOCK_RIGHT,
		CANT_DOCK_CENTER,
		CANT_CLOSE,
		CANT_ICONIFY,
		NO_GRIP
	}
	[CCode (cheader_filename = "gdl/gdl.h", cprefix = "GDL_DOCK_ITEM_BUTTON_IMAGE_")]
	public enum DockItemButtonImageType {
		CLOSE,
		ICONIFY
	}
	[CCode (cheader_filename = "gdl/gdl.h", cprefix = "GDL_DOCK_")]
	[Flags]
	public enum DockItemFlags {
		IN_DRAG,
		IN_PREDRAG,
		ICONIFIED,
		USER_ACTION
	}
	[CCode (cheader_filename = "gdl/gdl.h", cprefix = "GDL_DOCK_")]
	[Flags]
	public enum DockObjectFlags {
		AUTOMATIC,
		ATTACHED,
		IN_REFLOW,
		IN_DETACH
	}
	[CCode (cheader_filename = "gdl/gdl.h", cprefix = "GDL_DOCK_PARAM_")]
	[Flags]
	public enum DockParamFlags {
		EXPORT,
		AFTER
	}
	[CCode (cheader_filename = "gdl/gdl.h", cprefix = "GDL_DOCK_")]
	public enum DockPlacement {
		NONE,
		TOP,
		BOTTOM,
		RIGHT,
		LEFT,
		CENTER,
		FLOATING
	}
	[CCode (cheader_filename = "gdl/gdl.h", cprefix = "GDL_SWITCHER_STYLE_")]
	public enum SwitcherStyle {
		TEXT,
		ICON,
		BOTH,
		TOOLBAR,
		TABS,
		NONE
	}
	[CCode (cheader_filename = "gdl/gdl.h")]
	public const string DOCK_MASTER_PROPERTY;
	[CCode (cheader_filename = "gdl/gdl.h")]
	public const string DOCK_NAME_PROPERTY;
	[CCode (cheader_filename = "gdl/gdl.h")]
	public const int DOCK_OBJECT_FLAGS_SHIFT;
	[CCode (cheader_filename = "gdl/gdl.h")]
	public static string gettext (string msgid);
	[CCode (cheader_filename = "gdl/gdl.h")]
	public static void marshal_VOID__INT_INT (GLib.Closure closure, GLib.Value return_value, uint n_param_values, GLib.Value param_values, void* invocation_hint, void* marshal_data);
	[CCode (cheader_filename = "gdl/gdl.h")]
	public static void marshal_VOID__OBJECT_ENUM_BOXED (GLib.Closure closure, GLib.Value return_value, uint n_param_values, GLib.Value param_values, void* invocation_hint, void* marshal_data);
	[CCode (cheader_filename = "gdl/gdl.h")]
	public static void marshal_VOID__UINT_UINT (GLib.Closure closure, GLib.Value return_value, uint n_param_values, GLib.Value param_values, void* invocation_hint, void* marshal_data);
}
