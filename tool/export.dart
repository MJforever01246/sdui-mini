import 'dart:io';

import 'package:sdui_mini/bundle/definition.dart';

/// From mini root: dart run tool/export.dart
void main() {
  final bundle = buildTradingMiniBundle();
  for (final folder in ['publish', 'dist']) {
    Directory(folder).createSync(recursive: true);
    final file = File('$folder/bundle.json');
    file.writeAsStringSync('${bundle.toPrettyJson()}\n');
    stdout.writeln('Wrote ${file.absolute.path}');
  }
}
