$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$intake=Join-Path $PSScriptRoot 'qa-ai-media-intake.ps1'
$manifestPath=Join-Path $root 'config/gsc-ai-media-manifest.json'
$configPath=Join-Path $root 'config/gsc-intro-assets.json'
$backup=Join-Path $env:TEMP ("gsc-intro-assets-"+[guid]::NewGuid().ToString()+".json")

& $intake
if($LASTEXITCODE -ne 0){exit $LASTEXITCODE}

$m=Get-Content $manifestPath -Raw|ConvertFrom-Json
$c=Get-Content $configPath -Raw|ConvertFrom-Json
Copy-Item $configPath $backup -Force

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
  Copy-Item $backup $configPath -Force
  Remove-Item $backup -Force -ErrorAction SilentlyContinue
  Write-Host "AUTO_MAP ROLLBACK $($_.Exception.Message)"
  exit 65
}
Write-Host "AUTO_MAP STAGED_BACKUP $backup"
