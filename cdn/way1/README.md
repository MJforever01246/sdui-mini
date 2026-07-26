# webview-cdn

Lõi mini app (Vite + TypeScript). Tài liệu kiến trúc: [`docs/mini-app-research.html`](../../docs/mini-app-research.html).

## Scripts

| Lệnh | Mô tả |
|------|--------|
| `npm run dev` | Dev server `:5173` |
| `npm run dev:mobile` | Dev + Playwright iPhone 14 |
| `npm run preview:mobile` | Build + preview + mobile |
| `npm run build` | Output `dist/` cho CDN |

## URL

`http://localhost:5173/?module=register&locale=vi`

Android emulator: `http://10.0.2.2:5173/` trong `miniAppCdnConfig.baseUrl`.
