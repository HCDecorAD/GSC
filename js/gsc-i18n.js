(function(){'use strict';
var dict={
"Nơi tuổi vàng bắt đầu một chương mới.":"Where golden years begin a new chapter.",
"KHÁM PHÁ DỰ ÁN":"EXPLORE THE PROJECT","Dự án":"Project","Masterplan":"Masterplan","Không gian sống":"Living","Wellness":"Wellness","Tiện ích":"Amenities","Vị trí":"Location","Khám phá":"Explore",
"MỘT CHƯƠNG MỚI CHO TUỔI VÀNG":"A NEW CHAPTER FOR GOLDEN YEARS","Tổng diện tích":"Total site area","Tháp":"Towers","Tầng / tháp":"Floors / tower","Quy mô tầng":"Floor configuration",
"SỐNG KHÔNG CHỈ LÀ Ở":"LIVING IS MORE THAN RESIDING","HỆ SINH THÁI WELLNESS":"WELLNESS ECOSYSTEM","TIỆN ÍCH DỰ ÁN":"PROJECT AMENITIES","VỊ TRÍ KẾT NỐI":"CONNECTED LOCATION","KHÁM PHÁ GSC":"EXPLORE GSC",
"KHÁM PHÁ TOÀN CẢNH":"EXPLORE DIGITAL TWIN","KHÁM PHÁ DIGITAL TWIN →":"EXPLORE DIGITAL TWIN →","LIÊN HỆ":"CONTACT","Chăm sóc":"Care","Đời sống":"Lifestyle","Vận động & thư giãn":"Active & Relaxation","Thiên nhiên & tâm linh":"Nature & Spirituality",
"Sống":"Live","Kết nối":"Connect","Tận hưởng":"Enjoy","A DAY AT GSC":"A DAY AT GSC","MỖI NGÀY LÀ MỘT TRẢI NGHIỆM MỚI":"EVERY DAY, A NEW EXPERIENCE",
"MỘT HỆ SINH THÁI CHO CUỘC SỐNG AN TÂM":"AN ECOSYSTEM FOR PEACE OF MIND","Sống chủ động":"Active living","Chăm sóc gần bên":"Care close at hand","Kết nối cộng đồng":"Connected community","Gần gũi thiên nhiên":"Close to nature",
"VISUAL JOURNEY":"VISUAL JOURNEY","THE MASTERPLAN":"THE MASTERPLAN","Digital Twin":"Digital Twin"
};
var originals=new WeakMap();
function norm(s){return String(s||'').replace(/\s+/g,' ').trim();}
function translateTextNode(n,lang){
 if(!originals.has(n)) originals.set(n,n.nodeValue);
 var vi=originals.get(n);
 if(lang==='vi'){n.nodeValue=vi;return;}
 var k=norm(vi),v=dict[k]; if(v) n.nodeValue=vi.replace(k,v);
}
function setLang(lang){
 document.documentElement.lang=lang;
 var walker=document.createTreeWalker(document.body,NodeFilter.SHOW_TEXT,{acceptNode:function(n){
   if(!n.nodeValue||!norm(n.nodeValue)) return NodeFilter.FILTER_REJECT;
   if(n.parentElement&&n.parentElement.closest('script,style')) return NodeFilter.FILTER_REJECT;
   return NodeFilter.FILTER_ACCEPT;
 }});
 var nodes=[],n; while((n=walker.nextNode())) nodes.push(n); nodes.forEach(function(x){translateTextNode(x,lang);});
 document.querySelectorAll('.gsc-lang__btn').forEach(function(b){var on=b.dataset.lang===lang;b.classList.toggle('is-active',on);b.setAttribute('aria-pressed',on?'true':'false');});
 try{localStorage.setItem('gsc-lang',lang)}catch(e){}
}
document.addEventListener('DOMContentLoaded',function(){
 document.querySelectorAll('.gsc-lang__btn').forEach(function(b){b.addEventListener('click',function(){setLang(b.dataset.lang);});});
 var l='vi';try{l=localStorage.getItem('gsc-lang')||'vi'}catch(e){}setLang(l==='en'?'en':'vi');
});
})();