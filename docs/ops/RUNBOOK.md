# RUNBOOK (determinators-site)

## Daily health check
powershell:
  Stop="Stop"
  git status
  node -v
  npm -v
  npm ci
  npm run build

PASS means:
- clean repo state (or intentional diffs)
- dependencies install deterministically (npm ci)
- build succeeds (npm run build)

## Deploy
Deploy is whatever the host runs after a successful build.
Do not add alternate deploy paths outside this RUNBOOK unless explicitly recorded here.
