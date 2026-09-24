GSC DIGITAL TWIN — GitHub + Vercel + Google Drive

1. Upload index.html và videos.json lên GitHub repository.
2. Import repository vào Vercel và Deploy.
3. Trên Google Drive: mỗi video đặt quyền General access = Anyone with the link / Viewer.
4. Mở website > QUẢN LÝ VIDEO > chọn hotspot > dán Google Drive Share Link > LƯU LINK.
5. Kiểm tra bằng XEM THỬ.
6. Bấm XUẤT videos.json.
7. Trên GitHub, thay file videos.json cũ bằng file vừa xuất và Commit.
8. Vercel tự deploy. Sau đó mọi người truy cập website sẽ thấy video mới.

LƯU Ý:
- Không lưu mật khẩu hoặc GitHub token trong index.html.
- Google Drive dùng tốt cho demo/lượng truy cập vừa phải, nhưng không phải CDN video chuyên dụng.
- Nếu Drive hạn chế phát do quota hoặc chính sách chia sẻ, chuyển video sang Storage/CDN mà không cần đổi bố cục APP.
