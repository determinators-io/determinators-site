$ErrorActionPreference = "Stop"

Write-Host "== publish_release.ps1 (determinators-site) =="

# 1) Required files (static-only)
$required = @(
  "index.html",
  "robots.txt",
  "sitemap.xml",
  "site.webmanifest",
  "logo.png",
  "og.png",
  "favicon-16.png",
  "favicon-32.png",
  "apple-touch-icon.png"
)

$missing = $required | Where-Object { -not (Test-Path (Join-Path $PSScriptRoot $_)) }
if ($missing.Count -gt 0) {
  throw "Missing required files: $($missing -join ', ')"
}
Write-Host "OK: required files present."

# 2) Locked sentence (encoding-proof arrow)
$arrow  = [char]0x2192
$locked = "Determinators is deterministic plan-normalization middleware for agent workflows: JSON in $arrow canonical plan or refusal out."

$indexPath = Join-Path $PSScriptRoot "index.html"
$index = Get-Content -Raw -Encoding UTF8 $indexPath

if ($index -notmatch [regex]::Escape($locked)) {
  throw "LOCK FAIL: index.html does not contain the exact locked sentence (including the → arrow)."
}
Write-Host "OK: locked sentence present."

# 3) Hard bans (no theory/roadmap/lane language)
$banned = @("QAM","vault","lanes","proof","roadmap","coming soon","subscription","911")
$hits = @()
foreach ($b in $banned) { if ($index -match [regex]::Escape($b)) { $hits += $b } }
if ($hits.Count -gt 0) { throw "LOCK FAIL: banned terms found in index.html: $($hits -join ', ')" }
Write-Host "OK: no banned terms in index.html."

# 4) No scripts / tracking
if ($index -match "<script\b") { throw "LOCK FAIL: <script> tag found (tracking/scripts not allowed)." }
Write-Host "OK: no scripts."

Write-Host "OK: publish gates passed."
