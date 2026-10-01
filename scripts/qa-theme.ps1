$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$html=[IO.File]::ReadAllText((Join-Path $root 'gsc-introduction.html'))
$css=[IO.File]::ReadAllText((Join-Path $root 'css\gsc-introduction.css'))
$js=[IO.File]::ReadAllText((Join-Path $root 'js\gsc-introduction.js'))
$checks=@(
 @{n='toggle';ok=$html.Contains('data-gsc-theme-toggle')},
 @{n='pressed';ok=$html.Contains('aria-pressed="false"')},
 @{n='light-css';ok=$css.Contains('data-gsc-theme="light"')},
 @{n='storage';ok=$js.Contains("localStorage.getItem(key)")},
 @{n='system';ok=$js.Contains('prefers-color-scheme: light')},
 @{n='init';ok=$js.Contains('initTheme();')}
)
$bad=@($checks|?{-not $_.ok});"THEME_QA total=$($checks.Count) failed=$($bad.Count)";$bad|%{"THEME_FAIL "+$_.n};if($bad.Count){exit 43}
