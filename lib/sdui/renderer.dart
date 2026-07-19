import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models.dart';
import 'runtime.dart';

class SduiHost extends StatelessWidget {
  const SduiHost({super.key, required this.controller});

  final SduiRuntimeController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final screen = controller.currentScreen;
        return Scaffold(
          appBar: AppBar(
            title: Text(screen.title.isEmpty
                ? controller.bundle.name
                : screen.title),
            leading: controller.canPop
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: controller.pop,
                  )
                : null,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final node in screen.body)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SduiNodeView(node: node, controller: controller),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SduiNodeView extends StatelessWidget {
  const SduiNodeView({
    super.key,
    required this.node,
    required this.controller,
  });

  final SduiNode node;
  final SduiRuntimeController controller;

  @override
  Widget build(BuildContext context) {
    switch (node.type) {
      case 'text':
        return Text(
          node.props['value']?.toString() ?? '',
          style: _textStyle(context, node.props['style']?.toString()),
          textAlign: _align(node.props['align']?.toString()),
        );
      case 'button':
        final actionRaw = node.props['action'];
        return FilledButton(
          onPressed: actionRaw == null
              ? null
              : () => controller.dispatch(
                    SduiAction.fromJson(actionRaw),
                    context,
                  ),
          child: Text(node.props['label']?.toString() ?? 'OK'),
        );
      case 'outlinedButton':
        final actionRaw = node.props['action'];
        return OutlinedButton(
          onPressed: actionRaw == null
              ? null
              : () => controller.dispatch(
                    SduiAction.fromJson(actionRaw),
                    context,
                  ),
          child: Text(node.props['label']?.toString() ?? 'OK'),
        );
      case 'textField':
        final key = node.props['name']?.toString() ?? 'field';
        final keyboard = node.props['keyboard']?.toString();
        return TextFormField(
          initialValue: controller.field(key),
          decoration: InputDecoration(
            labelText: node.props['label']?.toString(),
            hintText: node.props['hint']?.toString(),
            border: const OutlineInputBorder(),
          ),
          keyboardType: keyboard == 'number'
              ? TextInputType.number
              : keyboard == 'phone'
                  ? TextInputType.phone
                  : TextInputType.text,
          inputFormatters: keyboard == 'number'
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          onChanged: (v) => controller.setField(key, v),
        );
      case 'segmented':
        final key = node.props['name']?.toString() ?? 'segment';
        final options = (node.props['options'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList();
        final current = controller.field(key, options.isEmpty ? '' : options.first);
        if (!controller.form.containsKey(key) && options.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.setField(key, options.first);
          });
        }
        return SegmentedButton<String>(
          segments: [
            for (final o in options)
              ButtonSegment(value: o, label: Text(o)),
          ],
          selected: {current},
          onSelectionChanged: (s) => controller.setField(key, s.first),
        );
      case 'card':
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final child in node.children)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SduiNodeView(node: child, controller: controller),
                  ),
              ],
            ),
          ),
        );
      case 'column':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final child in node.children)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SduiNodeView(node: child, controller: controller),
              ),
          ],
        );
      case 'row':
        return Row(
          children: [
            for (final child in node.children)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SduiNodeView(node: child, controller: controller),
                ),
              ),
          ],
        );
      case 'space':
        final h = (node.props['height'] as num?)?.toDouble() ?? 12;
        return SizedBox(height: h);
      case 'divider':
        return const Divider();
      case 'banner':
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            node.props['value']?.toString() ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      default:
        return Text(
          'Unsupported widget: ${node.type}',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        );
    }
  }

  TextStyle? _textStyle(BuildContext context, String? style) {
    final theme = Theme.of(context).textTheme;
    return switch (style) {
      'title' => theme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      'subtitle' => theme.titleMedium,
      'caption' => theme.bodySmall,
      'body' || null => theme.bodyLarge,
      _ => theme.bodyLarge,
    };
  }

  TextAlign? _align(String? align) {
    return switch (align) {
      'center' => TextAlign.center,
      'end' => TextAlign.end,
      _ => TextAlign.start,
    };
  }
}
