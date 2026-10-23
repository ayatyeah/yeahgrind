# Pre-defense 1 — Talk outline (7–8 minutes)

| # | Slide / topic | Speaker | Key message | Time |
|---|---|---|---|---|
| 1 | Title, team, supervisor | Ayat | YeahGrind: an intelligent social learning platform; official topic | 0:20 |
| 2 | Problem | Ayat | Short study windows vs long, fixed-order material; late feedback; studying alone or competing | 0:50 |
| 3 | Evidence | Ayat | Interviews I-01…I-03, the observed LMS process and published data; verified findings vs design hypotheses | 0:50 |
| 4 | Literature | Yernar | Microlearning, short and AI-generated video, retrieval practice and adaptive assessment, AI tutoring guardrails, peer learning; what the project takes from each | 1:00 |
| 5 | Existing systems | Ayat | 5 systems × 10 criteria; gaps G1–G7 → requirements | 0:40 |
| 6 | Aim, objectives, scope | Yernar | O1–O8 with measurable results; in/out of scope | 0:40 |
| 7 | Requirements | Yernar | 41 FR / 14 NFR with priorities and acceptance criteria; traceability to evidence | 0:30 |
| 8 | Architecture | Yernar | Modular monolith with background jobs, pathway engine, Elo-based assessment, video pipeline (Gemini narration, client-side rendering), AI gateway; diagrams | 1:00 |
| 9 | Technology choices | Yernar | Weighted comparison of the key decisions | 0:30 |
| 10 | Prototype walkthrough | Ayat | S1 goal → path → micro-plan → video → adaptive quiz → mastery → group | 1:00 |
| 11 | Evaluation plan | Ayat | Benchmarks B1–B6 and the learning + usability study vs a non-adaptive baseline | 0:40 |
| 12 | Plan, risks, repository | Yernar | Milestones M1–M8, YouTrack, Git workflow, top risks and mitigations | 0:30 |

## Likely questions

- **What is new?** The engineering integration and its evaluation: a personalized microlearning pathway over the student's own subject, fitted into the day, with generated short videos and adaptive assessment in one platform. A new ML algorithm is not claimed.
- **How do you prevent wrong content in generated videos and questions?**
  - Every script sentence must map to a source span, and a second generation is checked for consistency.
  - Questions start as drafts and must pass validation.
  - Items that fail go to the moderation queue, and students can report any item.
  - Benchmarks B3 and B4 measure the result.
- **Why Elo and not BKT, IRT-based adaptive testing or deep knowledge tracing?** Elo needs no calibration data at launch, updates in constant time and is easy to explain (Pelánek, 2016). IRT and BKT need calibration on large samples, and deep models need large training logs. B2 compares Elo with BKT and IRT offline on a public dataset.
- **Why template video and not avatars?** AI-generated teaching videos gave exam results similar to human-made ones (Netland et al., 2025), and a synthetic presenter showed no difference in learning gains (Leiker et al., 2023). Video helps most when added to practice (Noetel et al., 2021). So the budget goes into accuracy checks and practice rather than presenter realism. Avatar video would cost ≈ USD 1–4 per minute, versus near-zero rendering cost for the template pipeline.
- **How is the work split?** Yernar: backend, engines, pipeline. Ayat: frontend, UX research, social features, study. Every pull request is reviewed by the other member.
