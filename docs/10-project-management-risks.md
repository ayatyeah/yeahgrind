# 10. Project Management and Risks

## 10.1 Tools and traceability

| Tool | Use | Link |
|---|---|---|
| Git repository (GitHub) | Code, documentation, diagrams, tests; `main` is the reviewed baseline | https://github.com/ayatyeah/yeahgrind |
| YouTrack project **YG** | Every work item with owner, expected outcome, acceptance criteria and deadline; agile board with 2-week sprints | Backlog for import: [`youtrack-backlog.csv`](../project-management/youtrack-backlog.csv) |
| GitHub Actions | Lint, type check, tests and build on every pull request | `.github/workflows/` (task YG-14) |
| Backlog import file | Initial backlog of 56 tasks in YouTrack CSV import format | [`project-management/youtrack-backlog.csv`](../project-management/youtrack-backlog.csv) |

**Workflow** (details in [CONTRIBUTING.md](../CONTRIBUTING.md)):

1. Create a task in YouTrack, e.g. `YG-29 Assessment engine: Elo ability and difficulty, item selection, stopping rule`.
2. Work on a branch named after the task: `YG-29-assessment-engine`.
3. Commit with the task ID first, e.g. `YG-29: Add Elo item selection with property tests`.
4. Open a pull request that references the task and explains how the change was checked. The other team member reviews it before merge. The supervisor reviews selected significant changes at checkpoints.
5. Add the PR link to the task, and close the task only when its acceptance criteria are met.
6. Tag pre-defense submissions (`pre-defense-1`, `pre-defense-2`, `final-pre-defense`). Tags are never moved.

## 10.2 Responsibilities

| Area | Yernar Katyshev | Ayat Balmagambet |
|---|---|---|
| Proposal, requirements, literature, technology, architecture (01, 03, 05–07) | **R** | C |
| Evidence and interviews, existing systems, UX and prototype (02, 04, 08) | C | **R** |
| Verification plan (09) | **R** benchmarks B1, B2 | **R** plan text, B3–B5, learning and usability study |
| Project management, supervisor log (10, 11), README | shared | shared |
| Backend: data model, API, auth, AI gateway, job runner, content generation, pathway engine, assessment engine, video pipeline, LMS importer, rewards ledger | **R** | review |
| Frontend: PWA, goal/path, micro-plan, video player, quiz and mastery, feed, groups, moderation queue, privacy, progress, push UI, i18n, accessibility | review | **R** |
| CI/CD, deployment, monitoring | **R** | C |

R = responsible, C = consulted. Every pull request is reviewed by the other member. Estimated effort in the backlog: Yernar ≈ 350 h, Ayat ≈ 290 h of tasks, plus Ayat's share of the thesis text.

## 10.3 Milestones

| Milestone | Date | Deliverable | Exit criterion |
|---|---|---|---|
| **M1 Pre-defense 1** | 24 Oct 2026 | Analysis and design package, tag `pre-defense-1` | 24 October checklist complete in the repository; supervisor review recorded |
| M2 Platform foundation | 23 Nov 2026 | CI, data model, auth, PWA shell, AI gateway, job runner, day plan | E2E sign-in → plan item on staging; a background job completes and survives a restart |
| M3 Content and pathway | 21 Dec 2026 | Goals and material, skill map, micro-units, pathway engine, micro-plan, LMS deadlines | Goal → path → today's micro-plan on staging; B1 runs in CI |
| M4 Adaptive assessment and video scripts | 8 Feb 2027 | Question bank, Elo assessment engine, quiz and mastery UI, placement test, grading, validated video scripts | Adaptive quiz updates mastery and pathway; seeded-error test for scripts runs |
| **M5 Pre-defense 2** | February 2027 (department schedule) | Scenarios S1–S4 end to end on staging, intermediate test report | All *Must* requirements of E1–E3 implemented; first generated videos |
| M6 Video, social and engagement | 22 Mar 2027 | Video rendering and player, friends, feed, groups, moderation, rewards, privacy | All *Must* and *Should* requirements implemented |
| M7 Evaluation | 19 Apr 2027 | Benchmarks B1–B6, learning and usability study, accessibility and security review | Evaluation data for all thresholds collected |
| **M8 Final pre-defense** | May 2027 (department schedule) | Final release, evaluation report, thesis | Tag `final-pre-defense` |
| Defense | June 2027 | Thesis defense | — |

**Sprints** (2 weeks each):

| Sprint | Dates |
|---|---|
| S1 | 27 Oct – 9 Nov |
| S2 | 10 – 23 Nov |
| S3 | 24 Nov – 7 Dec |
| S4 | 8 – 21 Dec |
| *Exam buffer* | 22 Dec – 11 Jan |
| S5 | 12 – 25 Jan |
| S6 | 26 Jan – 8 Feb |
| S7 | 9 – 22 Feb |
| S8 | 23 Feb – 8 Mar |
| S9 | 9 – 22 Mar |
| S10 | 23 Mar – 5 Apr |
| S11 | 6 – 19 Apr |
| S12 | 20 Apr – 3 May |
| S13 | 4 – 17 May |

## 10.4 Backlog overview

| Epic | Tasks | Requirements |
|---|---|---|
| E0 Analysis and design (pre-defense 1) | YG-1 – YG-13 | all |
| E1 Platform foundation | YG-14 – YG-19 | FR-01, FR-02, FR-16, FR-40, NFR-05, NFR-12 |
| E2 Content and pathway | YG-20 – YG-27 | FR-05 – FR-17, NFR-06, NFR-11, NFR-13 |
| E3 Adaptive assessment | YG-28 – YG-32 | FR-10, FR-25 – FR-30 |
| E4 Short-form video generation | YG-33 – YG-36 | FR-19 – FR-24, NFR-03 |
| E5 Social learning, engagement, privacy | YG-37 – YG-45 | FR-03, FR-04, FR-31 – FR-39 |
| E6 Evaluation and thesis | YG-46 – YG-56 | EQ1 – EQ8, NFR-01 – NFR-14 |

## 10.5 Dependencies

| Dependency | Needed for | Owner | Needed by | Fallback |
|---|---|---|---|---|
| LLM API key with a monthly budget cap | Content generation, scripts, grading | Yernar | S2 | Second provider through the adapter |
| TTS provider with Russian (and Kazakh) voices | Video narration | Yernar | S7 | Alternative TTS adapter; KK narration stays off until quality is confirmed |
| S3-compatible object storage (target, ADR-0010) | Narration audio once media exceed about 5 GB | Yernar | After M6 | Narration stays in PostgreSQL `bytea` |
| Microsoft Entra ID app registration in the university tenant | FR-02 | Yernar (with university IT) | S2 | E-mail sign-in stays available |
| Moodle iCalendar export available to students | FR-17 | Yernar | S4 | Manual `.ics` upload; subjects typed in |
| Public assessment dataset with a license that allows research use | B2 | Yernar | S10 | Another open dataset; simulation-only evaluation |
| Raters for B3/B4 and a second human grader for B5 | Benchmarks | Ayat | S10 | Students from other groups; supervisor or teaching assistant |
| Participants: 3–5 interviews, 12 for the study | 02, §9.5 | Ayat | 23 Oct 2026; April 2027 | Recruit across programs; online sessions |
| Internal: AI gateway and job runner (YG-20, YG-21) before content (YG-23), questions (YG-28) and video (YG-33) | E2–E4 | Yernar | S2 | — |
| Internal: question bank (YG-28) before the assessment engine (YG-29) | E3 | Yernar | S5 | — |

## 10.6 Risk register

Probability (P) and impact (I): 1 = low, 3 = high. Score = P × I.

| ID | Risk | P | I | Score | Mitigation | Trigger / owner |
|---|---|---|---|---|---|---|
| R1 | Scope (pathway + video + assessment + social) too large for two people | 3 | 3 | 9 | MoSCoW priorities; *Could* items only after M6; video limited to template slides; scope review every sprint | Velocity < plan for 2 sprints / both |
| R2 | Generated content contains factual errors | 3 | 3 | 9 | Grounding to source spans, self-consistency check, draft status for questions, moderation queue, report button, B3/B4 benchmarks | Seeded-error recall < 80 % / Yernar |
| R3 | Video generation too slow or too expensive | 2 | 3 | 6 | Asynchronous jobs, reuse per unit and language, per-user limits, short scripts, cost metering | p90 > 5 min or cost > USD 0.05 / Yernar |
| R4 | Kazakh narration quality is insufficient | 2 | 2 | 4 | Native-speaker check before enabling; KK interface independent of KK narration; alternative voice provider | Check fails / Ayat |
| R5 | Adaptive assessment poorly calibrated at cold start | 2 | 2 | 4 | Elo with uncertainty-based step size; LLM difficulty priors; offline evaluation B2; placement test | B2 below baseline / Yernar |
| R6 | AI grading inaccurate or manipulable | 2 | 3 | 6 | Hidden rubrics, injection test set, κ threshold, report and review | κ < 0.70 / Yernar |
| R7 | Copyright or privacy problems with uploaded material | 2 | 2 | 4 | Material private to the owner by default; sharing only of generated units; terms of use; deletion with the account | Report received / Ayat |
| R8 | Social features enable harassment or spam | 1 | 2 | 2 | Friends-only default, blocking, reports, moderation queue, comment limits | Report volume / Ayat |
| R9 | Duplicate rewards or inconsistent mastery under concurrency | 2 | 3 | 6 | Idempotency keys, unique constraints, transactions, concurrency tests | Any test failure / Yernar |
| R10 | LLM/TTS provider outage or API change | 2 | 2 | 4 | Provider adapters, fallback providers, feature-level degradation | Error rate > 5 % / Yernar |
| R11 | Not enough participants for interviews or the study | 2 | 2 | 4 | Early recruitment across programs; short sessions; flexible time | < 3 interviews by 23 Oct / Ayat |
| R12 | Uneven contribution visibility in Git history | 2 | 2 | 4 | Own accounts; PR review by the other member; weekly board review | Board review / both |
| R13 | Free-tier AI terms allow the provider to use submitted content | 2 | 3 | 6 | Free tier only with synthetic test content; paid tier without use of content before any student material is narrated (NFR-06); provider terms checked before the pilot | Pilot start or a change of terms / Yernar |

## 10.7 Next steps after pre-defense 1

1. Record the committee's comments in [11-supervisor-feedback.md](11-supervisor-feedback.md) and create a YouTrack task for each.
2. Sprint S1 (27 Oct – 9 Nov):
   - YG-14 project skeleton, CI and staging;
   - YG-15 data model;
   - YG-16 e-mail authentication;
   - YG-17 PWA shell and i18n.
3. Feed the interview findings (YG-3) into requirement priorities in [06](06-requirements-specification.md).
