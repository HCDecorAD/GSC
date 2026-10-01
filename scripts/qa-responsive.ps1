$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$css=[IO.File]::ReadAllText((Join-Path $root 'css\gsc-introduction.css'))+[IO.File]::ReadAllText((Join-Path $root 'css\gsc-responsive.css'))
$checks=[ordered]@{bodyLock=($css -match '\.gsc-intro-lock\{[^}]*overflow:hidden');safeArea=($css -match 'safe-area-inset-bottom');mobileCTA=($css -match '\.gsc-mobile-cta');tap44=($css -match 'min-height:44px');reducedMotion=($css -match 'prefers-reduced-motion');noZoomCursor=($css -notmatch 'cursor:zoom-in');overflowGuard=($css -match 'overflow-x:hidden')}
$failed=@($checks.GetEnumerator()|Where-Object{-not $_.Value})
"RESPONSIVE_QA total=$($checks.Count) failed=$($failed.Count)"
$failed|ForEach-Object{"FAILED $($_.Key)"}
if($failed.Count){exit 8}
