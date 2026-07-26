# sdui-mini — kho Mini (artifact)

Repo: https://github.com/MJforever01246/sdui-mini

Super tải theo đường dẫn cấu hình (`sdui-super/lib/config/mini_paths.dart`).

## Cấu trúc publish

| Path | Cách |
|------|------|
| `cdn/way1/` | 1 · WebView CDN (static Vite dist) |
| `packages/way2_mini_register/` | 2 · Flutter package |
| `cdn/way3/` | 3 · registry + bundles (HMAC) |
| `publish/bundle.json` | SDUI OTA |
| `lib/` + `tool/` | Author SDUI (export bundle) |

## Quy trình

1. Sửa artifact / export bundle  
2. `git push origin main`  
3. Super load lại URL cấu hình (cách 1/3/SDUI không rebuild; cách 2 cần rebuild)

Chi tiết luồng: pack `mini_app/WORKFLOW.md`.
