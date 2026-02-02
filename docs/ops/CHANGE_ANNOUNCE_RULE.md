# CHANGE ANNOUNCE RULE (determinators-site)

## Announce Required (YES)
Announce if any of the following change:
1) package.json scripts, dependencies, or node engine constraints
2) lockfile changes that alter resolved dependency graph
3) hosting config (vercel.json / netlify.toml / etc.)
4) build output routing (basePath, redirects, rewrites, headers)
5) environment variable contract used by deploy/build
6) anything that changes how RUNBOOK's build works on a clean machine

## Announce Not Required (NO)
No announce needed for:
- copy edits / content-only changes that do not affect build/deploy
- styling/layout changes that keep build/deploy identical
- doc improvements

## Announcement format (single line)
STRUCTURE CHANGE: <what changed> | <why> | <how to run now> | <rollback>
