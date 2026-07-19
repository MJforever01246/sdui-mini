import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:sdui_mini/bundle/definition.dart';

/// CLI export.
///
///   cd mini
///   dart run tool/export_bundle.dart
///   dart run tool/export_bundle.dart --version 1.0.1
void main(List<String> args) {
  var version = '';
  for (var i = 0; i < args.length; i++) {
    if (args[i] == '--version' && i + 1 < args.length) {
      version = args[i + 1];
    }
  }

  final bundle = buildTradingMiniBundle();
  final map = bundle.toJson();
  if (version.isNotEmpty) {
    map['version'] = version;
  }

  final publishDir = Directory(p.join(Directory.current.path, 'publish'));
  if (!publishDir.existsSync()) {
    publishDir.createSync(recursive: true);
  }

  final outFile = File(p.join(publishDir.path, 'bundle.json'));
  final json = const JsonEncoder.withIndent('  ').convert(map);
  outFile.writeAsStringSync('$json\n');

  File(p.join(publishDir.path, 'index.html')).writeAsStringSync('''
<!doctype html>
<html>
  <head><meta charset="utf-8"><title>SDUI Mini Publish</title></head>
  <body>
    <h1>SDUI Mini publish folder</h1>
    <p>Open in Super:</p>
    <code>/bundle.json</code>
  </body>
</html>
''');

  stdout.writeln('Exported: ${outFile.path}');
  stdout.writeln('Version: ${map['version']}');
  stdout.writeln(
    'Serve: python -m http.server 8080 --directory publish',
  );
}
