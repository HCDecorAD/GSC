/* GSC Shell — header + footer + nút nổi FB/Zalo dùng chung cho mọi trang.
   Muốn đổi menu / số điện thoại / link mạng xã hội: sửa object CFG bên dưới, mọi trang đổi theo.
   Nạp ở cuối <body>, chạy đồng bộ để không bị nháy header cũ. */
(function (w, d) {
  'use strict';
  var root = d.documentElement;
  var CFG = {
    logo: 'assets/gsc-web/gsc-logo-gold-red.png',
    phone: '093 268 0592', tel: 'tel:+84932680592',
    email: 'Kathy.nguyen171@gmail.com',
    address: 'Vinhomes Grand Park, Nguyễn Xiển, Phường Long Thạnh Mỹ, Thủ Đức, TP.HCM',
    fb: 'https://www.facebook.com/profile.php?id=100083708970226',
    zalo: 'https://zalo.me/0932680592',
    tiktok: 'https://www.tiktok.com/@amo_3651',
    youtube: 'https://www.youtube.com/@AMO-NGUYEN',
    menu: [
      ['gsc-introduction.html', 'Giới thiệu', 'Introduction'],
      ['project.html', 'Dự án', 'Project'],
      ['residences.html', 'Không gian sống', 'Residences'],
      ['wellness.html', 'Wellness & Care', 'Wellness & Care'],
      ['lifestyle.html', 'Lifestyle', 'Lifestyle'],
      ['amenities.html', 'Tiện ích', 'Amenities'],
      ['location.html', 'Vị trí', 'Location'],
      ['gallery.html', 'Gallery', 'Gallery'],
      ['insights.html', 'Insights', 'Insights'],
      ['contact.html', 'Liên hệ', 'Contact'],
      ['index.html', 'Digital Twin', 'Digital Twin']
    ]
  };
  var T = {
    vi: { contact: 'LIÊN HỆ', about: 'Về GSC', explore: 'Khám phá', reach: 'Kết nối',
      blurb: 'Senior Living & Wellness — nơi tuổi vàng bắt đầu một chương mới: không gian sống, chăm sóc sức khoẻ, cộng đồng và thiên nhiên hài hoà trong một quần thể.',
      hot: 'Hotline / Zalo', mail: 'Email', office: 'Văn phòng liên hệ',
      note: 'Hình ảnh phối cảnh AI Concept chỉ minh hoạ định hướng, không phải công trình hoàn thành.',
      top: 'Lên đầu trang ↑', menu: 'Mở menu', theme: 'Sáng / Tối', fbl: 'Facebook', zl: 'Chat Zalo', home: 'Hotline' },
    en: { contact: 'CONTACT', about: 'About GSC', explore: 'Explore', reach: 'Connect',
      blurb: 'Senior Living & Wellness — where golden years begin a new chapter: living spaces, healthcare, community and nature in harmony.',
      hot: 'Hotline / Zalo', mail: 'Email', office: 'Contact office',
      note: 'AI concept renders illustrate the vision only and are not the completed building.',
      top: 'Back to top ↑', menu: 'Open menu', theme: 'Light / Dark', fbl: 'Facebook', zl: 'Chat on Zalo', home: 'Hotline' }
  };
  var lang = 'vi';
  try { lang = w.localStorage.getItem('gsc-lang') === 'en' ? 'en' : 'vi'; } catch (e) {}

  var page = (w.location.pathname.split('/').pop() || 'index.html').toLowerCase();
  if (page === '' || page === '/') page = 'index.html';
  var isHome = page === 'index.html' || !!d.getElementById('gscIntroStable');

  var ICON = {
    fb: '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M13.5 22v-8.2h2.8l.5-3.3h-3.3V8.4c0-.9.4-1.7 1.8-1.7h1.6V3.8S15.6 3.5 14.3 3.5c-2.7 0-4.4 1.6-4.4 4.5v2.5H7.2v3.3h2.7V22z"/></svg>',
    zalo: '<svg viewBox="0 0 48 48" aria-hidden="true"><path d="M24 6C13.5 6 6 13 6 21.6c0 4.6 2.2 8.7 5.6 11.5-.2 2.2-.9 4.3-2 6.1 3-.2 5.7-1.4 7.8-3 2.1.7 4.3 1 6.6 1 10.5 0 18-7 18-15.6S34.500 6 24 6z" fill="none" stroke="#fff" stroke-width="2.4"/><text x="24" y="26.5" text-anchor="middle" font-family="Arial,sans-serif" font-weight="700" font-size="11.5" fill="#fff" stroke="none">Zalo</text></svg>',
    tiktok: '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M16.6 3c.3 2.2 1.6 3.6 3.9 3.8v3a7 7 0 0 1-3.9-1.2v6.2c0 3.2-2.4 5.6-5.6 5.6S5.500 18.100 5.500 15s2.600-5.800 6-5.600v3.100c-1.600-.3-3 .9-3 2.500a2.600 2.600 0 0 0 5.200 0V3z"/></svg>',
    youtube: '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M21.600 7.200a2.500 2.500 0 0 0-1.800-1.800C18.200 5 12 5 12 5s-6.200 0-7.800.4A2.500 2.500 0 0 0 2.400 7.200C2 8.800 2 12 2 12s0 3.200.4 4.800a2.500 2.500 0 0 0 1.800 1.800C5.800 19 12 19 12 19s6.200 0 7.800-.4a2.500 2.500 0 0 0 1.800-1.800c.4-1.600.4-4.800.4-4.800s0-3.200-.4-4.800zM10 15V9l5.200 3z"/></svg>',
    phone: '<svg viewBox="0 0 24 24"><path d="M5 4h4l2 5-2.500 1.500a11 11 0 0 0 5 5L15 13l5 2v4a2 2 0 0 1-2 2A16 16 0 0 1 3 6a2 2 0 0 1 2-2z"/></svg>',
    mail: '<svg viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="14" rx="1.500"/><path d="m3 7 9 6 9-6"/></svg>',
    pin: '<svg viewBox="0 0 24 24"><path d="M12 21s7-6.100 7-11a7 7 0 0 0-14 0c0 4.900 7 11 7 11z"/><circle cx="12" cy="10" r="2.500"/></svg>'
  };

  function esc(s) { return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;'); }
  function el(html) { var t = d.createElement('div'); t.innerHTML = html.trim(); return t.firstChild; }
  function L() { return T[lang]; }

  function menuHTML() {
    return CFG.menu.map(function (m) {
      var cur = m[0].toLowerCase() === page ? ' aria-current="page"' : '';
      return '<li><a href="' + m[0] + '"' + cur + ' data-vi="' + esc(m[1]) + '" data-en="' + esc(m[2]) + '">' + esc(lang === 'en' ? m[2] : m[1]) + '</a></li>';
    }).join('');
  }

  function buildHeader() {
    var h = el(
      '<header class="gsc-sh" id="gsc-sh" role="banner">' +
      '<a class="gsc-sh__brand" href="gsc-introduction.html" aria-label="GSC Senior Living &amp; Wellness"><img src="' + CFG.logo + '" alt="GSC" width="120" height="46"></a>' +
      '<ul class="gsc-sh__nav" id="gsc-sh-nav" aria-label="Điều hướng chính">' + menuHTML() + '</ul>' +
      '<div class="gsc-sh__tools">' +
      '<div class="gsc-sh__lang" role="group" aria-label="Ngôn ngữ / Language"><button type="button" data-l="vi">VN</button><button type="button" data-l="en">EN</button></div>' +
      '<button class="gsc-sh__btn gsc-sh__theme" type="button" aria-label="Sáng / Tối"><span aria-hidden="true">☾</span></button>' +
      '<button class="gsc-sh__btn gsc-sh__burger" type="button" aria-expanded="false" aria-controls="gsc-sh-nav" aria-label="Mở menu">☰</button>' +
      '</div></header>');
    return h;
  }

  function buildFooter() {
    var t = L();
    var links = CFG.menu.map(function (m) {
      return '<li><a href="' + m[0] + '" data-vi="' + esc(m[1]) + '" data-en="' + esc(m[2]) + '">' + esc(lang === 'en' ? m[2] : m[1]) + '</a></li>';
    }).join('');
    return el(
      '<footer class="gsc-sh-footer" id="gsc-footer">' +
      '<div class="gsc-sh-footer__top"><a class="gsc-sh-footer__logo" href="gsc-introduction.html"><img src="' + CFG.logo + '" alt="GSC Senior Living &amp; Wellness" loading="lazy"></a>' +
      '<p class="gsc-sh-footer__slogan">WHERE GOLDEN YEARS BEGIN A NEW CHAPTER</p>' +
      '<div class="gsc-sh-footer__orn" aria-hidden="true"><i></i><b></b><i></i></div></div>' +
      '<div class="gsc-sh-footer__grid">' +
      '<div><h3 data-k="about">' + t.about + '</h3><p data-k="blurb">' + t.blurb + '</p>' +
      '<div class="gsc-sh-social">' +
      '<a href="' + CFG.fb + '" target="_blank" rel="noopener" aria-label="Facebook">' + ICON.fb + '</a>' +
      '<a href="' + CFG.zalo + '" target="_blank" rel="noopener" aria-label="Zalo"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3C6.800 3 3 6.500 3 10.800c0 2.300 1.100 4.400 2.800 5.800-.1 1.100-.5 2.100-1 3 1.500-.1 2.800-.7 3.900-1.500 1 .3 2.100.5 3.300.5 5.200 0 9-3.500 9-7.800S17.200 3 12 3zm-3 5h3.500l-3.200 4.200H12v1.300H7.300l3.200-4.200H9zm5.500 1.800h1.300v3.700h-1.300z"/></svg></a>' +
      '<a href="' + CFG.tiktok + '" target="_blank" rel="noopener" aria-label="TikTok">' + ICON.tiktok + '</a>' +
      '<a href="' + CFG.youtube + '" target="_blank" rel="noopener" aria-label="YouTube">' + ICON.youtube + '</a></div></div>' +
      '<div><h3 data-k="explore">' + t.explore + '</h3><ul class="gsc-sh-footer__links">' + links + '</ul></div>' +
      '<div><h3 data-k="contact">' + t.contact + '</h3><div class="gsc-sh-contact">' +
      '<a href="' + CFG.tel + '">' + ICON.phone + '<div><span data-k="hot">' + t.hot + '</span><b>' + CFG.phone + '</b></div></a>' +
      '<a href="mailto:' + CFG.email + '">' + ICON.mail + '<div><span data-k="mail">' + t.mail + '</span><b>' + CFG.email + '</b></div></a>' +
      '<a href="https://www.google.com/maps/search/?api=1&query=' + encodeURIComponent(CFG.address) + '" target="_blank" rel="noopener">' + ICON.pin + '<div><span data-k="office">' + t.office + '</span><small>' + CFG.address + '</small></div></a>' +
      '</div></div></div>' +
      '<div class="gsc-sh-footer__bar"><span>© GSC Senior Living &amp; Wellness · <span data-k="note">' + t.note + '</span></span><a href="#" data-top data-k="top">' + t.top + '</a></div>' +
      '</footer>');
  }

  function buildFab() {
    var t = L();
    return el('<div class="gsc-sh-fab" aria-label="Liên hệ nhanh">' +
      '<a class="fb" href="' + CFG.fb + '" target="_blank" rel="noopener" aria-label="Facebook">' + ICON.fb + '<em data-k="fbl">' + t.fbl + '</em></a>' +
      '<a class="zl" href="' + CFG.zalo + '" target="_blank" rel="noopener" aria-label="Zalo">' + ICON.zalo + '<em data-k="zl">' + t.zl + '</em></a></div>');
  }

  function buildHomeCard() {
    return el('<aside class="gsc-sh-homecard" aria-label="Liên hệ GSC"><h3 data-k="contact">' + L().contact + ' GSC</h3>' +
      '<a href="' + CFG.tel + '">' + CFG.phone + '</a><a href="mailto:' + CFG.email + '">' + CFG.email + '</a><small>' + CFG.address + '</small></aside>');
  }

  /* ---------- theme ---------- */
  function curTheme() {
    return root.getAttribute('data-theme') || root.getAttribute('data-gsc-theme') ||
      (function () { try { return w.localStorage.getItem('gsc-theme'); } catch (e) { return null; } })() ||
      (w.matchMedia && w.matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark');
  }
  function setTheme(v) {
    root.setAttribute('data-theme', v); root.setAttribute('data-gsc-theme', v);
    try { w.localStorage.setItem('gsc-theme', v); } catch (e) {}
    paintTheme();
  }
  function paintTheme() {
    var b = d.querySelector('.gsc-sh__theme span'); if (!b) return;
    var light = curTheme() === 'light';
    b.textContent = light ? '☀' : '☾';
    var btn = b.parentNode; btn.setAttribute('aria-pressed', String(light));
  }

  /* ---------- ngôn ngữ ---------- */
  function applyLang(l, fromUser) {
    lang = l === 'en' ? 'en' : 'vi';
    root.setAttribute('data-sh-lang', lang);
    d.querySelectorAll('.gsc-sh [data-vi],.gsc-sh-footer [data-vi]').forEach(function (a) { a.textContent = a.getAttribute('data-' + lang); });
    d.querySelectorAll('[data-k]').forEach(function (n) { var k = n.getAttribute('data-k'); if (T[lang][k] != null && n.closest('.gsc-sh-footer,.gsc-sh-homecard,.gsc-sh-fab')) n.textContent = (k === 'contact' && n.closest('.gsc-sh-homecard')) ? T[lang][k] + ' GSC' : T[lang][k]; });
    d.querySelectorAll('.gsc-sh__lang button').forEach(function (b) { b.classList.toggle('is-on', b.getAttribute('data-l') === lang); b.setAttribute('aria-pressed', String(b.getAttribute('data-l') === lang)); });
    var burger = d.querySelector('.gsc-sh__burger'); if (burger) burger.setAttribute('aria-label', T[lang].menu);
    if (fromUser) {
      try { w.localStorage.setItem('gsc-lang', lang); } catch (e) {}
      var legacy = d.querySelector('.gsc-lang__btn[data-lang="' + lang + '"]'); /* trang giới thiệu: dịch cả nội dung */
      if (legacy) legacy.click(); else root.lang = lang;
    }
  }

  function init() {
    if (root.classList.contains('gsc-sh-ready')) return;
    root.classList.add('gsc-sh-ready');
    var body = d.body;

    if (!isHome) {
      root.classList.add('gsc-sh-on');
      var header = buildHeader(), footer = buildFooter();
      body.insertBefore(header, body.firstChild);
      /* footer: đặt ở cuối thân trang, trước các <script> cuối */
      body.appendChild(footer);

      var burger = header.querySelector('.gsc-sh__burger');
      burger.addEventListener('click', function () {
        var o = !header.classList.contains('is-open'); header.classList.toggle('is-open', o); burger.setAttribute('aria-expanded', String(o));
      });
      header.querySelector('.gsc-sh__nav').addEventListener('click', function (e) { if (e.target.closest('a')) { header.classList.remove('is-open'); burger.setAttribute('aria-expanded', 'false'); } });
      d.addEventListener('keydown', function (e) { if (e.key === 'Escape') { header.classList.remove('is-open'); burger.setAttribute('aria-expanded', 'false'); } });
      d.addEventListener('click', function (e) { if (header.classList.contains('is-open') && !e.target.closest('.gsc-sh')) header.classList.remove('is-open'); });
      header.querySelector('.gsc-sh__theme').addEventListener('click', function () { setTheme(curTheme() === 'light' ? 'dark' : 'light'); });
      header.querySelectorAll('.gsc-sh__lang button').forEach(function (b) { b.addEventListener('click', function () { applyLang(b.getAttribute('data-l'), true); }); });
      footer.querySelector('[data-top]').addEventListener('click', function (e) { e.preventDefault(); w.scrollTo({ top: 0, behavior: 'smooth' }); });
      new MutationObserver(paintTheme).observe(root, { attributes: true, attributeFilter: ['data-theme', 'data-gsc-theme'] });
      paintTheme();
      applyLang(lang, false);

      /* nút "Liên hệ" cũ trên trang giới thiệu cuộn xuống footer mới */
      d.addEventListener('click', function (e) {
        var a = e.target.closest && e.target.closest('a[href="#gsc-intro-footer"]');
        if (a) { e.preventDefault(); e.stopImmediatePropagation(); footer.scrollIntoView({ behavior: 'smooth' }); }
      }, true);
    } else {
      body.appendChild(buildHomeCard());
    }
    body.appendChild(buildFab());
  }

  /* script nằm cuối <body> nên DOM phía trên đã sẵn sàng: chạy ngay để không nháy header cũ */
  if (d.body) init(); else d.addEventListener('DOMContentLoaded', init);
})(window, document);
