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
<html lang="vi">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>SDUI Mini · Public publish</title>
  <style>
    body { font-family: Segoe UI, system-ui, sans-serif; max-width: 720px; margin: 32px auto; padding: 0 16px; line-height: 1.45; }
    code, pre { background: #f4f3ef; padding: 2px 6px; border-radius: 4px; }
    pre { padding: 12px; overflow: auto; }
  </style>
</head>
<body>
  <h1>SDUI Mini — public link</h1>
  <p>Bundle: <a href="./bundle.json"><code>bundle.json</code></a> (version ${map['version']})</p>
  <p>GitHub raw:
    <code>https://raw.githubusercontent.com/MJforever01246/sdui-mini/main/publish/bundle.json</code>
  </p>
  <pre>python -m http.server 8080</pre>
  <p>Super → Open from URL → <code>http://127.0.0.1:8080/bundle.json</code></p>
</body>
</html>
''');

  stdout.writeln('Exported: ${outFile.path}');
  stdout.writeln('Version: ${map['version']}');
  stdout.writeln(
    'Serve: python -m http.server 8080 --directory publish',
  );
}
