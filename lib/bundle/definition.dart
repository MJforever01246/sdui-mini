import '../sdui/models.dart';

/// Nguồn sự thật mini app — sửa ở đây rồi Export.
SduiBundle buildTradingMiniBundle() {
  return SduiBundle.fromJson({
    'id': 'ck-mini',
    'name': 'Chứng khoán Mini',
    'version': '1.0.0',
    'entry': 'home',
    'screens': {
      'home': {
        'title': 'CK Mini',
        'body': [
          {
            'type': 'banner',
            'value': 'Mini app SDUI · publish bằng link',
          },
          {'type': 'space', 'height': 12},
          {
            'type': 'text',
            'value': 'Chứng khoán Mini',
            'style': 'title',
          },
          {
            'type': 'text',
            'value':
                'Đổi UI trong repo mini → export bundle.json → Super tải URL, không cần update app host.',
            'style': 'caption',
          },
          {'type': 'space', 'height': 16},
          {
            'type': 'card',
            'children': [
              {
                'type': 'text',
                'value': 'Mở tài khoản',
                'style': 'subtitle',
              },
              {'type': 'space', 'height': 8},
              {
                'type': 'button',
                'label': 'Đăng ký ngay',
                'action': {'type': 'navigate', 'screen': 'register'},
              },
            ],
          },
          {
            'type': 'card',
            'children': [
              {
                'type': 'text',
                'value': 'Giao dịch',
                'style': 'subtitle',
              },
              {'type': 'space', 'height': 8},
              {
                'type': 'button',
                'label': 'Đặt lệnh',
                'action': {'type': 'navigate', 'screen': 'order'},
              },
            ],
          },
        ],
      },
      'register': {
        'title': 'Đăng ký',
        'body': [
          {
            'type': 'text',
            'value': 'Thông tin định danh',
            'style': 'subtitle',
          },
          {'type': 'space', 'height': 12},
          {
            'type': 'textField',
            'name': 'fullName',
            'label': 'Họ và tên',
          },
          {
            'type': 'textField',
            'name': 'phone',
            'label': 'Số điện thoại',
            'keyboard': 'phone',
          },
          {
            'type': 'textField',
            'name': 'idNumber',
            'label': 'CCCD',
          },
          {
            'type': 'button',
            'label': 'Gửi hồ sơ',
            'action': {'type': 'submitRegister'},
          },
          {
            'type': 'outlinedButton',
            'label': 'Quay lại',
            'action': {'type': 'pop'},
          },
        ],
      },
      'order': {
        'title': 'Đặt lệnh',
        'body': [
          {
            'type': 'text',
            'value': 'Lệnh (demo)',
            'style': 'subtitle',
          },
          {'type': 'space', 'height': 12},
          {
            'type': 'segmented',
            'name': 'side',
            'options': ['BUY', 'SELL'],
          },
          {'type': 'space', 'height': 12},
          {
            'type': 'textField',
            'name': 'symbol',
            'label': 'Mã CK',
            'hint': 'VNM',
          },
          {
            'type': 'textField',
            'name': 'qty',
            'label': 'Khối lượng',
            'keyboard': 'number',
          },
          {
            'type': 'textField',
            'name': 'price',
            'label': 'Giá',
          },
          {
            'type': 'button',
            'label': 'Xác nhận đặt lệnh',
            'action': {'type': 'submitOrder'},
          },
          {
            'type': 'outlinedButton',
            'label': 'Hủy',
            'action': {'type': 'pop'},
          },
        ],
      },
      'done': {
        'title': 'Hoàn tất',
        'body': [
          {
            'type': 'text',
            'value': 'Thành công',
            'style': 'title',
            'align': 'center',
          },
          {'type': 'space', 'height': 12},
          {
            'type': 'text',
            'value':
                'Export lại bundle từ mini và reload URL trên Super để thấy thay đổi OTA.',
            'style': 'body',
            'align': 'center',
          },
          {'type': 'space', 'height': 16},
          {
            'type': 'button',
            'label': 'Về trang chủ',
            'action': {'type': 'replace', 'screen': 'home'},
          },
        ],
      },
    },
  });
}

SduiBundle buildDemoMiniBundle() => buildTradingMiniBundle();
