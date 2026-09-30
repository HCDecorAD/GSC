(function(){'use strict';
var dict={
"WHERE GOLDEN YEARS\nBEGIN A NEW CHAPTER":"WHERE GOLDEN YEARS\nBEGIN A NEW CHAPTER",
"Nơi tuổi vàng bắt đầu một chương mới.":"Where golden years begin a new chapter.",
"KHÁM PHÁ DỰ ÁN":"EXPLORE THE PROJECT","Tổng quan":"Overview","Kiến trúc":"Architecture","Tiện ích":"Amenities","Vị trí":"Location","Khám phá":"Explore",
"MỘT CHƯƠNG MỚI\nCHO TUỔI VÀNG":"A NEW CHAPTER\nFOR GOLDEN YEARS","Tổng diện tích":"Total site area","Tháp":"Towers","Tầng / tháp":"Floors / tower","Quy mô tầng":"Floor configuration",
"SỐNG KHÔNG\nCHỈ LÀ Ở":"LIVING IS MORE\nTHAN RESIDING","HỆ SINH THÁI WELLNESS":"WELLNESS ECOSYSTEM","TIỆN ÍCH\nDỰ ÁN":"PROJECT\nAMENITIES","VỊ TRÍ KẾT NỐI":"CONNECTED LOCATION","KHÁM PHÁ GSC":"EXPLORE GSC",
"KHÁM PHÁ TOÀN CẢNH":"EXPLORE DIGITAL TWIN","LIÊN HỆ":"CONTACT","Chăm sóc":"Care","Đời sống":"Lifestyle","Vận động & thư giãn":"Active & Relaxation","Thiên nhiên & tâm linh":"Nature & Spirituality",
"Sống":"Live","Kết nối":"Connect","Tận hưởng":"Enjoy"
};
var original=new WeakMap(), selector='h1,h2,h3,p,dt,dd,li,a,figcaption,span';
function key(el){return (original.get(el)||el.textContent).trim().replace(/\s*\n\s*/g,'\n').replace(/\s+/g,' ');}
function setLang(lang){document.documentElement.lang=lang;document.querySelectorAll(selector).forEach(function(el){if(!original.has(el))original.set(el,el.textContent);var vi=original.get(el);if(lang==='vi'){el.textContent=vi;return;}var k=key(el),v=dict[k];if(v)el.innerHTML=v.replace(/\n/g,'<br>');});document.querySelectorAll('.gsc-lang__btn').forEach(function(b){var on=b.dataset.lang===lang;b.classList.toggle('is-active',on);b.setAttribute('aria-pressed',on?'true':'false');});try{localStorage.setItem('gsc-lang',lang)}catch(e){}}
document.addEventListener('DOMContentLoaded',function(){document.querySelectorAll('.gsc-lang__btn').forEach(function(b){b.addEventListener('click',function(){setLang(b.dataset.lang)})});var l='vi';try{l=localStorage.getItem('gsc-lang')||'vi'}catch(e){}setLang(l==='en'?'en':'vi')});
})();