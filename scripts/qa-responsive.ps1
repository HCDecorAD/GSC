$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$f=[IO.File]::ReadAllText((Join-Path $root 'css\gsc-introduction.css'))
$h=[IO.File]::ReadAllText((Join-Path $root 'gsc-introduction.html'))
$checks=@(
 @{n='mobile820';ok=$f.Contains('@media (max-width:820px)')},
 @{n='mobile520';ok=$f.Contains('@media (max-width:520px)')},
 @{n='reduced-motion';ok=$f.Contains('prefers-reduced-motion')},
 @{n='theme';ok=$h.Contains('data-gsc-theme-toggle')},
 @{n='lang';ok=$h.Contains('data-lang="en"')}
)
$bad=@($checks|?{-not $_.ok});"RESPONSIVE_QA failed=$($bad.Count)";$bad|%{"RESPONSIVE_FAIL "+$_.n};if($bad.Count){exit 49}
