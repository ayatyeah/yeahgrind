# 11. Supervisor Feedback

Supervisor: **Arstan Makatov**. Review checkpoints: before each pre-defense and at milestones M2, M4 and M6 ([10 §10.3](10-project-management-risks.md#103-milestones)). Every comment is recorded below exactly as given. Each one gets a decision, an owner and a YouTrack task or commit that shows how it was addressed.

## 11.1 Review package for pre-defense 1

| Deliverable | File | Reviewer focus |
|---|---|---|
| Proposal and scope | [01](01-project-proposal.md) | Is the problem clear, the scope realistic for two people and the engineering complexity sufficient? |
| Evidence of relevance and interviews | [02](02-evidence-of-relevance.md), [research/](research/) | Are the findings separated from the design hypotheses? Is the interview sample adequate? |
| Literature review | [03](03-literature-review.md) | Coverage, recency and critical use of sources |
| Existing systems | [04](04-existing-systems-comparison.md) | Choice of systems and criteria |
| Technology comparison | [05](05-technology-comparison.md), [adr/](adr/) | Are the choices justified by requirements? |
| Requirements | [06](06-requirements-specification.md) | Verifiability of every *Must* requirement |
| Architecture and diagrams | [07](07-architecture.md), [`diagrams/`](../diagrams/) | Consistency between requirements, components, data and scenarios |
| Prototype | [08](08-ux-prototype.md), [`prototype/`](../prototype/index.html) | Clarity of key scenarios |
| Verification plan | [09](09-verification-evaluation-plan.md) | Baselines, thresholds and feasibility of the learning and usability study |
| Plan and risks | [10](10-project-management-risks.md) | Milestones and task traceability |

## 11.2 Questions for the supervisor

1. Is the scope appropriate for two people? The scope covers the pathway, video generation, adaptive assessment and social learning, with planning and gamification as support. Which *Could* items (FR-07, FR-18) should be dropped now?
2. Are the pilot topics for the evaluation acceptable (SQL, Python basics, academic English)? Who could validate the pre/post-test items and act as the second human grader for open answers?
3. Is the evaluation design acceptable? It has two parts:
   - **benchmarks:** simulation, offline assessment on a public dataset, video and content quality ratings;
   - **a learning and usability study:** 12 students, YeahGrind vs a static text + fixed quiz baseline, one session plus a 10-minute retention test a week later.
4. Does the study with students require approval from the university ethics committee?
5. Is template-based video (grounded LLM script + narration + slides rendered in the browser) sufficient for the "short-form video generation" part of the topic, or is an avatar or generative video expected?
6. What is the expected date of pre-defense 2 (planned February 2027), and which deliverables are expected there? Which bibliography style should the thesis use (currently APA 7)?

## 11.3 Feedback log

Planned checkpoints are listed first; each comment is added as a new row on the day it is given.

| # | Date | Deliverable | Supervisor comment (as given) | Decision / response | Owner | Task / commit | Status |
|---|---|---|---|---|---|---|---|
| 1 | 24 Oct 2026 | Pre-defense 1 package and the questions in §11.2 | Recorded after the review | — | Ayat Balmagambet | YG-12 | Planned |
| 2 | 23 Nov 2026 | M2 platform foundation | Recorded after the review | — | Yernar Katyshev | YG-14 – YG-21 | Planned |
| 3 | 8 Feb 2027 | M4 adaptive assessment and video scripts | Recorded after the review | — | Yernar Katyshev | YG-28 – YG-33 | Planned |
| 4 | 22 Mar 2027 | M6 video, social and engagement | Recorded after the review | — | Ayat Balmagambet | YG-34 – YG-45 | Planned |

## 11.4 How comments are handled

1. Each comment is copied into the log on the day of the meeting, either verbatim or as a paraphrase that the supervisor confirms by e-mail.
2. For each comment the team records a decision: *accept*, *accept partially* (with reason) or *discuss*.
3. Each accepted comment becomes a YouTrack task with acceptance criteria. The pull request that resolves it references both the task and the log row.
4. At the next checkpoint the supervisor sees the updated deliverable and the closed tasks.
