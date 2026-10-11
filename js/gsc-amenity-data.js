/* Dữ liệu 17 điểm tiện ích GSC — dùng chung cho Landing page và danh sách ở trang Intro.
   Thêm video: điền `video` = ID YouTube (vd "dQw4w9WgXcQ") hoặc `drive` = ID file Google Drive (đã chia sẻ công khai). */
(function(w){'use strict';
var I={
koi:'<path d="M3 13c3-5 8-6 12-3 2 1 4 1 6-1-1 5-5 8-10 8-3 0-6-1-8-4z"/><circle cx="8.5" cy="12" r=".8" fill="currentColor"/><path d="M4 19c2 1 4 1 6 0M14 21c2 0 4-1 5-2"/>',
pool:'<path d="M3 17c2 0 2-1.5 4.5-1.5S10 17 12 17s2-1.5 4.5-1.5S19 17 21 17M3 21c2 0 2-1.5 4.5-1.5S10 21 12 21s2-1.5 4.5-1.5S19 21 21 21"/><path d="M8 13V5a2 2 0 014 0M14 13V5a2 2 0 014 0M8 8h6M8 11h6"/>',
park:'<path d="M12 21v-7"/><path d="M12 14c-4 0-6-3-6-6a6 6 0 0112 0c0 3-2 6-6 6z"/><path d="M5 21h14"/>',
farm:'<path d="M12 21V11"/><path d="M12 11C12 7 9 5 5 5c0 4 3 6 7 6zM12 14c0-3 3-5 7-5 0 4-3 6-7 5z"/><path d="M4 21h16"/>',
spirit:'<path d="M12 3l9 6H3z"/><path d="M5 9v10M19 9v10M9 19V12M15 19V12M3 21h18"/>',
restaurant:'<path d="M6 3v7a2 2 0 002 2v9M10 3v7M8 3v7M17 21V3c-2 1-3 4-3 8h3"/>',
cafe:'<path d="M4 9h12v5a5 5 0 01-5 5H9a5 5 0 01-5-5z"/><path d="M16 10h2a2 2 0 010 4h-2M8 3c0 1.5 1.5 1.5 1.5 3M12 3c0 1.5 1.5 1.5 1.5 3"/>',
chess:'<path d="M9 21h6M8 18h8M10 18c0-3 1-4 1-6-2-1-3-3-2-5l3-3 3 2c1 1 1 3 0 4-1 1-2 2-2 4"/><circle cx="14" cy="5" r=".6" fill="currentColor"/>',
exercise:'<circle cx="12" cy="5" r="2"/><path d="M12 8v6M8 10l4 1 4-1M12 14l-3 7M12 14l3 7"/>',
walk:'<circle cx="13" cy="4.5" r="1.8"/><path d="M12 8l-2 5 3 2v6M12 8l3 3 3 1M10 13l-3 3"/>',
terrace3:'<path d="M3 21h18M5 21V10l7-5 7 5v11"/><path d="M9 21v-6h6v6M12 2v3"/>',
pharmacy:'<rect x="4" y="4" width="16" height="16" rx="3"/><path d="M12 8v8M8 12h8"/>',
physio:'<path d="M3 12h2M19 12h2M5 9v6M19 9v6M7 7v10M17 7v10M7 12h10"/>',
medical:'<path d="M12 21s-8-5-8-11a4.5 4.5 0 018-2.7A4.5 4.5 0 0120 10c0 6-8 11-8 11z"/><path d="M12 9v5M9.5 11.5h5"/>',
reception:'<path d="M3 19h18M5 19v-6a7 7 0 0114 0v6"/><path d="M12 6V4M9 4h6"/>',
market:'<path d="M3 4h2l2.4 11h10.2L20 7H6.2"/><circle cx="9" cy="19.5" r="1.4"/><circle cx="17" cy="19.5" r="1.4"/>',
parking:'<rect x="4" y="4" width="16" height="16" rx="3"/><path d="M10 17V8h3.5a2.5 2.5 0 010 5H10"/>'
};
var A=[
['koi','Hồ Koi','Koi Pond','nature','Mặt nước trung tâm với đài phun, cầu gỗ và đàn cá Koi — nơi dạo bước, ngắm cá và tìm một nhịp chậm giữa ngày.','A central water feature with fountains, a timber bridge and koi — a place to stroll, watch the fish and slow the pace.',['Đài phun nước','Cầu gỗ','Ngắm cá'],['Fountains','Timber bridge','Fish watching'],[50,66]],
['pool','Hồ bơi','Swimming Pool','nature','Hồ bơi ngoài trời với khu nằm nghỉ, phù hợp bơi nhẹ và aerobic dưới nước theo hướng dẫn.','An outdoor pool with loungers, suited to gentle swimming and guided aqua aerobics.',['Aqua aerobic','Nằm nghỉ','Ngoài trời'],['Aqua aerobics','Loungers','Outdoor'],[69,19]],
['park','Công viên','Park','nature','Thảm xanh, hoa và lối đi rợp bóng — không gian hít thở, ngồi nghỉ và gặp gỡ ngay trong khuôn viên.','Green lawns, flowers and shaded paths — space to breathe, sit and meet within the grounds.',['Bóng mát','Ghế nghỉ','Vườn hoa'],['Shade','Seating','Flower beds'],[77,68]],
['farm','Khu trồng trọt','Garden Plots','nature','Luống rau sạch để các cụ tự tay gieo trồng, chăm sóc và thu hoạch — niềm vui giản dị mỗi ngày.','Raised vegetable beds where residents plant, tend and harvest — a simple daily joy.',['Luống rau','Làm vườn','Thu hoạch'],['Raised beds','Gardening','Harvest'],[62,8]],
['spirit','Khu tâm linh','Spiritual Space','nature','Góc tĩnh lặng dành cho thắp hương, cầu nguyện và an yên tâm hồn.','A quiet corner for incense, prayer and inner calm.',['Tĩnh lặng','Thắp hương','Thiền'],['Quiet','Incense','Meditation'],[71,8]],
['chess','Khu đánh cờ','Chess Corner','active','Chòi nghỉ thoáng mát để chơi cờ, đọc báo và chuyện trò cùng bạn bè.','A breezy pavilion for chess, reading and chatting with friends.',['Cờ tướng','Chòi nghỉ','Giao lưu'],['Xiangqi','Pavilion','Socialising'],[27,60]],
['exercise','Khu tập ngoài trời','Outdoor Fitness','active','Thiết bị vận động nhẹ nhàng giữa cây xanh, phù hợp mọi thể trạng.','Gentle exercise equipment among greenery, suited to every fitness level.',['Dưỡng sinh','Thiết bị nhẹ','Buổi sáng'],['Qigong','Light equipment','Mornings'],[70,62]],
['walk','Đường dạo','Walking Path','active','Trục đi bộ phẳng, có mái che và cây xanh hai bên, đi lại an toàn quanh khuôn viên.','A flat, shaded promenade lined with greenery for safe walks around the grounds.',['Bằng phẳng','Bóng mát','An toàn'],['Level','Shaded','Safe'],[51,39]],
['terrace3','Không gian ngoài trời tầng 3','3rd-Floor Terrace','active','Sân vườn trên cao với tầm nhìn thoáng, ô che nắng và góc ngồi thư giãn.','An elevated garden terrace with open views, parasols and relaxing seating.',['Sân vườn','Tầm nhìn','Thư giãn'],['Garden deck','Views','Relax'],[39,32]],
['restaurant','Nhà hàng','Restaurant','community','Bữa ăn chuẩn vị, dinh dưỡng cân đối — bàn ăn chung để cả cộng đồng quây quần.','Balanced, flavourful meals and shared tables where the community gathers.',['Dinh dưỡng','Bàn ăn chung','Thực đơn thanh đạm'],['Nutrition','Shared tables','Light menu'],[40,50]],
['cafe','Cafe ngoài trời','Outdoor Café','community','Góc cafe dưới tán cây, nơi một tách trà buổi sáng trở thành cuộc trò chuyện dài.','A café under the trees where a morning tea becomes a long conversation.',['Trà & cafe','Dưới tán cây','Buổi sáng'],['Tea & coffee','Under the trees','Mornings'],[31,44]],
['pharmacy','Nhà thuốc','Pharmacy','care','Điểm mua thuốc và vật tư y tế ngay trong khuôn viên. Định hướng tiện ích, không phải xác nhận cơ sở đã được cấp phép.','On-site access to medicines and medical supplies. A planned amenity, not confirmation of a licensed facility.',['Gần căn hộ','Vật tư y tế','Định hướng'],['Close to homes','Medical supplies','Planned'],[35,49]],
['physio','Vật lý trị liệu','Physiotherapy','care','Không gian phục hồi chức năng và vận động trị liệu theo định hướng chăm sóc dài hạn.','Rehabilitation and movement therapy space within a long-term care vision.',['Phục hồi','Trị liệu','Định hướng'],['Rehabilitation','Therapy','Planned'],[65,49]],
['medical','Phòng y tế / cấp cứu','Medical & Emergency Room','care','Phòng y tế và quy trình ứng cứu nhanh, kết nối sân đáp trực thăng trên mái tháp. Định hướng, chưa phải cơ sở đã vận hành.','A medical room and rapid-response plan linked to rooftop helipads. A planned amenity, not an operating facility.',['Ứng cứu nhanh','Sân đáp','Định hướng'],['Rapid response','Helipad','Planned'],[42,29]],
['reception','Reception','Reception','daily','Sảnh đón sang trọng ở lối vào chính — tiếp đón, hướng dẫn và hỗ trợ cư dân, người thân suốt ngày.','A refined lobby at the main entrance — welcoming, guiding and assisting residents and family all day.',['Cổng chính','Đón tiếp','Hỗ trợ'],['Main gate','Welcome','Assistance'],[50,77]],
['market','Siêu thị','Supermarket','daily','Nhu yếu phẩm hằng ngày chỉ cách vài bước chân, đi lại thuận tiện và an toàn.','Daily essentials a few steps away, convenient and safe.',['Nhu yếu phẩm','Gần sảnh','Tiện lợi'],['Essentials','Near lobby','Convenient'],[50,49]],
['parking','Bãi xe','Parking','daily','Bãi đỗ rộng, bố trí tách biệt và gần lối vào để đưa đón dễ dàng.','Generous parking, set apart and close to the entrance for easy drop-offs.',['Rộng rãi','Đưa đón','Gần lối vào'],['Spacious','Drop-off','Near entrance'],[44,13]]
];
var G={nature:['NATURE & LANDSCAPE','Thiên nhiên & cảnh quan','Nature & Landscape'],active:['ACTIVE LIVING','Vận động & thư giãn','Active & Relaxed'],community:['COMMUNITY','Cộng đồng','Community'],care:['HEALTHCARE','Chăm sóc','Care'],daily:['DAILY LIVING','Đời sống hằng ngày','Daily Living']};
w.GSC_AM={icons:I,groups:G,list:A.map(function(a,i){return{n:i+1,key:a[0],id:'tt-'+a[0],vi:a[1],en:a[2],group:a[3],dvi:a[4],den:a[5],tvi:a[6],ten:a[7],pin:a[8],img:'assets/gsc-web/amenities/'+a[0]+'.webp',video:'',drive:''};}),
svg:function(k){return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">'+(I[k]||'')+'</svg>';}};
})(window);
