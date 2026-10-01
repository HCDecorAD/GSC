$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$html=[IO.File]::ReadAllText((Join-Path $root 'gsc-introduction.html'))
$cfg=Get-Content (Join-Path $root 'config\gsc-intro-assets.json') -Raw|ConvertFrom-Json
$slots=@('seniorliving','healthcare','active','community','daily','location')
$labelMissing=@($slots|Where-Object{$html -notmatch ('data-gsc-asset="'+$_+'" data-gsc-label="Concept AI')})
$mapped=@($slots|Where-Object{[bool]$cfg.assets.$_})
$missingFiles=@()
foreach($k in $mapped){$rel=$cfg.assets.$k;if(!(Test-Path (Join-Path $root ($rel -replace '/','\\')))){$missingFiles+=$k}}
"AI_CONCEPT_QA slots=$($slots.Count) labelsMissing=$($labelMissing.Count) mapped=$($mapped.Count) missingFiles=$($missingFiles.Count)"
if($labelMissing.Count -or $mapped.Count -ne $slots.Count -or $missingFiles.Count){exit 41}
