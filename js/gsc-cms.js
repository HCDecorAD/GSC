(async()=>{try{
const r=await fetch('config/intro.json?ts='+Date.now(),{cache:'no-store'});if(!r.ok)return;
const c=await r.json();
const set=(q,v)=>{const e=document.querySelector(q);if(e&&v!=null&&v!=='')e.textContent=v};
set('.gsc-intro-hero__vi',c.hero?.title);
(c.sections||[]).forEach(s=>{
 const el=document.getElementById(s.id);if(!el)return;
 el.hidden=s.enabled===false;
 set('#'+s.id+' .gsc-intro-h2',s.title);
 set('#'+s.id+' .gsc-intro-copy',s.text);
 const fig=el.querySelector('.gsc-intro-fig');
 if(fig&&s.image){
   const safe=String(s.image).replace(/["'()]/g,'');
   fig.style.backgroundImage='url("'+safe+'")';
   fig.style.backgroundSize='cover';fig.style.backgroundPosition='center';
   fig.classList.add('is-loaded');
 }
});
}catch(e){console.warn('GSC CMS content unavailable',e)}})();