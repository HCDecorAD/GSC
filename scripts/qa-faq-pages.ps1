$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path;$pages=@('project.html','wellness.html','location.html','gallery.html');$bad=0
foreach($p in $pages){$t=[IO.File]::ReadAllText((Join-Path $root $p));$q=([regex]::Matches($t,'<summary>')).Count;$faq=$false;$blocks=[regex]::Matches($t,'<script type="application/ld\+json">([\s\S]*?)</script>');foreach($b in $blocks){try{$j=$b.Groups[1].Value|ConvertFrom-Json;if($j.'@type' -eq 'FAQPage'){$faq=$true;$schemaQ=@($j.mainEntity).Count}}catch{}};$ok=$faq -and $q -ge 2 -and $schemaQ -eq $q;"FAQ_QA $p visible=$q schema=$schemaQ $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}}
"FAQ_QA total=$($pages.Count) failed=$bad";if($bad){exit 58}
