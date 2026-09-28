[Reading 12 lines from start (total: 12 lines, 0 remaining)]

# Changelog

## 1.0.0 — Full Introduction
- Mở rộng từ bản 9 section lên 15 section theo brief (thêm Masterplan, Healthcare & Daily Living, Active Living, Nature & Landscape, Community).
- Thêm nav sticky riêng (← TOÀN CẢNH, logo, 5 liên kết, scroll-spy `aria-current`), skip link.
- Thêm `data-gsc-logo`, `GSCIntro.setLogo`, `config.logo`.
- Lazy-load ảnh bằng IntersectionObserver (hero tải ngay), trạng thái lỗi ảnh `is-error`.
- Thêm asset hook: `masterplan`, `healthcare`, `active`, `nature`, `community`, `golden`.
- Thêm `aria-label` cho ảnh, vùng cuộn gallery có `tabindex` và `role="region"`.
- Sửa độ ưu tiên CSS: reset dùng `:where()` để margin của component không bị đè.
- Đổi tên file bỏ tiền tố số (`gsc-introduction.*`).
- Nội dung factual giữ nguyên bản trước, thêm 110 × 182 m ("khoảng") theo dữ liệu đã cung cấp.

[executed on device: HOCUONG (a318a9bd-cfd6-4540-bf01-3ab9fb7f587a)]