[Reading 33 lines from start (total: 33 lines, 0 remaining)]

# QA report

Môi trường: Chromium headless (Playwright), mở trực tiếp `file://`. Script kiểm thử chạy 2 lần; bản cuối sau khi sửa lỗi CSS bên dưới.

## Kết quả tự động
| Hạng mục | Kết quả |
|---|---|
| Viewport 1920, 1440, 1024, 768, 390, landscape 844×390 | Không tràn ngang (`scrollWidth == innerWidth`, không phần tử nào vượt biên, trừ gallery cuộn ngang có chủ đích) |
| Lỗi console / lỗi JS | 0 ở mọi viewport |
| Liên kết `#anchor` gãy, id trùng | 0 |
| Số `<h1>` | 1 |
| Reveal | 0 phần tử kẹt ở trạng thái ẩn sau khi cuộn hết trang |
| Counter | Kết quả cuối 20.000 / 02 / 36 |
| `prefers-reduced-motion` | Không phần tử nào bị ẩn, counter hiện giá trị cuối ngay |
| Lazy-load | Hero tải ngay; ảnh `location` chỉ tải sau khi cuộn tới gần |
| `setAsset`, `setExperience`, `setLogo` | Hoạt động (thử bằng ảnh data-URI) |
| Sự kiện `gsc-intro:action` | Nhận đúng `action = home`, `preventDefault` chặn được điều hướng |
| Resize | Bố cục đổi đúng qua 6 viewport, không lỗi |
| Tương phản (tính toán) | Chữ trắng/nền navy 15,7:1; chữ phụ 7,3:1; vàng 8,9:1; đồng/đen 5,1:1 (đạt AA) |
| Asset hook | 11 tên hook + `data-gsc-logo`, khớp `ASSET_MAP.md` |
| Ảnh/JS/CSS từ mạng ngoài | Không có |

## Lỗi tìm thấy khi review và đã sửa
1. Reset `.gsc-intro h1, p, ul…` (specificity cao) ghi đè margin của class component, làm tiêu đề hero sát logo. Đổi sang `:where()`.
2. Link logo trên nav bị thừa hưởng màu trắng thay vì vàng, cùng nguyên nhân. Đã sửa.
3. Tiêu đề hero 4 dòng trên 390 px. Thu cỡ chữ còn `clamp(32px, 9.4vw, 44px)`.

## Chưa kiểm tra được (cần Master Agent hoặc thiết bị thật)
- Cảm ứng thật trên iOS/Android (vuốt gallery, `100svh`, safe-area). Mới xét CSS và giả lập viewport.
- Safari và Firefox; chỉ chạy Chromium.
- Hiệu năng đo bằng Lighthouse và cuộn mượt với ảnh thật; hiện chỉ có placeholder gradient.
- Đọc bằng screen reader; mới kiểm tra cấu trúc semantic, `aria-label`, skip link và thứ tự Tab.
- Hiển thị khi nhúng iframe trong Homepage (chưa có Homepage để thử).

[executed on device: HOCUONG (a318a9bd-cfd6-4540-bf01-3ab9fb7f587a)]