# mission_control.ps1 — canonical Mission Control entrypoint (v1)
# Deterministic, non-interactive. No network. No prompts.
# Binder-proof: no param metadata; we parse $args manually.

$ErrorActionPreference = "Stop"

function Ensure-Dir([string]$path) {
  $dir = Split-Path -Parent $path
  if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
}

if (-not (Test-Path ".\.git")) { throw "Not at repo root (missing .git)." }

if ($args.Count -lt 1) {
  throw "Usage: .\mission_control.ps1 <bootstrap|test|publish|status> [statusOutPath]"
}

$cmd = [string]$args[0]
$statusOut = if ($args.Count -ge 2) { [string]$args[1] } else { "exports/status.json" }

switch ($cmd) {
  "bootstrap" {
    if (-not (Test-Path ".\bootstrap.ps1")) { throw "Missing bootstrap.ps1" }
    & .\bootstrap.ps1
    exit 0
  }
  "test" {
    if (-not (Test-Path ".\test.ps1")) { throw "Missing test.ps1" }
    & .\test.ps1
    exit 0
  }
  "publish" {
    if (-not (Test-Path ".\publish_release.ps1")) { throw "Missing publish_release.ps1" }
    & .\publish_release.ps1
    exit 0
  }
  "status" {
    Ensure-Dir $statusOut

    $head = (& git rev-parse HEAD).Trim()
    $branch = (& git branch --show-current).Trim()

    $originMain = ""
    try { $originMain = (& git rev-parse origin/main).Trim() } catch { $originMain = "" }

    $dirty = $false
    $porcelain = (& git status --porcelain)
    if ($porcelain -and $porcelain.Length -gt 0) { $dirty = $true }

    $repoName = Split-Path -Leaf (Get-Location)

    $obj = [ordered]@{
      repo = $repoName
      branch = $branch
      head = $head
      origin_main = $originMain
      clean = (-not $dirty)
      timestamp_utc = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    }

    Set-Content -Encoding UTF8 -Path $statusOut -Value ($obj | ConvertTo-Json -Depth 10)
    Write-Host "OK: wrote $statusOut"
    exit 0
  }
  default { throw "Unknown command: $cmd. Use: bootstrap | test | publish | status" }
}
