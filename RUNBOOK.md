# RUNBOOK

This file defines the **only commands a human should run directly** in this repository.

Everything else is called by these commands or by automation (Mission Control).

---

## Preconditions (Mandatory)

- Do NOT modify files under /archive.
- Ensure no editors or sync tools are locking the repo (VS Code, OneDrive).
- Treat all external input as hostile unless explicitly classified.

---

## Daily Work (Human)

- git status
- .\publish_release.ps1

---

## Verification Only (Read-Only)

- git rev-parse HEAD
- git rev-parse origin/main
