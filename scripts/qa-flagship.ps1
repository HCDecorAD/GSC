$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$html=[IO.File]::ReadAllText((Join-Path $root 'gsc-introduction.html'))
$checks=@(
 @{n='faq';ok=$html.Contains('Câu hỏi thường gặp')},
 @{n='faq-schema';ok=$html.Contains('"@type":"FAQPage"')},
 @{n='digital-twin';ok=$html.Contains('Digital Twin')},
 @{n='ai-disclosure';ok=$html.Contains('AI Concept')},
 @{n='theme';ok=$html.Contains('data-gsc-theme-toggle')},
 @{n='project-status';ok=$html.Contains('Đang triển khai dự án')},
 @{n='healthcare-direction';ok=$html.Contains('Các tiện ích chăm sóc được định hướng trong khuôn viên dự án.')},
 @{n='healthcare-license-disclosure';ok=$html.Contains('không phải xác nhận cơ sở y tế đã được cấp phép hoặc đang vận hành')},
 @{n='ai-not-completed';ok=$html.Contains('không được trình bày như ảnh công trình đã hoàn thành')}
)
$bad=@($checks|?{-not $_.ok});"FLAGSHIP_QA failed=$($bad.Count)";$bad|%{"FLAGSHIP_FAIL "+$_.n};if($bad.Count){exit 48}
