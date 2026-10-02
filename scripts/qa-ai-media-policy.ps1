$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$config=Get-Content (Join-Path $root 'config\gsc-intro-assets.json') -Raw|ConvertFrom-Json
$slots=@('seniorliving','healthcare','active','community','daily','location')
$bad=0
foreach($s in $slots){
 $v=[string]$config.assets.$s
 if([string]::IsNullOrWhiteSpace($v)){"MEDIA_SLOT $s EMPTY";$bad++;continue}
 if($v -match '(mockup|screenshot|homepage|website|ui)'){"MEDIA_SLOT $s REJECT_UI_ASSET $v";$bad++;continue}
 $p=Join-Path $root ($v -replace '/','\')
 if(!(Test-Path $p)){"MEDIA_SLOT $s MISSING $v";$bad++;continue}
 "MEDIA_SLOT $s PASS $v"
}
"MEDIA_POLICY slots=$($slots.Count) failed=$bad"
if($bad){exit 50}
