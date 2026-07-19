import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bundle/definition.dart';
import 'bundle/export_bundle.dart';
import 'sdui/models.dart';
import 'sdui/renderer.dart';
import 'sdui/runtime.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MiniApp());
}

class MiniApp extends StatelessWidget {
  const MiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDUI Mini Author',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B4F72)),
        useMaterial3: true,
      ),
      home: const MiniHomePage(),
    );
  }
}

class MiniHomePage extends StatefulWidget {
  const MiniHomePage({super.key});

  @override
  State<MiniHomePage> createState() => _MiniHomePageState();
}

class _MiniHomePageState extends State<MiniHomePage> {
  final SduiBundle _bundle = buildTradingMiniBundle();
  String? _lastExportPath;
  bool _exporting = false;

  Future<void> _export() async {
    setState(() => _exporting = true);
    try {
      final result = await exportBundle(_bundle);
      setState(() => _lastExportPath = result.path);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Đã export bundle'),
          content: SelectableText(
            'File: ${result.path}\n\n'
            'Serve:\n'
            '  python -m http.server 8080 --directory publish\n\n'
            'Super URL:\n'
            '  http://127.0.0.1:8080/bundle.json',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: result.json));
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Copy JSON'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export lỗi: $e')),
      );
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  void _preview() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _PreviewPage(bundle: _bundle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Author')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Mini app (SDUI source)',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sửa lib/bundle/definition.dart → Preview → Export → '
            'serve publish/ → Super tải URL (OTA).',
          ),
          const SizedBox(height: 20),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Bundle'),
            subtitle: Text('${_bundle.id} · v${_bundle.version}'),
          ),
          FilledButton.icon(
            onPressed: _preview,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Preview mini app'),
          ),
          const SizedBox(height: 8),
          FilledButton.tonalIcon(
            onPressed: _exporting ? null : _export,
            icon: _exporting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.publish),
            label: Text(_exporting ? 'Đang export…' : 'Export bundle.json'),
          ),
          if (_lastExportPath != null) ...[
            const SizedBox(height: 16),
            Text('Last export: $_lastExportPath'),
          ],
        ],
      ),
    );
  }
}

class _PreviewPage extends StatefulWidget {
  const _PreviewPage({required this.bundle});

  final SduiBundle bundle;

  @override
  State<_PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<_PreviewPage> {
  late final SduiRuntimeController _controller =
      SduiRuntimeController(widget.bundle);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SduiHost(controller: _controller);
  }
}
