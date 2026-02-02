# tools/require_core_files.ps1
$ErrorActionPreference = "Stop"

$required = @(
  "AGENTS.md",
  "RUNBOOK.md",
  "publish_release.ps1",
  "bootstrap.ps1",
  "test.ps1",
  "mission_control.ps1",
  ".gitignore",
  "archive\README.md"
)

$missing = @()
foreach ($p in $required) {
  if (-not (Test-Path (Join-Path (Get-Location) $p))) { $missing += $p }
}

if ($missing.Count -gt 0) { throw ("MISSING CORE FILE(S): " + ($missing -join ", ")) }

Write-Host "OK: required canonical files present."
