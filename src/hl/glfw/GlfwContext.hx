package hl.glfw;

import hl.bindings.GlfwBindings;

/** Platform selection used with `Context.hint(PLATFORM, ...)`. */
enum abstract GlfwPlatform(Int) from Int to Int {
	var ANY      = 0x00060000;
	var WIN32    = 0x00060001;
	var COCOA    = 0x00060002;
	var WAYLAND  = 0x00060003;
	var X11      = 0x00060004;
	var NULL     = 0x00060005;
}

/** Wayland libdecor preference. */
enum abstract GlfwWaylandLibdecor(Int) from Int to Int {
	var PREFER  = 0x00038001;
	var DISABLE = 0x00038002;
}

/** Initialisation hints (set before `Context.init()`). */
enum abstract GlfwInitHint(Int) from Int to Int {
	var JOYSTICK_HAT_BUTTONS   = 0x00050001;
	var ANGLE_PLATFORM_TYPE    = 0x00050002;
	var PLATFORM               = 0x00050003;
	var COCOA_CHDIR_RESOURCES  = 0x00051001;
	var COCOA_MENUBAR          = 0x00051002;
	var X11_XCB_VULKAN_SURFACE = 0x00052001;
	var WAYLAND_LIBDECOR       = 0x00053001;
}

/** GLFW error codes. */
enum abstract GlfwError(Int) from Int to Int {
	var NO_ERROR              = 0;
	var NOT_INITIALIZED       = 0x00010001;
	var NO_CURRENT_CONTEXT    = 0x00010002;
	var INVALID_ENUM          = 0x00010003;
	var INVALID_VALUE         = 0x00010004;
	var OUT_OF_MEMORY         = 0x00010005;
	var API_UNAVAILABLE       = 0x00010006;
	var VERSION_UNAVAILABLE   = 0x00010007;
	var PLATFORM_ERROR        = 0x00010008;
	var FORMAT_UNAVAILABLE    = 0x00010009;
	var NO_WINDOW_CONTEXT     = 0x0001000A;
	var CURSOR_UNAVAILABLE    = 0x0001000B;
	var FEATURE_UNAVAILABLE   = 0x0001000C;
	var FEATURE_UNIMPLEMENTED = 0x0001000D;
	var PLATFORM_UNAVAILABLE  = 0x0001000E;
}

/**
 * Central GLFW lifecycle and event-loop manager.
 *
 * ```haxe
 * // Optional: set hints before init
 * GlfwContext.hint(PLATFORM, GlfwPlatform.X11);
 *
 * if (!GlfwContext.init()) throw "GLFW failed";
 *
 * // ...create windows, run loop...
 *
 * GlfwContext.terminate();
 * ```
 */
class GlfwContext {
	/**
	 * Initialises the GLFW library.
	 * @return `true` on success.
	 */
	public static function init():Bool
		return GlfwBindings.init() != 0;

	/** Terminates the GLFW library and frees all resources. */
	public static inline function terminate():Void
		GlfwBindings.terminate();

	/** Sets an initialisation hint. Must be called before `init()`. */
	public static inline function hint(h:GlfwInitHint, value:Int):Void
		GlfwBindings.initHint(h, value);

	/** Convenience: choose the target platform before init. */
	public static inline function setPlatform(p:GlfwPlatform):Void
		GlfwBindings.initHint(GlfwInitHint.PLATFORM, p);

	/** Convenience: enable/disable joystick-hat buttons. */
	public static inline function setJoystickHatButtons(v:Bool):Void
		GlfwBindings.initHint(GlfwInitHint.JOYSTICK_HAT_BUTTONS, v ? 1 : 0);

	/**
	 * Returns the last GLFW error code and clears it.
	 * Description is available via the error callback.
	 */
	public static inline function getError():GlfwError
		return GlfwBindings.getError(null);

	/** Returns true if the last GLFW call produced no error. */
	public static inline function ok():Bool
		return GlfwBindings.getError(null) == 0;

	/** Returns the compiled GLFW version as a string. */
	public static inline function getVersionString():String
		return @:privateAccess String.fromUTF8(GlfwBindings.getVersionString());

	/** Returns the compiled GLFW version numbers. */
	public static function getVersion():{major:Int, minor:Int, rev:Int} {
		var ma = new hl.Bytes(4), mi = new hl.Bytes(4), rv = new hl.Bytes(4);
		GlfwBindings.getVersion(ma, mi, rv);
		return {major: ma.getI32(0), minor: mi.getI32(0), rev: rv.getI32(0)};
	}

	/** Returns the platform GLFW was compiled for and is currently running on. */
	public static inline function getPlatform():GlfwPlatform
		return GlfwBindings.getPlatform();

	/** Returns true if the library binary was compiled with support for `platform`. */
	public static inline function isPlatformSupported(platform:GlfwPlatform):Bool
		return GlfwBindings.platformSupported(platform) != 0;

	/**
	 * Processes all pending events and returns immediately.
	 * Call this once per frame.
	 */
	public static inline function pollEvents():Void
		GlfwBindings.pollEvents();

	/**
	 * Puts the calling thread to sleep until at least one event is available,
	 * then processes all pending events.
	 * Useful for GUI apps to avoid burning CPU when idle.
	 */
	public static inline function waitEvents():Void
		GlfwBindings.waitEvents();

	/**
	 * Like `waitEvents()` but returns after `timeout` seconds even if no
	 * events arrive.
	 */
	public static inline function waitEventsTimeout(timeout:Float):Void
		GlfwBindings.waitEventsTimeout(timeout);

	/**
	 * Posts an empty event to unblock a `waitEvents()` call from another thread.
	 */
	public static inline function postEmptyEvent():Void
		GlfwBindings.postEmptyEvent();

	/**
	 * Sets the swap interval (vsync).
	 * `0` = unlimited, `1` = vsync, `2` = half rate, …
	 */
	public static inline function setSwapInterval(interval:Int):Void
		GlfwBindings.swapInterval(interval);

	/** Enables vsync (swap interval = 1). */
	public static inline function enableVsync():Void
		GlfwBindings.swapInterval(1);

	/** Disables vsync (swap interval = 0). */
	public static inline function disableVsync():Void
		GlfwBindings.swapInterval(0);

	/** Returns the function pointer that can be passed to a GL loader. */
	public static inline function getProcAddressFn():hl.Bytes
		return GlfwBindings.getProcAddressFn();

	/** Returns the window whose context is current on this thread. */
	public static inline function getCurrentContext():GlfwWindow
		return GlfwBindings.getCurrentContext();

	/** Returns true if the named OpenGL/ES extension is supported. */
	public static function isExtensionSupported(name:String):Bool {
		@:privateAccess
		return GlfwBindings.extensionSupported(name.toUtf8()) != 0;
	}

	/** Returns true if Vulkan is minimally supported on this machine. */
	public static inline function isVulkanSupported():Bool
		return GlfwBindings.vulkanSupported() != 0;

	/** Returns the Vulkan instance extensions required by GLFW. */
	public static function getRequiredVulkanExtensions():Array<String> {
		var countBytes = new hl.Bytes(4);
		var raw = GlfwBindings.getRequiredInstanceExtensions(countBytes);

        //TODO:
		// Im exposing a null-terminated list of C strings; count is in countBytes.
		// We expose a safe empty array; projects with full Vulkan bindings can
		// use GlfwBindings.getRequiredInstanceExtensions directly.
		return [];
	}
}
