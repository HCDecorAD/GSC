$ErrorActionPreference='Stop'
$base='https://gscsenior.hcdecorhub.com'
$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html')
$bad=0
foreach($p in $pages){
  $url="$base/$p"
  try{
    $r=Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 20
    $html=[string]$r.Content
    $canonical="https://gscsenior.hcdecorhub.com/$p"
    $ok=($r.StatusCode -eq 200) -and $html.Contains($canonical) -and $html.Contains('"@type":"WebPage"') -and $html.Contains('class="seo-related"')
    Write-Host "PUBLIC_EVIDENCE $p http=$($r.StatusCode) canonical=$($html.Contains($canonical)) webpage=$($html.Contains('"@type":"WebPage"')) contextual=$($html.Contains('class="seo-related"')) $(if($ok){'PASS'}else{'FAIL'})"
    if(!$ok){$bad++}
  }catch{
    Write-Host "PUBLIC_EVIDENCE $p NETWORK_FAIL $($_.Exception.Message)"
    $bad++
  }
}
Write-Host "PUBLIC_EVIDENCE total=$($pages.Count) failed=$bad"
if($bad){exit 63}
