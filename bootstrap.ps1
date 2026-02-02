# bootstrap.ps1 — canonical repo bootstrap
# Rule: no side effects beyond dependency setup and sanity checks.

$ErrorActionPreference = "Stop"

Write-Host "BOOTSTRAP: starting"

# Basic sanity
if (-not (Test-Path ".\.git")) { throw "Not at repo root (missing .git)." }
if (-not (Test-Path ".\publish_release.ps1")) { throw "Missing publish_release.ps1 at repo root." }
if (-not (Test-Path ".\AGENTS.md")) { throw "Missing AGENTS.md at repo root." }
if (-not (Test-Path ".\RUNBOOK.md")) { throw "Missing RUNBOOK.md at repo root." }

# Python (optional; only checked if present in PATH)
try {
  $py = (Get-Command python -ErrorAction Stop).Source
  Write-Host "Python:" $py
} catch {
  Write-Host "Python: not found (OK if this repo does not require it)."
}

# Node (optional)
try {
  $node = (Get-Command node -ErrorAction Stop).Source
  Write-Host "Node:" $node
} catch {
  Write-Host "Node: not found (OK if this repo does not require it)."
}

Write-Host "BOOTSTRAP: done"
