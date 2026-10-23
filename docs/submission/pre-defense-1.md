# Pre-defense 1 — Submission Summary

| | |
|---|---|
| Project | Development of an Intelligent Social Learning Platform with Personalized Microlearning Pathways, Short-Form Video Generation, and Adaptive Knowledge Assessment (YeahGrind) |
| Team | Yernar Katyshev, Ayat Balmagambet (SE-2425) · Supervisor: Arstan Makatov |
| Date | 24 October 2026 |
| Repository | https://github.com/ayatyeah/yeahgrind (public; interview notes are shared with the supervisor and the committee on request) |
| Tag | `pre-defense-1` |
| YouTrack | Project YG: https://yeahgrind.youtrack.cloud/projects/YG — 56 tasks with owners, priorities, estimates, deadlines and dependency links; Scrum board with sprints PD1 and S1–S13: https://yeahgrind.youtrack.cloud/agiles/204-1. Source of the import: [`project-management/youtrack-backlog.csv`](../../project-management/youtrack-backlog.csv) |

## Completed work (checklist of the 24 October minimum requirements)

| Requirement | Where |
|---|---|
| Completed project README | [README.md](../../README.md) |
| Project proposal and scope | [01-project-proposal.md](../01-project-proposal.md) |
| Evidence of relevance (interviews, observation, available data) | [02-evidence-of-relevance.md](../02-evidence-of-relevance.md), [research/](../research/) |
| Literature review with analysis table | [03-literature-review.md](../03-literature-review.md) |
| Existing system comparison (5 systems × 10 criteria) | [04-existing-systems-comparison.md](../04-existing-systems-comparison.md) |
| Technology comparison (key decisions × 3 alternatives, weighted) | [05-technology-comparison.md](../05-technology-comparison.md), [adr/](../adr/) |
| Initial requirements and acceptance criteria (41 FR, 14 NFR) | [06-requirements-specification.md](../06-requirements-specification.md), [tests/acceptance/](../../tests/acceptance/) |
| Architectural diagrams with editable sources (context, use case, component + data model, 2 sequences, deployment) | [07-architecture.md](../07-architecture.md), [diagrams/](../../diagrams/) |
| Prototype materials | [prototype/index.html](../../prototype/index.html), [screens](../../prototype/screens/), [08-ux-prototype.md](../08-ux-prototype.md), [api/openapi.yaml](../../api/openapi.yaml) |
| Verification and evaluation plan | [09-verification-evaluation-plan.md](../09-verification-evaluation-plan.md) |
| YouTrack with assigned and prioritized tasks | [Project YG](https://yeahgrind.youtrack.cloud/projects/YG), [board](https://yeahgrind.youtrack.cloud/agiles/204-1), [10-project-management-risks.md](../10-project-management-risks.md), [backlog](../../project-management/youtrack-backlog.csv) |
| Supervisor review | [11-supervisor-feedback.md](../11-supervisor-feedback.md) |
| Progressive contributions of each member | Git history, pull requests and reviews (each member commits from their own account) |

## Design limitations (accepted for this release)

- Videos are template-based (slides, narration, captions). Photorealistic avatars and generative video models are excluded to keep cost, time and factual control manageable.
- Assessment uses an Elo-style rating per learner–skill and per item, which needs no prior calibration. Calibrated IRT and deep knowledge tracing are excluded at launch because they need large answer logs; the consented logs allow evaluating them later.
- Generated content is grounded in the student's material or unit text and passes validation. Items that fail go to human review; no automatic check removes all model errors, which is why reporting and moderation are part of the design.
- Kazakh narration is enabled only after a native-speaker quality check; the Kazakh interface does not depend on it.
- Moodle is used only through the student's own calendar export; course content and grades are not accessed.

## Outstanding for this stage

- YG-12: the supervisor's review of this package; comments go into the log in [11-supervisor-feedback.md](../11-supervisor-feedback.md) with a decision and a task each.

## Next tasks (sprint S1, 27 Oct – 9 Nov 2026)

YG-14 project skeleton, CI and staging · YG-15 data model and migrations · YG-16 e-mail authentication · YG-17 PWA shell and i18n · tasks created from the committee's and supervisor's comments.
