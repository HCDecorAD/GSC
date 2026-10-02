import fs from 'node:fs';
import assert from 'node:assert/strict';

const read=p=>JSON.parse(fs.readFileSync(p,'utf8').replace(/^\uFEFF/,''));
const cfg=read('gsc-config.json');
let pass=0;
const t=(name,fn)=>{fn();pass++;console.log('PASS',name)};

t('CNAME authority',()=>{
  assert.equal(fs.readFileSync('CNAME','utf8').trim(),'gscsenior.hcdecorhub.com');
});

t('11 hotspots enabled',()=>{
  const ids=Object.keys(cfg.hotspots||{});
  assert.equal(ids.length,11);
  for(let i=1;i<=11;i++){
    const h=cfg.hotspots[String(i)];
    assert.ok(h,'hotspot '+i);
    assert.equal(h.id,i);
    assert.equal(h.enabled,true);
    assert.ok(Number.isFinite(Number(h.x))&&Number.isFinite(Number(h.y)));
  }
});

t('videos 1-10 present and hotspot 11 intentionally has no video',()=>{
  for(let i=1;i<=10;i++){
    const v=cfg.videos[String(i)];
    assert.ok(v?.url,'video '+i);
    assert.ok(v.url.startsWith('https://drive.google.com/file/d/'),'video '+i+' drive url');
  }
  assert.equal(cfg.videos['11']?.url||'','');
});

t('required static pages exist',()=>{
  for(const f of ['index.html','gsc-introduction.html','amenities.html','contact.html','gallery.html','location.html','residences.html','wellness.html']){
    assert.equal(fs.existsSync(f),true,f);
  }
});

t('seo/public control files exist',()=>{
  for(const f of ['robots.txt','sitemap.xml','404.html']) assert.equal(fs.existsSync(f),true,f);
});

console.log('GSC_E2E_SOURCE_PASS '+pass+'/5 hotspots=11 videos=10 hotspot11_video=none authority=github-pages');
