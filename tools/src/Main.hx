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

		var proc:Process = new Process("haxelib", ["path", "hl_glfw"]);
		var code = proc.exitCode();
		if (code != 0) {
			Sys.println("Error getting the hl_glfw path: " + proc.stderr.readAll().toString());
			Sys.exit(code);
		}

		var path:String = Path.normalize(proc.stdout.readLine()).split("src")[0];
		var project:String = Path.join([path, "project"]);

		Sys.setCwd(project);

		var libPath = Path.join([project, "libs", "hl.lib"]);
		if (!FileSystem.exists(libPath)) {
			var res = runWithSpinner("Compiling hashlink", "haxelib", ["run", "hxcpp", "BuildHashlink.xml", "-DHXCPP_M64"]);
			if (res.code != 0) {
				Sys.println("Hashlink build error: " + res.stderr);
				Sys.exit(res.code);
			}
		}

		var res = runWithSpinner("Compiling hdll", "haxelib", ["run", "hxcpp", "Build.xml", "-DHXCPP_M64"]);
		if (res.code != 0) {
			Sys.println("Hashlink build error: " + res.stderr);
			Sys.exit(res.code);
		}

		Sys.println("Compiled Succesfully!");

		var bytes:Bytes = File.getBytes("./glfw.hdll");
		File.saveBytes(Path.join([original, "glfw.hdll"]), bytes);
	}

	static function runWithSpinner(label:String, cmd:String, args:Array<String>):ProcResult {
		var queue = new Deque<ProcResult>();

		Thread.create(() -> {
			var p = new Process(cmd, args);
			var c = p.exitCode();
			queue.add({
				code: c,
				stdout: p.stdout.readAll().toString(),
				stderr: p.stderr.readAll().toString()
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
