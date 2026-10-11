/* Trang Intro: gắn icon + link tới Landing page Tiện ích cho từng mục trong danh sách */
(function(){'use strict';
var M={'hồ koi':'koi','hồ bơi':'pool','công viên':'park','khu trồng trọt':'farm','khu tâm linh':'spirit','nhà hàng':'restaurant','cafe ngoài trời':'cafe','khu đánh cờ':'chess','khu tập ngoài trời':'exercise','đường dạo':'walk','không gian ngoài trời tầng 3':'terrace3','nhà thuốc':'pharmacy','vật lý trị liệu':'physio','phòng y tế / cấp cứu':'medical','reception':'reception','siêu thị':'market','bãi xe':'parking'};
function run(){
 var D=window.GSC_AM;if(!D)return;var E={};D.list.forEach(function(a){E[a.en.toLowerCase()]=a.key;});
 document.querySelectorAll('.gsc-intro-list1 li').forEach(function(li){
  if(li.querySelector('.gsc-am-li'))return;
  var t=(li.textContent||'').trim().toLowerCase(),k=M[t]||E[t];if(!k)return;
  var txt=li.textContent.trim();li.textContent='';
  var a=document.createElement('a');a.className='gsc-am-li';a.href='gsc-amenities.html#tt-'+k;a.setAttribute('data-k',k);
  a.innerHTML='<i class="gsc-am-ic">'+D.svg(k)+'</i><span></span><em aria-hidden="true">→</em>';
  a.querySelector('span').textContent=txt;li.appendChild(a);li.classList.add('has-am');
 });
}
if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',run);else run();
setTimeout(run,900);setTimeout(run,2500);
})();
