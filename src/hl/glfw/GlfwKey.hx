package hl.glfw;

enum abstract GlfwKey(Int) from Int to Int {
	var UNKNOWN = -1;

	var SPACE = 32;
	var APOSTROPHE = 39;
	var COMMA = 44;
	var MINUS = 45;
	var PERIOD = 46;
	var SLASH = 47;
	var ZERO = 48;
	var ONE = 49;
	var TWO = 50;
	var THREE = 51;
	var FOUR = 52;
	var FIVE = 53;
	var SIX = 54;
	var SEVEN = 55;
	var EIGHT = 56;
	var NINE = 57;
	var SEMICOLON = 59;
	var EQUAL = 61;
	var A = 65;
	var B = 66;
	var C = 67;
	var D = 68;
	var E = 69;
	var F = 70;
	var G = 71;
	var H = 72;
	var I = 73;
	var J = 74;
	var K = 75;
	var L = 76;
	var M = 77;
	var N = 78;
	var O = 79;
	var P = 80;
	var Q = 81;
	var R = 82;
	var S = 83;
	var T = 84;
	var U = 85;
	var V = 86;
	var W = 87;
	var X = 88;
	var Y = 89;
	var Z = 90;
	var LEFT_BRACKET = 91;
	var BACKSLASH = 92;
	var RIGHT_BRACKET = 93;
	var GRAVE_ACCENT = 96;
	var WORLD_1 = 161;
	var WORLD_2 = 162;

	var ESCAPE = 256;
	var ENTER = 257;
	var TAB = 258;
	var BACKSPACE = 259;
	var INSERT = 260;
	var DELETE = 261;
	var RIGHT = 262;
	var LEFT = 263;
	var DOWN = 264;
	var UP = 265;
	var PAGE_UP = 266;
	var PAGE_DOWN = 267;
	var HOME = 268;
	var END = 269;
	var CAPS_LOCK = 280;
	var SCROLL_LOCK = 281;
	var NUM_LOCK = 282;
	var PRINT_SCREEN = 283;
	var PAUSE = 284;
	var F1 = 290;
	var F2 = 291;
	var F3 = 292;
	var F4 = 293;
	var F5 = 294;
	var F6 = 295;
	var F7 = 296;
	var F8 = 297;
	var F9 = 298;
	var F10 = 299;
	var F11 = 300;
	var F12 = 301;
	var F13 = 302;
	var F14 = 303;
	var F15 = 304;
	var F16 = 305;
	var F17 = 306;
	var F18 = 307;
	var F19 = 308;
	var F20 = 309;
	var F21 = 310;
	var F22 = 311;
	var F23 = 312;
	var F24 = 313;
	var F25 = 314;

	var KP_0 = 320;
	var KP_1 = 321;
	var KP_2 = 322;
	var KP_3 = 323;
	var KP_4 = 324;
	var KP_5 = 325;
	var KP_6 = 326;
	var KP_7 = 327;
	var KP_8 = 328;
	var KP_9 = 329;
	var KP_DECIMAL = 330;
	var KP_DIVIDE = 331;
	var KP_MULTIPLY = 332;
	var KP_SUBTRACT = 333;
	var KP_ADD = 334;
	var KP_ENTER = 335;
	var KP_EQUAL = 336;

	var LEFT_SHIFT = 340;
	var LEFT_CONTROL = 341;
	var LEFT_ALT = 342;
	var LEFT_SUPER = 343;
	var RIGHT_SHIFT = 344;
	var RIGHT_CONTROL = 345;
	var RIGHT_ALT = 346;
	var RIGHT_SUPER = 347;
	var MENU = 348;

	public inline function getName(scancode:Int = 0):String {
		var b = hl.bindings.GlfwBindings.getKeyName(this, scancode);
		return b == null ? "?" : @:privateAccess String.fromUTF8(b);
	}

	@:to
	public inline function toString():String {
		return getName(getScancode());
	}

	public inline function getScancode():Int {
		return hl.bindings.GlfwBindings.getKeyScancode(this);
	}
}
