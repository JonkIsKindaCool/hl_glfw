# Hashlink GLFW

Bindings and wrappers of [GLFW](https://www.glfw.org/) for the [Hashlink](https://hashlink.haxe.org/) target, letting you create windows, contexts, and handle input directly from Haxe.

## Features

- Window creation and management (size, title, resizing, close events)
- OpenGL context creation and control (`makeCurrent`, swap interval, buffer swapping)
- Keyboard and input event callbacks
- Thin wrapper around GLFW, staying close to the native API for familiarity
- Works alongside `hl_glad` for OpenGL function loading

## Installation

Install via haxelib:

```bash
haxelib install hl_glfw
```

Then add it to your project's `.hxml`:

```
-lib hl_glfw
```

## Requirements

To build the native `.hdll` files you'll need:

- [HXCPP](https://github.com/HaxeFoundation/hxcpp)
- A C/C++ compiler (e.g. GCC, Clang, or MSVC depending on your platform)

## Build

To build the `.hdll` files, run:

```bash
haxelib run hl_glfw build
```

This compiles the native GLFW bindings for your current platform.

## Usage/Examples

```haxe
import hl.glfw.GlfwWindow;
import hl.glfw.GlfwContext;
import hl.glfw.GlfwInput;

class Main {
	static function main():Void {
		if (!GlfwContext.init()) {
			trace("Error initializing GLFW");
			return;
		}

		var window:GlfwWindow = new GlfwWindow(800, 600, "Simple GLFW Window");

		if (window == null) {
			trace("Error creating GLFW window");
			GlfwContext.terminate();
			return;
		}

		window.onSizeChanged = (w, h) -> {
			trace('Size Change(w: $w, h: $h)');
		};

		window.makeCurrent();
		GlfwContext.setSwapInterval(1);

		window.onKey = function(key:Int, scancode:Int, action:GlfwKeyAction, mods:GlfwKeyMod):Void {
			if (action == PRESS && key == 256) {
				window.shouldClose = true;
			}
		};

		while (!window.shouldClose) {
			GlfwContext.pollEvents();

			window.swapBuffers();
		}

		window.destroy();
		GlfwContext.terminate();
	}
}
```

## API Overview

| Class | Description |
|---|---|
| `GlfwContext` | Global GLFW state: initialization, termination, event polling, swap interval |
| `GlfwWindow` | Window creation and management, size/close callbacks, buffer swapping |
| `GlfwInput` | Input event types (keys, mods, actions) used in window callbacks |
| `GlfwKey` | GLFW Keycodes |
| `GlfwMonitor` | Monitor management, get the size, name, position, etc |
| `GlfwTime` | Utilities for time management in GLFW |

## Contributing

Issues and pull requests are welcome! If you run into a bug or are missing a GLFW feature, feel free to open an issue.

## License

MIT License — see [LICENSE](LICENSE) for details.