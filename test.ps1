# test.ps1 — canonical test entrypoint
# Rule: tests must be deterministic and non-interactive.

$ErrorActionPreference = "Stop"

Write-Host "TEST: starting"

# Default: run the gate runner as the test surface
.\publish_release.ps1

Write-Host "TEST: done"
