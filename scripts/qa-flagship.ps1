$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$html=[IO.File]::ReadAllText((Join-Path $root 'gsc-introduction.html'))
$checks=@(
 @{n='faq';ok=$html.Contains('Câu hỏi thường gặp')},
 @{n='faq-schema';ok=$html.Contains('"@type":"FAQPage"')},
 @{n='digital-twin';ok=$html.Contains('Digital Twin')},
 @{n='ai-disclosure';ok=$html.Contains('AI Concept')},
 @{n='theme';ok=$html.Contains('data-gsc-theme-toggle')}
)
$bad=@($checks|?{-not $_.ok});"FLAGSHIP_QA failed=$($bad.Count)";$bad|%{"FLAGSHIP_FAIL "+$_.n};if($bad.Count){exit 48}
