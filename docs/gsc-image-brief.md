# GSC — Bộ hình đề xuất theo tiêu đề (Intro page)

Mục tiêu: mỗi tiêu đề có **một câu chuyện riêng** — các cụ đang *làm gì đó* (chơi cờ, tập dưỡng sinh, được chăm sóc, trồng rau…) —
thay vì tái sử dụng cùng một phối cảnh kiến trúc. Hiện 5 ô đang dùng chung 3 ảnh render cũ nên nhìn trùng lặp.

## Cách dùng
1. Tạo ảnh theo prompt bên dưới (Midjourney / Imagen / Firefly / Nano Banana… đều được).
2. Xuất **WebP**, cạnh dài ≥ 2000 px, đặt đúng tên vào `assets/gsc-web/life/`.
3. Không cần sửa code: trang tự lấy ảnh mới; thiếu file thì dùng ảnh cũ. Chữ chú thích "AI Concept" giữ nguyên.

## Quy tắc để KHÔNG trùng style
- Mỗi ảnh một **góc máy + giờ trong ngày + tông màu** khác nhau (bảng dưới).
- Người Việt 65–80 tuổi, da/nếp nhăn tự nhiên, trang phục đời thường lịch sự, **không** chữ/logo trong ảnh, không tay/mắt méo.
- Một "ngôn ngữ chung" duy nhất: ảnh chụp thực tế (photoreal), ống kính 35–85 mm, màu ấm, có chút vàng kim của thương hiệu.
- Bố cục chừa khoảng thở bên một cạnh để chữ/viền vàng không che mặt người.

## Danh sách ảnh

| # | Tiêu đề / vị trí | File | Cảnh | Góc máy · Giờ · Tông |
|---|---|---|---|---|
| 1 | SENIOR LIVING | `life-senior-living.webp` | Cặp vợ chồng cụ uống trà trên ban công căn hộ, phía xa là hai tháp GSC | Trung cảnh, ngang tầm mắt · buổi sáng · vàng nhạt, kem |
| 2 | HỆ SINH THÁI WELLNESS (dải ngang) | `life-aqua-wellness.webp` | Nhóm cụ tập aerobic dưới nước ở hồ bơi, có huấn luyện viên | Toàn cảnh 21:9 · trưa nắng · xanh ngọc, trắng |
| 3 | HEALTHCARE | `life-healthcare.webp` | Chuyên viên vật lý trị liệu nâng đỡ một cụ tập đi giữa thanh song song, phòng sáng sạch | Cận trung cảnh · ánh sáng trong nhà dịu · trắng, xanh teal |
| 4 | ACTIVE LIVING | `life-active-taichi.webp` | Nhóm cụ tập dưỡng sinh / thái cực trên bãi cỏ cạnh hồ, ngược sáng | Toàn cảnh, thấp · bình minh · cam hồng, sương mỏng |
| 5 | NATURE & LANDSCAPE | `life-gardening.webp` | Các cụ chăm sóc luống rau, tưới cây, thu hoạch cà chua trong khu trồng trọt | Cận cảnh tay + khuôn mặt cười · giờ vàng · xanh lá, nâu đất |
| 6 | COMMUNITY | `life-chess-community.webp` | Hai cụ chơi cờ tướng trong chòi nghỉ, mấy cụ khác đứng xem, cười | Candid, lấy nét nông · chiều · gỗ ấm, bokeh xanh |
| 7 | DAILY LIVING | `life-daily-cafe.webp` | Các cụ ngồi cafe ngoài trời cạnh sảnh Reception, nhân viên mang trà tới | Trung cảnh · sáng muộn · be, xanh cây |
| 8 | GOLDEN YEARS (cuối trang) | `life-golden-couple.webp` | Đôi vợ chồng cụ nắm tay đi trên cây cầu gỗ bên hồ Koi, hoàng hôn | Chân dung nửa người, ngược sáng · hoàng hôn · vàng kim, tím nhạt |

Ảnh bổ sung (tuỳ chọn, cho Gallery / hotspot): cụ cho cháu nhỏ ăn cá Koi (chiều tối); cụ thắp hương ở khu tâm linh (bình minh, sương); cụ đi bộ trên đường dạo giữa hai hàng cây (06:30).

## Prompt gợi ý (tiếng Anh, dán nguyên)

Phần chung — thêm vào cuối **mọi** prompt:
> photorealistic documentary photography, natural skin texture, authentic Vietnamese elderly people aged 65-80, warm golden color grading, no text, no logos, no watermark, shallow depth of field, 35mm lens, high detail --ar 4:3

1. **Senior Living** — *An elderly Vietnamese couple sharing tea on a bright apartment balcony in the morning, twin 36-storey towers with golden facade lines visible beyond lush greenery, soft cream light, relaxed and dignified.*
2. **Aqua wellness** — *Wide shot, a group of Vietnamese seniors doing gentle aqua aerobics in a resort swimming pool with a friendly instructor, midday sun sparkling on turquoise water, palm trees, smiling faces.* (`--ar 21:9`)
3. **Healthcare** — *A caring physiotherapist in a soft teal uniform gently supporting an elderly Vietnamese man walking between parallel bars in a bright, clean rehabilitation room, reassuring smile, soft window light.*
4. **Active living** — *Low-angle wide shot of a group of Vietnamese seniors practicing tai chi on a dewy lawn beside a lake at sunrise, backlit, pink-orange sky, light mist, calm synchronized poses.*
5. **Gardening** — *Close-medium shot of elderly Vietnamese men and women tending raised vegetable beds, watering and harvesting ripe tomatoes, laughing, straw hats, golden hour light, rich green leaves.*
6. **Community / chess** — *Candid photo of two elderly Vietnamese men playing xiangqi on a wooden table in a garden pavilion, several seniors watching and smiling, warm afternoon light, blurred green background.*
7. **Daily living** — *Elderly Vietnamese friends chatting at an outdoor café beside a resort lobby, a staff member serving tea, mid-morning light, beige tones and tropical plants.*
8. **Golden years** — *Elderly Vietnamese couple holding hands on a wooden bridge over a koi pond at sunset, backlit golden rim light, soft purple sky, gentle emotional mood, half-body portrait.* (`--ar 3:2`)

## Lưu ý pháp lý / nhất quán
- Ảnh là *AI Concept* minh hoạ định hướng, không phải ảnh công trình hoàn thành — giữ dòng chú thích hiện có.
- Mục Healthcare chỉ là định hướng tiện ích, không dùng ảnh gợi ý cơ sở y tế đã cấp phép.
