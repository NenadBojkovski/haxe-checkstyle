package checkstyle.reporter;

import checkstyle.LintMessage.SeverityLevel;
import sys.io.File;
import sys.io.FileOutput;
import haxe.io.Output;

class TextReporter implements IReporter {

	var report:StringBuf;
	var file:FileOutput;

	var errors:Int;
	var warnings:Int;
	var infos:Int;
	var total:Int;

	public function new(path:String) {
		if (path != null) {
			file = File.write(path);
			report = new StringBuf();
		}
	}

	static function severityString(s:SeverityLevel):String {
		return switch (s){
			case INFO: return "Info";
			case WARNING: return "Warning";
			case ERROR: return "Error";
			case IGNORE: return "Ignore";
		}
	}

	public function start() {
		errors = 0;
		warnings = 0;
		infos = 0;
		total = 0;
		Sys.println("");
		Sys.println("Running Checkstyle...");
		Sys.println("");
	}

	@SuppressWarnings('checkstyle:LineLength')
	public function finish() {
		if (file != null) {
			file.writeString(report.toString());
			file.close();
		}

		total = errors + warnings + infos;
		if (Sys.systemName() == "Windows") {
			Sys.println("Total Issues: " + total + " Errors: " + errors + " Warnings: " + warnings + " Infos: " + infos);
		}
		else {
			Sys.println("\033[1m\nTotal Issues: " + total + " (\033[0m\033[91mErrors: " + errors + "\033[0m, \033[95mWarnings: " + warnings + "\033[0m, \033[94mInfos: " + infos + ")\n" + "\033[0m");
		}
	}

	public function fileStart(f:LintFile) {}

	public function fileFinish(f:LintFile) {}

	public function addMessage(m:LintMessage) {
		var sb:StringBuf = new StringBuf();
		sb.add(m.fileName);
		sb.add(':');
		sb.add(m.line);
		if (m.startColumn >= 0) {
			var isRange = m.startColumn != m.endColumn;
			sb.add(': character${isRange ? "s" : ""} ');
			sb.add(m.startColumn);
			if (isRange) {
				sb.add('-');
				sb.add(m.endColumn);
			}
			sb.add(' ');
		}
		sb.add(": ");
		sb.add(severityString(m.severity));
		sb.add(": ");
		sb.add(m.message);
		sb.add("\n");

		var output:Output = Sys.stderr();

		switch (m.severity) {
			case ERROR: errors++;
			case WARNING: warnings++;
			case INFO:
				infos++;
				output = Sys.stdout();
			default:
		}

		var line = sb.toString();
		output.writeString(line);
		if (file != null) report.add(line);
	}
}