/* GSC Introduction — media layer: lazy images, logo, video. Attaches to window.GSCIntro. */
(function (w, d) {
  'use strict';
  var G = w.GSCIntro = w.GSCIntro || {};
  if (G._media) return;
  var reduce = w.matchMedia && w.matchMedia('(prefers-reduced-motion: reduce)').matches;
  var saveData = !!(w.navigator && w.navigator.connection && w.navigator.connection.saveData);
  function all(sel) { return Array.prototype.slice.call(d.querySelectorAll(sel)); }

  /* ---------- Images (lazy, WebP/AVIF-ready) ---------- */
  var lazy = null;
  function bg(url) { return 'url("' + String(url).replace(/"/g, '%22') + '")'; }
  function paint(el, url, alt) {
    var img = new Image();
    img.onload = function () {
      el.style.backgroundImage = bg(url);
      el.classList.remove('is-error'); el.classList.add('is-loaded');
      if (alt) { el.setAttribute('role', 'img'); el.setAttribute('aria-label', alt); }
    };
    img.onerror = function () { el.classList.add('is-error'); };
    img.src = url;
  }
  /* srcset-like: url may be a string or {avif, webp, src}; first format the browser can decode wins */
  function pick(u, cb) {
    if (typeof u === 'string' || !u) return cb(u);
    var list = [['avif', 'image/avif'], ['webp', 'image/webp']].filter(function (f) { return u[f[0]]; });
    (function next(i) {
      if (i >= list.length) return cb(u.src);
      var t = new Image();
      t.onload = function () { cb(u[list[i][0]]); };
      t.onerror = function () { next(i + 1); };
      t.src = u[list[i][0]];
    })(0);
  }
  function queue(el, u, alt) {
    if (!u) return;
    var go = function () { pick(u, function (url) { if (url) paint(el, url, alt); }); };
    if (el.hasAttribute('data-gsc-eager') || !('IntersectionObserver' in w)) { go(); return; }
    el.__go = go;
    if (!lazy) lazy = new IntersectionObserver(function (es) {
      es.forEach(function (en) {
        if (!en.isIntersecting) return;
        lazy.unobserve(en.target); en.target.__go();
      });
    }, { rootMargin: '400px 0px' });
    lazy.observe(el);
  }
  G.setAsset = function (name, url, alt) {
    all('[data-gsc-asset="' + name + '"]').forEach(function (el) { queue(el, url, alt); });
  };
  /* Gallery tiles share the "experience" hook; pass values in tile order */
  G.setExperience = function (list) {
    var tiles = all('[data-gsc-asset="experience"]');
    (list || []).forEach(function (u, i) { if (tiles[i]) queue(tiles[i], u); });
  };
  G.setLogo = function (url, alt) {
    if (!url) return;
    all('[data-gsc-logo]').forEach(function (el) {
      var img = d.createElement('img');
      img.src = url; img.alt = alt || 'GSC Senior Living & Wellness'; img.decoding = 'async';
      if (el.tagName === 'A') { el.textContent = ''; el.appendChild(img); }
      else if (el.parentNode) el.parentNode.replaceChild(img, el);
    });
  };

  /* ---------- Video: MP4 (+ optional WebM), poster, lazy, muted autoplay when appropriate ---------- */
  var vio = null;
  function playable(v) { return !reduce && !saveData; }
  G.setVideo = function (name, opts) {
    if (!opts || !opts.src) return;
    all('[data-gsc-video="' + name + '"]').forEach(function (box) {
      if (box.__vid) { box.__vid.pause(); box.textContent = ''; box.__vid = null; }
      var v = d.createElement('video');
      v.muted = true; v.defaultMuted = true; v.loop = opts.loop !== false;
      v.setAttribute('muted', ''); v.setAttribute('playsinline', ''); v.setAttribute('webkit-playsinline', '');
      v.playsInline = true; v.preload = 'none';
      if (opts.poster) v.poster = opts.poster;
      if (opts.label) v.setAttribute('aria-label', opts.label); else v.setAttribute('aria-hidden', 'true');
      v.tabIndex = -1;
      var auto = opts.autoplay !== false && playable();
      if (!auto) { v.controls = true; v.tabIndex = 0; v.removeAttribute('aria-hidden'); if (!opts.label) v.setAttribute('aria-label', 'Video giới thiệu dự án GSC'); }
      box.textContent = '';
      box.appendChild(v);
      box.hidden = false; box.removeAttribute('aria-hidden');
      if (opts.poster) box.style.backgroundImage = bg(opts.poster);
      var attached = false;
      function attach() {
        if (attached) return; attached = true;
        [['webm', 'video/webm'], ['src', 'video/mp4']].forEach(function (f) {
          if (!opts[f[0]]) return;
          var s = d.createElement('source'); s.src = opts[f[0]]; s.type = f[1]; v.appendChild(s);
        });
        v.addEventListener('error', function () { box.classList.add('is-fallback'); v.removeAttribute('controls'); v.style.display = 'none'; }, true);
        v.load();
      }
      box.__vid = v;
      if (!('IntersectionObserver' in w)) { attach(); if (auto) v.play().catch(function () {}); return; }
      if (!vio) vio = new IntersectionObserver(function (es) {
        es.forEach(function (en) {
          var el = en.target.__vid; if (!el) return;
          if (en.isIntersecting) { en.target.__attach(); if (en.target.__auto) { var p = el.play(); if (p && p.catch) p.catch(function () {}); } }
          else if (!el.paused) el.pause();
        });
      }, { rootMargin: '200px 0px', threshold: 0.25 });
      box.__attach = attach; box.__auto = auto;
      vio.observe(box);
    });
  };
  /* Pause every video when the tab is hidden */
  d.addEventListener('visibilitychange', function () {
    if (d.hidden) all('[data-gsc-video]').forEach(function (b) { if (b.__vid && !b.__vid.paused) b.__vid.pause(); });
  });
  G._media = true;
})(window, document);

[executed on device: HOCUONG (a318a9bd-cfd6-4540-bf01-3ab9fb7f587a)]
