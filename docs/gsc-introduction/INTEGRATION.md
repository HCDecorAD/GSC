[Reading 36 lines from start (total: 36 lines, 0 remaining)]

# Integration (không cần sửa Homepage)

## 1. Đặt file
Copy 3 file vào cùng một thư mục của site (ví dụ `/intro/`). Nếu tách thư mục, sửa 2 đường dẫn trong HTML (`<link>` và `<script>`).

## 2. Mở từ Homepage
Nút "GIỚI THIỆU DỰ ÁN" của Homepage chỉ cần trỏ tới file này (`<a href="/intro/gsc-introduction.html">`) hoặc mở trong iframe. Trang không đọc và không ghi bất kỳ biến toàn cục hay CSS nào của Homepage; toàn bộ class có tiền tố `gsc-intro-`, JS chỉ đăng ký `window.GSCIntro`.

## 3. Cấu hình (tùy chọn, khai báo TRƯỚC thẻ `<script src="gsc-introduction.js">`)
```html
<script>
window.GSC_INTRO_CONFIG = {
  logo: 'media/gsc-logo.svg',
  links: { home: '/', panorama: '/', contact: '/lien-he' },
  assets: { hero: 'media/intro/hero.jpg' /* xem ASSET_MAP.md */ },
  onAction: function (action, el) { /* return false để chặn điều hướng mặc định */ }
};
</script>
```
Nếu không cấu hình: `home` và `panorama` trỏ `index.html`, `contact` cuộn xuống footer, hero CTA cuộn tới `#gsc-intro-overview`.

## 4. Hook
- **← TOÀN CẢNH:** `[data-gsc-action="home"]` (trong nav). Cấu hình `links.home` hoặc sửa `href`.
- **CTA cuối:** `data-gsc-action="panorama"` (KHÁM PHÁ TOÀN CẢNH) và `"contact"` (LIÊN HỆ). Chưa có dữ liệu liên hệ nào được tạo; gắn bằng `links.contact`.
- **Sự kiện:** `gsc-intro:action` (bubbles, cancelable), `detail = { action, href }`. `preventDefault()` để tự xử lý, ví dụ đóng iframe.
- **Logo:** mọi phần tử `[data-gsc-logo]` (nav, hero, CTA cuối, footer). `GSCIntro.setLogo(url, alt)` hoặc `config.logo` thay chữ "GSC" bằng `<img>` (cao tối đa 44 px).
- **Ảnh:** `data-gsc-asset`, xem `ASSET_MAP.md`. API: `GSCIntro.setAsset(name, url, alt)`, `GSCIntro.setExperience([6 url])`.

## 5. Chạy trong iframe
Không cần cấu hình thêm. Nếu Homepage muốn nút đóng riêng, bắt sự kiện `gsc-intro:action` với `action === 'home'`, gọi `preventDefault()` rồi đóng iframe.

## 6. Hành vi responsive
1920/1440: nav đủ 5 liên kết, các khối 2 cột. ≤1024: ẩn liên kết nav (còn ← TOÀN CẢNH và logo), khối xếp dọc, lưới 2 cột. ≤640: nút full-width, danh sách 1 cột, gallery vuốt ngang có scroll-snap. Mobile landscape thấp (≤520 px cao): nav không sticky, hero không ép 100vh.

## 7. Hiệu năng
Ảnh chỉ tải khi cách viewport ≤ 400 px (hero tải ngay). Nên dùng WebP/AVIF, hero ≤ 300 KB, ảnh còn lại ≤ 200 KB.

[executed on device: HOCUONG (a318a9bd-cfd6-4540-bf01-3ab9fb7f587a)]