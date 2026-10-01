/* GSC Introduction — core: init, nav, menu, reveal, counters, parallax, actions. API: window.GSCIntro */
(function (w, d) {
  'use strict';
  var G = w.GSCIntro = w.GSCIntro || {};
  var root, reduce = w.matchMedia && w.matchMedia('(prefers-reduced-motion: reduce)').matches;
  var cfg = { assets: {}, links: {}, onAction: null };

  function all(sel) { return Array.prototype.slice.call((root || d).querySelectorAll(sel)); }

  /* Sticky nav: solid after hero threshold, scroll-spy sets aria-current */
  function initNav() {
    var nav = d.getElementById('gsc-intro-nav');
    if (!nav) return;
    var links = Array.prototype.slice.call(nav.querySelectorAll('.gsc-intro-nav__links a'));
    function solid() { nav.classList.toggle('is-solid', (w.pageYOffset || 0) > 40); }
    solid();
    w.addEventListener('scroll', solid, { passive: true });
    if (!('IntersectionObserver' in w)) return;
    var spy = new IntersectionObserver(function (es) {
      es.forEach(function (en) {
        if (!en.isIntersecting) return;
        links.forEach(function (a) {
          if (a.getAttribute('href') === '#' + en.target.id) a.setAttribute('aria-current', 'true');
          else a.removeAttribute('aria-current');
        });
      });
    }, { rootMargin: '-45% 0px -50% 0px' });
    links.forEach(function (a) { var t = d.querySelector(a.getAttribute('href')); if (t) spy.observe(t); });
  }

  /* CTA hooks: [data-gsc-action="home|panorama|contact|scroll"] */
  function onClick(e) {
    var a = e.target.closest ? e.target.closest('[data-gsc-action]') : null;
    if (!a) return;
    var action = a.getAttribute('data-gsc-action');
    var ev = new CustomEvent('gsc-intro:action', { bubbles: true, cancelable: true, detail: { action: action, href: a.getAttribute('href') } });
    a.dispatchEvent(ev);
    if (typeof cfg.onAction === 'function' && cfg.onAction(action, a) === false) { e.preventDefault(); return; }
    if (ev.defaultPrevented) { e.preventDefault(); return; }
    var url = cfg.links[action];
    if (action === 'scroll') {
      var t = d.querySelector(a.getAttribute('href'));
      if (t) { e.preventDefault(); t.scrollIntoView({ behavior: reduce ? 'auto' : 'smooth', block: 'start' }); }
    } else if (url) {
      e.preventDefault();
      w.location.href = url;
    }
  }

  /* Reveal on scroll + counters */
  function countTo(el) {
    var end = parseInt(el.getAttribute('data-gsc-count'), 10), pad = parseInt(el.getAttribute('data-gsc-pad') || '0', 10);
    function fmt(n) { var s = String(n).replace(/\B(?=(\d{3})+(?!\d))/g, '.'); while (s.length < pad) s = '0' + s; return s; }
    if (reduce || isNaN(end)) { el.textContent = fmt(end); return; }
    var t0 = null, dur = 1600;
    function step(t) {
      if (t0 === null) t0 = t;
      var p = Math.min((t - t0) / dur, 1), e = 1 - Math.pow(1 - p, 3);
      el.textContent = fmt(Math.round(end * e));
      if (p < 1) w.requestAnimationFrame(step);
    }
    w.requestAnimationFrame(step);
  }

  function initReveal() {
    var items = all('.gsc-intro-reveal'), counters = all('[data-gsc-count]');
    if (!('IntersectionObserver' in w) || reduce) {
      items.forEach(function (el) { el.classList.add('is-in'); });
      counters.forEach(function (el) { el.textContent = el.textContent; });
      return;
    }
    root.classList.add('is-js');
    counters.forEach(function (el) { el.textContent = el.getAttribute('data-gsc-pad') ? '00' : '0'; });
    var io = new IntersectionObserver(function (es) {
      es.forEach(function (en) {
        if (!en.isIntersecting) return;
        en.target.classList.add('is-in');
        all('[data-gsc-count]').forEach(function (c) {
          if (en.target.contains(c) && !c.__done) { c.__done = 1; countTo(c); }
        });
        io.unobserve(en.target);
      });
    }, { threshold: 0.15 });
    items.forEach(function (el) { io.observe(el); });
  }

  /* Light parallax on hero background only */
  function initParallax() {
    if (reduce) return;
    var bg = d.querySelector('.gsc-intro-hero__bg'), ticking = false;
    if (!bg) return;
    w.addEventListener('scroll', function () {
      if (ticking) return;
      ticking = true;
      w.requestAnimationFrame(function () {
        var y = w.pageYOffset || 0;
        if (y < w.innerHeight * 1.2) bg.style.transform = 'translate3d(0,' + (y * 0.18).toFixed(1) + 'px,0)';
        ticking = false;
      });
    }, { passive: true });
  }

  /* Mobile / tablet menu: toggle button, Esc, outside click, focus return */
  function initMenu() {
    var nav = d.getElementById('gsc-intro-nav');
    var btn = nav && nav.querySelector('.gsc-intro-nav__toggle');
    var menu = d.getElementById('gsc-intro-menu');
    if (!btn || !menu) return;
    function set(open) {
      nav.classList.toggle('is-open', open);
      btn.setAttribute('aria-expanded', open ? 'true' : 'false');
      d.documentElement.classList.toggle('gsc-intro-lock', open);
      if (open) {
        var first = menu.querySelector('a,button,[tabindex]:not([tabindex="-1"])');
        if (first) first.focus();
      }
    }
    btn.addEventListener('click', function () { set(btn.getAttribute('aria-expanded') !== 'true'); });
    menu.addEventListener('click', function (e) { if (e.target.closest('a')) set(false); });
    d.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && nav.classList.contains('is-open')) { set(false); btn.focus(); return; }
      if (e.key === 'Tab' && nav.classList.contains('is-open')) {
        var focusable = Array.prototype.slice.call(menu.querySelectorAll('a,button,[tabindex]:not([tabindex="-1"])'));
        if (!focusable.length) return;
        var first = focusable[0], last = focusable[focusable.length - 1];
        if (e.shiftKey && d.activeElement === first) { e.preventDefault(); last.focus(); }
        else if (!e.shiftKey && d.activeElement === last) { e.preventDefault(); first.focus(); }
      }
    });
    d.addEventListener('click', function (e) { if (nav.classList.contains('is-open') && !nav.contains(e.target)) set(false); });
    w.addEventListener('resize', function () { if (w.innerWidth > 1024) set(false); });
  }


  function initTheme() {
    var btn=d.querySelector('[data-gsc-theme-toggle]');
    if(!btn)return;
    var key='gsc-theme', saved=null;
    try{saved=w.localStorage.getItem(key);}catch(e){}
    var preferred=saved || (w.matchMedia&&w.matchMedia('(prefers-color-scheme: light)').matches?'light':'dark');
    function setTheme(theme,persist){
      var light=theme==='light';
      d.documentElement.setAttribute('data-gsc-theme',light?'light':'dark');
      btn.setAttribute('aria-pressed',light?'true':'false');
      btn.querySelector('span').textContent=light?'☀':'☾';
      btn.querySelector('b').textContent=light?'SÁNG':'TỐI';
      var meta=d.querySelector('meta[name="theme-color"]');if(meta)meta.setAttribute('content',light?'#f7f3ea':'#070c16');
      if(persist){try{w.localStorage.setItem(key,light?'light':'dark');}catch(e){}}
    }
    setTheme(preferred,false);
    btn.addEventListener('click',function(){setTheme(d.documentElement.getAttribute('data-gsc-theme')==='light'?'dark':'light',true);});
  }

  function apply(o) {
    if (o.logo) G.setLogo(o.logo, o.logoAlt);
    Object.keys(o.assets || {}).forEach(function (k) {
      if (k === 'experience') G.setExperience(o.assets[k]); else if (o.assets[k]) G.setAsset(k, o.assets[k], (o.alts || {})[k]);
    });
    if (o.experience) G.setExperience(o.experience);
    Object.keys(o.videos || {}).forEach(function (k) { G.setVideo(k, o.videos[k]); });
  }

  function init(options) {
    if (G._ready) return G;                     /* prevent duplicate initialization */
    root = d.getElementById('gsc-intro-root');
    if (!root) return G;
    G._ready = true;
    var o = options || w.GSC_INTRO_CONFIG || {};
    cfg.links = o.links || {};
    cfg.onAction = o.onAction || null;
    apply(o);
    root.addEventListener('click', onClick);
    initNav(); initMenu(); initTheme(); initReveal(); initParallax();
    /* Optional JSON config (only over http/https; fetch of file:// is blocked by browsers) */
    var url = o.configUrl || 'config/gsc-intro-assets.json';
    if (o.configUrl !== false && /^https?:$/.test(w.location.protocol) && w.fetch) {
      w.fetch(url, { credentials: 'same-origin' }).then(function (r) { return r.ok ? r.json() : null; })
        .then(function (j) { if (j) { cfg.links = Object.assign({}, cleanLinks(j.links), cfg.links); apply(j); } })
        .catch(function () {});
    }
    return G;
  }
  function cleanLinks(l) { var r = {}; Object.keys(l || {}).forEach(function (k) { if (l[k]) r[k] = l[k]; }); return r; }

  G.init = init;
  if (d.readyState === 'loading') d.addEventListener('DOMContentLoaded', function () { init(); });
  else init();
})(window, document);

