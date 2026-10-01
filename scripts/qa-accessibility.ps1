$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$html=[IO.File]::ReadAllText((Join-Path $root 'gsc-introduction.html'))
$js=[IO.File]::ReadAllText((Join-Path $root 'js\gsc-introduction.js'))
$checks=[ordered]@{
lang=($html -match '<html[^>]+lang="vi"')
skip=($html -match 'class="gsc-intro-skip"')
main=($html -match 'id="gsc-intro-main"')
navToggle=($html -match 'aria-controls="gsc-intro-menu"')
expanded=($html -match 'aria-expanded="false"')
langPressed=($html -match 'aria-pressed="true"')
reducedMotion=([IO.File]::ReadAllText((Join-Path $root 'css\gsc-responsive.css')) -match 'prefers-reduced-motion')
}
$failed=@($checks.GetEnumerator()|Where-Object {-not $_.Value})
"ACCESS_QA total=$($checks.Count) failed=$($failed.Count)"
$failed|ForEach-Object {"FAILED $($_.Key)"}
if($failed.Count){exit 5}
