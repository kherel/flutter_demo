import 'package:logging/logging.dart';
import 'package:ansicolor/ansicolor.dart';

void loggerConfig() {
  final white = AnsiPen()..white(bold: false);
  final redBg = AnsiPen()..rgb(bg: true, g: 0, b: 0, r:253)..white(bold: true);

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    if (rec.error == null) {
      print('${white(rec.loggerName)}: ${rec.message}');
    } else {
      print('${redBg(rec.loggerName)}: ${rec.message}, ${rec.error}');
    }
  });
}
