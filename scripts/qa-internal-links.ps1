$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path;$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html');$bad=0
foreach($p in $pages){$t=[IO.File]::ReadAllText((Join-Path $root $p));$m=[regex]::Match($t,'<p class="seo-related">([\s\S]*?)</p>');$links=if($m.Success){([regex]::Matches($m.Value,'href="([^"]+)"')).Count}else{0};$ok=$links -ge 2;"INTERNAL_LINKS $p contextual=$links $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}}
"INTERNAL_LINK_QA total=$($pages.Count) failed=$bad";if($bad){exit 57}
