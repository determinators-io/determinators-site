# publish_release.ps1 — determinators-site gate (canonical)
# Deterministic, non-interactive. No core-engine dependencies.

$ErrorActionPreference = "Stop"

& .\tools\require_core_files.ps1

Write-Host "== determinators-site publish_release.ps1 =="

$webRoot = "."

# Mandatory (must exist)
$required = @(
  (Join-Path $webRoot "index.html"),
  (Join-Path $webRoot "robots.txt")
)

# Optional (warn only)
$optional = @(
  (Join-Path $webRoot "sitemap.xml"),
  (Join-Path $webRoot "site.webmanifest")
)

$missing = @()
foreach ($p in $required) { if (-not (Test-Path $p)) { $missing += $p } }
if ($missing.Count -gt 0) { throw ("Missing required site files:`n" + ($missing -join "`n")) }

foreach ($p in $optional) { if (-not (Test-Path $p)) { Write-Warning "Optional missing: $p" } }

New-Item -ItemType Directory -Force .\docs\snapshots | Out-Null
git ls-files | Sort-Object | Set-Content -Encoding UTF8 .\docs\snapshots\REPO_TREE.md
Write-Host "Wrote docs/snapshots/REPO_TREE.md"

Write-Host "OK: site gates passed."
