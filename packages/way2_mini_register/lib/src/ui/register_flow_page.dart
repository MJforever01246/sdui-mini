import 'package:flutter/material.dart';

import '../models/register_config.dart';
import '../models/register_result.dart';

/// UI mini app — demо đăng ký (tách khỏi WebView CDN).
class RegisterFlowPage extends StatefulWidget {
  const RegisterFlowPage({super.key, required this.config});

  final RegisterConfig config;

  @override
  State<RegisterFlowPage> createState() => _RegisterFlowPageState();
}

class _RegisterFlowPageState extends State<RegisterFlowPage> {
  static const _primary = Color(0xFFFCAF17);

  String _investorType = '0001';
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String? _branch;
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool get _canNext => (_phoneCtrl.text.replaceAll(RegExp(r'\D'), '').length >= 10);

  Future<void> _submit() async {
    final name = _nameCtrl.text.trim();
    final phone = _phoneCtrl.text.replaceAll(RegExp(r'\D'), '');
    if (name.isEmpty || phone.length < 10 || _branch == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đủ tên, SĐT (≥10 số) và chi nhánh')),
      );
      return;
    }

    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    Navigator.of(context).pop(
      RegisterResult(
        success: true,
        investorType: _investorType,
        fullName: name,
        phone: phone,
        branch: _branch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mini · Đăng ký'),
        backgroundColor: const Color(0xFFFEF6E1),
        foregroundColor: const Color(0xFF26282C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(
            const RegisterResult(success: false, cancelled: true),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Text(
            'KB Securities × Mini Register',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'partner: ${widget.config.partnerId} · ${widget.config.locale}',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          const Text('1. Loại nhà đầu tư', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _chip('0001', 'Cá nhân - VN'),
              _chip('0002', 'Tổ chức - VN'),
              _chip('0003', 'Cá nhân - NN'),
              _chip('0004', 'Tổ chức - NN'),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: '2. Họ tên / Tổ chức',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: '3. Số điện thoại (*)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _branch,
            decoration: const InputDecoration(
              labelText: '6. Chi nhánh (*)',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'HCM', child: Text('TP. Hồ Chí Minh')),
              DropdownMenuItem(value: 'HN', child: Text('Hà Nội')),
              DropdownMenuItem(value: 'DN', child: Text('Đà Nẵng')),
            ],
            onChanged: (v) => setState(() => _branch = v),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: const Color(0xFF26282C),
                disabledBackgroundColor: _primary.withOpacity(0.4),
              ),
              onPressed: (!_canNext || _loading) ? null : _submit,
              child: _loading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Tiếp theo', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hướng #2 · Flutter package — không WebView/CDN',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _chip(String value, String label) {
    final selected = _investorType == value;
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: selected,
      selectedColor: const Color(0xFFFEF6E1),
      onSelected: (_) => setState(() => _investorType = value),
    );
  }
}
