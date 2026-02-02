param(
  [switch]$LaneEExtras
)

$ErrorActionPreference = "Stop"
Write-Host "== publish_release.ps1 (determinators-site) =="

# 0) Sanity: repo + index
$root = $PSScriptRoot
$indexPath = Join-Path $root "index.html"
if (-not (Test-Path $indexPath)) { throw "Missing index.html at repo root." }

# 1) Required files
$required = @(
  "index.html",
  "logo.png",
  "og.png",
  "robots.txt",
  "sitemap.xml",
  "site.webmanifest"
)

$missing = @()
foreach ($r in $required) {
  if (-not (Test-Path (Join-Path $root $r))) { $missing += $r }
}
if ($missing.Count -gt 0) { throw "Missing required files: $($missing -join ', ')" }
Write-Host "OK: required files present."

# 2) Read index (UTF-8)
$index = Get-Content -Raw -Encoding UTF8 $indexPath

# 3) Locked sentence (encoding-proof arrow)
$arrow  = [char]0x2192  # →
$locked = "Determinators is deterministic plan-normalization middleware for agent workflows: JSON in $arrow canonical plan or refusal out."
if ($index -notmatch [regex]::Escape($locked)) {
  throw "LOCK FAIL: index.html does not contain the exact locked sentence (including the → arrow)."
}
Write-Host "OK: locked sentence present."

# 4) Hard bans
$banned = @("QAM","vault","lanes","proof","roadmap","coming soon","subscription","911")
$hits = @()
foreach ($b in $banned) { if ($index -match [regex]::Escape($b)) { $hits += $b } }
if ($hits.Count -gt 0) { throw "LOCK FAIL: banned terms found in index.html: $($hits -join ', ')" }
Write-Host "OK: no banned terms in index.html."

# 5) No scripts
if ($index -match "<script\b") { throw "LOCK FAIL: <script> tag found (tracking/scripts not allowed)." }
Write-Host "OK: no scripts."

# 6) LaneEExtras (your extra gates)
if ($LaneEExtras) {
  # Require Example C
  if ($index -notmatch "Example C") { throw "LANE-E EXTRAS FAIL: Example C missing." }

  # Require exactly one A/B/C
  $countA = ([regex]::Matches($index, "Example A")).Count
  $countB = ([regex]::Matches($index, "Example B")).Count
  $countC = ([regex]::Matches($index, "Example C")).Count
  if ($countA -ne 1 -or $countB -ne 1 -or $countC -ne 1) {
    throw "LANE-E EXTRAS FAIL: example counts must be exactly 1 each. Found A=$countA, B=$countB, C=$countC"
  }

  # Pricing removed (literal tokens; no false positives)
  $pricingTokens = @(
    '$99', '$199', '$499',
    'lemonsqueezy', 'checkout', 'Buy lifetime',
    'Get lifetime access', 'Lifetime pricing'
  )

  $phits = @()
  foreach ($p in $pricingTokens) {
    if ($p -and ($index -match [regex]::Escape($p))) { $phits += $p }
  }
  if ($phits.Count -gt 0) {
    throw "LANE-E EXTRAS FAIL: pricing tokens present: $($phits -join ', ')"
  }

  Write-Host "OK: LaneEExtras checks passed."
}

Write-Host "OK: publish gates passed."

# 7) Git hashes (best-effort)
if (Get-Command git -ErrorAction SilentlyContinue) {
  try { git fetch -q origin | Out-Null } catch { Write-Host "(warn) git fetch failed; continuing" }
  try { Write-Host ("HEAD: " + ((git rev-parse HEAD).Trim())) } catch { Write-Host "(warn) rev-parse HEAD failed" }
  try { Write-Host ("origin/main: " + ((git rev-parse origin/main).Trim())) } catch { Write-Host "(warn) rev-parse origin/main failed" }
}
