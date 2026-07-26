# Publish bundle lên GitHub + Super tải OTA

## Trạng thái

| Hạng mục | Giá trị |
|----------|---------|
| Repo mini (author + artifact) | https://github.com/MJforever01246/sdui-mini |
| Repo super (host) | https://github.com/MJforever01246/sdui-super |
| **Public OTA URL** | https://raw.githubusercontent.com/MJforever01246/sdui-mini/main/publish/bundle.json |

Super Host đã prefill URL trên. Mở app → **Open from URL**.

---

## Local public-link (không cần GitHub)

```powershell
$env:PATH = "C:\Users\Admin\flutter\bin;$env:PATH"
cd C:\Users\Admin\sdui-demo\mini
dart run tool/export_bundle.dart
cd publish
python -m http.server 8080
```

Trong Super: `http://127.0.0.1:8080/bundle.json`  
Điện thoại: dùng IP LAN; Android emulator: `10.0.2.2`.

---

## Quy trình OTA

1. Sửa `lib/bundle/definition.dart` trong mini  
2. `dart run tool/export_bundle.dart --version 1.0.x`  
3. `git add publish && git commit -m "Bump mini bundle" && git push`  
4. Super bấm **Open from URL** lại (không rebuild Super)

`raw.githubusercontent.com` có thể cache vài phút — tăng `version` trong bundle để nhận bản mới dễ hơn.

## Mirror trên sdui-super

`super/publish/bundle.json` là bản mirror mẫu (offline / raw trên repo host).
**Nguồn sự thật** vẫn là `sdui-mini/publish/bundle.json`.
