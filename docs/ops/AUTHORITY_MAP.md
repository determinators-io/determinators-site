# AUTHORITY MAP (determinators-site)

## Authoritative (changes require announce)
- Deploy/build entrypoints:
  - package.json (scripts, dependencies)
  - lockfile (package-lock.json / pnpm-lock.yaml / yarn.lock — whichever exists)
  - hosting config (vercel.json / netlify.toml / wrangler.toml — whichever exists)
- Public exports/assets that external systems depend on (if any)
- Any environment contract docs used by deployment (if present)

## Derived (regenerated; no announce if behavior unchanged)
- Build output directories (e.g., .next/, dist/, build/)
- Generated artifacts

## Non-authoritative
- Draft copy not referenced by RUNBOOK
- Scratch notes

## Change Discipline
If it affects deploy/build behavior or entrypoints, it is authoritative and must be announced.
