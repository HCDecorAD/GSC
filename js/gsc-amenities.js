(function(){'use strict';
var D=window.GSC_AM,d=document,root=d.documentElement,reduce=matchMedia('(prefers-reduced-motion: reduce)').matches;
var lang='vi';function gl(){var l=root.getAttribute('data-sh-lang');if(!l){try{l=localStorage.getItem('gsc-lang')}catch(e){}}return l==='en'?'en':'vi';}
function t(a,f){return a[f+(lang==='en'?'':'')]}
var pts=d.getElementById('am-points'),rail=d.getElementById('am-rail'),mapbox=d.getElementById('am-mapbox');
var vi=function(a,k){return lang==='en'?a[k==='d'?'den':k==='t'?'ten':'en']:a[k==='d'?'dvi':k==='t'?'tvi':'vi'];};
function media(a){
 var v='';
 if(a.video)v='<iframe src="https://www.youtube-nocookie.com/embed/'+a.video+'" title="'+a.vi+'" loading="lazy" allowfullscreen></iframe>';
 else if(a.drive)v='<iframe src="https://drive.google.com/file/d/'+a.drive+'/preview" title="'+a.vi+'" loading="lazy" allowfullscreen></iframe>';
 return '<div class="am-fig"><div class="am-fig__img" style="background-image:url('+a.img+')"></div><span class="am-fig__no">'+('0'+a.n).slice(-2)+'<small>/17</small></span><span class="am-fig__ic">'+D.svg(a.key)+'</span>'+(v?'<div class="am-fig__vid">'+v+'</div>':'')+'</div>';
}
function build(){
 var html='',cur='';
 D.list.forEach(function(a){
  if(a.group!==cur){cur=a.group;var g=D.groups[cur];html+='<header class="am-group" data-g="'+cur+'"><span class="am-group__line"></span><p class="am-eyebrow">'+g[0]+'</p><h2 class="am-h2 am-foil">'+(lang==='en'?g[2]:g[1])+'</h2></header>';}
  html+='<section class="am-point am-reveal" id="'+a.id+'" data-key="'+a.key+'"><div class="am-wrap am-split'+(a.n%2?'':' am-split--rev')+'">'+media(a)+
  '<div class="am-txt"><span class="am-big" aria-hidden="true">'+D.svg(a.key)+'</span><p class="am-eyebrow">'+('0'+a.n).slice(-2)+' — '+D.groups[a.group][0]+'</p><h3 class="am-h3 am-foil">'+vi(a,'n')+'</h3><p class="am-copy">'+vi(a,'d')+'</p><ul class="am-tags">'+vi(a,'t').map(function(x){return '<li>'+x+'</li>'}).join('')+'</ul>'+
  '<a class="am-more" href="index.html">'+(lang==='en'?'See on Digital Twin':'Xem trên Digital Twin')+' →</a></div></div></section>';
 });
 pts.innerHTML=html;
 rail.innerHTML='<div class="am-rail__in">'+D.list.map(function(a){return '<a href="#'+a.id+'" data-id="'+a.id+'" title="'+vi(a,'n')+'" aria-label="'+vi(a,'n')+'">'+D.svg(a.key)+'<b>'+vi(a,'n')+'</b></a>';}).join('')+'</div>';
 mapbox.querySelectorAll('.am-pin').forEach(function(p){p.remove();});
 D.list.forEach(function(a){var p=d.createElement('a');p.className='am-pin';p.href='#'+a.id;p.style.left=a.pin[0]+'%';p.style.top=a.pin[1]+'%';p.setAttribute('aria-label',vi(a,'n'));p.innerHTML='<i>'+D.svg(a.key)+'</i><span>'+vi(a,'n')+'</span>';mapbox.appendChild(p);});
 observe();
}
var io,spy;
function observe(){
 if(io)io.disconnect();if(spy)spy.disconnect();
 io=new IntersectionObserver(function(es){es.forEach(function(e){if(e.isIntersecting){e.target.classList.add('is-in');io.unobserve(e.target);}});},{threshold:.15});
 d.querySelectorAll('.am-reveal,.am-group').forEach(function(n){io.observe(n);});
 spy=new IntersectionObserver(function(es){es.forEach(function(e){if(e.isIntersecting){var id=e.target.id;rail.querySelectorAll('a').forEach(function(a){var on=a.dataset.id===id;a.classList.toggle('is-on',on);if(on){var r=rail.querySelector('.am-rail__in');if(r&&innerWidth<=900)r.scrollTo({left:a.offsetLeft-r.clientWidth/2+a.clientWidth/2,behavior:'smooth'});}});}});},{rootMargin:'-45% 0px -50% 0px'});
 d.querySelectorAll('.am-point').forEach(function(n){spy.observe(n);});
 /* rail chỉ hiện khi đã qua bản đồ */
}
function railVis(){var m=d.getElementById('am-map').getBoundingClientRect(),c=d.querySelector('.am-cta').getBoundingClientRect();rail.classList.toggle('is-show',m.bottom<innerHeight*.5&&c.top>innerHeight*.6);}
/* parallax nhẹ cho ảnh */
var tick=false;function onScroll(){railVis();if(reduce||tick)return;tick=true;requestAnimationFrame(function(){tick=false;d.querySelectorAll('.am-fig__img').forEach(function(f){var r=f.parentNode.getBoundingClientRect();if(r.bottom<0||r.top>innerHeight)return;var p=(r.top+r.height/2-innerHeight/2)/innerHeight;f.style.transform='scale(1.12) translateY('+(p*-22).toFixed(1)+'px)';});var h=d.querySelector('.am-hero__bg');if(h&&scrollY<innerHeight)h.style.transform='translateY('+(scrollY*.3)+'px) scale(1.08)';});}
addEventListener('scroll',onScroll,{passive:true});addEventListener('resize',railVis);
/* ngôn ngữ cho phần tĩnh */
function statics(){d.querySelectorAll('[data-vi][data-en]').forEach(function(n){if(n.closest('.gsc-sh,.gsc-sh-footer'))return;n.textContent=n.getAttribute('data-'+lang);});}
function setLang(){lang=gl();statics();build();}
new MutationObserver(function(){if(gl()!==lang)setLang();}).observe(root,{attributes:true,attributeFilter:['data-sh-lang','lang']});
/* cuộn mượt tới điểm, trừ header */
d.addEventListener('click',function(e){var a=e.target.closest&&e.target.closest('a[href^="#"]');if(!a)return;var id=a.getAttribute('href').slice(1),el=id&&d.getElementById(id);if(!el)return;e.preventDefault();var y=el.getBoundingClientRect().top+scrollY-(innerWidth<=900?130:60);scrollTo({top:y,behavior:reduce?'auto':'smooth'});history.replaceState(null,'','#'+id);
 el.classList.add('is-ping');setTimeout(function(){el.classList.remove('is-ping');},1600);});
/* bụi vàng hero */
(function(){var c=d.querySelector('.am-sparkle');if(!c||reduce)return;var x=c.getContext('2d'),W,H,P=[];function rs(){W=c.width=c.offsetWidth;H=c.height=c.offsetHeight;}rs();addEventListener('resize',rs);
 for(var i=0;i<46;i++)P.push({x:Math.random(),y:Math.random(),r:Math.random()*1.8+.4,s:Math.random()*.0004+.0001,p:Math.random()*6});
 (function f(t){x.clearRect(0,0,W,H);P.forEach(function(q){q.y-=q.s*16;if(q.y<0)q.y=1;var a=.35+.55*Math.abs(Math.sin(t/900+q.p));x.fillStyle='rgba(240,205,120,'+a+')';x.beginPath();x.arc(q.x*W,q.y*H,q.r,0,6.3);x.fill();});requestAnimationFrame(f);})(0);})();
setLang();
if(location.hash){setTimeout(function(){var el=d.getElementById(location.hash.slice(1));if(el)el.scrollIntoView({block:'start'});},400);}
})();
