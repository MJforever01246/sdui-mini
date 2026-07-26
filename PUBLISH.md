# Publish mini lên GitHub (không dùng Python)

## Nguyên tắc

| Trước | Nay |
|-------|-----|
| `python -m http.server` local | **git push** lên `sdui-mini` |
| Super dán `http://127.0.0.1:8080/...` | Super dán **jsDelivr / raw.githubusercontent.com** |

Host file tĩnh = GitHub (+ jsDelivr CDN).

## Map thư mục → URL

| Artifact | Path trong repo | URL Super dùng |
|----------|-----------------|----------------|
| SDUI bundle | `publish/bundle.json` | `https://raw.githubusercontent.com/MJforever01246/sdui-mini/main/publish/bundle.json` |
| Cách 3 registry | `cdn/way3/registry.json` | `https://cdn.jsdelivr.net/gh/MJforever01246/sdui-mini@main/cdn/way3/registry.json` |
| Cách 3 bundles | `cdn/way3/bundles/...` | base `.../cdn/way3` |
| Cách 1 WebView | `cdn/way1/index.html` | `https://cdn.jsdelivr.net/gh/MJforever01246/sdui-mini@main/cdn/way1/index.html?...` |
| Cách 2 package | `packages/way2_mini_register/` | git dependency trong `pubspec.yaml` Super |

## Checklist push

```powershell
cd <clone-sdui-mini>
git add cdn publish packages
git status
git commit -m "Publish mini artifacts"
git push origin main
```

Đợi ~1–2 phút nếu jsDelivr cache; tăng `version` trong bundle/registry để nhận bản mới dễ hơn.

## Super tương ứng

Repo: https://github.com/MJforever01246/sdui-super

- SDUI host (root): Open from URL → SDUI bundle
- `apps/platform_host`: Online URL → Cách 3 registry (prefill GitHub)
- `apps/way2_host`: depend git `way2_mini_register`
