# sdui-mini — kho Mini (publish bằng GitHub)

Repo public: https://github.com/MJforever01246/sdui-mini

Super App chỉ **tải** artifact từ đây (jsDelivr / raw GitHub). **Không** cần Python `http.server`.

## Cấu trúc

| Path | Cách | Super tải thế nào |
|------|------|-------------------|
| `cdn/way1/` | **1** WebView + CDN | Mở URL HTML trên jsDelivr |
| `packages/way2_mini_register/` | **2** Flutter package | `git` dependency (rebuild Super khi đổi mini) |
| `cdn/way3/` | **3** Proprietary runtime | Registry + bundle JSON (HMAC) qua HTTP |
| `publish/bundle.json` + `lib/` | **SDUI** author → OTA JSON | Super Open from URL |

## URL ổn định (dùng trong Super)

### SDUI
```text
https://raw.githubusercontent.com/MJforever01246/sdui-mini/main/publish/bundle.json
```
hoặc
```text
https://cdn.jsdelivr.net/gh/MJforever01246/sdui-mini@main/publish/bundle.json
```

### Cách 3 — registry
```text
https://cdn.jsdelivr.net/gh/MJforever01246/sdui-mini@main/cdn/way3/registry.json
```
Base URL:
```text
https://cdn.jsdelivr.net/gh/MJforever01246/sdui-mini@main/cdn/way3
```

### Cách 1 — WebView
```text
https://cdn.jsdelivr.net/gh/MJforever01246/sdui-mini@main/cdn/way1/index.html?module=register&locale=vi
```

### Cách 2 — pubspec (trên Super)
```yaml
mini_register:
  git:
    url: https://github.com/MJforever01246/sdui-mini.git
    path: packages/way2_mini_register
    ref: main
```

## Quy trình cập nhật mini (OTA / git)

1. Sửa nguồn tương ứng (SDUI `lib/bundle/definition.dart`, way3 bundles, way1 source rồi `npm run build` → copy `dist` vào `cdn/way1`, …)
2. Commit + **push** `main`
3. Super tải lại URL (cách 1/3/SDUI) — **không rebuild Super**  
   Cách 2: `flutter pub upgrade` + rebuild Super (vì compile-in)

Chi tiết: [`PUBLISH.md`](./PUBLISH.md)

## Author SDUI (tùy chọn)

```powershell
$env:PATH = "C:\Users\Admin\flutter\bin;$env:PATH"
cd <clone>/sdui-mini
dart run tool/export_bundle.dart --version 1.0.2
git add publish && git commit -m "Bump SDUI bundle" && git push
```
