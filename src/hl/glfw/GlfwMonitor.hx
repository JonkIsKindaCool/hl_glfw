package hl.glfw;

import hl.bindings.GlfwBindings;

/** Event type delivered to the monitor-change callback. */
enum abstract MonitorEvent(Int) from Int to Int {
	var CONNECTED = 0x00040001;
	var DISCONNECTED = 0x00040002;
}

typedef MonitorCallback = (monitor:GlfwMonitor, event:MonitorEvent) -> Void;

/**
 * Wrapper for a GLFW monitor handle.
 *
 * ```haxe
 * var primary = GlfwMonitor.primary;
 * trace(primary.name);                       // e.g. "LG ULTRAGEAR"
 * trace(primary.workarea);                   // {x, y, width, height}
 *
 * for (m in GlfwMonitor.getAll())
 *     trace(m.name + " @ " + m.getPos());
 *
 * GlfwMonitor.onChange = (m, e) -> trace('$e: ${m.name}');
 * ```
 */
@:forward
abstract GlfwMonitor(hl.Abstract<"GLFWmonitor">) from hl.Abstract<"GLFWmonitor"> to hl.Abstract<"GLFWmonitor"> {
	/** Returns the primary monitor. */
	public static var primary(get, never):GlfwMonitor;

	private static inline function get_primary():GlfwMonitor
		return GlfwBindings.getPrimaryMonitor();

	/** Returns all currently connected monitors. */
	public static function getAll():Array<GlfwMonitor> {
		var countBytes = new hl.Bytes(4);

		GlfwBindings.getMonitors(countBytes);
		var count = countBytes.getI32(0);

		var arr:Array<GlfwMonitor> = [];

		/** TODO: Invalid_argument("index out of bounds")
			for (i in 0...count) {
				var monitorPtr = GlfwBindings.getMonitorAt(i);
				if (monitorPtr != null) {
					arr.push(monitorPtr);
				}
			}
		**/
		return arr;
	}

	/** Callback invoked when a monitor is connected or disconnected. */
	public static var onChange(get, set):MonitorCallback;

	private static var _onChange:MonitorCallback = null;

	private static inline function get_onChange():MonitorCallback
		return _onChange;

	private static function set_onChange(cb:MonitorCallback):MonitorCallback {
		_onChange = cb;
		GlfwBindings.setMonitorCallback(cb == null ? null : (m:hl.Abstract<"GLFWmonitor">, e:Int) -> cb(m, e));
		return cb;
	}

	/** Human-readable monitor name as reported by the OS. */
	public var name(get, never):String;

	private inline function get_name():String
		return @:privateAccess String.fromUTF8(GlfwBindings.getMonitorName(this));

	/** Virtual desktop position of the monitor's upper-left corner. */
	public function getPos():{x:Int, y:Int} {
		var x = new hl.Bytes(4), y = new hl.Bytes(4);
		GlfwBindings.getMonitorPos(this, x, y);
		return {x: x.getI32(0), y: y.getI32(0)};
	}

	/** The area of the monitor not occupied by OS taskbars/panels. */
	public function getWorkarea():{
		x:Int,
		y:Int,
		width:Int,
		height:Int
	} {
		var x = new hl.Bytes(4), y = new hl.Bytes(4);
		var w = new hl.Bytes(4), h = new hl.Bytes(4);
		GlfwBindings.getMonitorWorkarea(this, x, y, w, h);
		return {
			x: x.getI32(0),
			y: y.getI32(0),
			width: w.getI32(0),
			height: h.getI32(0)
		};
	}

	/** Physical size in millimetres. */
	public function getPhysicalSize():{widthMM:Int, heightMM:Int} {
		var w = new hl.Bytes(4), h = new hl.Bytes(4);
		GlfwBindings.getMonitorPhysicalSize(this, w, h);
		return {widthMM: w.getI32(0), heightMM: h.getI32(0)};
	}

	/** DPI scaling factor relative to 96 dpi (1.0 = 96 dpi). */
	public function getContentScale():{x:Float, y:Float} {
		var x = new hl.Bytes(4), y = new hl.Bytes(4);
		GlfwBindings.getMonitorContentScale(this, x, y);
		return {x: x.getF32(0), y: y.getF32(0)};
	}

	/** Sets the gamma exponent for this monitor (1.0 = linear). */
	public inline function setGamma(gamma:Float):Void
		GlfwBindings.setGamma(this, gamma);

	/**
	 * Returns the current video mode of this monitor as an opaque handle.
	 * Use `GlfwMonitor.primary` for the most common case.
	 */
	public inline function getVideoMode():hl.Abstract<"GLFWvidmode">
		return GlfwBindings.getVideoMode(this);
}
