$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$files=Get-ChildItem $root -Recurse -File -Include *.html,*.js,*.json | Where-Object {$_.FullName -notmatch '\\.git\\|\\.qa\\'}
$text=($files|ForEach-Object {[IO.File]::ReadAllText($_.FullName)}) -join "`n"
$required=@('093 268 0592','Kathy.nguyen171@gmail.com','facebook.com/profile.php?id=100083708970226','tiktok.com/@amo_3651','youtube.com/@AMO-NGUYEN','zaloapp.com/qr/p/1s3r599zmwd4m')
$missing=@($required|Where-Object {$text -notlike ('*'+$_+'*')})
$forbidden=@('0909 888 999','info@gscsenior.com')
$found=@($forbidden|Where-Object {$text -like ('*'+$_+'*')})
"CONTACT_QA requiredMissing=$($missing.Count) forbiddenFound=$($found.Count)"
$missing|ForEach-Object {"MISSING $_"}
$found|ForEach-Object {"FORBIDDEN $_"}
if($missing.Count -or $found.Count){exit 4}
