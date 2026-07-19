# Publish bundle lên GitHub + Super tải OTA

## Trạng thái hiện tại

- Bundle **đã có**: `publish/bundle.json` (~4.6KB)
- `publish/` **không** bị `.gitignore` — sẽ được push cùng repo
- Chưa có remote / chưa commit (cả `mini` và `super`)

---

## A. Tạo 2 repo trống trên GitHub (web)

1. Vào https://github.com/new  
2. Tạo **public** repo, ví dụ:
   - `sdui-mini` (không tick “Add README”)
   - `sdui-super` (không tick “Add README”)
3. Giữ URL dạng:
   - `https://github.com/<USER>/sdui-mini.git`
   - `https://github.com/<USER>/sdui-super.git`

---

## B. Push repo **mini** (có bundle)

Mở PowerShell:

```powershell
$env:PATH = "C:\Users\Admin\flutter\bin;$env:PATH"
cd C:\Users\Admin\sdui-demo\mini

# (tuỳ chọn) export lại bundle mới nhất
dart run tool/export.dart

git add .
git commit -m "Initial SDUI mini author and publish bundle"

# Thay <USER> bằng GitHub username của bạn
git branch -M main
git remote add origin https://github.com/<USER>/sdui-mini.git
git push -u origin main
```

Nếu GitHub hỏi đăng nhập: dùng Personal Access Token (Settings → Developer settings → PAT) làm mật khẩu HTTPS, hoặc SSH.

---

## C. Push repo **super**

```powershell
cd C:\Users\Admin\sdui-demo\super

git add .
git commit -m "Initial SDUI super host"

git branch -M main
git remote add origin https://github.com/<USER>/sdui-super.git
git push -u origin main
```

---

## D. URL Super tải bundle (hoàn thiện concept OTA)

Sau khi `mini` đã push, URL raw ổn định:

```text
https://raw.githubusercontent.com/<USER>/sdui-mini/main/publish/bundle.json
```

Trong Super: dán URL này → **Open from URL**.

Kiểm tra nhanh trên trình duyệt: mở link trên phải thấy JSON (`"id": "ck-mini"`).

---

## E. Quy trình OTA sau này

1. Sửa `lib/bundle/definition.dart` trong mini  
2. `dart run tool/export.dart` (hoặc Export trong app)  
3. `git add publish/bundle.json && git commit -m "Bump mini bundle" && git push`  
4. Super bấm **Open from URL** lại (không cần rebuild Super)

Lưu ý: raw.githubusercontent.com đôi khi cache vài phút; đổi `version` trong bundle để dễ nhận ra bản mới.
