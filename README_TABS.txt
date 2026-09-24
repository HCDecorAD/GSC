GSC APP v3 — TOP PAGE TABS

pages.json quản lý các Tab liên kết Page.
Mỗi Page:
- name: tên trên thanh TOP
- icon: ký hiệu
- url: URL Page
- mode: "iframe" mở ngay trong APP hoặc "newtab" mở tab trình duyệt mới
- enabled: true/false

Ví dụ:
{
 "id":"amenities",
 "name":"Tiện ích",
 "icon":"◇",
 "url":"https://example.com/tien-ich",
 "mode":"iframe",
 "enabled":true
}

Lưu ý: một số website chặn iframe. Với website đó hãy đặt mode = "newtab".
