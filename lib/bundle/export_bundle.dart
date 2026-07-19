import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../sdui/models.dart';

class ExportResult {
  const ExportResult({
    required this.path,
    required this.json,
  });

  final String path;
  final String json;
}

/// Ghi bundle.json vào mini/publish (desktop) hoặc documents (mobile).
Future<ExportResult> exportBundle(SduiBundle bundle) async {
  final json = bundle.toPrettyJson();

  late final Directory targetDir;
  if (!kIsWeb &&
      (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    targetDir = Directory(p.join(Directory.current.path, 'publish'));
  } else {
    final docs = await getApplicationDocumentsDirectory();
    targetDir = Directory(p.join(docs.path, 'sdui_export'));
  }

  if (!await targetDir.exists()) {
    await targetDir.create(recursive: true);
  }

  final file = File(p.join(targetDir.path, 'bundle.json'));
  await file.writeAsString('$json\n');
  return ExportResult(path: file.path, json: json);
}
