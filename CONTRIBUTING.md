# Contributing

## Workflow

1. **Task first.** Every meaningful work item is a YouTrack task in project `YG` with an owner, expected outcome, acceptance criteria and deadline.
2. **Branch per task** from `main`: `YG-<id>-<short-name>`, e.g. `YG-22-recommendation-scoring`.
3. **Commits** are small and coherent, with the task ID first: `YG-22: Add hard-constraint filters and property tests`. Documentation and design changes are committed the same way.
4. **Pull request** using the template: what changed and why, the YouTrack task, and how the change was checked (tests, screenshots, updated diagrams).
5. **Review.** The other team member reviews every pull request before merge. The supervisor reviews selected significant changes at agreed checkpoints. `main` is the reviewed baseline: no direct pushes, no force-pushes.
6. **Close the loop.** Add the PR link to the YouTrack task. Mark the task done only when its acceptance criteria are met.
7. **Tags.** Each pre-defense submission is tagged on the reviewed commit: `pre-defense-1`, `pre-defense-2`, `final-pre-defense`. Tags are never moved or replaced.

## Accounts and authorship

- Each member commits from their own GitHub account with an identifiable name and e-mail (`git config user.name` / `user.email`).
- Shared accounts are not used.

## Secrets and personal data

- Never commit passwords, API keys, tokens, `.env` files, database dumps or personal data.
- Configuration examples use placeholders only: [`config/.env.example`](config/.env.example).
- Interview notes are pseudonymized (I-01 … I-03); audio recordings never go into Git.

## Document ownership (primary author → reviewer)

| Yernar Katyshev → Ayat | Ayat Balmagambet → Yernar | Joint |
|---|---|---|
| 01 proposal, 03 literature, 05 technology + ADRs, 06 requirements, 07 architecture + diagrams, 09 benchmarks, `api/` | 02 evidence + interviews, 04 existing systems, 08 UX + `prototype/`, 09 usability study | README, 10 plan and risks, 11 supervisor log |

## Definition of done

- Acceptance criteria of the task are met and checked.
- Tests added or updated; CI is green.
- Docs and diagrams updated when behavior or design changed.
- Reviewed and approved by the other team member.
