$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$m=Get-Content (Join-Path $root 'config/gsc-ai-media-manifest.json') -Raw|ConvertFrom-Json
$bad=0
Add-Type -AssemblyName System.Drawing
foreach($p in $m.slots.PSObject.Properties){
 $slot=$p.Name;$rel=[string]$p.Value;$full=Join-Path $root ($rel -replace '/','\')
 if(!(Test-Path $full)){Write-Host "MEDIA_INTAKE $slot MISSING $rel";$bad++;continue}
 $fi=Get-Item $full
 if($fi.Length -lt 50000){Write-Host "MEDIA_INTAKE $slot FAIL_TOO_SMALL bytes=$($fi.Length)";$bad++;continue}
 try{$img=[System.Drawing.Image]::FromFile($full);$w=$img.Width;$h=$img.Height;$img.Dispose();$ratio=$w/[double]$h;$ok=($w -ge 1200 -and $h -ge 700 -and $ratio -ge 1.3 -and $ratio -le 2.0);Write-Host "MEDIA_INTAKE $slot $($w)x$($h) ratio=$([math]::Round($ratio,2)) $(if($ok){'PASS'}else{'FAIL_DIMENSIONS'})";if(!$ok){$bad++}}catch{Write-Host "MEDIA_INTAKE $slot FAIL_IMAGE $($_.Exception.Message)";$bad++}
}
Write-Host "MEDIA_INTAKE failed=$bad"
if($bad){exit 64}
