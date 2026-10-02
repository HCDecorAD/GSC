$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$checks=@(
 @{Page='project.html';Terms=@('giai đoạn phát triển dự án','không được suy diễn từ hình ảnh concept')},
 @{Page='residences.html';Terms=@('AI Concept Visualization','chưa công bố cơ cấu loại căn')},
 @{Page='wellness.html';Terms=@('không đồng nghĩa cơ sở y tế đã được cấp phép hoặc đang vận hành','không phải xác nhận về giấy phép y tế')},
 @{Page='lifestyle.html';Terms=@('không phải lịch hoạt động hay chương trình vận hành đã công bố')},
 @{Page='amenities.html';Terms=@('định hướng tiện ích của dự án','không được hiểu là xác nhận cơ sở y tế đã được cấp phép')},
 @{Page='location.html';Terms=@('khoảng cách tham khảo','không công bố thời gian di chuyển cố định')},
 @{Page='gallery.html';Terms=@('AI Concept Visualization','không phải ảnh công trình hoàn thành')},
 @{Page='insights.html';Terms=@('không thay thế tư vấn y khoa','định hướng phát triển')},
 @{Page='contact.html';Terms=@('Website không thay thế tài liệu công bố chính thức','tài liệu chính thức')}
)
$bad=0
foreach($c in $checks){
 $t=[IO.File]::ReadAllText((Join-Path $root $c.Page))
 $missing=@($c.Terms|Where-Object{$t -notlike "*$_*"})
 if($missing.Count){
  Write-Host "DISCLOSURE_QA $($c.Page) FAIL missing=$($missing -join ' | ')"
  $bad++
 } else { Write-Host "DISCLOSURE_QA $($c.Page) PASS" }
}
Write-Host "DISCLOSURE_QA total=$($checks.Count) failed=$bad"
if($bad){exit 72}
