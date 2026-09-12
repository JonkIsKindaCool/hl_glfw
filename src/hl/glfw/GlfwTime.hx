package hl.glfw;

import hl.bindings.GlfwBindings;

/**
 * High-precision GLFW timer utilities.
 *
 * ```haxe
 * var clock = new GlfwTime.GlfwDeltaClock();
 *
 * while (!window.shouldClose) {
 *   var dt = clock.tick();   // seconds since last tick
 *   update(dt);
 *   Context.pollEvents();
 *   window.swapBuffers();
 * }
 * ```
 */
class GlfwTime {
	/**
	 * Seconds elapsed since GLFW was initialised (or since `reset()` was called).
	 * Resolution is generally in the microsecond range.
	 */
	public static var time(get, set):Float;

	private static inline function get_time():Float
		return GlfwBindings.getTime();

	private static inline function set_time(value:Float):Float {
		GlfwBindings.setTime(value);
		return value;
	}

	/** Resets the clock to zero. Equivalent to `time = 0.0`. */
	public static inline function reset():Void
		GlfwBindings.setTime(0.0);

	/**
	 * The current value of the raw high-resolution timer, in ticks.
	 * Divide by `timerFrequency` to get seconds.
	 * This counter never wraps and is not affected by `setTime`.
	 */
	public static var timerValue(get, never):haxe.Int64;
	private static inline function get_timerValue():haxe.Int64
		return GlfwBindings.getTimerValue();

	/**
	 * Ticks per second of the raw timer.
	 * Typically 1 000 000 000 on modern platforms (nanosecond resolution).
	 */
	public static var timerFrequency(get, never):haxe.Int64;
	private static inline function get_timerFrequency():haxe.Int64
		return GlfwBindings.getTimerFrequency();

	/**
	 * Converts a raw timer value (from `timerValue`) to seconds.
	 */
	public static inline function ticksToSeconds(ticks:haxe.Int64):Float
		return haxe.Int64.toInt(ticks) / haxe.Int64.toInt(GlfwBindings.getTimerFrequency());

	/**
	 * Returns the time elapsed since `last` and updates `last` to now.
	 * Convenience for one-liner delta-time tracking without a full DeltaClock.
	 *
	 * ```haxe
	 * var last = GlfwTime.time;
	 * while (running) {
	 *   var dt = GlfwTime.lap(last);
	 * }
	 * ```
	 */
	public static inline function lap(last:Float):Float {
		var now = GlfwBindings.getTime();
		var dt  = now - last;
                
		return dt;
	}
}

/**
 * Tracks per-frame delta time.
 *
 * ```haxe
 * var clock = new GlfwDeltaClock();
 * while (running) {
 *   var dt = clock.tick();   // seconds since last call
 *   var fps = clock.fps;     // smoothed frames per second
 * }
 * ```
 */
class GlfwDeltaClock {
	var _last:Float;
	var _delta:Float = 0.0;

	// Simple exponential moving average for FPS display.
	var _smoothFps:Float = 0.0;
	static inline var FPS_ALPHA:Float = 0.05;

	public function new() {
		_last = GlfwBindings.getTime();
	}

	/**
	 * Call once per frame.  Returns the time in seconds since the previous call.
	 */
	public function tick():Float {
		var now = GlfwBindings.getTime();
		_delta = now - _last;
		_last  = now;

		var instantFps = _delta > 0.0 ? 1.0 / _delta : 0.0;
		_smoothFps = _smoothFps == 0.0 ? instantFps : _smoothFps + FPS_ALPHA * (instantFps - _smoothFps);

		return _delta;
	}

	/** Delta time (seconds) from the most recent `tick()` call. */
	public var delta(get, never):Float;
	private inline function get_delta():Float return _delta;

	/** Smoothed frames-per-second estimate. */
	public var fps(get, never):Float;
	private inline function get_fps():Float return _smoothFps;

	/** Resets the clock so the next `tick()` returns a near-zero delta. */
	public inline function reset():Void
		_last = GlfwBindings.getTime();
}
