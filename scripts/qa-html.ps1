$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$p=Join-Path $root 'gsc-introduction.html'
$s=[IO.File]::ReadAllText($p)
$ids=[regex]::Matches($s,'id="([^"]+)"')|%{$_.Groups[1].Value}
$dups=$ids|Group-Object|? Count -gt 1|% Name
$anchors=[regex]::Matches($s,'href="#([^"]+)"')|%{$_.Groups[1].Value}|Sort-Object -Unique
$broken=$anchors|?{$_ -notin $ids}
$h1=([regex]::Matches($s,'<h1\b')).Count
$css=[IO.File]::ReadAllText((Join-Path $root 'css\gsc-introduction.css'))
$badFonts=([regex]::Matches(($s+"`n"+$css),'Cormorant|Playfair|Georgia|Times New Roman|UTM Times','IgnoreCase')).Count
"HTML_QA h1=$h1 duplicateIds=$($dups.Count) brokenAnchors=$($broken.Count) legacyFonts=$badFonts"
if($h1 -ne 1 -or $dups.Count -gt 0 -or $broken.Count -gt 0 -or $badFonts -gt 0){exit 2}
