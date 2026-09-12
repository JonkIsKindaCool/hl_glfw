package hl.glfw;

import hl.bindings.GlfwBindings;

/** The state of a key or mouse button at a given moment. */
enum abstract GlfwKeyState(Int) from Int to Int {
	var RELEASE = 0;
	var PRESS = 1;
	var REPEAT = 2;

	/** True when the key is currently down (pressed or held). */
	public var isDown(get, never):Bool;

	private inline function get_isDown():Bool
		return this == PRESS || this == REPEAT;
}

/** The action delivered in key / mouse-button callbacks. */
enum abstract GlfwKeyAction(Int) from Int to Int {
	var RELEASE = 0;
	var PRESS = 1;
	var REPEAT = 2;
}

/**
 * Modifier-key bitmask.
 *
 * ```haxe
 * window.onKey = (key, sc, action, mods) -> {
 *   if (mods.has(CONTROL) && key == GlfwKey.S) save();
 * }
 * ```
 */
enum abstract GlfwKeyMod(Int) from Int to Int {
	var NONE = 0x0000;
	var SHIFT = 0x0001;
	var CONTROL = 0x0002;
	var ALT = 0x0004;
	var SUPER = 0x0008;
	var CAPS_LOCK = 0x0010;
	var NUM_LOCK = 0x0020;

	/** Returns true if this modifier flag is set. */
	public inline function has(mod:GlfwKeyMod):Bool
		return (this & mod) != 0;

	/** Returns true if no modifier is active. */
	public inline function isNone():Bool
		return this == 0;
}

/** Standard mouse buttons. */
enum abstract GlfwMouseButton(Int) from Int to Int {
	var LEFT = 0;
	var RIGHT = 1;
	var MIDDLE = 2;
	var BUTTON_4 = 3;
	var BUTTON_5 = 4;
	var BUTTON_6 = 5;
	var BUTTON_7 = 6;
	var BUTTON_8 = 7;
}

/** Cursor visibility / capture modes. */
enum abstract GlfwCursorMode(Int) from Int to Int {
	/** Normal cursor – visible and free. */
	var NORMAL = 0x00034001;

	/** Cursor hidden when over the window, but not locked. */
	var HIDDEN = 0x00034002;

	/** Cursor hidden and locked to the window; raw motion available. */
	var DISABLED = 0x00034003;

	/** Cursor confined to the window's content area. */
	var CAPTURED = 0x00034004;
}

/** Standard system cursor shapes. */
enum abstract GlfwCursorShape(Int) from Int to Int {
	var ARROW = 0x00036001;
	var IBEAM = 0x00036002;
	var CROSSHAIR = 0x00036003;
	var POINTING_HAND = 0x00036004;
	var RESIZE_EW = 0x00036005;
	var RESIZE_NS = 0x00036006;
	var RESIZE_NWSE = 0x00036007;
	var RESIZE_NESW = 0x00036008;
	var RESIZE_ALL = 0x00036009;
	var NOT_ALLOWED = 0x0003600A;
}

/** Joystick hat direction bitmask. */
enum abstract GlfwHatState(Int) from Int to Int {
	var CENTERED = 0;
	var UP = 1;
	var RIGHT = 2;
	var DOWN = 4;
	var LEFT = 8;
	var RIGHT_UP = 3;
	var RIGHT_DOWN = 6; 
	var LEFT_UP = 9;
	var LEFT_DOWN = 12; 

	public inline function isUp():Bool
		return (this & UP) != 0;

	public inline function isDown():Bool
		return (this & DOWN) != 0;

	public inline function isLeft():Bool
		return (this & LEFT) != 0;

	public inline function isRight():Bool
		return (this & RIGHT) != 0;
}

typedef GlfwKeyCallback = (key:GlfwKey, scancode:Int, action:GlfwKeyAction, mods:GlfwKeyMod) -> Void;
typedef GlfwCharCallback = (codepoint:Int) -> Void;
typedef GlfwCharModsCallback = (codepoint:Int, mods:GlfwKeyMod) -> Void;
typedef GlfwMouseButtonCallback = (button:GlfwMouseButton, action:GlfwKeyAction, mods:GlfwKeyMod) -> Void;
typedef GlfwCursorPosCallback = (x:Float, y:Float) -> Void;
typedef GlfwCursorEnterCallback = (entered:Bool) -> Void;
typedef GlfwScrollCallback = (xOffset:Float, yOffset:Float) -> Void;
typedef GlfwDropCallback = (paths:Array<String>) -> Void;

class GlfwInput {
	public static inline function getKey(window:GlfwWindow, key:GlfwKey):GlfwKeyState
		return GlfwBindings.getKey(window, key);

	/** True if key is currently pressed or held. */
	public static inline function isKeyDown(window:GlfwWindow, key:GlfwKey):Bool
		return GlfwBindings.getKey(window, key) != 0;

	/** True only on the first frame the key is pressed (not repeated). */
	public static inline function isKeyJustPressed(window:GlfwWindow, key:GlfwKey):Bool
		return GlfwBindings.getKey(window, key) == GlfwKeyState.PRESS;

	/** Human-readable layout name for the key ("A", "Space", …). */
	public static inline function getKeyName(key:GlfwKey, scancode:Int = 0):String {
		var b = GlfwBindings.getKeyName(key, scancode);
		return b == null ? "" : @:privateAccess String.fromUTF8(b);
	}

	/** True if raw mouse-motion input is supported on this platform. */
	public static inline function isRawMouseMotionSupported():Bool
		return GlfwBindings.rawMouseMotionSupported() != 0;

	/** Returns the current state of a mouse button. */
	public static inline function getMouseButton(window:GlfwWindow, button:GlfwMouseButton):GlfwKeyState
		return GlfwBindings.getMouseButton(window, button);

	/** True if the button is currently held down. */
	public static inline function isMouseButtonDown(window:GlfwWindow, button:GlfwMouseButton):Bool
		return GlfwBindings.getMouseButton(window, button) != 0;

	/** Returns the cursor position in screen coordinates (doubles). */
	public static function getCursorPos(window:GlfwWindow):{x:Float, y:Float} {
		var x = new hl.Bytes(8);
		var y = new hl.Bytes(8);

		GlfwBindings.getCursorPos(window, x, y);
		return {x: x.getF64(0), y: y.getF64(0)};
	}

	/** Sets the cursor position within the window. */
	public static inline function setCursorPos(window:GlfwWindow, x:Float, y:Float):Void
		GlfwBindings.setCursorPos(window, x, y);

	/** Sets the cursor mode for the window (NORMAL / HIDDEN / DISABLED / CAPTURED). */
	public static inline function setCursorMode(window:GlfwWindow, mode:GlfwCursorMode):Void
		GlfwBindings.setInputMode(window, 0x00033001 /*GLFW_CURSOR*/, mode);

	/** Returns the current cursor mode. */
	public static inline function getCursorMode(window:GlfwWindow):GlfwCursorMode
		return GlfwBindings.getInputMode(window, 0x00033001);

	/** Enable / disable sticky keys (state is kept until polled). */
	public static inline function setStickyKeys(window:GlfwWindow, enabled:Bool):Void
		GlfwBindings.setInputMode(window, 0x00033002 /*STICKY_KEYS*/, enabled ? 1 : 0);

	/** Enable / disable sticky mouse buttons. */
	public static inline function setStickyMouseButtons(window:GlfwWindow, enabled:Bool):Void
		GlfwBindings.setInputMode(window, 0x00033003 /*STICKY_MOUSE_BUTTONS*/, enabled ? 1 : 0);

	/** Enable / disable reporting of lock-key modifier bits (Caps Lock, Num Lock). */
	public static inline function setLockKeyMods(window:GlfwWindow, enabled:Bool):Void
		GlfwBindings.setInputMode(window, 0x00033004 /*LOCK_KEY_MODS*/, enabled ? 1 : 0);

	/** Enable / disable raw mouse motion (requires DISABLED cursor mode). */
	public static inline function setRawMouseMotion(window:GlfwWindow, enabled:Bool):Void
		GlfwBindings.setInputMode(window, 0x00033005 /*RAW_MOUSE_MOTION*/, enabled ? 1 : 0);

	/** Creates a standard system cursor from a shape enum. Destroy with destroyCursor(). */
	public static inline function createStandardCursor(shape:GlfwCursorShape):GlfwCursor
		return GlfwBindings.createStandardCursor(shape);

	/** Creates a custom cursor from pixel data. */
	public static inline function createCursor(image:hl.Abstract<"GLFWimage">, xhot:Int, yhot:Int):GlfwCursor
		return GlfwBindings.createCursor(image, xhot, yhot);

	/** Destroys a cursor object. */
	public static inline function destroyCursor(cursor:GlfwCursor):Void
		GlfwBindings.destroyCursor(cursor);

	/** Sets the active cursor for a window (pass null to reset to default). */
	public static inline function setCursor(window:GlfwWindow, cursor:GlfwCursor):Void
		GlfwBindings.setCursor(window, cursor);
}

@:forward
abstract GlfwCursor(hl.Abstract<"GLFWcursor">) from hl.Abstract<"GLFWcursor"> to hl.Abstract<"GLFWcursor"> {
	/** Creates a standard system cursor by shape. */
	public static inline function standard(shape:GlfwCursorShape):GlfwCursor
		return GlfwBindings.createStandardCursor(shape);

	/** Destroys the cursor and frees its resources. */
	public inline function destroy():Void
		GlfwBindings.destroyCursor(this);
}
