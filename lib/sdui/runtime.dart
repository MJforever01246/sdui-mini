import 'package:flutter/material.dart';

import 'models.dart';

/// Form values + navigation stack for one loaded mini bundle.
class SduiRuntimeController extends ChangeNotifier {
  SduiRuntimeController(this.bundle) {
    _stack.add(bundle.entry);
  }

  final SduiBundle bundle;
  final Map<String, String> form = {};
  final List<String> _stack = [];
  String? lastMessage;

  String get currentScreenId => _stack.last;

  SduiScreen get currentScreen {
    final screen = bundle.screens[currentScreenId];
    if (screen == null) {
      throw StateError('Screen "$currentScreenId" missing in bundle');
    }
    return screen;
  }

  bool get canPop => _stack.length > 1;

  void setField(String key, String value) {
    form[key] = value;
    notifyListeners();
  }

  String field(String key, [String fallback = '']) => form[key] ?? fallback;

  void navigate(String screenId) {
    if (!bundle.screens.containsKey(screenId)) {
      throw StateError('Unknown screen: $screenId');
    }
    _stack.add(screenId);
    notifyListeners();
  }

  void replace(String screenId) {
    if (!bundle.screens.containsKey(screenId)) {
      throw StateError('Unknown screen: $screenId');
    }
    _stack
      ..removeLast()
      ..add(screenId);
    notifyListeners();
  }

  void pop() {
    if (canPop) {
      _stack.removeLast();
      notifyListeners();
    }
  }

  Future<void> dispatch(SduiAction action, BuildContext context) async {
    switch (action.type) {
      case 'navigate':
        navigate(action.params['screen'] as String);
        break;
      case 'replace':
        replace(action.params['screen'] as String);
        break;
      case 'pop':
        pop();
        break;
      case 'submitOrder':
        final symbol = field('symbol', '???');
        final qty = field('qty', '0');
        final side = field('side', 'BUY');
        lastMessage = 'Đã gửi lệnh $side $qty $symbol (demo)';
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(lastMessage!)),
          );
        }
        if (bundle.screens.containsKey('done')) {
          replace('done');
        }
        break;
      case 'submitRegister':
        lastMessage =
            'Đăng ký demo: ${field('fullName')} / ${field('phone')}';
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(lastMessage!)),
          );
        }
        if (bundle.screens.containsKey('done')) {
          replace('done');
        }
        break;
      case 'snack':
        final text = action.params['message'] as String? ?? 'OK';
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(text)),
          );
        }
        break;
      default:
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unknown action: ${action.type}')),
          );
        }
    }
  }
}
