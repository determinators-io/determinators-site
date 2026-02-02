# Repository Structure Update — 2026-02

This document records a structural normalization across all repositories.

## What changed
- Canonical control surface standardized:
  - mission_control.ps1
  - bootstrap.ps1
  - test.ps1
  - publish_release.ps1 (repo-specific semantics)
- tools/require_core_files.ps1 is authoritative
- /archive is non-authoritative and guarded
- determinators-site uses a site-specific publish gate
- Repos are intentionally NOT merged

## What did NOT change
- Lane firewalls remain intact
- No core math, proofs, or invariants were modified
- No release advancement occurred

## Authority
This file is informational only.
Authoritative behavior is enforced by:
- AGENTS.md
- RUNBOOK.md
- mission_control.ps1
