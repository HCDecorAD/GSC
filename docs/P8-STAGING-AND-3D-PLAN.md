# GSC P8 staging / Digital Twin implementation

Production branch `main` is unchanged. P8 local artifact: GSC-V1-P8-Nine-Pages.zip (9 HTML pages, WebP imagery, VI/EN content).

## Integration checks
1. Import the complete P8 archive, preserving relative assets and navigation.
2. Verify custom domain routing and GitHub Pages publishing settings.
3. Check all nine routes: /, /overview, /location, /architecture, /explore, /amenities, /wellness, /gallery, /contact.
4. Verify contact: 093.268.0592, Kathy.nguyen171@gmail.com; Vinhomes Grand Park, Nguyễn Xiển, Phường Long Thạnh Mỹ, Thủ Đức, TP.HCM.
5. Confirm mobile, keyboard navigation, SEO and asset HTTP 200 before promoting.

## Digital Twin 3D architecture
- Use Three.js + GLTFLoader for approved GLB/glTF model; host compressed assets under assets/3d/.
- Share one viewer component between homepage and /explore; use hotspot metadata with stable IDs and route mappings.
- Serialize selected hotspot, camera pose, floor, tower and zoom into sessionStorage; restore on return.
- Prefer progressive LOD and lazy load; show static image and hotspot links for reduced-motion, low-end mobile and WebGL-unavailable clients.
- Never infer true floor plans or tower details from illustrative marketing renders.
- Test desktop/mobile performance and WebGL context-loss recovery.

STATUS: staging preparation only. Neither P8 site files nor 3D models are deployed by this note.
