# AGENTS.md — QAM/LPN (Repo Root)

Hard rules:
- Network OFF. Web search OFF.
- No new invariants / roles / primitives.
- No cross-lane edits. Touch only files explicitly requested.
- No refactors. No silent changes. No behavior change unless explicitly GO-gated.
- Always run lane gates after changes; stop on failures.
- Outputs must be deterministic and replayable.
