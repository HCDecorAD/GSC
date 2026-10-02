import assert from 'node:assert/strict';

const origin='https://gscsenior.hcdecorhub.com';
async function get(path){
  const r=await fetch(origin+path,{redirect:'follow',headers:{'user-agent':'HC-GSC-Production-Smoke/1.0'}});
  const text=await r.text();
  return {r,text};
}

const home=await get('/');
assert.equal(home.r.ok,true,'home must return 2xx');
assert.ok(home.text.toLowerCase().includes('<html'),'home must be HTML');
assert.ok(new URL(home.r.url).hostname==='gscsenior.hcdecorhub.com','home must remain on production authority');

const robots=await get('/robots.txt');
assert.equal(robots.r.ok,true,'robots.txt must return 2xx');

const sitemap=await get('/sitemap.xml');
assert.equal(sitemap.r.ok,true,'sitemap.xml must return 2xx');
assert.ok(/<urlset|<sitemapindex/i.test(sitemap.text),'sitemap must be XML sitemap');

console.log('GSC_PRODUCTION_SMOKE_PASS home=2xx robots=2xx sitemap=2xx authority=gscsenior.hcdecorhub.com');
