/* GSC Fly-through — cuộn chuột để camera "bay" qua từng khu của dự án.
   Thuần JavaScript, không phụ thuộc thư viện. Dữ liệu các điểm dừng nằm trong STOPS bên dưới:
   x, y = tâm điểm trên ảnh (0..1), s = độ zoom, rx = độ nghiêng (độ). Chỉnh tại đây để đổi hành trình. */
(function (w, d) {
  'use strict';
  var sec = d.getElementById('gsc-intro-fly');
  if (!sec) return;

  var IMG_W = 1672, IMG_H = 941, ASPECT = IMG_W / IMG_H;
  var reduce = w.matchMedia && w.matchMedia('(prefers-reduced-motion: reduce)').matches;
  var fine = w.matchMedia && w.matchMedia('(hover: hover) and (pointer: fine)').matches;

  var STOPS = [
    { x: .50, y: .50, s: 1.00, rx: 7,
      vi: ['TOÀN CẢNH', 'Toàn cảnh GSC', 'Cuộn chuột để bay qua từng không gian của dự án, từ cổng vào đến hai tháp đôi.'],
      en: ['OVERVIEW', 'GSC at a glance', 'Scroll to fly through each space of the project, from the entrance to the twin towers.'] },
    { x: .49, y: .86, s: 1.75, rx: 3,
      vi: ['MẶT TIỀN', 'Mặt tiền – Cổng vào', 'Điểm đón đầu tiên, nối khuôn viên với trục đường chính.'],
      en: ['FRONTAGE', 'Frontage – Entrance', 'The first welcome, linking the grounds to the main road.'] },
    { x: .47, y: .80, s: 2.15, rx: 2,
      vi: ['HỒ CÁ KOI', 'Hồ cá Koi', 'Mặt nước, cầu gỗ và đài phun nước ngay trước sảnh.'],
      en: ['KOI POND', 'Koi pond', 'Water, a timber bridge and fountains right in front of the lobby.'] },
    { x: .69, y: .78, s: 2.20, rx: 2,
      vi: ['KHU ĐÁNH CỜ', 'Khu đánh cờ – Thư giãn', 'Góc sinh hoạt nhẹ nhàng giữa cây xanh.'],
      en: ['CHESS GARDEN', 'Chess & relaxation', 'A gentle gathering corner among the greenery.'] },
    { x: .49, y: .67, s: 1.85, rx: 3,
      vi: ['CỔNG CHÍNH TÒA NHÀ', 'Cổng chính tòa nhà', 'Sảnh đón và khối đế kết nối hai tháp.'],
      en: ['MAIN LOBBY', 'Main building entrance', 'The lobby and podium that connect the two towers.'] },
    { x: .49, y: .30, s: 1.55, rx: 4,
      vi: ['HAI THÁP ĐÔI', 'Hai tháp đôi', 'Hai tháp 36 tầng (G + 35), điểm nhấn kiến trúc của dự án.'],
      en: ['TWIN TOWERS', 'Twin towers', 'Two 36-storey towers (G + 35), the architectural landmark of the project.'] },
    { x: .50, y: .40, s: 2.20, rx: 2,
      vi: ['HỒ BƠI', 'Hồ bơi', 'Không gian vận động và thư giãn ngoài trời.'],
      en: ['SWIMMING POOL', 'Swimming pool', 'Outdoor space for exercise and relaxation.'] },
    { x: .245, y: .37, s: 2.10, rx: 2,
      vi: ['TRỒNG TRỌT', 'Khu trồng trọt', 'Vườn trồng trọt để gần gũi thiên nhiên mỗi ngày.'],
      en: ['GARDENING', 'Gardening area', 'Gardens that keep nature close every day.'] },
    { x: .74, y: .365, s: 2.30, rx: 2,
      vi: ['TÂM LINH', 'Khu tâm linh', 'Góc tĩnh lặng dành cho đời sống tinh thần.'],
      en: ['SPIRITUAL', 'Spiritual area', 'A quiet corner for spiritual life.'] },
    { x: .18, y: .56, s: 2.00, rx: 3,
      vi: ['BÃI XE', 'Bãi xe', 'Bãi xe rộng rãi hai bên khuôn viên.'],
      en: ['PARKING', 'Parking', 'Generous parking on both sides of the grounds.'] },
    { x: .50, y: .50, s: 1.00, rx: 7,
      vi: ['HOÀN TẤT', 'Một chương mới cho tuổi vàng', 'Khám phá tương tác từng hotspot trong Digital Twin.'],
      en: ['COMPLETE', 'A new chapter for golden years', 'Explore every hotspot interactively in the Digital Twin.'] }
  ];
  var N = STOPS.length;
  sec.style.setProperty('--fly-steps', N);

  var TXT = {
    vi: { kicker: 'BAY QUANH DỰ ÁN', title: 'Trải nghiệm từng không gian', hint: 'CUỘN ĐỂ BAY', skip: 'BỎ QUA ↓', cta: 'KHÁM PHÁ DIGITAL TWIN', note: 'AI Concept Visualization — hình ảnh minh họa định hướng, không phải công trình hoàn thành.', rail: 'Đi tới: ' },
    en: { kicker: 'FLY AROUND THE PROJECT', title: 'Experience every space', hint: 'SCROLL TO FLY', skip: 'SKIP ↓', cta: 'EXPLORE DIGITAL TWIN', note: 'AI Concept Visualization — illustrative imagery, not a completed building.', rail: 'Go to: ' }
  };

  var stick = sec.querySelector('.gsc-fly__stick');
  var tilt = sec.querySelector('.gsc-fly__tilt');
  var world = sec.querySelector('.gsc-fly__world');
  var img = world.querySelector('img');
  var card = sec.querySelector('.gsc-fly__card');
  var elNum = sec.querySelector('.gsc-fly__num');
  var elName = sec.querySelector('.gsc-fly__name');
  var elText = sec.querySelector('.gsc-fly__text');
  var elCta = sec.querySelector('.gsc-fly__cta');
  var rail = sec.querySelector('.gsc-fly__rail');

  var vw = 0, vh = 0, W = 0, H = 0;
  var target = 0, cur = 0, active = -1, running = false, visible = false;
  var mx = 0, my = 0, tmx = 0, tmy = 0;

  function lang() { return (d.documentElement.lang || 'vi').toLowerCase().indexOf('en') === 0 ? 'en' : 'vi'; }
  function clamp(v, a, b) { return v < a ? a : v > b ? b : v; }
  function smooth(t) { t = clamp(t, 0, 1); return t * t * (3 - 2 * t); }

  /* ---------- Giao diện chữ (song ngữ) ---------- */
  function paintStatic() {
    var L = TXT[lang()];
    sec.querySelector('.gsc-fly__kicker').textContent = L.kicker;
    sec.querySelector('.gsc-fly__title').textContent = L.title;
    sec.querySelector('.gsc-fly__hint span').textContent = L.hint;
    sec.querySelector('.gsc-fly__skip').textContent = L.skip;
    sec.querySelector('.gsc-fly__note').textContent = L.note;
    elCta.textContent = L.cta;
    var btns = rail.querySelectorAll('button');
    for (var i = 0; i < btns.length; i++) {
      btns[i].setAttribute('aria-label', L.rail + STOPS[i][lang()][1]);
      btns[i].querySelector('span').textContent = STOPS[i][lang()][0];
    }
  }
  function paintCard(i) {
    var s = STOPS[i], t = s[lang()], pad = function (n) { return n < 10 ? '0' + n : '' + n; };
    elNum.innerHTML = '<b>' + pad(i + 1) + '</b> / ' + pad(N);
    elName.textContent = t[1];
    elText.textContent = t[2];
    elCta.hidden = i !== N - 1;
  }
  function setActive(i) {
    if (i === active) return;
    active = i;
    var btns = rail.querySelectorAll('button');
    for (var k = 0; k < btns.length; k++) btns[k].classList.toggle('is-on', k === i);
    if (reduce) { paintCard(i); return; }
    card.classList.add('is-swap');
    w.setTimeout(function () { paintCard(i); card.classList.remove('is-swap'); }, 200);
  }

  /* ---------- Rail ---------- */
  for (var i = 0; i < N; i++) {
    (function (i) {
      var li = d.createElement('li'), b = d.createElement('button'), sp = d.createElement('span');
      b.type = 'button'; b.appendChild(sp); li.appendChild(b); rail.appendChild(li);
      b.addEventListener('click', function () { goTo(i); });
    })(i);
  }
  function goTo(i) {
    var top = sec.getBoundingClientRect().top + (w.pageYOffset || d.documentElement.scrollTop || 0);
    var total = sec.offsetHeight - vh;
    w.scrollTo({ top: top + (i / (N - 1)) * total + 1, behavior: reduce ? 'auto' : 'smooth' });
  }

  /* ---------- Máy quay ---------- */
  function measure() {
    vw = stick.clientWidth; vh = stick.clientHeight;
    W = Math.max(vw, vh * ASPECT); H = W / ASPECT;
    world.style.width = W + 'px'; world.style.height = H + 'px';
  }
  function readProgress() {
    var r = sec.getBoundingClientRect();
    var total = r.height - vh;
    target = total > 0 ? clamp(-r.top / total, 0, 1) : 0;
  }
  function frame() {
    running = false;
    if (!visible) return;
    var k = reduce ? 1 : 0.1;
    cur += (target - cur) * k;
    if (Math.abs(target - cur) < 0.0002) cur = target;
    tmx += (mx - tmx) * 0.08; tmy += (my - tmy) * 0.08;

    var t = cur * (N - 1);
    var i = clamp(Math.floor(t), 0, N - 2), frac = t - i;
    if (cur >= 1) { i = N - 2; frac = 1; }
    /* giữ lại một nhịp ở mỗi điểm dừng, rồi mới bay */
    var f = reduce ? (frac < .5 ? 0 : 1) : smooth((frac - 0.22) / 0.56);
    var a = STOPS[i], b = STOPS[i + 1];

    var cx = a.x + (b.x - a.x) * f, cy = a.y + (b.y - a.y) * f;
    var ls = Math.log(a.s) + (Math.log(b.s) - Math.log(a.s)) * f;
    var s = Math.exp(ls) * (1 - 0.2 * Math.sin(Math.PI * f));       /* lùi ra giữa chặng cho cảm giác bay */
    var rx = a.rx + (b.rx - a.rx) * f + (fine ? tmy * -1.4 : 0);
    var ry = (fine ? tmx * 2.2 : 0) + (f > 0 && f < 1 ? (b.x - a.x) * 5 * Math.sin(Math.PI * f) : 0);

    var sw = W * s, sh = H * s;
    var tx = vw / 2 - cx * sw - (fine ? tmx * 14 : 0);
    var ty = vh / 2 - cy * sh - (fine ? tmy * 10 : 0);
    tx = clamp(tx, vw - sw, 0); ty = clamp(ty, vh - sh, 0);

    world.style.transform = 'translate3d(' + tx.toFixed(1) + 'px,' + ty.toFixed(1) + 'px,0) scale(' + s.toFixed(4) + ')';
    tilt.style.setProperty('--frx', rx.toFixed(2) + 'deg');
    tilt.style.setProperty('--fry', ry.toFixed(2) + 'deg');

    setActive(clamp(Math.round(t), 0, N - 1));
    sec.classList.toggle('is-start', cur < 0.02);
    sec.classList.toggle('is-moving', cur >= 0.02);

    if (Math.abs(target - cur) > 0.0002 || Math.abs(mx - tmx) > 0.002 || Math.abs(my - tmy) > 0.002) kick();
  }
  function kick() { if (!running && visible) { running = true; w.requestAnimationFrame(frame); } }

  w.addEventListener('scroll', function () { if (visible) { readProgress(); kick(); } }, { passive: true });
  w.addEventListener('resize', function () { measure(); readProgress(); kick(); }, { passive: true });
  if (fine) {
    stick.addEventListener('pointermove', function (e) {
      var r = stick.getBoundingClientRect();
      mx = ((e.clientX - r.left) / r.width - 0.5) * 2;
      my = ((e.clientY - r.top) / r.height - 0.5) * 2;
      kick();
    }, { passive: true });
    stick.addEventListener('pointerleave', function () { mx = 0; my = 0; kick(); }, { passive: true });
  }
  /* phím mũi tên khi đang ở trong phần này */
  d.addEventListener('keydown', function (e) {
    if (!visible || (e.key !== 'ArrowRight' && e.key !== 'ArrowLeft')) return;
    var r = sec.getBoundingClientRect();
    if (r.top > 0 || r.bottom < vh) return;
    var i = clamp(Math.round(cur * (N - 1)) + (e.key === 'ArrowRight' ? 1 : -1), 0, N - 1);
    goTo(i);
  });

  /* ngôn ngữ đổi -> vẽ lại chữ */
  new MutationObserver(function () { paintStatic(); if (active >= 0) paintCard(active); })
    .observe(d.documentElement, { attributes: true, attributeFilter: ['lang'] });

  if ('IntersectionObserver' in w) {
    new IntersectionObserver(function (es) {
      visible = es[0].isIntersecting;
      if (visible) { measure(); readProgress(); cur = target; kick(); }
    }, { rootMargin: '200px 0px' }).observe(sec);
  } else { visible = true; }

  paintStatic();
  measure(); readProgress(); cur = target;
  paintCard(0); active = 0;
  rail.querySelectorAll('button')[0].classList.add('is-on');
  img.addEventListener('load', function () { kick(); });
  kick();
})(window, document);
