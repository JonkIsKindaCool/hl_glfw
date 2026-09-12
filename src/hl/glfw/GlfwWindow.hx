package hl.glfw;

import hl.glfw.GlfwInput;
import hl.Bytes;
import hl.bindings.GlfwBindings;

/** All hints that accept an integer value. */
enum abstract GlfwWindowHint(Int) from Int to Int {
	// Visibility / decoration
	var FOCUSED = 0x00020001;
	var RESIZABLE = 0x00020003;
	var VISIBLE = 0x00020004;
	var DECORATED = 0x00020005;
	var AUTO_ICONIFY = 0x00020006;
	var FLOATING = 0x00020007;
	var MAXIMIZED = 0x00020008;
	var CENTER_CURSOR = 0x00020009;
	var TRANSPARENT_FRAMEBUFFER = 0x0002000A;
	var FOCUS_ON_SHOW = 0x0002000C;
	var MOUSE_PASSTHROUGH = 0x0002000D;
	var POSITION_X = 0x0002000E;
	var POSITION_Y = 0x0002000F;
	// Framebuffer
	var RED_BITS = 0x00021001;
	var GREEN_BITS = 0x00021002;
	var BLUE_BITS = 0x00021003;
	var ALPHA_BITS = 0x00021004;
	var DEPTH_BITS = 0x00021005;
	var STENCIL_BITS = 0x00021006;
	var ACCUM_RED_BITS = 0x00021007;
	var ACCUM_GREEN_BITS = 0x00021008;
	var ACCUM_BLUE_BITS = 0x00021009;
	var ACCUM_ALPHA_BITS = 0x0002100A;
	var AUX_BUFFERS = 0x0002100B;
	var STEREO = 0x0002100C;
	var SAMPLES = 0x0002100D;
	var SRGB_CAPABLE = 0x0002100E;
	var REFRESH_RATE = 0x0002100F;
	var DOUBLEBUFFER = 0x00021010;
	// Context
	var CLIENT_API = 0x00022001;
	var CONTEXT_VERSION_MAJOR = 0x00022002;
	var CONTEXT_VERSION_MINOR = 0x00022003;
	var CONTEXT_ROBUSTNESS = 0x00022005;
	var OPENGL_FORWARD_COMPAT = 0x00022006;
	var CONTEXT_DEBUG = 0x00022007;
	var OPENGL_PROFILE = 0x00022008;
	var CONTEXT_RELEASE_BEHAVIOR = 0x00022009;
	var CONTEXT_NO_ERROR = 0x0002200A;
	var CONTEXT_CREATION_API = 0x0002200B;
	var SCALE_TO_MONITOR = 0x0002200C;
	var SCALE_FRAMEBUFFER = 0x0002200D;
	// Platform-specific (string hints use WindowHintString)
	var COCOA_RETINA_FRAMEBUFFER = 0x00023001;
	var COCOA_GRAPHICS_SWITCHING = 0x00023003;
	var WIN32_KEYBOARD_MENU = 0x00025001;
	var WIN32_SHOWDEFAULT = 0x00025002;
}

/** String-valued window hints (passed via windowHintString). */
enum abstract GlfwWindowHintString(Int) from Int to Int {
	var COCOA_FRAME_NAME = 0x00023002;
	var X11_CLASS_NAME = 0x00024001;
	var X11_INSTANCE_NAME = 0x00024002;
	var WAYLAND_APP_ID = 0x00026001;
}

/** OpenGL client API selection. */
enum abstract GlfwClientApi(Int) from Int to Int {
	var NO_API = 0;
	var OPENGL = 0x00030001;
	var OPENGL_ES = 0x00030002;
}

/** OpenGL profile selection. */
enum abstract GlfwOpenGLProfile(Int) from Int to Int {
	var ANY = 0;
	var CORE = 0x00032001;
	var COMPATIBILITY = 0x00032002;
}

/** Context robustness strategy. */
enum abstract ContextRobustness(Int) from Int to Int {
	var NONE = 0;
	var NO_RESET_NOTIFICATION = 0x00031001;
	var LOSE_CONTEXT_ON_RESET = 0x00031002;
}

/** Context release-behaviour. */
enum abstract GlfwContextReleaseBehavior(Int) from Int to Int {
	var ANY = 0;
	var FLUSH = 0x00035001;
	var NONE = 0x00035002;
}

/** Context creation API. */
enum abstract GlfwContextCreationApi(Int) from Int to Int {
	var NATIVE = 0x00036001;
	var EGL = 0x00036002;
	var OSMESA = 0x00036003;
}

/**
 * Fluent builder for GLFW window hints.
 *
 * ```haxe
 * WindowHints.defaults()
 *   .opengl(3, 3, CoreProfile)
 *   .resizable(false)
 *   .apply();
 * ```
 */
class GlfwWindowHints {
	/** Resets all hints to their defaults and returns a new builder. */
	public static function defaults():GlfwWindowHints {
		GlfwBindings.defaultWindowHints();
		return new GlfwWindowHints();
	}

	function new() {}

	/** Configures a core-profile OpenGL context of the given version. */
	public function opengl(major:Int, minor:Int, profile:GlfwOpenGLProfile = CORE, forwardCompat:Bool = true):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.CLIENT_API, GlfwClientApi.OPENGL);
		GlfwBindings.windowHint(GlfwWindowHint.CONTEXT_VERSION_MAJOR, major);
		GlfwBindings.windowHint(GlfwWindowHint.CONTEXT_VERSION_MINOR, minor);
		GlfwBindings.windowHint(GlfwWindowHint.OPENGL_PROFILE, profile);
		GlfwBindings.windowHint(GlfwWindowHint.OPENGL_FORWARD_COMPAT, forwardCompat ? 1 : 0);
		return this;
	}

	/** Configures an OpenGL ES context. */
	public function openglES(major:Int, minor:Int):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.CLIENT_API, GlfwClientApi.OPENGL_ES);
		GlfwBindings.windowHint(GlfwWindowHint.CONTEXT_VERSION_MAJOR, major);
		GlfwBindings.windowHint(GlfwWindowHint.CONTEXT_VERSION_MINOR, minor);
		return this;
	}

	/** Disables the OpenGL/ES context (for Vulkan or no-context windows). */
	public function noApi():GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.CLIENT_API, GlfwClientApi.NO_API);
		return this;
	}

	public function resizable(v:Bool = true):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.RESIZABLE, v ? 1 : 0);
		return this;
	}

	public function visible(v:Bool = true):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.VISIBLE, v ? 1 : 0);
		return this;
	}

	public function decorated(v:Bool = true):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.DECORATED, v ? 1 : 0);
		return this;
	}

	public function floating(v:Bool = false):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.FLOATING, v ? 1 : 0);
		return this;
	}

	public function maximized(v:Bool = false):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.MAXIMIZED, v ? 1 : 0);
		return this;
	}

	public function focused(v:Bool = true):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.FOCUSED, v ? 1 : 0);
		return this;
	}

	public function focusOnShow(v:Bool = true):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.FOCUS_ON_SHOW, v ? 1 : 0);
		return this;
	}

	public function transparentFramebuffer(v:Bool = false):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.TRANSPARENT_FRAMEBUFFER, v ? 1 : 0);
		return this;
	}

	public function mousePassthrough(v:Bool = false):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.MOUSE_PASSTHROUGH, v ? 1 : 0);
		return this;
	}

	public function scaleToMonitor(v:Bool = false):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.SCALE_TO_MONITOR, v ? 1 : 0);
		return this;
	}

	/** Sets the initial window position. Use -1 to let the OS decide. */
	public function position(x:Int, y:Int):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.POSITION_X, x);
		GlfwBindings.windowHint(GlfwWindowHint.POSITION_Y, y);
		return this;
	}

	public function samples(n:Int):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.SAMPLES, n);
		return this;
	}

	public function srgbCapable(v:Bool = true):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.SRGB_CAPABLE, v ? 1 : 0);
		return this;
	}

	public function doublebuffer(v:Bool = true):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.DOUBLEBUFFER, v ? 1 : 0);
		return this;
	}

	public function depthBits(n:Int):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.DEPTH_BITS, n);
		return this;
	}

	public function stencilBits(n:Int):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.STENCIL_BITS, n);
		return this;
	}

	public function refreshRate(hz:Int):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.REFRESH_RATE, hz);
		return this;
	}

	public function debugContext(v:Bool = false):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.CONTEXT_DEBUG, v ? 1 : 0);
		return this;
	}

	public function contextNoError(v:Bool = false):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.CONTEXT_NO_ERROR, v ? 1 : 0);
		return this;
	}

	public function robustness(r:ContextRobustness):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.CONTEXT_ROBUSTNESS, r);
		return this;
	}

	public function releaseBehavior(r:GlfwContextReleaseBehavior):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.CONTEXT_RELEASE_BEHAVIOR, r);
		return this;
	}

	public function creationApi(api:GlfwContextCreationApi):GlfwWindowHints {
		GlfwBindings.windowHint(GlfwWindowHint.CONTEXT_CREATION_API, api);
		return this;
	}

	public function waylandAppId(id:String):GlfwWindowHints {
		@:privateAccess GlfwBindings.windowHintString(GlfwWindowHintString.WAYLAND_APP_ID, id.toUtf8());
		return this;
	}

	public function x11ClassName(name:String):GlfwWindowHints {
		@:privateAccess GlfwBindings.windowHintString(GlfwWindowHintString.X11_CLASS_NAME, name.toUtf8());
		return this;
	}

	public function x11InstanceName(name:String):GlfwWindowHints {
		@:privateAccess GlfwBindings.windowHintString(GlfwWindowHintString.X11_INSTANCE_NAME, name.toUtf8());
		return this;
	}

	public function cocoaFrameName(name:String):GlfwWindowHints {
		@:privateAccess GlfwBindings.windowHintString(GlfwWindowHintString.COCOA_FRAME_NAME, name.toUtf8());
		return this;
	}

	/** Set any integer hint directly. */
	public function hint(h:GlfwWindowHint, value:Int):GlfwWindowHints {
		GlfwBindings.windowHint(h, value);
		return this;
	}

	/** Set any string hint directly. */
	public function hintString(h:GlfwWindowHintString, value:String):GlfwWindowHints {
		@:privateAccess GlfwBindings.windowHintString(h, value.toUtf8());
		return this;
	}
}

/** Attributes that can be queried or changed after window creation. */
enum abstract GlfwWindowAttrib(Int) from Int to Int {
	var FOCUSED = 0x00020001;
	var ICONIFIED = 0x00020002;
	var RESIZABLE = 0x00020003;
	var VISIBLE = 0x00020004;
	var DECORATED = 0x00020005;
	var AUTO_ICONIFY = 0x00020006;
	var FLOATING = 0x00020007;
	var MAXIMIZED = 0x00020008;
	var TRANSPARENT_FRAMEBUFFER = 0x0002000A;
	var HOVERED = 0x0002000B;
	var FOCUS_ON_SHOW = 0x0002000C;
	var MOUSE_PASSTHROUGH = 0x0002000D;
	var DOUBLEBUFFER = 0x00021010;
	var CLIENT_API = 0x00022001;
	var CONTEXT_VERSION_MAJOR = 0x00022002;
	var CONTEXT_VERSION_MINOR = 0x00022003;
	var CONTEXT_REVISION = 0x00022004;
	var CONTEXT_ROBUSTNESS = 0x00022005;
	var OPENGL_FORWARD_COMPAT = 0x00022006;
	var CONTEXT_DEBUG = 0x00022007;
	var OPENGL_PROFILE = 0x00022008;
	var CONTEXT_RELEASE_BEHAVIOR = 0x00022009;
	var CONTEXT_NO_ERROR = 0x0002200A;
	var CONTEXT_CREATION_API = 0x0002200B;
}

/**
 * High-level wrapper for a GLFW window.
 *
 * ```haxe
 * GlfwWindowHints.defaults().opengl(3, 3).resizable(false).apply();
 * var win = new GlfwWindow(1280, 720, "My App");
 * win.makeCurrent();
 * GlfwContext.setSwapInterval(1);
 *
 * while (!win.shouldClose) {
 *   GlfwContext.pollEvents();
 *   win.swapBuffers();
 * }
 * win.destroy();
 * ```
 */
@:forward
abstract GlfwWindow(hl.Abstract<"GLFWwindow">) from hl.Abstract<"GLFWwindow"> to hl.Abstract<"GLFWwindow"> {
	/**
	 * Creates a new window.
	 *
	 * @param width   Width in screen coordinates.
	 * @param height  Height in screen coordinates.
	 * @param title   UTF-8 window title.
	 * @param monitor If non-null, the window is created fullscreen on that monitor.
	 * @param share   Optional window whose OpenGL context to share resources with.
	 */
	public inline function new(width:Int, height:Int, title:String, ?monitor:GlfwMonitor, ?share:GlfwWindow) {
		@:privateAccess
		this = GlfwBindings.createWindow(width, height, title.toUtf8(), monitor, share);
	}

	/** Destroys the window and its context. */
	public inline function destroy():Void
		GlfwBindings.destroyWindow(this);

	/** Makes this window's OpenGL context current on the calling thread. */
	public inline function makeCurrent():Void
		GlfwBindings.makeContextCurrent(this);

	/** Swaps the front and back buffers. */
	public inline function swapBuffers():Void
		GlfwBindings.swapBuffers(this);

	public var shouldClose(get, set):Bool;

	private inline function get_shouldClose():Bool
		return GlfwBindings.windowShouldClose(this) != 0;

	private inline function set_shouldClose(v:Bool):Bool {
		GlfwBindings.setWindowShouldClose(this, v ? 1 : 0);
		return v;
	}

	public var title(get, set):String;

	private inline function get_title():String
		return @:privateAccess String.fromUTF8(GlfwBindings.getWindowTitle(this));

	private inline function set_title(v:String):String {
		@:privateAccess GlfwBindings.setWindowTitle(this, v.toUtf8());
		return v;
	}

	public var opacity(get, set):Float;

	private inline function get_opacity():Float
		return GlfwBindings.getWindowOpacity(this);

	private inline function set_opacity(v:Float):Float {
		GlfwBindings.setWindowOpacity(this, v);
		return v;
	}

	public var monitor(get, never):GlfwMonitor;

	private inline function get_monitor():GlfwMonitor
		return GlfwBindings.getWindowMonitor(this);

	/**
	 * Transitions to fullscreen on `monitor`, or back to windowed mode when
	 * `monitor` is null (restoring the given bounds and refresh rate).
	 */
	public function setMonitor(monitor:GlfwMonitor, x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0, refreshRate:Int = -1):Void {
		if (width == 0 || height == 0) {
			var s = getSize();
			width = s.width;
			height = s.height;
		}
		GlfwBindings.setWindowMonitor(this, monitor, x, y, width, height, refreshRate);
	}

	/** Enters fullscreen on the primary monitor at its current video mode. */
	public function goFullscreen(?monitor:GlfwMonitor):Void {
		if (monitor == null)
			monitor = GlfwMonitor.primary;
		var vm = GlfwBindings.getVideoMode(monitor);
		// GLFWvidmode: int width, height, r, g, b, refreshRate
		// We read width/height from the first two I32s in the struct memory.
		// Since GLFWvidmode is opaque in HL, we fall back to the current window size.
		var s = getSize();
		GlfwBindings.setWindowMonitor(this, monitor, 0, 0, s.width, s.height, -1 /*DONT_CARE*/);
	}

	/** Exits fullscreen and returns to windowed mode at the given position and size. */
	public function goWindowed(x:Int, y:Int, width:Int, height:Int):Void
		GlfwBindings.setWindowMonitor(this, null, x, y, width, height, 0);

	public var clipboard(get, set):String;

	private inline function get_clipboard():String {
		var b = GlfwBindings.getClipboardString(this);
		return b == null ? "" : @:privateAccess String.fromUTF8(b);
	}

	private inline function set_clipboard(v:String):String {
		@:privateAccess GlfwBindings.setClipboardString(this, v.toUtf8());
		return v;
	}

	public function getSize():{width:Int, height:Int} {
		var w = new Bytes(4), h = new Bytes(4);
		GlfwBindings.getWindowSize(this, w, h);
		return {width: w.getI32(0), height: h.getI32(0)};
	}

	public inline function setSize(width:Int, height:Int):Void
		GlfwBindings.setWindowSize(this, width, height);

	public function getPos():{x:Int, y:Int} {
		var x = new Bytes(4), y = new Bytes(4);
		GlfwBindings.getWindowPos(this, x, y);
		return {x: x.getI32(0), y: y.getI32(0)};
	}

	public inline function setPos(x:Int, y:Int):Void
		GlfwBindings.setWindowPos(this, x, y);

	public function getFramebufferSize():{width:Int, height:Int} {
		var w = new Bytes(4), h = new Bytes(4);
		GlfwBindings.getFramebufferSize(this, w, h);
		return {width: w.getI32(0), height: h.getI32(0)};
	}

	public function getFrameSize():{
		left:Int,
		top:Int,
		right:Int,
		bottom:Int
	} {
		var l = new Bytes(4),
			t = new Bytes(4),
			r = new Bytes(4),
			b = new Bytes(4);
		GlfwBindings.getWindowFrameSize(this, l, t, r, b);
		return {
			left: l.getI32(0),
			top: t.getI32(0),
			right: r.getI32(0),
			bottom: b.getI32(0)
		};
	}

	public function getContentScale():{x:Float, y:Float} {
		var x = new Bytes(4), y = new Bytes(4);
		GlfwBindings.getWindowContentScale(this, x, y);
		return {x: x.getF32(0), y: y.getF32(0)};
	}

	public inline function setSizeLimits(minW:Int, minH:Int, maxW:Int, maxH:Int):Void
		GlfwBindings.setWindowSizeLimits(this, minW, minH, maxW, maxH);

	public inline function setAspectRatio(numer:Int, denom:Int):Void
		GlfwBindings.setWindowAspectRatio(this, numer, denom);

	public inline function show():Void
		GlfwBindings.showWindow(this);

	public inline function hide():Void
		GlfwBindings.hideWindow(this);

	public inline function iconify():Void
		GlfwBindings.iconifyWindow(this);

	public inline function maximize():Void
		GlfwBindings.maximizeWindow(this);

	public inline function restore():Void
		GlfwBindings.restoreWindow(this);

	public inline function focus():Void
		GlfwBindings.focusWindow(this);

	public inline function requestAttention():Void
		GlfwBindings.requestWindowAttention(this);

	public inline function getAttribute(attrib:GlfwWindowAttrib):Int
		return GlfwBindings.getWindowAttrib(this, attrib);

	public inline function getBoolAttribute(attrib:GlfwWindowAttrib):Bool
		return GlfwBindings.getWindowAttrib(this, attrib) != 0;

	public inline function setAttribute(attrib:GlfwWindowAttrib, value:Int):Void
		GlfwBindings.setWindowAttrib(this, attrib, value);

	public inline function setBoolAttribute(attrib:GlfwWindowAttrib, value:Bool):Void
		GlfwBindings.setWindowAttrib(this, attrib, value ? 1 : 0);

	/** Convenience: is the window currently focused? */
	public var isFocused(get, never):Bool;

	private inline function get_isFocused():Bool
		return getBoolAttribute(GlfwWindowAttrib.FOCUSED);

	/** Convenience: is the window currently iconified (minimised)? */
	public var isIconified(get, never):Bool;

	private inline function get_isIconified():Bool
		return getBoolAttribute(GlfwWindowAttrib.ICONIFIED);

	/** Convenience: is the window maximised? */
	public var isMaximized(get, never):Bool;

	private inline function get_isMaximized():Bool
		return getBoolAttribute(GlfwWindowAttrib.MAXIMIZED);

	/** Convenience: is the cursor hovering over the window? */
	public var isHovered(get, never):Bool;

	private inline function get_isHovered():Bool
		return getBoolAttribute(GlfwWindowAttrib.HOVERED);

	/** Convenience: is the window visible? */
	public var isVisible(get, never):Bool;

	private inline function get_isVisible():Bool
		return getBoolAttribute(GlfwWindowAttrib.VISIBLE);

	/** True if the given key is currently down. */
	public inline function isKeyDown(key:GlfwKey):Bool
		return GlfwBindings.getKey(this, key) != 0;

	/** True if the given mouse button is currently down. */
	public inline function isMouseButtonDown(button:GlfwMouseButton):Bool
		return GlfwBindings.getMouseButton(this, button) != 0;

	/** Returns the cursor position in window-content-area coordinates. */
	public function getCursorPos():{x:Float, y:Float} {
		var x = new Bytes(8), y = new Bytes(8);
		GlfwBindings.getCursorPos(this, x, y);
		return {x: x.getF64(0), y: y.getF64(0)};
	}

	/** Sets the cursor mode. */
	public inline function setCursorMode(mode:GlfwCursorMode):Void
		GlfwBindings.setInputMode(this, 0x00033001, mode);

	public var cursorMode(get, set):GlfwCursorMode;

	private inline function get_cursorMode():GlfwCursorMode
		return GlfwBindings.getInputMode(this, 0x00033001);

	private inline function set_cursorMode(v:GlfwCursorMode):GlfwCursorMode {
		GlfwBindings.setInputMode(this, 0x00033001, v);
		return v;
	}

	/** Sets the active cursor object (null = default arrow). */
	public inline function setCursor(cursor:GlfwCursor):Void
		GlfwBindings.setCursor(this, cursor);

	public var onPosChanged(never, set):(x:Int, y:Int) -> Void;

	private inline function set_onPosChanged(cb:(x:Int, y:Int) -> Void):(x:Int, y:Int) -> Void {
		GlfwBindings.setWindowPosCallback(this, cb);
		return cb;
	}

	public var onSizeChanged(never, set):(width:Int, height:Int) -> Void;

	private inline function set_onSizeChanged(cb:(width:Int, height:Int) -> Void):(width:Int, height:Int) -> Void {
		GlfwBindings.setWindowSizeCallback(this, cb);
		return cb;
	}

	public var onClose(never, set):() -> Void;

	private inline function set_onClose(cb:() -> Void):() -> Void {
		GlfwBindings.setWindowCloseCallback(this, cb);
		return cb;
	}

	public var onRefresh(never, set):() -> Void;

	private inline function set_onRefresh(cb:() -> Void):() -> Void {
		GlfwBindings.setWindowRefreshCallback(this, cb);
		return cb;
	}

	public var onFocusChanged(never, set):(focused:Bool) -> Void;

	private inline function set_onFocusChanged(cb:(focused:Bool) -> Void):(focused:Bool) -> Void {
		GlfwBindings.setWindowFocusCallback(this, cb);
		return cb;
	}

	public var onIconifyChanged(never, set):(iconified:Bool) -> Void;

	private inline function set_onIconifyChanged(cb:(iconified:Bool) -> Void):(iconified:Bool) -> Void {
		GlfwBindings.setWindowIconifyCallback(this, cb);
		return cb;
	}

	public var onMaximizeChanged(never, set):(maximized:Bool) -> Void;

	private inline function set_onMaximizeChanged(cb:(maximized:Bool) -> Void):(maximized:Bool) -> Void {
		GlfwBindings.setWindowMaximizeCallback(this, cb);
		return cb;
	}

	public var onFramebufferSizeChanged(never, set):(width:Int, height:Int) -> Void;

	private inline function set_onFramebufferSizeChanged(cb:(width:Int, height:Int) -> Void):(width:Int, height:Int) -> Void {
		GlfwBindings.setFramebufferSizeCallback(this, cb);
		return cb;
	}

	public var onContentScaleChanged(never, set):(xscale:Single, yscale:Single) -> Void;

	private inline function set_onContentScaleChanged(cb:(xscale:Single, yscale:Single) -> Void):(xscale:Single, yscale:Single) -> Void {
		GlfwBindings.setWindowContentScaleCallback(this, cb);
		return cb;
	}

	public var onKey(never, set):GlfwKeyCallback;

	private inline function set_onKey(cb:GlfwKeyCallback):GlfwKeyCallback {
		GlfwBindings.setKeyCallback(this, cb == null ? null : (k:Int, s:Int, a:Int, m:Int) -> cb(k, s, a, m));
		return cb;
	}

	public var onChar(never, set):GlfwCharCallback;

	private inline function set_onChar(cb:GlfwCharCallback):GlfwCharCallback {
		GlfwBindings.setCharCallback(this, cb == null ? null : (c:Int) -> cb(c));
		return cb;
	}

	public var onCharMods(never, set):GlfwCharModsCallback;

	private inline function set_onCharMods(cb:GlfwCharModsCallback):GlfwCharModsCallback {
		GlfwBindings.setCharModsCallback(this, cb == null ? null : (c:Int, m:Int) -> cb(c, m));
		return cb;
	}

	public var onMouseButton(never, set):GlfwMouseButtonCallback;

	private inline function set_onMouseButton(cb:GlfwMouseButtonCallback):GlfwMouseButtonCallback {
		GlfwBindings.setMouseButtonCallback(this, cb == null ? null : (b:Int, a:Int, m:Int) -> cb(b, a, m));
		return cb;
	}

	public var onCursorPos(never, set):GlfwCursorPosCallback;

	private inline function set_onCursorPos(cb:GlfwCursorPosCallback):GlfwCursorPosCallback {
		GlfwBindings.setCursorPosCallback(this, cb == null ? null : (x:Float, y:Float) -> cb(x, y));
		return cb;
	}

	public var onCursorEnter(never, set):GlfwCursorEnterCallback;

	private inline function set_onCursorEnter(cb:GlfwCursorEnterCallback):GlfwCursorEnterCallback {
		GlfwBindings.setCursorEnterCallback(this, cb == null ? null : (e:Int) -> cb(e != 0));
		return cb;
	}

	public var onScroll(never, set):GlfwScrollCallback;

	private inline function set_onScroll(cb:GlfwScrollCallback):GlfwScrollCallback {
		GlfwBindings.setScrollCallback(this, cb == null ? null : (x:Float, y:Float) -> cb(x, y));
		return cb;
	}

	public var onDrop(never, set):GlfwDropCallback;

	private inline function set_onDrop(cb:GlfwDropCallback):GlfwDropCallback {
		GlfwBindings.setDropCallback(this, cb == null ? null : (count:Int, paths:hl.NativeArray<hl.Bytes>) -> {
			cb([for (i in 0...paths.length) @:privateAccess String.fromUTF8(paths[i])]);
		});
		return cb;
	}
}
