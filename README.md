# hl_glfw

[GLFW](https://www.glfw.org/) bindings for [HashLink](https://hashlink.haxe.org/): create windows and OpenGL
contexts, read keyboard, mouse and cursor input, query monitors and time — directly from Haxe.

The API is a thin, typed wrapper that stays close to GLFW's own, so the [GLFW documentation](https://www.glfw.org/docs/latest/)
applies almost one-to-one. Pair it with [`hl_glad`](https://github.com/JonkIsKindaCool/hl_glad) to load OpenGL
functions once you have a context.

## Contents

- [Features](#features)
- [Platforms](#platforms)
- [Installation](#installation)
- [Building the native library](#building-the-native-library)
- [Quick start](#quick-start)
- [Using it with HashLink and HashLink/C](#using-it-with-hashlink-and-hashlinkc)
- [More examples](#more-examples)
- [API overview](#api-overview)
- [Callbacks](#callbacks)
- [Notes and limitations](#notes-and-limitations)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Features

- **Windows:** creation and destruction, title, size, position, framebuffer size, content scale, opacity,
  fullscreen / windowed switching, iconify, maximize, restore, focus, attention requests, attributes, clipboard.
- **Window hints** through a fluent builder: `GlfwWindowHints.defaults().opengl(3, 3).resizable(true).samples(4)`.
- **OpenGL context:** `makeCurrent`, buffer swapping, swap interval / vsync, `getProcAddress` for loaders,
  current-context and extension queries.
- **Input:** key and mouse-button state, characters, cursor position, cursor modes, standard and custom
  cursors, scrolling, file drops, sticky keys, raw mouse motion.
- **17 callbacks**, set as plain Haxe properties (`window.onKey = ...`).
- **Monitors:** primary and all monitors, name, position, work area, physical size, content scale, gamma,
  video mode, connect / disconnect events.
- **Timing:** GLFW's high-resolution timer plus a small delta-time / FPS helper.
- **Vulkan support queries** (`isVulkanSupported`, required instance extensions).
- Works with the **HashLink VM** and with **HashLink/C** (statically or dynamically linked).

## Platforms

| Platform | Status |
|---|---|
| Windows x64 | Supported |
| Linux x64 | Supported (X11 backend; Wayland sessions run through XWayland) |
| macOS x64 / arm64, Linux arm64 | Build targets exist, not validated yet |
| Windows x86 | Not supported (the build requires 64-bit) |
| WebAssembly | Not supported |

The bundled GLFW is version 3.6.0, built against the HashLink 2.0 headers.

## Installation

```bash
haxelib install hl_glfw
```

```hxml
-lib hl_glfw
```

The Haxe side is ready to use, but the **native library must be built once for your platform** (next section).

## Building the native library

### Requirements

| Platform | You need |
|---|---|
| all | [hxcpp](https://github.com/HaxeFoundation/hxcpp) (`haxelib install hxcpp`) |
| Windows | Visual Studio or Build Tools with the **Desktop development with C++** workload, 64-bit |
| Linux | `gcc` or `clang`, plus the X11 and OpenGL development packages (Debian/Ubuntu: `libx11-dev libgl1-mesa-dev`) |
| macOS | Xcode command line tools |

### Commands

```bash
haxelib run hl_glfw                  # dynamic library: glfw.hdll            (default)
haxelib run hl_glfw --static-hdll    # static library:  glfw_static.lib|.a + glfw_static.deps
haxelib run hl_glfw --help
```

- `--dynamic-hdll` is the default and produces `glfw.hdll`, loaded at runtime. It is what the HashLink VM
  uses, and it also works with HashLink/C.
- `--static-hdll` (or `-DSTATIC_HDLL`) produces a static library that is linked **into** a HashLink/C
  executable. Next to it a `.deps` file lists the system libraries it needs (`-lGL`, `opengl32.lib`,
  frameworks, ...), one per line.
- The result is written to the **directory you run the command from**. The first build takes longer, and on
  Windows it also builds the HashLink import library the `.hdll` links against.

### Where to put the result

For the VM, put `glfw.hdll` next to your `.hl` file.

For HashLink/C with [`hl_compile`](https://github.com/JonkIsKindaCool/hl_compile), keep the libraries in your
project, split by how they are linked and by target (`Windows64`, `Linux64`, `LinuxArm64`, `Mac64`, `MacArm64`):

```
hdlls/
├─ static/
│  └─ Windows64/    glfw_static.lib  glfw_static.deps
└─ dynamic/
   └─ Windows64/    glfw.hdll
```

```bash
cd hdlls/static/Windows64  && haxelib run hl_glfw --static-hdll
cd hdlls/dynamic/Windows64 && haxelib run hl_glfw
```

If the same library exists in both folders, `hl_compile` links only the static one.

## Quick start

```haxe
import hl.glfw.GlfwContext;
import hl.glfw.GlfwWindow;
import hl.glfw.GlfwKey;
import hl.glfw.GlfwInput;

class Main {
	static function main():Void {
		if (!GlfwContext.init()) {
			Sys.println("Could not initialize GLFW");
			Sys.exit(1);
		}

		var window = new GlfwWindow(800, 600, "Hello GLFW");
		if (window == null) {
			Sys.println("Could not create the window");
			GlfwContext.terminate();
			Sys.exit(1);
		}

		window.makeCurrent();
		GlfwContext.enableVsync();

		window.onKey = (key, scancode, action, mods) -> {
			if (key == GlfwKey.ESCAPE && action == GlfwKeyAction.PRESS)
				window.shouldClose = true;
		};

		window.onSizeChanged = (w, h) -> trace('size: $w x $h');

		while (!window.shouldClose) {
			GlfwContext.pollEvents();
			window.swapBuffers();
		}

		window.destroy();
		GlfwContext.terminate();
	}
}
```

`GlfwWindowHints` comes with `import hl.glfw.GlfwWindow`; the key, mouse and action enums come with
`import hl.glfw.GlfwInput`.

## Using it with HashLink and HashLink/C

**HashLink VM** (bytecode):

```bash
haxe -lib hl_glfw -main Main --hl main.hl
hl main.hl                      # glfw.hdll next to main.hl
```

Use a HashLink 2.0 VM: the native library is built against the 2.0 headers.

**HashLink/C** through `hl_compile`:

```hxml
-lib hl_glfw
-lib hl_compile
--hl bin/main.c
--main Main
```

`haxe build.hxml` generates the C code, builds the executable and links the libraries found in `hdlls/`
(see the `hl_compile` README for the details, including the Windows runtime DLL).

## More examples

Window hints, input callbacks, fullscreen toggle and frame timing:

```haxe
GlfwWindowHints.defaults().opengl(3, 3).resizable(true).samples(4);

var window = new GlfwWindow(1280, 720, "Input demo");
window.makeCurrent();
GlfwContext.enableVsync();

window.onKey = (key, scancode, action, mods) -> {
	if (action != GlfwKeyAction.PRESS)
		return;
	if (key == GlfwKey.ESCAPE)
		window.shouldClose = true;
	if (key == GlfwKey.F11)
		window.goFullscreen();
};

window.onMouseButton = (button, action, mods) -> {
	if (button == GlfwMouseButton.LEFT && action == GlfwKeyAction.PRESS)
		trace("left click");
};

window.onCursorPos = (x, y) -> {};
window.onScroll = (dx, dy) -> trace('scroll: $dy');
window.onDrop = paths -> trace('dropped: $paths');

var clock = new GlfwDeltaClock();
while (!window.shouldClose) {
	GlfwContext.pollEvents();

	var dt = clock.tick(); // seconds since the previous tick
	window.title = 'Input demo - ${Std.int(clock.fps)} fps';

	window.swapBuffers();
}
```

Polling instead of callbacks:

```haxe
if (window.isKeyDown(GlfwKey.SPACE)) { /* ... */ }
var cursor = window.getCursorPos(); // {x:Float, y:Float}
```

Monitors:

```haxe
for (monitor in GlfwMonitor.getAll())
	trace(monitor.name);

window.goFullscreen(GlfwMonitor.primary);
```

## API overview

| Type | Covers |
|---|---|
| `GlfwContext` | init / terminate, init hints, platform selection, event loop (`pollEvents`, `waitEvents`, `waitEventsTimeout`, `postEmptyEvent`), swap interval, `getProcAddressFn`, current context, extension and Vulkan queries, version, `getError` |
| `GlfwWindow` | create / destroy, title, size, position, framebuffer size, content scale, opacity, fullscreen / windowed, iconify / maximize / restore / focus, attributes, clipboard, `shouldClose`, the callbacks |
| `GlfwWindowHints` | fluent builder for window and context hints (defined in `GlfwWindow.hx`) |
| `GlfwInput` | key and mouse state, key names, cursor position / modes / shapes / custom cursors, sticky keys, raw mouse motion; also the input enums (`GlfwKeyAction`, `GlfwKeyMod`, `GlfwMouseButton`, `GlfwCursorMode`, ...) and callback types |
| `GlfwKey` | keycodes |
| `GlfwMonitor` | monitors, name, position, work area, physical size, content scale, gamma, video mode, `onChange` |
| `GlfwTime` | GLFW timer: `time`, `reset`, `timerValue`, `timerFrequency` |
| `GlfwDeltaClock` | frame delta time and FPS |

## Callbacks

Set them as properties on a `GlfwWindow`:

| Property | Arguments |
|---|---|
| `onPosChanged` | `x, y` |
| `onSizeChanged` | `width, height` |
| `onClose` | — |
| `onRefresh` | — |
| `onFocusChanged` | `focused` |
| `onIconifyChanged` | `iconified` |
| `onMaximizeChanged` | `maximized` |
| `onFramebufferSizeChanged` | `width, height` |
| `onContentScaleChanged` | `xscale, yscale` |
| `onKey` | `key, scancode, action, mods` |
| `onChar` | `codepoint` |
| `onCharMods` | `codepoint, mods` |
| `onMouseButton` | `button, action, mods` |
| `onCursorPos` | `x, y` |
| `onCursorEnter` | `entered` |
| `onScroll` | `xOffset, yOffset` |
| `onDrop` | `paths` |

Monitor connect / disconnect is `GlfwMonitor.onChange = (monitor, event) -> ...`.

## Notes and limitations

- **Main thread only.** As in GLFW, create windows and poll events from the thread that initialised GLFW.
- **Callbacks are global per kind, not per window.** Setting `onKey` on a second window replaces the first
  window's handler. Treat the callbacks as single-window for now.
- **Callbacks may run inside the call that triggers them** (for example resizing a window from code on
  Windows), not only during `pollEvents`. Do not rely on them arriving at a fixed point of your loop.
- **Exceptions inside a callback do not crash the process.** They are caught, printed to stderr, and the
  program continues.
- **A failed `new GlfwWindow(...)` yields `null`.** Always check it.
- **No error callback.** Check `GlfwContext.getError()` / `GlfwContext.ok()` after calls that can fail.
- **Joysticks and gamepads** are not exposed yet (only their constants are).

## Troubleshooting

| Symptom | Likely cause and fix |
|---|---|
| `Could not load library glfw.hdll` | The `.hdll` is not next to the `.hl` file (VM), or is not in `hdlls/dynamic/<target>` (`hl_compile`). |
| `libhl.dll` not found (Windows) | Run the executable from its `build/<target>` folder; `hl_compile` copies the DLL there. |
| `Compiling HDLL requires 64 bits` | On Windows the native library only builds for 64-bit. |
| Crash the moment a callback fires | Two HashLink runtimes in the process. Rebuild the library with the current version; `hl_compile` refuses to link a `.hdll` that embeds its own runtime. |
| `GlfwContext.init()` returns false on Linux | No display available: run inside a graphical session (`DISPLAY` must be set). |
| Second window ignores its callbacks | Callbacks are global per kind, see [limitations](#notes-and-limitations). |

## Contributing

Issues and pull requests are welcome. If you hit a bug or miss a GLFW feature, open an issue.

## License

MIT — see [LICENSE](LICENSE).

The repository bundles third-party code, each under its own license:
[GLFW](https://www.glfw.org/license.html) (zlib/libpng, `project/libs/glfw`) and
[HashLink](https://github.com/HaxeFoundation/hashlink) (MIT, `project/libs/hashlink`).