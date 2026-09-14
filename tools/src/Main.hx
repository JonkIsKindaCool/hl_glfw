package;

import sys.io.File;
import haxe.io.Bytes;
import sys.FileSystem;
import haxe.io.Path;
import sys.io.Process;
import sys.thread.Thread;
import sys.thread.Deque;

typedef ProcResult = {code:Int, stdout:String, stderr:String};

class Main {
	static function main() {
		var args = Sys.args();
		var original:String = args.length > 0 ? Path.normalize(args[args.length - 1]) : Path.normalize(Sys.getCwd());

		var archFlag = getArchFlag();

		var proc:Process = new Process("haxelib", ["path", "hl_glfw"]);
		var code = proc.exitCode();
		if (code != 0) {
			Sys.println("Error getting the hl_glfw path: " + proc.stderr.readAll().toString());
			Sys.exit(code);
		}

		var path:String = Path.normalize(proc.stdout.readLine()).split("src")[0];
		var project:String = Path.join([path, "project"]);

		Sys.setCwd(project);

		var outArch = getOutArch(archFlag);
		var libPath = Path.join([project, "binaries", outArch, "hl.lib"]);
		if (!FileSystem.exists(libPath)) {
			var res = runWithSpinner("Compiling hashlink", "haxelib", ["run", "hxcpp", "BuildHashlink.xml", archFlag]);
			if (res.code != 0) {
				Sys.println("Hashlink build error: " + res.stderr);
				Sys.exit(res.code);
			}
		}

		var res = runWithSpinner("Compiling hdll", "haxelib", ["run", "hxcpp", "Build.xml", archFlag]);
		if (res.code != 0) {
			Sys.println("hdll build error: " + res.stderr);
			Sys.exit(res.code);
		}

		Sys.println("Compiled successfully!");

		var bytes:Bytes = File.getBytes(Path.join(["binaries", outArch, "glfw.hdll"]));
		File.saveBytes(Path.join([original, "glfw.hdll"]), bytes);
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
