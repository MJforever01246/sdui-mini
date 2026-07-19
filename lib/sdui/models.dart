import 'dart:convert';

class SduiBundle {
  const SduiBundle({
    required this.id,
    required this.name,
    required this.version,
    required this.entry,
    required this.screens,
  });

  final String id;
  final String name;
  final String version;
  final String entry;
  final Map<String, SduiScreen> screens;

  factory SduiBundle.fromJson(Map<String, dynamic> json) {
    final screensJson = json['screens'] as Map<String, dynamic>? ?? {};
    return SduiBundle(
      id: json['id'] as String? ?? 'unknown',
      name: json['name'] as String? ?? 'Mini App',
      version: json['version'] as String? ?? '0.0.0',
      entry: json['entry'] as String? ?? 'home',
      screens: screensJson.map(
        (key, value) => MapEntry(
          key,
          SduiScreen.fromJson(value as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory SduiBundle.fromJsonString(String raw) {
    return SduiBundle.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'version': version,
        'entry': entry,
        'screens': screens.map((k, v) => MapEntry(k, v.toJson())),
      };

  String toPrettyJson() =>
      const JsonEncoder.withIndent('  ').convert(toJson());
}

class SduiScreen {
  const SduiScreen({
    required this.title,
    required this.body,
  });

  final String title;
  final List<SduiNode> body;

  factory SduiScreen.fromJson(Map<String, dynamic> json) {
    final body = (json['body'] as List<dynamic>? ?? [])
        .map((e) => SduiNode.fromJson(e as Map<String, dynamic>))
        .toList();
    return SduiScreen(
      title: json['title'] as String? ?? '',
      body: body,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body.map((e) => e.toJson()).toList(),
      };
}

class SduiNode {
  const SduiNode({
    required this.type,
    this.props = const {},
    this.children = const [],
  });

  final String type;
  final Map<String, dynamic> props;
  final List<SduiNode> children;

  factory SduiNode.fromJson(Map<String, dynamic> json) {
    final children = (json['children'] as List<dynamic>? ?? [])
        .map((e) => SduiNode.fromJson(e as Map<String, dynamic>))
        .toList();
    final props = Map<String, dynamic>.from(json['props'] as Map? ?? {});
    for (final entry in json.entries) {
      if (entry.key == 'type' ||
          entry.key == 'props' ||
          entry.key == 'children') {
        continue;
      }
      props.putIfAbsent(entry.key, () => entry.value);
    }
    return SduiNode(
      type: json['type'] as String? ?? 'unknown',
      props: props,
      children: children,
    );
  }

  factory SduiNode.text(String value, {String? style, String? align}) =>
      SduiNode(
        type: 'text',
        props: {
          'value': value,
          'style': ?style,
          'align': ?align,
        },
      );

  factory SduiNode.button(String label, Map<String, dynamic> action) =>
      SduiNode(
        type: 'button',
        props: {'label': label, 'action': action},
      );

  factory SduiNode.outlinedButton(String label, Map<String, dynamic> action) =>
      SduiNode(
        type: 'outlinedButton',
        props: {'label': label, 'action': action},
      );

  factory SduiNode.textField({
    required String name,
    required String label,
    String? hint,
    String? keyboard,
  }) =>
      SduiNode(
        type: 'textField',
        props: {
          'name': name,
          'label': label,
          'hint': ?hint,
          'keyboard': ?keyboard,
        },
      );

  factory SduiNode.banner(String value) =>
      SduiNode(type: 'banner', props: {'value': value});

  factory SduiNode.space([double height = 12]) =>
      SduiNode(type: 'space', props: {'height': height});

  factory SduiNode.card(List<SduiNode> children) =>
      SduiNode(type: 'card', children: children);

  factory SduiNode.segmented({
    required String name,
    required List<String> options,
  }) =>
      SduiNode(
        type: 'segmented',
        props: {'name': name, 'options': options},
      );

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      ...props,
      if (children.isNotEmpty)
        'children': children.map((e) => e.toJson()).toList(),
    };
  }
}

class SduiAction {
  const SduiAction({
    required this.type,
    this.params = const {},
  });

  final String type;
  final Map<String, dynamic> params;

  factory SduiAction.fromJson(dynamic raw) {
    if (raw is String) {
      return SduiAction(type: raw);
    }
    final json = Map<String, dynamic>.from(raw as Map);
    final params = Map<String, dynamic>.from(json)..remove('type');
    return SduiAction(
      type: json['type'] as String? ?? 'unknown',
      params: params,
    );
  }

  Map<String, dynamic> toJson() => {'type': type, ...params};
}
