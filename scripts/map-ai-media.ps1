$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$intake=Join-Path $PSScriptRoot 'qa-ai-media-intake.ps1'
$manifestPath=Join-Path $root 'config/gsc-ai-media-manifest.json'
$configPath=Join-Path $root 'config/gsc-intro-assets.json'

& $intake
if($LASTEXITCODE -ne 0){exit $LASTEXITCODE}

$m=Get-Content $manifestPath -Raw|ConvertFrom-Json
$c=Get-Content $configPath -Raw|ConvertFrom-Json

try {
  foreach($p in $m.slots.PSObject.Properties){
    if(!($c.assets.PSObject.Properties.Name -contains $p.Name)){throw "unknown slot $($p.Name)"}
    $c.assets.($p.Name)=[string]$p.Value
    Write-Host "AUTO_MAP $($p.Name) -> $($p.Value)"
  }
  $json=$c|ConvertTo-Json -Depth 20
  [IO.File]::WriteAllText($configPath,$json,(New-Object Text.UTF8Encoding($false)))
  Write-Host "AUTO_MAP STAGED"
} catch {
  Write-Host "AUTO_MAP FAILED $($_.Exception.Message)"
  exit 65
}
