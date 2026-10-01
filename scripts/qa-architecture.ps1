$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$bad=@()
Get-ChildItem $root -Recurse -Force -File | Where-Object {$_.FullName -notmatch '\\.git\\|\\.qa\\|\\scripts\\qa-architecture\.ps1 | ForEach-Object {
  $rel=$_.FullName.Substring($root.Length+1)
  if($rel -match '(^|\\|/)vercel(\.json|\\|/|$)|\.vercel'){ $bad += $rel; return }
  if($_.Extension -in '.html','.js','.json','.yml','.yaml','.md','.txt','.bat','.ps1'){
    try{$t=[IO.File]::ReadAllText($_.FullName);if($t -match '(?i)vercel\.app|vercel\.com|@vercel/'){ $bad += $rel }}catch{}
  }
}
"ARCH_QA vercelRefs=$($bad.Count)"
$bad|Sort-Object -Unique|ForEach-Object{"VERCEL_REF $_"}
if($bad.Count){exit 42}
} | ForEach-Object {
  $rel=$_.FullName.Substring($root.Length+1)
  if($rel -match '(^|\\|/)vercel(\.json|\\|/|$)|\.vercel'){ $bad += $rel; return }
  if($_.Extension -in '.html','.js','.json','.yml','.yaml','.md','.txt','.bat','.ps1'){
    try{$t=[IO.File]::ReadAllText($_.FullName);if($t -match '(?i)vercel\.app|vercel\.com|@vercel/'){ $bad += $rel }}catch{}
  }
}
"ARCH_QA vercelRefs=$($bad.Count)"
$bad|Sort-Object -Unique|ForEach-Object{"VERCEL_REF $_"}
if($bad.Count){exit 42}
