$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$html=[IO.File]::ReadAllText((Join-Path $root 'gsc-introduction.html'))
$checks=@(
 @{n='faq';ok=$html.Contains('Câu hỏi thường gặp')},
 @{n='faq-schema';ok=$html.Contains('"@type":"FAQPage"')},
 @{n='digital-twin';ok=$html.Contains('Digital Twin')},
 @{n='ai-disclosure';ok=$html.Contains('AI Concept')},
 @{n='theme';ok=$html.Contains('data-gsc-theme-toggle')},
 @{n='project-status';ok=$html.Contains('Đang trong giai đoạn phát triển dự án') -and $html.Contains('Tiến độ thực tế cần xác nhận theo thông tin cập nhật')},
 @{n='healthcare-direction';ok=$html.Contains('Các tiện ích chăm sóc được định hướng trong khuôn viên dự án.')},
 @{n='healthcare-license-disclosure';ok=$html.Contains('không phải xác nhận cơ sở y tế đã được cấp phép hoặc đang vận hành')},
 @{n='ai-not-completed';ok=$html.Contains('không được trình bày như ảnh công trình đã hoàn thành')},
 @{n='location-reference';ok=$html.Contains('Các khoảng cách trên là thông tin tham khảo') -and $html.Contains('thời gian di chuyển thực tế phụ thuộc tuyến đường và điều kiện giao thông')},
 @{n='healthcare-direction-copy';ok=$html.Contains('Các tiện ích chăm sóc được định hướng trong khuôn viên dự án.')},
 @{n='healthcare-group-label';ok=$html.Contains('Chăm sóc <small>· định hướng</small>')},
 @{n='ai-a11y-concept-labels';ok=([regex]::Matches($html,'aria-label="Hình minh họa ý tưởng AI')).Count -eq 6}
)
$bad=@($checks|?{-not $_.ok});"FLAGSHIP_QA failed=$($bad.Count)";$bad|%{"FLAGSHIP_FAIL "+$_.n};if($bad.Count){exit 48}
