package;

import sys.io.File;
import haxe.io.Bytes;
import sys.FileSystem;
import haxe.io.Path;
import sys.io.Process;
import sys.thread.Thread;
import sys.thread.Deque;

using StringTools;

typedef ProcResult = {code:Int, stdout:String, stderr:String};

class Main {
	static inline var NAME:String = "glfw";
	static inline var HAXELIB:String = "hl_glfw";

	static function printUsage():Void {
		Sys.println('Usage: haxelib run $HAXELIB [options]');
		Sys.println('');
		Sys.println('Options:');
		Sys.println('  --static-hdll    Build a static library (${NAME}_static.lib / ${NAME}_static.a + ${NAME}_static.deps)');
		Sys.println('                   to link straight into the HLC executable, instead of a $NAME.hdll.');
		Sys.println('                   Same as passing -DSTATIC_HDLL to the build.');
		Sys.println('  --dynamic-hdll   Build the $NAME.hdll (default).');
		Sys.println('  -h, --help       Show this help.');
	}

	static function main() {
		var staticHdll:Bool = false;
		var positional:Array<String> = [];

		for (a in Sys.args()) {
			switch (a) {
				case "--static-hdll", "-DSTATIC_HDLL":
					staticHdll = true;
				case "--dynamic-hdll":
					staticHdll = false;
				case "-h", "--help":
					printUsage();
					Sys.exit(0);
				default:
					if (a.startsWith("-")) {
						Sys.println('Unknown option: $a');
						Sys.println('');
						printUsage();
						Sys.exit(1);
					}
					positional.push(a);
			}
		}

		var original:String = positional.length > 0 ? Path.normalize(positional[positional.length - 1]) : Path.normalize(Sys.getCwd());

		var archFlag = getArchFlag();

		var proc:Process = new Process("haxelib", ["path", HAXELIB]);
		var code = proc.exitCode();
		if (code != 0) {
			Sys.println('Error getting the $HAXELIB path: ' + proc.stderr.readAll().toString());
			Sys.exit(code);
		}

		var path:String = Path.normalize(proc.stdout.readLine()).split("src")[0];
		var project:String = Path.join([path, "project"]);

		Sys.setCwd(project);

		var outArch = getOutArch(archFlag);

		resetObjIfModeChanged(staticHdll);

		if (staticHdll) {
			buildStatic(archFlag, outArch, original);
		} else {
			buildDynamic(archFlag, outArch, original);
		}
	}

	static function buildStatic(archFlag:String, outArch:String, original:String):Void {
		var res = runWithSpinner("Compiling static library", "haxelib", ["run", "hxcpp", "Build.xml", archFlag, "-DSTATIC_HDLL"]);
		if (res.code != 0) {
			Sys.println("static library build error: " + res.stderr);
			Sys.exit(res.code);
		}

		var libName:String = staticLibFileName();
		var built:String = Path.join(["binaries", outArch, libName]);
		if (!FileSystem.exists(built)) {
			Sys.println('Error: $built was not produced.');
			Sys.exit(1);
		}

		Sys.println("Compiled successfully!");

		File.saveBytes(Path.join([original, libName]), File.getBytes(built));

		var depsName:String = '${NAME}_static.deps';
		File.saveContent(Path.join([original, depsName]), systemLibs().join("\n") + "\n");

		Sys.println('Static library: ' + Path.join([original, libName]));
		Sys.println('Link dependencies: ' + Path.join([original, depsName]));
	}

	static function staticLibFileName():String {
		return '${NAME}_static' + (Sys.systemName() == "Windows" ? ".lib" : ".a");
	}

	static function systemLibs():Array<String> {
		return switch (Sys.systemName()) {
			case "Windows": ["opengl32.lib", "gdi32.lib", "user32.lib", "shell32.lib", "winmm.lib"];
			case "Linux": ["-lGL", "-lX11", "-lpthread", "-ldl", "-lm"];
			case "Mac": ["-framework Cocoa", "-framework OpenGL", "-framework IOKit", "-framework CoreVideo"];
			default: [];
		}
	}

	static function resetObjIfModeChanged(staticHdll:Bool):Void {
		var marker:String = Path.join(["obj", ".hdll_mode"]);
		var mode:String = staticHdll ? "static" : "dynamic";

		if (FileSystem.exists(marker) && File.getContent(marker) == mode)
			return;

		if (FileSystem.exists("obj"))
			deleteDirectoryRecursive("obj");
		FileSystem.createDirectory("obj");
		File.saveContent(marker, mode);
	}

	static function deleteDirectoryRecursive(dir:String):Void {
		for (item in FileSystem.readDirectory(dir)) {
			var p = Path.join([dir, item]);
			if (FileSystem.isDirectory(p))
				deleteDirectoryRecursive(p);
			else
				FileSystem.deleteFile(p);
		}
		FileSystem.deleteDirectory(dir);
	}

	static function buildDynamic(archFlag:String, outArch:String, original:String):Void {
		if (Sys.systemName() == "Windows") {
			var importLib = Path.join([Sys.getCwd(), "binaries", outArch, "libhl.lib"]);
			if (!FileSystem.exists(importLib)) {
				var res = runWithSpinner("Compiling hashlink", "haxelib", ["run", "hxcpp", "BuildHashlink.xml", archFlag]);
				if (res.code != 0) {
					Sys.println("Hashlink build error: " + res.stderr);
					Sys.exit(res.code);
				}
				var found = findFile("obj", "libhl.lib");
				if (found == null) {
					Sys.println("Error: libhl.lib (import lib of libhl.dll) was not produced under " + Path.join([Sys.getCwd(), "obj"]));
					Sys.exit(1);
				}
				File.copy(found, importLib);
			}
		}

		var res = runWithSpinner("Compiling hdll", "haxelib", ["run", "hxcpp", "Build.xml", archFlag]);
		if (res.code != 0) {
			Sys.println("hdll build error: " + res.stderr);
			Sys.exit(res.code);
		}

		Sys.println("Compiled successfully!");

		var hdllPath:String = Path.join(["binaries", outArch, '$NAME.hdll']);
		var built:Bytes = File.getBytes(hdllPath);
		if (built.toString().indexOf("hl_global_init") >= 0) {
			Sys.println('Warning: $NAME.hdll seems to contain its own copy of the HashLink runtime. Callbacks will crash; it must import libhl instead.');
		}

		File.saveBytes(Path.join([original, '$NAME.hdll']), built);
	}

	static function findFile(dir:String, name:String):String {
		if (!FileSystem.exists(dir))
			return null;
		for (item in FileSystem.readDirectory(dir)) {
			var p = Path.join([dir, item]);
			if (FileSystem.isDirectory(p)) {
				var r = findFile(p, name);
				if (r != null)
					return r;
			} else if (item == name)
				return p;
		}
		return null;
	}

	static function getArchFlag():String {
		var raw:String;
		if (Sys.systemName() == "Windows") {
			raw = Sys.getEnv("PROCESSOR_ARCHITECTURE");
			if (raw == null) raw = "AMD64";
		} else {
			var p = new Process("uname", ["-m"]);
			p.exitCode();
			raw = p.stdout.readLine();
		}
		raw = raw.toLowerCase();

		if (raw.indexOf("arm64") >= 0 || raw.indexOf("aarch64") >= 0)
			return "-DHXCPP_ARM64";
		if (raw.indexOf("arm") >= 0)
			return "-DHXCPP_ARM7";

		return "-DHXCPP_M64";
	}

	static function getOutArch(archFlag:String):String {
		return switch (Sys.systemName()) {
			case "Windows": "Windows64";
			case "Linux":
				switch (archFlag) {
					case "-DHXCPP_ARM64": "LinuxArm64";
					default: "Linux64";
				}
			case "Mac":
				switch (archFlag) {
					case "-DHXCPP_ARM64": "MacArm64";
					default: "Mac64";
				}
			default: "unknown";
		}
	}

	static function runWithSpinner(label:String, cmd:String, args:Array<String>):ProcResult {
		var queue = new Deque<ProcResult>();

		Thread.create(() -> {
			var p = new Process(cmd, args);

			var stdoutBuf = new StringBuf();
			var stderrBuf = new StringBuf();

			var stdoutThread = Thread.create(() -> {
				try {
					while (true)
						stdoutBuf.addChar(p.stdout.readByte());
				} catch (e:haxe.io.Eof) {}
			});
			var stderrThread = Thread.create(() -> {
				try {
					while (true)
						stderrBuf.addChar(p.stderr.readByte());
				} catch (e:haxe.io.Eof) {}
			});

			var c = p.exitCode();

			Sys.sleep(0.05);

			queue.add({
				code: c,
				stdout: stdoutBuf.toString(),
				stderr: stderrBuf.toString()
			});
		});

		var dots = 0;
		var result:ProcResult = null;

		while (result == null) {
			result = queue.pop(false);

			if (result == null) {
				var anim = [for (i in 0...(dots % 4)) "."].join("");
				Sys.print("\r" + label + anim + "    ");
				Sys.stdout().flush();
				dots++;
				Sys.sleep(0.3);
			}
		}

		Sys.println("\r" + label + "... done!" + "     ");
		if (result.stdout.length > 0)
			Sys.println(result.stdout);

		return result;
	}
}
