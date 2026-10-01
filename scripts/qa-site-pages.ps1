$ErrorActionPreference='Stop'
$base='https://gscsenior.hcdecorhub.com'
$paths=@('/','/gsc-introduction.html','/project.html','/residences.html','/wellness.html','/lifestyle.html','/amenities.html','/location.html','/gallery.html','/insights.html','/contact.html','/sitemap.xml')
$bad=0
foreach($p in $paths){try{$r=Invoke-WebRequest -UseBasicParsing -Uri ($base+$p) -TimeoutSec 20;$ok=$r.StatusCode -eq 200 -and $r.RawContentLength -gt 20;"GSC_SITE "+$r.StatusCode+" bytes="+$r.RawContentLength+" "+$p;if(!$ok){$bad++}}catch{"GSC_SITE FAIL "+$p+" "+$_.Exception.Message;$bad++}}
"GSC_SITE_SMOKE total=$($paths.Count) failed=$bad"
if($bad){exit 45}
