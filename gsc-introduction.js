[Reading 170 lines from start (total: 170 lines, 0 remaining)]

/* GSC Introduction — window.GSCIntro (vanilla JS, no dependencies) */
(function (w, d) {
  'use strict';
  var root, reduce = w.matchMedia && w.matchMedia('(prefers-reduced-motion: reduce)').matches;
  var cfg = { assets: {}, links: {}, onAction: null };

  function all(sel) { return Array.prototype.slice.call((root || d).querySelectorAll(sel)); }

  /* Lazy asset loader: images load when within 400px of the viewport (hero loads at once) */
  var lazy = null;
  function paint(el, url, alt) {
    var img = new Image();
    img.onload = function () {
      el.style.backgroundImage = 'url("' + url + '")';
      el.classList.add('is-loaded');
      if (alt) { el.setAttribute('role', 'img'); el.setAttribute('aria-label', alt); }
    };
    img.onerror = function () { el.classList.add('is-error'); };
    img.src = url;
  }
  function queue(el, url, alt) {
    if (!url) return;
    if (el.hasAttribute('data-gsc-eager') || !('IntersectionObserver' in w)) { paint(el, url, alt); return; }
    el.__src = url; el.__alt = alt;
    if (!lazy) {
      lazy = new IntersectionObserver(function (es) {
        es.forEach(function (en) {
          if (!en.isIntersecting) return;
          paint(en.target, en.target.__src, en.target.__alt);
          lazy.unobserve(en.target);
        });
      }, { rootMargin: '400px 0px' });
    }
    lazy.observe(el);
  }

  /* Asset hooks: GSCIntro.setAsset('hero', 'media/hero.jpg', 'alt') */
  function setAsset(name, url, alt) {
    all('[data-gsc-asset="' + name + '"]').forEach(function (el) { queue(el, url, alt); });
  }
  /* Six gallery tiles share the "experience" hook: pass URLs in tile order */
  function setExperience(list) {
    var tiles = all('[data-gsc-asset="experience"]');
    (list || []).forEach(function (url, i) { if (tiles[i]) queue(tiles[i], url); });
  }
  /* Logo hook: GSCIntro.setLogo('media/gsc-logo.svg') swaps every [data-gsc-logo] for an <img> */
  function setLogo(url, alt) {
    if (!url) return;
    all('[data-gsc-logo]').forEach(function (el) {
      var host = el.tagName === 'A' ? el : el.parentNode;
      var img = d.createElement('img');
      img.src = url; img.alt = alt || 'GSC Senior Living & Wellness'; img.decoding = 'async';
      if (el.tagName === 'A') { el.textContent = ''; el.appendChild(img); }
      else { host.replaceChild(img, el); }
    });
  }

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

  function init(options) {
    root = d.getElementById('gsc-intro-root');
    if (!root || root.__gscIntroInitialized) return;
    root.__gscIntroInitialized = true;
    var o = options || w.GSC_INTRO_CONFIG || {};
    cfg.links = o.links || {};
    cfg.onAction = o.onAction || null;
    Object.keys(o.assets || {}).forEach(function (k) {
      if (k === 'experience') setExperience(o.assets[k]); else setAsset(k, o.assets[k]);
    });
    if (o.logo) setLogo(o.logo, o.logoAlt);
    root.addEventListener('click', onClick);
    initNav();
    initReveal();
    initParallax();
  }

  w.GSCIntro = { init: init, setAsset: setAsset, setExperience: setExperience, setLogo: setLogo };
  if (d.readyState === 'loading') d.addEventListener('DOMContentLoaded', function () { init(); });
  else init();
})(window, document);

[executed on device: HOCUONG (a318a9bd-cfd6-4540-bf01-3ab9fb7f587a)]