# 9. Verification and Evaluation Plan

## 9.1 What has to be demonstrated

| ID | Evaluation question | Method | Baseline | Success threshold |
|---|---|---|---|---|
| EQ1 | Does the system meet its specified requirements? | Automated, E2E and inspection tests (§9.2) | — | 100 % of *Must* requirements pass; ≥ 90 % of *Should* |
| EQ2 | Does the pathway respect prerequisites and time, and reach mastery with fewer units than a fixed order? | Simulation benchmark B1 | Fixed curriculum order; random eligible order | 0 prerequisite violations; 0 budget overruns; fewer units to reach goal mastery than both baselines |
| EQ3 | Does adaptive assessment estimate knowledge better and faster than non-adaptive testing? | B2: offline evaluation on a public dataset + simulation | Skill-average predictor; fixed 10-item quiz | Higher AUC and lower RMSE than the baseline (95 % bootstrap CI); ≥ 30 % fewer items for the same mastery classification accuracy (≥ 90 %) |
| EQ4 | Does the video pipeline produce correct, usable short videos reliably and cheaply? | B3: 50-job batch, seeded-error test, rater study | — | ≥ 90 % success; p90 ≤ 5 min; ≥ 80 % of seeded errors flagged; mean rated accuracy and clarity ≥ 4.0/5; ≤ USD 0.05 per video |
| EQ5 | Is generated learning content valid? | B4: skill maps, units, questions reviewed by raters | — | 100 % acyclic maps; ≥ 90 % units within limits; ≥ 85 % of generated questions correct and unambiguous before moderation |
| EQ6 | Is AI grading of open answers close to human grading and safe? | B5: reference set | Two human graders; keyword grader | Pass/fail agreement ≥ 85 %, κ ≥ 0.70; 0 successful injections; 0 answer leaks in hints |
| EQ7 | Do students learn more efficiently and find the platform usable compared with a non-adaptive baseline? | Learning and usability study with a 1-week retention test (§9.5) | Same content as static text + fixed quiz | Higher median normalized learning gain than the baseline; SUS ≥ 70; task success ≥ 85 % |
| EQ8 | Are performance, security, accessibility and integrity targets met? | B6 and audits | — | NFR-01 – NFR-14 thresholds |

## 9.2 Requirement-to-test matrix

| Requirements | Verification | Tool / artifact | Level |
|---|---|---|---|
| FR-01 – FR-04, NFR-05, NFR-06 | Auth, lockout, tenant restriction, ownership (IDOR) with two users, consent gating, export completeness, cascade deletion, AI payload inspection | Vitest + test DB; `tests/acceptance/accounts.feature` | Integration |
| FR-05 – FR-09 | Input limits, injection set, skill-map acyclicity, unit limits, source spans | Vitest with recorded provider responses; B4 | Integration + benchmark |
| FR-10 – FR-15 | Eligibility, priority, plan fitting, explanation fidelity, spaced-review scheduler (10 scenarios) | Vitest + fast-check property tests; B1 | Unit + benchmark |
| FR-16 – FR-18 | Calendar rendering of all sources; iCalendar parsing (time zones, recurrence, cancellations); encrypted URL; import preview and undo | Vitest with `.ics` fixtures; Playwright | Integration + E2E |
| FR-19 – FR-24, NFR-03, NFR-13 | Job states, retries, reuse (call counter), script validation, output checks (narration length from the WAV header, WebVTT cues, exported file loads in a `<video>` element), player accessibility | Vitest with fake providers; Playwright; B3 | Integration + benchmark |
| FR-25 – FR-30, NFR-02 | Item validation, selection rule, no repeats, stopping rule, Elo update direction, idempotent answers, hidden keys and rubrics, report values | Vitest; B2, B5 | Unit + benchmark |
| FR-31 – FR-36 | Friendship states, visibility filtering, blocking, comments, group progress, report creation, moderation actions and audit | Vitest; Playwright | Integration + E2E |
| FR-37 – FR-39, NFR-07 | Ledger uniqueness under 100 parallel duplicates, purchases, no-penalty inspection, quiet hours across time zones | Vitest with concurrent requests and fake clock | Integration |
| FR-40, FR-41 | i18n missing-key check; event export without identifiers | CI script; Vitest | CI + integration |
| NFR-01, NFR-02, NFR-04 | Latency under load | k6 (50 virtual users, 10 min); micro-benchmarks | B6 |
| NFR-08 | Usability | Study in §9.5 | User study |
| NFR-09 | Accessibility | @axe-core/playwright on every core screen; manual keyboard and screen-reader pass; caption presence check for all videos | E2E + manual |
| NFR-10 | Responsiveness, PWA | Playwright at 320/390/1440 px; Lighthouse CI (mobile) | E2E |
| NFR-11 | Resilience | Fault injection: LLM/TTS timeout, 500, invalid JSON; storage failure; LMS 404 | Integration |
| NFR-12, NFR-14 | Coverage and observability | Coverage report; log schema inspection | CI + inspection |

Acceptance scenarios in Given/When/Then form are kept in [`tests/acceptance/`](../tests/acceptance/).

## 9.3 Test environment and conditions

- **Version under test:** the Git tag of the evaluated release; tag and commit hash are recorded in every report.
- **Environments:** local (Node.js 24 LTS, PostgreSQL 18 in Docker) for unit and integration tests; staging on the production configuration for E2E, load and user studies. Each environment uses a separate database, and all test data is synthetic.
- **AI settings:** model versions, voices and temperature are fixed for benchmark runs. Each AI benchmark runs three times, and the mean and standard deviation are reported.
- **Devices:** Android phone (Chrome) and iPhone (Safari) at 390 px; laptop at 1440 px.
- **Data sets:** synthetic learner profiles, the public assessment dataset (license noted), grading reference set, seeded-error scripts and `.ics` fixtures are versioned in `tests/benchmarks/`. A README describes their origin.

## 9.4 Component benchmarks

### B1 Personalized pathway (simulation)

- **Setup:**
  - 3 pilot topics (SQL, Python basics, academic English), each with a skill map of 9–15 skills and its units;
  - 100 simulated learners per topic, each with random true initial mastery per skill, daily budgets of 10–60 min and deadlines;
  - simulated answers follow a two-state learning model (BKT-style) driven by the true state, independent of the engine under test.
- **Compared:** YeahGrind pathway vs (a) fixed curriculum order, (b) random choice among eligible units.
- **Metrics:**
  - prerequisite violations;
  - budget overruns;
  - units and minutes needed until all goal skills are mastered;
  - share of units spent on skills that were already mastered;
  - review coverage;
  - explanation fidelity (reason = top factor).
- **Threshold:** 0 violations and overruns; 100 % fidelity; fewer units and minutes to goal mastery than both baselines (median, 95 % bootstrap CI).

### B2 Adaptive assessment

- **Offline prediction:** a public dataset of student answers with skill tags (ASSISTments 2009–2010 skill-builder data, or another openly licensed set if its terms change) with a chronological 80/20 split per student.
  - **Models:** Elo-style rating (chosen design), with Bayesian Knowledge Tracing and a 1PL IRT model fitted on the training split as comparison models.
  - **Baseline:** per-skill average correctness.
  - **Metrics:** AUC and RMSE of next-answer prediction, with 95 % bootstrap confidence intervals.
- **Adaptive vs fixed testing:** a simulation with known true mastery.
  - **Compared:** the adaptive quiz (target *P* = 0.7, stopping rule) against a fixed random 10-item quiz.
  - **Metrics:** mastery classification accuracy (mastered / not) and number of items used.
- **Threshold:** Elo model better than the baseline on AUC and RMSE, and within the confidence interval of BKT/IRT or better; adaptive quiz reaches ≥ 90 % classification accuracy with ≥ 30 % fewer items; selection ≤ 500 ms p95.

### B3 Video generation pipeline

- **Batch:** 50 jobs over 3 topics × 2 languages (EN, RU), plus 5 KK jobs for the native-speaker check.
- **Reliability and speed:**
  - success rate after retries;
  - p50 and p90 total time;
  - duration within 60–120 s;
  - audio and caption presence (narration WAV and WebVTT cues for every clip; the exported MP4/WebM loads in a browser `<video>` element).
- **Grounding:** 20 scripts with 10 injected factual errors (wrong numbers, swapped terms, unsupported claims); share of errors flagged by validation.
- **Quality rating:** 3 student raters score 20 random videos (1–5) on accuracy, clarity, audio quality and caption sync.
- **Cost:** tokens and TTS characters per video, converted to USD at current prices.
- **Threshold:** ≥ 90 % success, p90 ≤ 5 min, ≥ 80 % of injected errors flagged, mean accuracy and clarity ≥ 4.0, ≤ USD 0.05 per video.

### B4 Generated content validity

- 10 source documents → skill maps and units: acyclicity, unit length, source-span coverage; 20 units rated for coherence by two raters.
- 100 generated questions are reviewed by two raters for a correct key, a single correct option, plausible distractors and skill fit. Inter-rater agreement is reported.
- **Threshold:** 100 % acyclic; ≥ 90 % units within limits; ≥ 80 % units coherent; ≥ 85 % questions valid before moderation; 0 invalid items served (they are blocked by status).

### B5 AI grading of open answers

- **Reference set:** 60 answers = 3 subjects × 4 exercises × 5 answer types (correct, partial, incorrect, off-topic, injection attempt). Two human graders apply the rubric independently; human–human agreement is reported first.
- **Metrics:**
  - pass/fail accuracy and Cohen's κ against the human consensus;
  - MAE of the score;
  - feedback rubric (strength, concrete improvement, no full solution);
  - injection success rate;
  - hint leakage rate.
- **Baseline:** keyword-overlap grader.
- **Threshold:** accuracy ≥ 85 %, κ ≥ 0.70, MAE ≤ 12, 0 injections, 0 leaks.

### B6 Performance, integrity and resilience

| Test | Condition | Threshold |
|---|---|---|
| Load | k6, 50 virtual users, 10 min: plan, unit, quiz answer, feed, mastery | p95 ≤ 500 ms; errors < 1 % |
| Item selection / pathway | 1,000 calls with 2,000 items and 5,000 attempts | ≤ 500 ms / ≤ 2 s p95 |
| AI latency | 100 gradings | p95 ≤ 15 s |
| Exactly-once | 100 parallel identical answer and reward requests | One attempt and one reward; no negative balances |
| Fault injection | LLM/TTS timeout, 500, invalid JSON; storage write failure; LMS 404 | Feature-level error; rest of the app works; no fake AI output |

## 9.5 Learning and usability study against the baseline

The study takes one 75-minute session per participant plus a 10-minute online retention test one week later. Following Weidlich et al. (2025), the treatment is specified precisely, the control is active (the same content without video and adaptivity), and retention is measured after a delay.

- **Design:** within-subject and counterbalanced. Each participant studies two comparable topics (e.g. *SQL LEFT JOIN + GROUP BY* and *Python list comprehensions + dictionaries*), one per condition. The order of conditions and the topic–condition pairing are balanced across participants.
  - **Condition A — YeahGrind:** micro-units with generated video, adaptive quiz with feedback, mastery report.
  - **Condition B — baseline:** the same unit texts as static pages (no video, no adaptivity) and a fixed 10-item quiz with correct/incorrect feedback.
- **Participants:** 12 AITU students who were not involved in development and did not take part in the requirement interviews. Recruitment and consent follow [research/consent-and-recruitment.md](research/consent-and-recruitment.md).
- **Procedure:**
  1. Consent and background (5 min).
  2. Pre-test with 5 items per topic (5 min).
  3. Topic 1 in the first condition (15 min).
  4. Topic 2 in the other condition (15 min).
  5. Post-test with 8 new items per topic (10 min).
  6. Usability tasks S1, S5 and S6 in YeahGrind (15 min).
  7. SUS and NASA-TLX raw, then debrief (10 min).
  8. **Delayed retention:** 7 days later, a 10-minute online test with 6 new items per topic.
- **Measures:**
  - **learning:** normalized learning gain per topic, *(post − pre) / (max − pre)*, and delayed retention score;
  - **efficiency:** time on study tasks;
  - **usability:** task success, time-on-task, errors and assists; SUS; perceived workload;
  - **qualitative:** debrief themes.
- **Analysis:** medians and interquartile ranges; paired Wilcoxon signed-rank test with effect size *r* for learning gain and time. Results are reported with confidence intervals and treated as evidence for this setting, not as a population-wide claim.
- **Thresholds:** higher median normalized gain in condition A; SUS ≥ 70; task success ≥ 85 %.
- **Fairness of the comparison:**
  - post-test items are written independently of the quiz item bank;
  - both conditions use the same unit texts and the same time limit;
  - test items are validated by the supervisor or a teaching assistant.

## 9.6 Aim → evidence summary

| Part of the aim | Evidence | Baseline | Report section |
|---|---|---|---|
| Personalized microlearning pathway | B1, study condition A | Fixed and random order; static pages | §1 |
| Short-form video generation | B3, study ratings | — | §2 |
| Adaptive knowledge assessment | B2, B5, study | Skill average; fixed quiz; human graders | §3 |
| Valid generated content | B4 | — | §4 |
| Social learning | FR-31 – FR-36 tests, usability task S5, debrief | — | §5 |
| Learning efficiency and usability | §9.5 | Static text + fixed quiz | §6 |
| Quality attributes | B6, audits | — | §7 |

## 9.7 Reporting and reproducibility

Each evaluation run produces a dated report in `docs/evaluation/` with:

- the release tag and commit hash;
- the environment and model settings;
- dataset versions and licenses;
- raw results (CSV);
- the analysis scripts;
- the summary tables above.

Failed thresholds are reported together with the corrective YouTrack task.

## 9.8 Test cases

| Test ID | Test scenario | Expected result |
|---|---|---|
| TC-01 | Registration, sign-in and access to another user\'s goal | Sign-in works; access to foreign resources returns 404 |
| TC-02 | Sign-in with a Microsoft account from another tenant | Rejected; AITU accounts accepted |
| TC-03 | Learning activity before consent | No analytics event stored; progress stored |
| TC-04 | Account deletion | No user-owned row or private media object remains |
| TC-05 | Goal with pasted material containing injected instructions | Material treated as data; skill map valid and acyclic |
| TC-06 | Pathway with locked prerequisites | No unit of a locked skill is planned |
| TC-07 | Check-in with 40 free minutes | Planned time ≤ 40 min; every item has a reason |
| TC-08 | Review due for a mastered skill | Review item included in today\'s plan |
| TC-09 | Moodle calendar connection and refresh | Deadlines and course names imported; changed and canceled events updated; URL never returned |
| TC-10 | First request for a unit video | Status 202; job runs; narration 60–120 s with WebVTT captions; the player shows slides in sync and exports MP4 or WebM |
| TC-11 | Second request for the same video | Status 200; no new LLM or TTS call |
| TC-12 | Script with an ungrounded sentence | Status needs_review; not visible to students; listed in moderation queue |
| TC-13 | LLM or TTS timeout during a video job | Retried up to 3 times, then failed with a message; no fake output |
| TC-14 | Kazakh video before the quality check | Status 409 |
| TC-15 | Next-question selection | Item with P closest to 0.7; no repeats; ≤ 500 ms |
| TC-16 | Correct and incorrect answers | Ability and mastery move in the expected direction |
| TC-17 | Same answer submitted twice with one idempotency key | Stored result returned; no second update or reward |
| TC-18 | Request for hints and question data | No response contains the answer key or rubric |
| TC-19 | Open answer with a prompt-injection attempt | Graded by the rubric; injection has no effect |
| TC-20 | Feed with friends\' and non-friends\' events | Only permitted events shown; scores private |
| TC-21 | Study group progress | Group total shown; no member ranking by default |
| TC-22 | Moderator rejects a generated question | Question never served again; action logged |
| TC-23 | 100 parallel duplicate reward requests | Exactly one reward; no negative balance |
| TC-24 | Reminder during quiet hours | Not sent; delivered after quiet hours |
| TC-25 | Load test with 50 virtual users | p95 ≤ 500 ms; error rate < 1 % |
| TC-26 | Accessibility scan of core screens | Zero critical or serious axe-core violations |
| TC-27 | Learning and usability study vs baseline | Gain, retention, SUS and task metrics recorded for both conditions |
