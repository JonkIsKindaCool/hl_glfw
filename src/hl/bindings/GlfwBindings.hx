package hl.bindings;

@:hlNative("glfw")
extern class GlfwBindings {
	inline static var VERSION_MAJOR:Int = 3;
	inline static var VERSION_MINOR:Int = 6;
	inline static var VERSION_REVISION:Int = 0;

	// Boolean values
	inline static var TRUE:Int = 1;
	inline static var FALSE:Int = 0;

	// Key and button actions
	inline static var RELEASE:Int = 0;
	inline static var PRESS:Int = 1;
	inline static var REPEAT:Int = 2;

	// Joystick hat states
	inline static var HAT_CENTERED:Int = 0;
	inline static var HAT_UP:Int = 1;
	inline static var HAT_RIGHT:Int = 2;
	inline static var HAT_DOWN:Int = 4;
	inline static var HAT_LEFT:Int = 8;
	inline static var HAT_RIGHT_UP:Int = 3;
	inline static var HAT_RIGHT_DOWN:Int = 6;
	inline static var HAT_LEFT_UP:Int = 9;
	inline static var HAT_LEFT_DOWN:Int = 12;

	// Key unknown
	inline static var KEY_UNKNOWN:Int = -1;

	// Printable keys
	inline static var KEY_SPACE:Int = 32;
	inline static var KEY_APOSTROPHE:Int = 39;
	inline static var KEY_COMMA:Int = 44;
	inline static var KEY_MINUS:Int = 45;
	inline static var KEY_PERIOD:Int = 46;
	inline static var KEY_SLASH:Int = 47;
	inline static var KEY_0:Int = 48;
	inline static var KEY_1:Int = 49;
	inline static var KEY_2:Int = 50;
	inline static var KEY_3:Int = 51;
	inline static var KEY_4:Int = 52;
	inline static var KEY_5:Int = 53;
	inline static var KEY_6:Int = 54;
	inline static var KEY_7:Int = 55;
	inline static var KEY_8:Int = 56;
	inline static var KEY_9:Int = 57;
	inline static var KEY_SEMICOLON:Int = 59;
	inline static var KEY_EQUAL:Int = 61;
	inline static var KEY_A:Int = 65;
	inline static var KEY_B:Int = 66;
	inline static var KEY_C:Int = 67;
	inline static var KEY_D:Int = 68;
	inline static var KEY_E:Int = 69;
	inline static var KEY_F:Int = 70;
	inline static var KEY_G:Int = 71;
	inline static var KEY_H:Int = 72;
	inline static var KEY_I:Int = 73;
	inline static var KEY_J:Int = 74;
	inline static var KEY_K:Int = 75;
	inline static var KEY_L:Int = 76;
	inline static var KEY_M:Int = 77;
	inline static var KEY_N:Int = 78;
	inline static var KEY_O:Int = 79;
	inline static var KEY_P:Int = 80;
	inline static var KEY_Q:Int = 81;
	inline static var KEY_R:Int = 82;
	inline static var KEY_S:Int = 83;
	inline static var KEY_T:Int = 84;
	inline static var KEY_U:Int = 85;
	inline static var KEY_V:Int = 86;
	inline static var KEY_W:Int = 87;
	inline static var KEY_X:Int = 88;
	inline static var KEY_Y:Int = 89;
	inline static var KEY_Z:Int = 90;
	inline static var KEY_LEFT_BRACKET:Int = 91;
	inline static var KEY_BACKSLASH:Int = 92;
	inline static var KEY_RIGHT_BRACKET:Int = 93;
	inline static var KEY_GRAVE_ACCENT:Int = 96;
	inline static var KEY_WORLD_1:Int = 161;
	inline static var KEY_WORLD_2:Int = 162;

	// Function keys
	inline static var KEY_ESCAPE:Int = 256;
	inline static var KEY_ENTER:Int = 257;
	inline static var KEY_TAB:Int = 258;
	inline static var KEY_BACKSPACE:Int = 259;
	inline static var KEY_INSERT:Int = 260;
	inline static var KEY_DELETE:Int = 261;
	inline static var KEY_RIGHT:Int = 262;
	inline static var KEY_LEFT:Int = 263;
	inline static var KEY_DOWN:Int = 264;
	inline static var KEY_UP:Int = 265;
	inline static var KEY_PAGE_UP:Int = 266;
	inline static var KEY_PAGE_DOWN:Int = 267;
	inline static var KEY_HOME:Int = 268;
	inline static var KEY_END:Int = 269;
	inline static var KEY_CAPS_LOCK:Int = 280;
	inline static var KEY_SCROLL_LOCK:Int = 281;
	inline static var KEY_NUM_LOCK:Int = 282;
	inline static var KEY_PRINT_SCREEN:Int = 283;
	inline static var KEY_PAUSE:Int = 284;
	inline static var KEY_F1:Int = 290;
	inline static var KEY_F2:Int = 291;
	inline static var KEY_F3:Int = 292;
	inline static var KEY_F4:Int = 293;
	inline static var KEY_F5:Int = 294;
	inline static var KEY_F6:Int = 295;
	inline static var KEY_F7:Int = 296;
	inline static var KEY_F8:Int = 297;
	inline static var KEY_F9:Int = 298;
	inline static var KEY_F10:Int = 299;
	inline static var KEY_F11:Int = 300;
	inline static var KEY_F12:Int = 301;
	inline static var KEY_F13:Int = 302;
	inline static var KEY_F14:Int = 303;
	inline static var KEY_F15:Int = 304;
	inline static var KEY_F16:Int = 305;
	inline static var KEY_F17:Int = 306;
	inline static var KEY_F18:Int = 307;
	inline static var KEY_F19:Int = 308;
	inline static var KEY_F20:Int = 309;
	inline static var KEY_F21:Int = 310;
	inline static var KEY_F22:Int = 311;
	inline static var KEY_F23:Int = 312;
	inline static var KEY_F24:Int = 313;
	inline static var KEY_F25:Int = 314;

	// Keypad keys
	inline static var KEY_KP_0:Int = 320;
	inline static var KEY_KP_1:Int = 321;
	inline static var KEY_KP_2:Int = 322;
	inline static var KEY_KP_3:Int = 323;
	inline static var KEY_KP_4:Int = 324;
	inline static var KEY_KP_5:Int = 325;
	inline static var KEY_KP_6:Int = 326;
	inline static var KEY_KP_7:Int = 327;
	inline static var KEY_KP_8:Int = 328;
	inline static var KEY_KP_9:Int = 329;
	inline static var KEY_KP_DECIMAL:Int = 330;
	inline static var KEY_KP_DIVIDE:Int = 331;
	inline static var KEY_KP_MULTIPLY:Int = 332;
	inline static var KEY_KP_SUBTRACT:Int = 333;
	inline static var KEY_KP_ADD:Int = 334;
	inline static var KEY_KP_ENTER:Int = 335;
	inline static var KEY_KP_EQUAL:Int = 336;

	// Modifier and special keys
	inline static var KEY_LEFT_SHIFT:Int = 340;
	inline static var KEY_LEFT_CONTROL:Int = 341;
	inline static var KEY_LEFT_ALT:Int = 342;
	inline static var KEY_LEFT_SUPER:Int = 343;
	inline static var KEY_RIGHT_SHIFT:Int = 344;
	inline static var KEY_RIGHT_CONTROL:Int = 345;
	inline static var KEY_RIGHT_ALT:Int = 346;
	inline static var KEY_RIGHT_SUPER:Int = 347;
	inline static var KEY_MENU:Int = 348;
	inline static var KEY_LAST:Int = 348;

	// Modifier key flags
	inline static var MOD_SHIFT:Int = 0x0001;
	inline static var MOD_CONTROL:Int = 0x0002;
	inline static var MOD_ALT:Int = 0x0004;
	inline static var MOD_SUPER:Int = 0x0008;
	inline static var MOD_CAPS_LOCK:Int = 0x0010;
	inline static var MOD_NUM_LOCK:Int = 0x0020;

	// Mouse buttons
	inline static var MOUSE_BUTTON_1:Int = 0;
	inline static var MOUSE_BUTTON_2:Int = 1;
	inline static var MOUSE_BUTTON_3:Int = 2;
	inline static var MOUSE_BUTTON_4:Int = 3;
	inline static var MOUSE_BUTTON_5:Int = 4;
	inline static var MOUSE_BUTTON_6:Int = 5;
	inline static var MOUSE_BUTTON_7:Int = 6;
	inline static var MOUSE_BUTTON_8:Int = 7;
	inline static var MOUSE_BUTTON_LAST:Int = 7;
	inline static var MOUSE_BUTTON_LEFT:Int = 0;
	inline static var MOUSE_BUTTON_RIGHT:Int = 1;
	inline static var MOUSE_BUTTON_MIDDLE:Int = 2;

	// Joystick IDs
	inline static var JOYSTICK_1:Int = 0;
	inline static var JOYSTICK_2:Int = 1;
	inline static var JOYSTICK_3:Int = 2;
	inline static var JOYSTICK_4:Int = 3;
	inline static var JOYSTICK_5:Int = 4;
	inline static var JOYSTICK_6:Int = 5;
	inline static var JOYSTICK_7:Int = 6;
	inline static var JOYSTICK_8:Int = 7;
	inline static var JOYSTICK_9:Int = 8;
	inline static var JOYSTICK_10:Int = 9;
	inline static var JOYSTICK_11:Int = 10;
	inline static var JOYSTICK_12:Int = 11;
	inline static var JOYSTICK_13:Int = 12;
	inline static var JOYSTICK_14:Int = 13;
	inline static var JOYSTICK_15:Int = 14;
	inline static var JOYSTICK_16:Int = 15;
	inline static var JOYSTICK_LAST:Int = 15;

	// Gamepad buttons
	inline static var GAMEPAD_BUTTON_A:Int = 0;
	inline static var GAMEPAD_BUTTON_B:Int = 1;
	inline static var GAMEPAD_BUTTON_X:Int = 2;
	inline static var GAMEPAD_BUTTON_Y:Int = 3;
	inline static var GAMEPAD_BUTTON_LEFT_BUMPER:Int = 4;
	inline static var GAMEPAD_BUTTON_RIGHT_BUMPER:Int = 5;
	inline static var GAMEPAD_BUTTON_BACK:Int = 6;
	inline static var GAMEPAD_BUTTON_START:Int = 7;
	inline static var GAMEPAD_BUTTON_GUIDE:Int = 8;
	inline static var GAMEPAD_BUTTON_LEFT_THUMB:Int = 9;
	inline static var GAMEPAD_BUTTON_RIGHT_THUMB:Int = 10;
	inline static var GAMEPAD_BUTTON_DPAD_UP:Int = 11;
	inline static var GAMEPAD_BUTTON_DPAD_RIGHT:Int = 12;
	inline static var GAMEPAD_BUTTON_DPAD_DOWN:Int = 13;
	inline static var GAMEPAD_BUTTON_DPAD_LEFT:Int = 14;
	inline static var GAMEPAD_BUTTON_LAST:Int = 14;
	inline static var GAMEPAD_BUTTON_CROSS:Int = 0;
	inline static var GAMEPAD_BUTTON_CIRCLE:Int = 1;
	inline static var GAMEPAD_BUTTON_SQUARE:Int = 2;
	inline static var GAMEPAD_BUTTON_TRIANGLE:Int = 3;

	// Gamepad axes
	inline static var GAMEPAD_AXIS_LEFT_X:Int = 0;
	inline static var GAMEPAD_AXIS_LEFT_Y:Int = 1;
	inline static var GAMEPAD_AXIS_RIGHT_X:Int = 2;
	inline static var GAMEPAD_AXIS_RIGHT_Y:Int = 3;
	inline static var GAMEPAD_AXIS_LEFT_TRIGGER:Int = 4;
	inline static var GAMEPAD_AXIS_RIGHT_TRIGGER:Int = 5;
	inline static var GAMEPAD_AXIS_LAST:Int = 5;

	// Error codes
	inline static var NO_ERROR:Int = 0;
	inline static var NOT_INITIALIZED:Int = 0x00010001;
	inline static var NO_CURRENT_CONTEXT:Int = 0x00010002;
	inline static var INVALID_ENUM:Int = 0x00010003;
	inline static var INVALID_VALUE:Int = 0x00010004;
	inline static var OUT_OF_MEMORY:Int = 0x00010005;
	inline static var API_UNAVAILABLE:Int = 0x00010006;
	inline static var VERSION_UNAVAILABLE:Int = 0x00010007;
	inline static var PLATFORM_ERROR:Int = 0x00010008;
	inline static var FORMAT_UNAVAILABLE:Int = 0x00010009;
	inline static var NO_WINDOW_CONTEXT:Int = 0x0001000A;
	inline static var CURSOR_UNAVAILABLE:Int = 0x0001000B;
	inline static var FEATURE_UNAVAILABLE:Int = 0x0001000C;
	inline static var FEATURE_UNIMPLEMENTED:Int = 0x0001000D;
	inline static var PLATFORM_UNAVAILABLE:Int = 0x0001000E;

	// Window hints and attributes
	inline static var FOCUSED:Int = 0x00020001;
	inline static var ICONIFIED:Int = 0x00020002;
	inline static var RESIZABLE:Int = 0x00020003;
	inline static var VISIBLE:Int = 0x00020004;
	inline static var DECORATED:Int = 0x00020005;
	inline static var AUTO_ICONIFY:Int = 0x00020006;
	inline static var FLOATING:Int = 0x00020007;
	inline static var MAXIMIZED:Int = 0x00020008;
	inline static var CENTER_CURSOR:Int = 0x00020009;
	inline static var TRANSPARENT_FRAMEBUFFER:Int = 0x0002000A;
	inline static var HOVERED:Int = 0x0002000B;
	inline static var FOCUS_ON_SHOW:Int = 0x0002000C;
	inline static var MOUSE_PASSTHROUGH:Int = 0x0002000D;
	inline static var POSITION_X:Int = 0x0002000E;
	inline static var POSITION_Y:Int = 0x0002000F;

	// Framebuffer bits
	inline static var RED_BITS:Int = 0x00021001;
	inline static var GREEN_BITS:Int = 0x00021002;
	inline static var BLUE_BITS:Int = 0x00021003;
	inline static var ALPHA_BITS:Int = 0x00021004;
	inline static var DEPTH_BITS:Int = 0x00021005;
	inline static var STENCIL_BITS:Int = 0x00021006;
	inline static var ACCUM_RED_BITS:Int = 0x00021007;
	inline static var ACCUM_GREEN_BITS:Int = 0x00021008;
	inline static var ACCUM_BLUE_BITS:Int = 0x00021009;
	inline static var ACCUM_ALPHA_BITS:Int = 0x0002100A;
	inline static var AUX_BUFFERS:Int = 0x0002100B;
	inline static var STEREO:Int = 0x0002100C;
	inline static var SAMPLES:Int = 0x0002100D;
	inline static var SRGB_CAPABLE:Int = 0x0002100E;
	inline static var REFRESH_RATE:Int = 0x0002100F;
	inline static var DOUBLEBUFFER:Int = 0x00021010;

	// Context hints and attributes
	inline static var CLIENT_API:Int = 0x00022001;
	inline static var CONTEXT_VERSION_MAJOR:Int = 0x00022002;
	inline static var CONTEXT_VERSION_MINOR:Int = 0x00022003;
	inline static var CONTEXT_REVISION:Int = 0x00022004;
	inline static var CONTEXT_ROBUSTNESS:Int = 0x00022005;
	inline static var OPENGL_FORWARD_COMPAT:Int = 0x00022006;
	inline static var CONTEXT_DEBUG:Int = 0x00022007;
	inline static var OPENGL_PROFILE:Int = 0x00022008;
	inline static var CONTEXT_RELEASE_BEHAVIOR:Int = 0x00022009;
	inline static var CONTEXT_NO_ERROR:Int = 0x0002200A;
	inline static var CONTEXT_CREATION_API:Int = 0x0002200B;
	inline static var SCALE_TO_MONITOR:Int = 0x0002200C;
	inline static var SCALE_FRAMEBUFFER:Int = 0x0002200D;

	// macOS specific hints
	inline static var COCOA_RETINA_FRAMEBUFFER:Int = 0x00023001;
	inline static var COCOA_FRAME_NAME:Int = 0x00023002;
	inline static var COCOA_GRAPHICS_SWITCHING:Int = 0x00023003;

	// X11 specific hints
	inline static var X11_CLASS_NAME:Int = 0x00024001;
	inline static var X11_INSTANCE_NAME:Int = 0x00024002;

	// Win32 specific hints
	inline static var WIN32_KEYBOARD_MENU:Int = 0x00025001;
	inline static var WIN32_SHOWDEFAULT:Int = 0x00025002;

	// Wayland specific hints
	inline static var WAYLAND_APP_ID:Int = 0x00026001;

	// Client API values
	inline static var NO_API:Int = 0;
	inline static var OPENGL_API:Int = 0x00030001;
	inline static var OPENGL_ES_API:Int = 0x00030002;

	// Context robustness values
	inline static var NO_ROBUSTNESS:Int = 0;
	inline static var NO_RESET_NOTIFICATION:Int = 0x00031001;
	inline static var LOSE_CONTEXT_ON_RESET:Int = 0x00031002;

	// OpenGL profile values
	inline static var OPENGL_ANY_PROFILE:Int = 0;
	inline static var OPENGL_CORE_PROFILE:Int = 0x00032001;
	inline static var OPENGL_COMPAT_PROFILE:Int = 0x00032002;

	// Input modes
	inline static var CURSOR:Int = 0x00033001;
	inline static var STICKY_KEYS:Int = 0x00033002;
	inline static var STICKY_MOUSE_BUTTONS:Int = 0x00033003;
	inline static var LOCK_KEY_MODS:Int = 0x00033004;
	inline static var RAW_MOUSE_MOTION:Int = 0x00033005;
	inline static var UNLIMITED_MOUSE_BUTTONS:Int = 0x00033006;

	// Cursor modes
	inline static var CURSOR_NORMAL:Int = 0x00034001;
	inline static var CURSOR_HIDDEN:Int = 0x00034002;
	inline static var CURSOR_DISABLED:Int = 0x00034003;
	inline static var CURSOR_CAPTURED:Int = 0x00034004;

	// Context release behavior
	inline static var ANY_RELEASE_BEHAVIOR:Int = 0;
	inline static var RELEASE_BEHAVIOR_FLUSH:Int = 0x00035001;
	inline static var RELEASE_BEHAVIOR_NONE:Int = 0x00035002;

	// Context creation API
	inline static var NATIVE_CONTEXT_API:Int = 0x00036001;
	inline static var EGL_CONTEXT_API:Int = 0x00036002;
	inline static var OSMESA_CONTEXT_API:Int = 0x00036003;

	// ANGLE platform type
	inline static var ANGLE_PLATFORM_TYPE_NONE:Int = 0x00037001;
	inline static var ANGLE_PLATFORM_TYPE_OPENGL:Int = 0x00037002;
	inline static var ANGLE_PLATFORM_TYPE_OPENGLES:Int = 0x00037003;
	inline static var ANGLE_PLATFORM_TYPE_D3D9:Int = 0x00037004;
	inline static var ANGLE_PLATFORM_TYPE_D3D11:Int = 0x00037005;
	inline static var ANGLE_PLATFORM_TYPE_VULKAN:Int = 0x00037007;
	inline static var ANGLE_PLATFORM_TYPE_METAL:Int = 0x00037008;

	// Wayland preferences
	inline static var WAYLAND_PREFER_LIBDECOR:Int = 0x00038001;
	inline static var WAYLAND_DISABLE_LIBDECOR:Int = 0x00038002;

	// Position
	inline static var ANY_POSITION:Int = 0x80000000;

	// Cursor shapes
	inline static var ARROW_CURSOR:Int = 0x00036001;
	inline static var IBEAM_CURSOR:Int = 0x00036002;
	inline static var CROSSHAIR_CURSOR:Int = 0x00036003;
	inline static var POINTING_HAND_CURSOR:Int = 0x00036004;
	inline static var RESIZE_EW_CURSOR:Int = 0x00036005;
	inline static var RESIZE_NS_CURSOR:Int = 0x00036006;
	inline static var RESIZE_NWSE_CURSOR:Int = 0x00036007;
	inline static var RESIZE_NESW_CURSOR:Int = 0x00036008;
	inline static var RESIZE_ALL_CURSOR:Int = 0x00036009;
	inline static var NOT_ALLOWED_CURSOR:Int = 0x0003600A;
	inline static var HRESIZE_CURSOR:Int = 0x00036005;
	inline static var VRESIZE_CURSOR:Int = 0x00036006;
	inline static var HAND_CURSOR:Int = 0x00036004;

	// Monitor events
	inline static var CONNECTED:Int = 0x00040001;
	inline static var DISCONNECTED:Int = 0x00040002;

	// Init hints
	inline static var JOYSTICK_HAT_BUTTONS:Int = 0x00050001;
	inline static var ANGLE_PLATFORM_TYPE:Int = 0x00050002;
	inline static var PLATFORM:Int = 0x00050003;
	inline static var COCOA_CHDIR_RESOURCES:Int = 0x00051001;
	inline static var COCOA_MENUBAR:Int = 0x00051002;
	inline static var X11_XCB_VULKAN_SURFACE:Int = 0x00052001;
	inline static var WAYLAND_LIBDECOR:Int = 0x00053001;

	// Platform values
	inline static var ANY_PLATFORM:Int = 0x00060000;
	inline static var PLATFORM_WIN32:Int = 0x00060001;
	inline static var PLATFORM_COCOA:Int = 0x00060002;
	inline static var PLATFORM_WAYLAND:Int = 0x00060003;
	inline static var PLATFORM_X11:Int = 0x00060004;
	inline static var PLATFORM_NULL:Int = 0x00060005;

	// Miscellaneous
	inline static var DONT_CARE:Int = -1;

	public static function init():Int;
	public static function terminate():Void;
	@:hlNative("glfw", "init_hint")
	public static function initHint(hint:Int, value:Int):Void;
	@:hlNative("glfw", "init_allocator")
	public static function initAllocator(allocator:hl.Abstract<"GLFWallocator">):Void;
	@:hlNative("glfw", "get_version")
	public static function getVersion(major:hl.Bytes, minor:hl.Bytes, rev:hl.Bytes):Void;
	@:hlNative("glfw", "get_version_string")
	public static function getVersionString():hl.Bytes;
	@:hlNative("glfw", "get_error")
	public static function getError(description:hl.Bytes):Int;
	@:hlNative("glfw", "set_error_callback")
	public static function setErrorCallback(callback:hl.Bytes):hl.Bytes;
	@:hlNative("glfw", "get_platform")
	public static function getPlatform():Int;
	@:hlNative("glfw", "platform_supported")
	public static function platformSupported(platform:Int):Int;
	@:hlNative("glfw", "get_monitors")
	public static function getMonitors(count:hl.Bytes):hl.Bytes;
	@:hlNative("glfw", "get_monitor_at")
	public static extern function getMonitorAt(index:Int):hl.Abstract<"GLFWmonitor">;
	@:hlNative("glfw", "get_primary_monitor")
	public static function getPrimaryMonitor():hl.Abstract<"GLFWmonitor">;
	@:hlNative("glfw", "get_monitor_pos")
	public static function getMonitorPos(monitor:hl.Abstract<"GLFWmonitor">, xpos:hl.Bytes, ypos:hl.Bytes):Void;
	@:hlNative("glfw", "get_monitor_workarea")
	public static function getMonitorWorkarea(monitor:hl.Abstract<"GLFWmonitor">, xpos:hl.Bytes, ypos:hl.Bytes, width:hl.Bytes, height:hl.Bytes):Void;
	@:hlNative("glfw", "get_monitor_physical_size")
	public static function getMonitorPhysicalSize(monitor:hl.Abstract<"GLFWmonitor">, widthMM:hl.Bytes, heightMM:hl.Bytes):Void;
	@:hlNative("glfw", "get_monitor_content_scale")
	public static function getMonitorContentScale(monitor:hl.Abstract<"GLFWmonitor">, xscale:hl.Bytes, yscale:hl.Bytes):Void;
	@:hlNative("glfw", "get_monitor_name")
	public static function getMonitorName(monitor:hl.Abstract<"GLFWmonitor">):hl.Bytes;
	@:hlNative("glfw", "set_monitor_user_pointer")
	public static function setMonitorUserPointer(monitor:hl.Abstract<"GLFWmonitor">, pointer:hl.Bytes):Void;
	@:hlNative("glfw", "get_monitor_user_pointer")
	public static function getMonitorUserPointer(monitor:hl.Abstract<"GLFWmonitor">):hl.Bytes;
	@:hlNative("glfw", "set_monitor_callback")
	public static function setMonitorCallback(callback:(monitor:hl.Abstract<"GLFWmonitor">, event:Int) -> Void):Void;
	@:hlNative("glfw", "get_video_modes")
	public static function getVideoModes(monitor:hl.Abstract<"GLFWmonitor">, count:hl.Bytes):hl.Abstract<"GLFWvidmode">;
	@:hlNative("glfw", "get_video_mode")
	public static function getVideoMode(monitor:hl.Abstract<"GLFWmonitor">):hl.Abstract<"GLFWvidmode">;
	@:hlNative("glfw", "set_gamma")
	public static function setGamma(monitor:hl.Abstract<"GLFWmonitor">, gamma:Single):Void;
	@:hlNative("glfw", "get_gamma_ramp")
	public static function getGammaRamp(monitor:hl.Abstract<"GLFWmonitor">):hl.Abstract<"GLFWgammaramp">;
	@:hlNative("glfw", "set_gamma_ramp")
	public static function setGammaRamp(monitor:hl.Abstract<"GLFWmonitor">, ramp:hl.Abstract<"GLFWgammaramp">):Void;
	@:hlNative("glfw", "default_window_hints")
	public static function defaultWindowHints():Void;
	@:hlNative("glfw", "window_hint")
	public static function windowHint(hint:Int, value:Int):Void;
	@:hlNative("glfw", "window_hint_string")
	public static function windowHintString(hint:Int, value:hl.Bytes):Void;
	@:hlNative("glfw", "create_window")
	public static function createWindow(width:Int, height:Int, title:hl.Bytes, monitor:hl.Abstract<"GLFWmonitor">,
		share:hl.Abstract<"GLFWwindow">):hl.Abstract<"GLFWwindow">;
	@:hlNative("glfw", "destroy_window")
	public static function destroyWindow(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "window_should_close")
	public static function windowShouldClose(window:hl.Abstract<"GLFWwindow">):Int;
	@:hlNative("glfw", "set_window_should_close")
	public static function setWindowShouldClose(window:hl.Abstract<"GLFWwindow">, value:Int):Void;
	@:hlNative("glfw", "get_window_title")
	public static function getWindowTitle(window:hl.Abstract<"GLFWwindow">):hl.Bytes;
	@:hlNative("glfw", "set_window_title")
	public static function setWindowTitle(window:hl.Abstract<"GLFWwindow">, title:hl.Bytes):Void;
	@:hlNative("glfw", "set_window_icon")
	public static function setWindowIcon(window:hl.Abstract<"GLFWwindow">, count:Int, images:hl.Abstract<"GLFWimage">):Void;
	@:hlNative("glfw", "get_window_pos")
	public static function getWindowPos(window:hl.Abstract<"GLFWwindow">, xpos:hl.Bytes, ypos:hl.Bytes):Void;
	@:hlNative("glfw", "set_window_pos")
	public static function setWindowPos(window:hl.Abstract<"GLFWwindow">, xpos:Int, ypos:Int):Void;
	@:hlNative("glfw", "get_window_size")
	public static function getWindowSize(window:hl.Abstract<"GLFWwindow">, width:hl.Bytes, height:hl.Bytes):Void;
	@:hlNative("glfw", "set_window_size_limits")
	public static function setWindowSizeLimits(window:hl.Abstract<"GLFWwindow">, minwidth:Int, minheight:Int, maxwidth:Int, maxheight:Int):Void;
	@:hlNative("glfw", "set_window_aspect_ratio")
	public static function setWindowAspectRatio(window:hl.Abstract<"GLFWwindow">, numer:Int, denom:Int):Void;
	@:hlNative("glfw", "set_window_size")
	public static function setWindowSize(window:hl.Abstract<"GLFWwindow">, width:Int, height:Int):Void;
	@:hlNative("glfw", "get_framebuffer_size")
	public static function getFramebufferSize(window:hl.Abstract<"GLFWwindow">, width:hl.Bytes, height:hl.Bytes):Void;
	@:hlNative("glfw", "get_window_frame_size")
	public static function getWindowFrameSize(window:hl.Abstract<"GLFWwindow">, left:hl.Bytes, top:hl.Bytes, right:hl.Bytes, bottom:hl.Bytes):Void;
	@:hlNative("glfw", "get_window_content_scale")
	public static function getWindowContentScale(window:hl.Abstract<"GLFWwindow">, xscale:hl.Bytes, yscale:hl.Bytes):Void;
	@:hlNative("glfw", "get_window_opacity")
	public static function getWindowOpacity(window:hl.Abstract<"GLFWwindow">):Single;
	@:hlNative("glfw", "set_window_opacity")
	public static function setWindowOpacity(window:hl.Abstract<"GLFWwindow">, opacity:Single):Void;
	@:hlNative("glfw", "iconify_window")
	public static function iconifyWindow(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "restore_window")
	public static function restoreWindow(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "maximize_window")
	public static function maximizeWindow(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "show_window")
	public static function showWindow(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "hide_window")
	public static function hideWindow(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "focus_window")
	public static function focusWindow(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "request_window_attention")
	public static function requestWindowAttention(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "get_window_monitor")
	public static function getWindowMonitor(window:hl.Abstract<"GLFWwindow">):hl.Abstract<"GLFWmonitor">;
	@:hlNative("glfw", "set_window_monitor")
	public static function setWindowMonitor(window:hl.Abstract<"GLFWwindow">, monitor:hl.Abstract<"GLFWmonitor">, xpos:Int, ypos:Int, width:Int, height:Int,
		refreshRate:Int):Void;
	@:hlNative("glfw", "get_window_attrib")
	public static function getWindowAttrib(window:hl.Abstract<"GLFWwindow">, attrib:Int):Int;
	@:hlNative("glfw", "set_window_attrib")
	public static function setWindowAttrib(window:hl.Abstract<"GLFWwindow">, attrib:Int, value:Int):Void;
	@:hlNative("glfw", "set_window_user_pointer")
	public static function setWindowUserPointer(window:hl.Abstract<"GLFWwindow">, pointer:hl.Bytes):Void;
	@:hlNative("glfw", "get_window_user_pointer")
	public static function getWindowUserPointer(window:hl.Abstract<"GLFWwindow">):hl.Bytes;
	@:hlNative("glfw", "set_window_pos_callback")
	public static function setWindowPosCallback(window:hl.Abstract<"GLFWwindow">, callback:(x:Int, y:Int) -> Void):Void;
	@:hlNative("glfw", "set_window_size_callback")
	public static function setWindowSizeCallback(window:hl.Abstract<"GLFWwindow">, callback:(width:Int, height:Int) -> Void):Void;
	@:hlNative("glfw", "set_window_close_callback")
	public static function setWindowCloseCallback(window:hl.Abstract<"GLFWwindow">, callback:() -> Void):Void;
	@:hlNative("glfw", "set_window_refresh_callback")
	public static function setWindowRefreshCallback(window:hl.Abstract<"GLFWwindow">, callback:() -> Void):Void;
	@:hlNative("glfw", "set_window_focus_callback")
	public static function setWindowFocusCallback(window:hl.Abstract<"GLFWwindow">, callback:(focused:Bool) -> Void):Void;
	@:hlNative("glfw", "set_window_iconify_callback")
	public static function setWindowIconifyCallback(window:hl.Abstract<"GLFWwindow">, callback:(iconified:Bool) -> Void):Void;
	@:hlNative("glfw", "set_window_maximize_callback")
	public static function setWindowMaximizeCallback(window:hl.Abstract<"GLFWwindow">, callback:(maximized:Bool) -> Void):Void;
	@:hlNative("glfw", "set_framebuffer_size_callback")
	public static function setFramebufferSizeCallback(window:hl.Abstract<"GLFWwindow">, callback:(width:Int, height:Int) -> Void):Void;
	@:hlNative("glfw", "set_window_content_scale_callback")
	public static function setWindowContentScaleCallback(window:hl.Abstract<"GLFWwindow">, callback:(xscale:Single, yscale:Single) -> Void):Void;
	@:hlNative("glfw", "poll_events")
	public static function pollEvents():Void;
	@:hlNative("glfw", "wait_events")
	public static function waitEvents():Void;
	@:hlNative("glfw", "wait_events_timeout")
	public static function waitEventsTimeout(timeout:Float):Void;
	@:hlNative("glfw", "post_empty_event")
	public static function postEmptyEvent():Void;
	@:hlNative("glfw", "get_input_mode")
	public static function getInputMode(window:hl.Abstract<"GLFWwindow">, mode:Int):Int;
	@:hlNative("glfw", "set_input_mode")
	public static function setInputMode(window:hl.Abstract<"GLFWwindow">, mode:Int, value:Int):Void;
	@:hlNative("glfw", "raw_mouse_motion_supported")
	public static function rawMouseMotionSupported():Int;
	@:hlNative("glfw", "get_key_name")
	public static function getKeyName(key:Int, scancode:Int):hl.Bytes;
	@:hlNative("glfw", "get_key_scancode")
	public static function getKeyScancode(key:Int):Int;
	@:hlNative("glfw", "get_key")
	public static function getKey(window:hl.Abstract<"GLFWwindow">, key:Int):Int;
	@:hlNative("glfw", "get_mouse_button")
	public static function getMouseButton(window:hl.Abstract<"GLFWwindow">, button:Int):Int;
	@:hlNative("glfw", "get_cursor_pos")
	public static function getCursorPos(window:hl.Abstract<"GLFWwindow">, xpos:hl.Bytes, ypos:hl.Bytes):Void;
	@:hlNative("glfw", "set_cursor_pos")
	public static function setCursorPos(window:hl.Abstract<"GLFWwindow">, xpos:Float, ypos:Float):Void;
	@:hlNative("glfw", "create_cursor")
	public static function createCursor(image:hl.Abstract<"GLFWimage">, xhot:Int, yhot:Int):hl.Abstract<"GLFWcursor">;
	@:hlNative("glfw", "create_standard_cursor")
	public static function createStandardCursor(shape:Int):hl.Abstract<"GLFWcursor">;
	@:hlNative("glfw", "destroy_cursor")
	public static function destroyCursor(cursor:hl.Abstract<"GLFWcursor">):Void;
	@:hlNative("glfw", "set_cursor")
	public static function setCursor(window:hl.Abstract<"GLFWwindow">, cursor:hl.Abstract<"GLFWcursor">):Void;
	@:hlNative("glfw", "set_key_callback")
	public static function setKeyCallback(window:hl.Abstract<"GLFWwindow">, callback:(key:Int, scancode:Int, action:Int, mods:Int) -> Void):Void;
	@:hlNative("glfw", "set_char_callback")
	public static function setCharCallback(window:hl.Abstract<"GLFWwindow">, callback:(codepoint:Int) -> Void):Void;
	@:hlNative("glfw", "set_char_mods_callback")
	public static function setCharModsCallback(window:hl.Abstract<"GLFWwindow">, callback:(codepoint:Int, mods:Int) -> Void):Void;
	@:hlNative("glfw", "set_mouse_button_callback")
	public static function setMouseButtonCallback(window:hl.Abstract<"GLFWwindow">, callback:(button:Int, action:Int, mods:Int) -> Void):Void;
	@:hlNative("glfw", "set_cursor_pos_callback")
	public static function setCursorPosCallback(window:hl.Abstract<"GLFWwindow">, callback:(xpos:Float, ypos:Float) -> Void):Void;
	@:hlNative("glfw", "set_cursor_enter_callback")
	public static function setCursorEnterCallback(window:hl.Abstract<"GLFWwindow">, callback:(entered:Int) -> Void):Void;
	@:hlNative("glfw", "set_scroll_callback")
	public static function setScrollCallback(window:hl.Abstract<"GLFWwindow">, callback:(xoffset:Float, yoffset:Float) -> Void):Void;
	@:hlNative("glfw", "set_drop_callback")
	public static function setDropCallback(window:hl.Abstract<"GLFWwindow">, callback:(count:Int, paths:hl.NativeArray<hl.Bytes>) -> Void):Void;
	@:hlNative("glfw", "joystick_present")
	public static function joystickPresent(jid:Int):Int;
	@:hlNative("glfw", "get_joystick_axes")
	public static function getJoystickAxes(jid:Int, count:hl.Bytes):hl.Bytes;
	@:hlNative("glfw", "get_joystick_buttons")
	public static function getJoystickButtons(jid:Int, count:hl.Bytes):hl.Bytes;
	@:hlNative("glfw", "get_joystick_hats")
	public static function getJoystickHats(jid:Int, count:hl.Bytes):hl.Bytes;
	@:hlNative("glfw", "get_joystick_name")
	public static function getJoystickName(jid:Int):hl.Bytes;
	@:hlNative("glfw", "get_joystick_guid")
	public static function getJoystickGUID(jid:Int):hl.Bytes;
	@:hlNative("glfw", "set_joystick_user_pointer")
	public static function setJoystickUserPointer(jid:Int, pointer:hl.Bytes):Void;
	@:hlNative("glfw", "get_joystick_user_pointer")
	public static function getJoystickUserPointer(jid:Int):hl.Bytes;
	@:hlNative("glfw", "joystick_is_gamepad")
	public static function joystickIsGamepad(jid:Int):Int;
	@:hlNative("glfw", "set_joystick_callback")
	public static function setJoystickCallback(callback:hl.Bytes):hl.Bytes;
	@:hlNative("glfw", "update_gamepad_mappings")
	public static function updateGamepadMappings(string:hl.Bytes):Int;
	@:hlNative("glfw", "get_gamepad_name")
	public static function getGamepadName(jid:Int):hl.Bytes;
	@:hlNative("glfw", "get_gamepad_state")
	public static function getGamepadState(jid:Int, state:hl.Abstract<"GLFWgamepadstate">):Int;
	@:hlNative("glfw", "set_clipboard_string")
	public static function setClipboardString(window:hl.Abstract<"GLFWwindow">, string:hl.Bytes):Void;
	@:hlNative("glfw", "get_clipboard_string")
	public static function getClipboardString(window:hl.Abstract<"GLFWwindow">):hl.Bytes;
	@:hlNative("glfw", "get_time")
	public static function getTime():Float;
	@:hlNative("glfw", "set_time")
	public static function setTime(time:Float):Void;
	@:hlNative("glfw", "get_timer_value")
	public static function getTimerValue():hl.I64;
	@:hlNative("glfw", "get_timer_frequency")
	public static function getTimerFrequency():hl.I64;
	@:hlNative("glfw", "make_context_current")
	public static function makeContextCurrent(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "get_current_context")
	public static function getCurrentContext():hl.Abstract<"GLFWwindow">;
	@:hlNative("glfw", "swap_buffers")
	public static function swapBuffers(window:hl.Abstract<"GLFWwindow">):Void;
	@:hlNative("glfw", "swap_interval")
	public static function swapInterval(interval:Int):Void;
	@:hlNative("glfw", "extension_supported")
	public static function extensionSupported(extension:hl.Bytes):Int;
	@:hlNative("glfw", "get_proc_address_fn")
	public static function getProcAddressFn():hl.Bytes;
	@:hlNative("glfw", "vulkan_supported")
	public static function vulkanSupported():Int;
	@:hlNative("glfw", "get_required_instance_extensions")
	public static function getRequiredInstanceExtensions(count:hl.Bytes):hl.Bytes;
}
