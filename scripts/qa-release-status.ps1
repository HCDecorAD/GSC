$ErrorActionPreference='Stop'
$t=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'gsc-release-status.bat'))
$checks=@('SOURCE_FAIL','PUBLIC_RC','MEDIA_RC','SOURCE QA PASS','PUBLIC DEPLOYMENT NOT CONFIRMED','AI MEDIA PENDING')
$bad=0
foreach($x in $checks){$ok=$t.Contains($x);Write-Host "STATUS_SEMANTICS $x $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}}
Write-Host "STATUS_SEMANTICS failed=$bad";if($bad){exit 67}
