import 'package:flutter/material.dart';

import 'models/register_config.dart';
import 'models/register_result.dart';
import 'ui/register_flow_page.dart';

/// API public cho super app — tương đương openEkyc/openRegister.
class MiniRegister {
  MiniRegister._();

  /// Mở mini app đăng ký dạng full-screen route trên [context] của host.
  static Future<RegisterResult?> open(
    BuildContext context, {
    RegisterConfig config = const RegisterConfig(),
  }) {
    return Navigator.of(context).push<RegisterResult>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => RegisterFlowPage(config: config),
      ),
    );
  }
}
