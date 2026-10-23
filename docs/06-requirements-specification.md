# 6. Requirements Specification

## 6.1 Conventions

- **Priority (MoSCoW):** **M** must have (needed for the aim and the evaluation), **S** should have, **C** could have, **W** won't have in this release.
- **Verification:**
  - **T** automated test (unit / integration / API);
  - **E2E** browser test;
  - **D** demonstration;
  - **I** inspection;
  - **B** benchmark from the evaluation plan;
  - **U** user study.
- **Source:** evidence IDs from [02-evidence-of-relevance.md](02-evidence-of-relevance.md): E = literature, observation or system analysis; H = interview hypotheses H1–H10 checked in interviews I-01…I-03. Gaps G1–G8 come from [04-existing-systems-comparison.md](04-existing-systems-comparison.md).
- **Owner** is the main implementer; the other member reviews. IDs are used in the YouTrack backlog, branches, pull requests and the test plan ([09](09-verification-evaluation-plan.md)).

## 6.2 Actors

| Actor | Description |
|---|---|
| Student | Registered adult learner; primary actor |
| Group member | Student who belongs to a study group |
| Moderator | Team role that reviews reported or unverified generated content |
| Microsoft Entra ID | Identity provider of the university tenant |
| Moodle LMS | Source of personal deadlines and course names (iCalendar export) |
| LLM provider | Generates skill maps, units, scripts and questions; grades open answers |
| TTS provider | Produces narration audio for videos |
| Scheduler | Time-based triggers: LMS refresh, review reminders, job cleanup |

## 6.3 Functional requirements

### A. Accounts and data rights

| ID | The system shall… | P | Acceptance criteria | Ver. | Owner | Source |
|---|---|---|---|---|---|---|
| FR-01 | let a student register and sign in with e-mail and password | M | Passwords stored as bcrypt/argon2 hashes; wrong password → 401; duplicate e-mail → 409; 5 failed attempts per minute → 429; a user cannot read another user's resources (403/404) | T | Yernar | — |
| FR-02 | allow sign-in with Microsoft Entra ID restricted to the university tenant | S | Other tenants rejected; first sign-in creates a profile; linking only from an authenticated session; no automatic merge by e-mail | T, D | Yernar | E14, H2 |
| FR-03 | ask for explicit, versioned consent before logging learning analytics, and allow withdrawal | M | No analytics events stored before opt-in; consent stores policy version and time; withdrawal stops logging and deletes analytics; learning progress stays | T | Yernar | E13, H9, G8 |
| FR-04 | let the student export all personal data and delete the account | M | Export = one JSON file with all user-owned records; deletion cascades to all user-owned tables and generated private content (SQL assertion in test) | T | Yernar | E13, G8 |

### B. Goals, material and micro-units

| ID | The system shall… | P | Acceptance criteria | Ver. | Owner | Source |
|---|---|---|---|---|---|---|
| FR-05 | let the student create a learning goal or choose a university subject, and set level and daily time budget (5–60 min) | M | Values outside range → 422; subjects can be picked from course names found in the connected LMS calendar or typed in | T, E2E | Ayat | E1, H1, G6 |
| FR-06 | accept source material as pasted text (≤ 20,000 characters) | M | Valid text → 201 with topic ID; longer → 413; empty → 422; text treated as data, not instructions (injection set passes) | T, B | Yernar | E4, G6 |
| FR-07 | accept a text-based PDF (≤ 10 MB) as source material | C | Text extracted and processed as FR-06; scanned PDF → clear error message | T | Yernar | H4 |
| FR-08 | build a skill map with prerequisites for the goal or material | M | 5–30 skills; graph is acyclic (automated check); every skill has a name, description and ≥ 1 prerequisite link or is a root | T, B | Yernar | E6 |
| FR-09 | segment content into micro-units | M | Each unit has one learning objective, 2–5 min reading time (≤ 400 words) and ≥ 1 mapped skill; when material is given, every unit references its source span; on 10 sample documents ≥ 90 % of units meet the limits, and in a review of 20 units ≥ 80 % are judged coherent by two raters | T, B | Yernar | E1, G6 |

### C. Personalized microlearning pathway

| ID | The system shall… | P | Acceptance criteria | Ver. | Owner | Source |
|---|---|---|---|---|---|---|
| FR-10 | offer a placement test (≤ 10 items) that initializes mastery | S | After the test every assessed skill has an initial mastery value; the test can be skipped (priors apply) | T | Yernar | E6 |
| FR-11 | compute a personalized pathway of micro-units | M | Only units whose prerequisite skills have mastery ≥ threshold are eligible (100 % in 100 simulated learners); priority uses knowledge gap, goal relevance, review due date and deadline proximity; recomputed ≤ 2 s (p95) after each quiz | T, B | Yernar | E1, E6, G1, G2 |
| FR-12 | provide a daily check-in (energy 1–5, free minutes) and build today's micro-plan | M | Total planned time ≤ free minutes; check-in ≤ 3 interactions, defaults from the previous day, skippable | T, E2E, U | Ayat | E12, H1, H3, G5 |
| FR-13 | show for each recommended unit why it was chosen | M | One-sentence reason generated from the strongest priority factor ("Quiz in Databases in 3 days", "Review due: JOINs") plus factor breakdown on demand; reason matches computed factors in 100 % of tests | T, U | Ayat | E15, H3 |
| FR-14 | let the student accept or postpone a recommended unit | S | Accept places it in the first free slot; postponing lowers its priority for today only; both are logged as feedback | T | Ayat | H3 |
| FR-15 | schedule spaced review of learned skills | S | A skill whose review is due and whose mastery fell below threshold re-enters the pathway in the next session; scheduler unit-tested on 10 scenarios | T | Yernar | E5 |
| FR-16 | show micro-units, own tasks and LMS deadlines in a day plan and calendar (week/month) | S | Items carry a source label; time zone = profile time zone; E2E at 320/390/1440 px | E2E | Ayat | E14, H2, G5 |
| FR-17 | connect the student's Moodle calendar via iCalendar URL and refresh it three times a day | S | URL validated server-side, stored encrypted, never returned to the browser; changed or canceled events updated; deadlines raise priority of the related goal; disconnect deletes the URL | T, D | Yernar | E14, H2, G5 |
| FR-18 | import a class timetable from a screenshot or text with preview and undo | C | Nothing saved before confirmation; uncertain rows shown as warnings; undo removes only that batch | T | Ayat | H2 |

### D. Short-form video generation

| ID | The system shall… | P | Acceptance criteria | Ver. | Owner | Source |
|---|---|---|---|---|---|---|
| FR-19 | generate a short video (60–120 s) for a micro-unit: grounded script, narration, slide visuals and captions | M | The video plays in the app with narration and captions, and can be saved as an MP4 or WebM file of 60–120 s with an audio track (container depends on the browser) plus a WebVTT caption file; on 20 test jobs ≥ 90 % succeed | T, B | Yernar | E2, E3, G1 |
| FR-20 | run video generation as an asynchronous job with visible status and retry | M | Request → 202 within 500 ms; status queued / running / succeeded / failed / needs_review; up to 3 automatic retries; the UI shows status and errors, never a blank state | T, E2E | Yernar | — |
| FR-21 | validate generated scripts before rendering | M | Each factual sentence maps to a source span (when material exists) or to the unit text; length 120–280 words; self-consistency check across two generations; on 20 scripts with 10 injected errors ≥ 80 % of errors are flagged; flagged scripts go to `needs_review` and are not published | T, B | Yernar | E4, E7 |
| FR-22 | reuse an existing video for the same unit version and language | S | A second request returns the stored video without a new LLM/TTS call (call counter in test) | T | Yernar | NFR-13 |
| FR-23 | narrate in English (M), Russian (S) and Kazakh (C, enabled only after a native-speaker quality check) | S | EN end to end; RU tested on 5 units; KK flag off until the check is recorded | T, I | Yernar | H10, G7 |
| FR-24 | play videos with captions, transcript, speed control and a "sources" panel | M | Captions on by default and switchable; transcript searchable; sources panel lists the source spans or states "generated from unit text"; keyboard accessible | E2E | Ayat | E2, H4 |

### E. Adaptive knowledge assessment

| ID | The system shall… | P | Acceptance criteria | Ver. | Owner | Source |
|---|---|---|---|---|---|---|
| FR-25 | maintain a question bank per skill (multiple choice and short answer) with a difficulty parameter | M | ≥ 5 validated questions per skill in pilot topics; LLM-generated items pass schema, answer-key and distractor checks; unvalidated items are never served | T, B | Yernar | E4, E5, G2 |
| FR-26 | select the next question adaptively | M | Item chosen so that the predicted success probability is closest to 0.7 among eligible items of the current skills; no repeats within a quiz; stops when mastery confidence is reached or after 10 items; selection ≤ 500 ms p95 | T, B | Yernar | E6, G2 |
| FR-27 | update ability, item difficulty and per-skill mastery after each answer | M | Elo update of the learner's ability for the skill and of the item difficulty (graded score for open answers); mastery = predicted success on a typical item of the skill; values move in the expected direction for correct/incorrect answers (unit tests); repeated submissions with the same idempotency key change nothing | T | Yernar | E6, G2 |
| FR-28 | grade short open answers and code with AI against a hidden rubric | S | Score 0–100 with one strength and one concrete improvement (no generic praise); code never executed; rubric never sent to the client; scores of 70–85 get a second grading pass; the student can appeal to a human reviewer; agreement with human graders ≥ 85 % pass/fail and κ ≥ 0.70 | T, B | Yernar | E8, E9, G3 |
| FR-29 | give hints before revealing an answer | M | Up to 2 hints per item; the API refuses to return the correct answer before an attempt; hints contain no full answer (leak test set) | T, B | Yernar | E7, H6, G3 |
| FR-30 | show a mastery report | M | Mastery per skill, weak areas first, links to recommended units; values equal stored mastery (E2E with seeded learner) | E2E | Ayat | E5, H5 |

### F. Social learning

| ID | The system shall… | P | Acceptance criteria | Ver. | Owner | Source |
|---|---|---|---|---|---|---|
| FR-31 | let students add friends (request / accept) and block users | M | Only accepted friends see friends-only items; blocked users disappear from feed and search | T | Yernar | E11, H7 |
| FR-32 | show an activity feed of friends' learning events with per-item visibility | M | Feed contains only events from friends whose visibility allows it; default visibility "friends"; scores are hidden unless the owner shares them | T, E2E | Ayat | E11, H7 |
| FR-33 | let students share a unit or video with friends or a group, like and comment | S | Shared item appears in recipients' feed; comment ≤ 500 characters; owner can delete comments on own items | T | Ayat | E11, G4 |
| FR-34 | support study groups with a shared goal and a cooperative weekly challenge | S | Group progress = sum of members' completed units toward the goal; no individual ranking shown by default; owner can revoke invite link and remove members | T | Ayat | E10, E11, H7, H8, G4 |
| FR-35 | let users report inappropriate content or incorrect generated content | M | A report creates a record in the moderation queue within 5 s, with the content snapshot | T | Ayat | E4 |
| FR-36 | provide a moderation queue for reported and unverified items | S | Moderator can hide content, verify or reject generated items; rejected items are never served again; every action is logged | T | Ayat | E4, E7 |

### G. Engagement

| ID | The system shall… | P | Acceptance criteria | Ver. | Owner | Source |
|---|---|---|---|---|---|---|
| FR-37 | award XP, levels, character stats and coins for completed units and quizzes; offer cosmetic avatar skins | S | Rewards computed on the server, once per unit (unique ledger key); purchases reject insufficient balance and duplicates; concurrent duplicates → exactly one reward | T | Yernar | E10 |
| FR-38 | never penalise inactivity | M | No mechanic removes XP, coins, mastery or progress after missed days; streaks, if shown, can be paused without loss | I, T | Ayat | E10, H8, G4 |
| FR-39 | send opt-in push reminders for planned units and due reviews with per-device quiet hours | S | No sends during quiet hours (time-zone aware); at most one reminder per item and device | T | Yernar | E12 |

### H. Platform

| ID | The system shall… | P | Acceptance criteria | Ver. | Owner | Source |
|---|---|---|---|---|---|---|
| FR-40 | offer the interface in English, Russian and Kazakh | S | All strings externalised; CI check reports 0 missing keys for 3 locales; switching without reload | T | Ayat | H10, G7 |
| FR-41 | log pseudonymized learning interactions for evaluation (with consent) | M | Events: unit view, video watch %, question ID, correctness, response time; export contains no name or e-mail | T, I | Yernar | E13 |

### Won't have in this release

W-01 native apps · W-02 own model training · W-03 deep knowledge tracing · W-04 photorealistic avatar video · W-05 reading Moodle course content or grades · W-06 official grading or proctoring · W-07 payments · W-08 public social network.

## 6.4 Non-functional requirements

| ID | Category | Requirement and measurable criterion | P | Ver. |
|---|---|---|---|---|
| NFR-01 | Performance | Non-generation API endpoints p95 ≤ 500 ms at 50 concurrent virtual users | M | B (k6) |
| NFR-02 | Performance | Next-item selection ≤ 500 ms p95; pathway recomputation ≤ 2 s p95 | M | B |
| NFR-03 | Video throughput | A 60–120 s video is ready in ≤ 5 min for p90 of jobs; failure rate < 10 % over 50 jobs after retries | M | B |
| NFR-04 | AI latency | Open-answer grading p95 ≤ 15 s; progress state after 300 ms; timeout 30 s with retry | S | B |
| NFR-05 | Security | OWASP ASVS 5.0 Level 1 checklist; secrets only on the server; ownership check on every resource; private media served only through authorized routes; secret scanning in CI | M | T, I |
| NFR-06 | Privacy | No names, e-mails or account IDs in AI/TTS requests; provider storage disabled where available; Gemini TTS on the paid tier, where content is not used to improve Google products, before any student content is narrated, and the free tier only with test content; consent before analytics; Law of the RK No. 94-V | M | I, T |
| NFR-07 | Integrity | Rewards and mastery updates idempotent and transactional: 100 parallel duplicate submissions → one effect | M | T |
| NFR-08 | Usability | Mean SUS ≥ 70 (n = 12); a new user reaches the first micro-unit within 3 min of sign-up | S | U |
| NFR-09 | Accessibility | WCAG 2.2 AA for core flows; captions for every video; 0 critical/serious axe-core violations; full keyboard operation | M | T, I |
| NFR-10 | Responsiveness, PWA | Core flows at 320–1440 px without horizontal scroll; Lighthouse mobile performance ≥ 80; installable on Android and iOS | M | E2E, B |
| NFR-11 | Resilience | Failure of LLM, TTS, storage or LMS affects only the dependent feature; no fake AI output is ever shown | M | T |
| NFR-12 | Maintainability | TypeScript strict; ≥ 70 % line coverage of domain modules (pathway, assessment, pipeline, ledger); CI on every pull request | S | T, I |
| NFR-13 | Cost | Average LLM + TTS cost ≤ USD 0.05 per generated video and ≤ USD 0.30 per active user per month; per-user and global limits | S | B |
| NFR-14 | Observability | Structured logs with request ID; job and AI call metrics (latency, tokens, characters, outcome); alert at > 5 % error rate for 10 min | S | I |

## 6.5 Traceability

| Objective | Requirements |
|---|---|
| O3 Content ingestion | FR-05 – FR-09 |
| O4 Pathway | FR-10 – FR-18 |
| O5 Video generation | FR-19 – FR-24, NFR-03, NFR-13 |
| O6 Adaptive assessment | FR-25 – FR-30, NFR-02 |
| O7 Social learning | FR-31 – FR-36 |
| O8 Evaluation | FR-41, NFR-08, all benchmarks in [09](09-verification-evaluation-plan.md) |

| Evidence / gap | Requirements |
|---|---|
| E1 microlearning | FR-05, FR-09, FR-11 |
| E2–E3 short video, AI-generated video | FR-19, FR-24 |
| E4 errors in LLM-generated content | FR-06, FR-21, FR-25, FR-35, FR-36 |
| E5 retrieval practice, spacing | FR-15, FR-25, FR-30 |
| E6 adaptive assessment, knowledge tracing | FR-08, FR-10, FR-11, FR-26, FR-27 |
| E7–E9 AI tutoring guardrails and grading reliability | FR-21, FR-28, FR-29, FR-36 |
| E10 gamification design, streak loss | FR-34, FR-37, FR-38 |
| E11 peer learning | FR-31 – FR-34 |
| E12 procrastination, planning | FR-12, FR-39 |
| E13 student data privacy | FR-03, FR-04, FR-41, NFR-06 |
| E14 observed LMS process | FR-02, FR-16, FR-17 |
| E15 explanations and trust | FR-13 |
| H1–H10 interview hypotheses | see [02 §2.6](02-evidence-of-relevance.md#26-from-findings-to-requirements) |
| G1 video and adaptivity in separate products | FR-11, FR-19 – FR-24 |
| G2 adaptive assessment only on vendor content | FR-08, FR-25 – FR-27 |
| G3 restricted AI feedback on open answers | FR-28, FR-29 |
| G4 competitive, punitive social mechanics | FR-31 – FR-34, FR-38 |
| G5 learning not fitted into the student's day | FR-12, FR-16, FR-17 |
| G6 higher-education content not in micro-units | FR-05, FR-06, FR-09 |
| G7 no Kazakh; strong AI features paid or regional | FR-23, FR-40, NFR-13 |
| G8 incomplete data controls | FR-03, FR-04, NFR-06 |
