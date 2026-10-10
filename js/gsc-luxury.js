/* GSC Luxury — bụi vàng lấp lánh (canvas, không phụ thuộc thư viện).
   Chèn vào hero, khối Golden Years và CTA cuối. Tự dừng khi ra khỏi màn hình / tab ẩn.
   Tắt hoàn toàn khi người dùng bật "giảm chuyển động". */
(function (w, d) {
  'use strict';
  if (w.matchMedia && w.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

  var TARGETS = [
    { sel: '.gsc-intro-hero', count: 46, size: 1.9 },
    { sel: '.gsc-intro-golden', count: 34, size: 1.7 },
    { sel: '.gsc-intro-final', count: 40, size: 1.8 }
  ];
  var small = w.innerWidth < 700;
  var dpr = Math.min(w.devicePixelRatio || 1, 2);

  function Sparkle(host, count, size) {
    var cv = d.createElement('canvas');
    cv.className = 'gsc-sparkle';
    cv.setAttribute('aria-hidden', 'true');
    host.insertBefore(cv, host.firstChild);
    var ctx = cv.getContext('2d');
    var W = 0, H = 0, run = false, raf = 0, parts = [];
    var n = small ? Math.round(count * 0.55) : count;

    function resize() {
      W = host.clientWidth; H = host.clientHeight;
      cv.width = Math.round(W * dpr); cv.height = Math.round(H * dpr);
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    }
    function make(init) {
      return {
        x: Math.random() * W,
        y: init ? Math.random() * H : H + 10,
        r: (Math.random() * 0.8 + 0.5) * size,
        vy: -(Math.random() * 0.22 + 0.06),
        vx: (Math.random() - 0.5) * 0.12,
        ph: Math.random() * 6.283,
        sp: Math.random() * 0.025 + 0.012,
        star: Math.random() < 0.35
      };
    }
    function star(x, y, r, a) {
      var g = ctx.createRadialGradient(x, y, 0, x, y, r * 4);
      g.addColorStop(0, 'rgba(255,244,214,' + a + ')');
      g.addColorStop(0.35, 'rgba(230,196,126,' + (a * 0.55) + ')');
      g.addColorStop(1, 'rgba(230,196,126,0)');
      ctx.fillStyle = g;
      ctx.beginPath(); ctx.arc(x, y, r * 4, 0, 6.283); ctx.fill();
    }
    function cross(x, y, r, a) {
      ctx.strokeStyle = 'rgba(255,244,214,' + a + ')';
      ctx.lineWidth = 0.8;
      ctx.beginPath();
      ctx.moveTo(x - r * 3.2, y); ctx.lineTo(x + r * 3.2, y);
      ctx.moveTo(x, y - r * 3.2); ctx.lineTo(x, y + r * 3.2);
      ctx.stroke();
    }
    function frame() {
      if (!run) return;
      ctx.clearRect(0, 0, W, H);
      for (var i = 0; i < parts.length; i++) {
        var p = parts[i];
        p.ph += p.sp; p.x += p.vx; p.y += p.vy;
        if (p.y < -10 || p.x < -10 || p.x > W + 10) parts[i] = p = make(false);
        var a = 0.25 + 0.75 * Math.abs(Math.sin(p.ph));
        star(p.x, p.y, p.r, a);
        if (p.star && a > 0.82) cross(p.x, p.y, p.r, (a - 0.82) * 4);
      }
      raf = w.requestAnimationFrame(frame);
    }
    function start() { if (run) return; run = true; raf = w.requestAnimationFrame(frame); }
    function stop() { run = false; w.cancelAnimationFrame(raf); }

    resize();
    for (var i = 0; i < n; i++) parts.push(make(true));
    w.addEventListener('resize', function () { resize(); }, { passive: true });

    if ('IntersectionObserver' in w) {
      new IntersectionObserver(function (es) {
        es.forEach(function (e) { e.isIntersecting ? start() : stop(); });
      }, { threshold: 0.05 }).observe(host);
    } else { start(); }
    d.addEventListener('visibilitychange', function () { if (d.hidden) stop(); });
  }

  function init() {
    TARGETS.forEach(function (t) {
      var host = d.querySelector(t.sel);
      if (host && !host.querySelector('.gsc-sparkle')) Sparkle(host, t.count, t.size);
    });
  }
  if (d.readyState === 'loading') d.addEventListener('DOMContentLoaded', init); else init();
})(window, document);
