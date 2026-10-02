$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
& (Join-Path $PSScriptRoot 'qa-ai-media-intake.ps1')
if($LASTEXITCODE -ne 0){exit $LASTEXITCODE}
$manifestPath=Join-Path $root 'config/gsc-ai-media-manifest.json'
$configPath=Join-Path $root 'config/gsc-intro-assets.json'
$m=Get-Content $manifestPath -Raw|ConvertFrom-Json
$c=Get-Content $configPath -Raw|ConvertFrom-Json
$backup="$configPath.bak"
Copy-Item $configPath $backup -Force
foreach($p in $m.slots.PSObject.Properties){
  if(!($c.assets.PSObject.Properties.Name -contains $p.Name)){Write-Host "AUTO_MAP FAIL unknown slot $($p.Name)";Copy-Item $backup $configPath -Force;exit 65}
  $c.assets.($p.Name)=[string]$p.Value
  Write-Host "AUTO_MAP $($p.Name) -> $($p.Value)"
}
$c|ConvertTo-Json -Depth 20|Set-Content $configPath -Encoding UTF8
Write-Host "AUTO_MAP PASS backup=$backup"
