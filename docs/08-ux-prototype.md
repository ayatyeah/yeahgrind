# 8. UX and Prototype

## 8.1 Prototype materials

| Material | Location |
|---|---|
| Clickable mid-fidelity mockups (open in any browser; primary buttons follow the scenario) | [`prototype/index.html`](../prototype/index.html) |
| PNG export of every screen | [`prototype/screens/`](../prototype/screens/) |
| All screens on one page | [`prototype/screens/overview.png`](../prototype/screens/overview.png) |
| API behind the screens (endpoints, schemas, example payloads) | [`api/openapi.yaml`](../api/openapi.yaml), [`api/examples/`](../api/examples/) |

The mockups use a monochrome visual language: neutral surfaces, one dark accent, and color only for state labels (review due, LMS, unit). This keeps attention on the learning content and keeps contrast compliant with WCAG 2.2 AA (NFR-09). Frames use a 390 × 800 phone viewport because most micro-sessions are expected on phones. All layouts also work at 320 px (NFR-10).

**Persona.** *Aigerim*, 2nd-year student. She has a Databases quiz on Friday, has 25–40 free minutes on weekdays, learns best from short explanations, and prepares together with three friends.

## 8.2 Key scenarios

| ID | Scenario | Screens | Requirements | Success signal in the user study |
|---|---|---|---|---|
| S1 | Set a goal (subject from LMS), add own material → skill map and path | [P1](../prototype/screens/P1-goal-and-material.png), [P2](../prototype/screens/P2-skill-map-path.png) | FR-05 – FR-11 | Path created in ≤ 3 min; participant explains why some skills are locked |
| S2 | Daily check-in → today's micro-plan with reasons | [P3](../prototype/screens/P3-today-micro-plan.png) | FR-12 – FR-16 | Participant names the reason for the first unit and confirms the plan fits the free time |
| S3 | Study a micro-unit with a generated short video | [P4](../prototype/screens/P4-micro-unit-video.png) | FR-19 – FR-24 | Participant finds captions, transcript and sources without help |
| S4 | Adaptive quiz → feedback → mastery report | [P5](../prototype/screens/P5-adaptive-quiz.png), [P5b](../prototype/screens/P5b-feedback-mastery.png), [P6](../prototype/screens/P6-mastery-report.png) | FR-25 – FR-30 | Participant states the weakest skill and the planned next unit |
| S5 | Friends feed, sharing, study group with cooperative goal | [P7](../prototype/screens/P7-friends-feed.png), [P8](../prototype/screens/P8-study-group.png) | FR-31 – FR-34 | Participant shares a video to the group and finds the group's progress |
| S6 | Privacy, visibility, language and reminders | [P9](../prototype/screens/P9-privacy-settings.png) | FR-03, FR-04, FR-17, FR-39, FR-40 | Participant finds data export and changes default visibility |
| M1 | Moderator reviews a failed script and reported items | [P10](../prototype/screens/P10-moderation-queue.png) | FR-21, FR-35, FR-36 | Item resolved with audit entry |

## 8.3 Screen notes

**P1 Goal and material.**
- Subjects are suggested from the course names in the student's Moodle calendar export, and any subject can be typed in.
- Level and daily time budget (5–60 min) feed the trajectory.
- Uploaded material is shown with its extraction status and a note that it is treated as data. The note matters because student material is also an attack surface for prompt injection (FR-06).

**P2 Skill map and trajectory.**
- The path is shown as a small prerequisite graph with four states: mastered, current, review due and locked.
- The placement test result appears immediately ("3 skills already mastered"), which shows the student why the path does not start at the beginning (FR-10, FR-11).

**P3 Check-in and micro-plan.**
- A two-value check-in (energy, free minutes) produces a short list of units and reviews that fit the free time.
- Every unit carries a one-line reason from the strongest priority factor (FR-13).
- LMS deadlines appear in the same list with a source label.

**P4 Micro-unit with generated video.**
- A 60–120 s video with captions on by default, a transcript, speed control and a narration language switch.
- A *Sources* panel links every sentence of the script to the student's material (FR-21, FR-24).
- Sharing to a group and reporting are one tap away.

**P5 Adaptive quiz.**
- The progress bar shows "max 10" because the quiz stops early when mastery is confident (FR-26).
- Two graduated hints are available before answering, and the correct answer is never revealed before an attempt (FR-29).

**P5b Feedback and mastery update.**
- An explanation follows every answer, and the mastery change is shown numerically (Elo update, FR-27).
- Open answers receive AI feedback with one strength and one concrete improvement, without a full solution (FR-28).

**P6 Mastery report.**
- Per-skill mastery, with weak areas first and a direct link to the planned unit (FR-30).
- XP and level are visible, and the note that missed days never remove progress is permanent (FR-37, FR-38).

**P7 Friends feed.**
- Friends' learning events, shared videos and comments.
- Quiz scores are private unless shared (FR-31 – FR-33).

**P8 Study group.**
- A shared goal and a cooperative weekly target ("23 / 32 units together") with a group reward.
- Individual ranking is hidden by default (FR-34).

**P9 Privacy and settings.**
- Learning analytics are **off by default**.
- Plain-language statement of what goes to AI services.
- Default visibility, export, deletion, quiet hours, interface and narration language, LMS connection.

**P10 Moderation queue.**
- Lists scripts that failed grounding validation (`needs_review`) and student reports about questions, AI feedback and comments.
- Rejected generated items are never served again (FR-36).

## 8.4 Interaction rules applied across screens

| Rule | Where | Reason |
|---|---|---|
| Every AI-generated item shows where it comes from and can be reported | P4, P5b, P10 | Trust and error recovery for generated content |
| Every recommendation carries a reason | P2, P3, P6 | Transparent personalization |
| No answers before an attempt; hints first | P5, P5b | Guardrail evidence on unrestricted AI help ([03](03-literature-review.md)) |
| Cooperation over competition; scores private by default | P7, P8 | Evidence on punitive/competitive mechanics and peer learning |
| Captions on by default for all videos | P4 | Accessibility and noisy environments (NFR-09) |
| Loading state after 300 ms; job status for videos | all | NFR-03, NFR-11 |
| Touch targets ≥ 44 × 44 px; visible focus; contrast ≥ 4.5:1 | all | NFR-09 |

## 8.5 Prototype walkthroughs

Before each epic is implemented, its screens are walked through with 3–5 students in a 20-minute think-aloud session, using the scenarios above as tasks. Issues are rated by severity (0–4, Nielsen's scale), and every issue of severity ≥ 3 becomes a YouTrack task before implementation. The final evaluation with the implemented system is described in [09 §9.5](09-verification-evaluation-plan.md#95-learning-and-usability-study-against-the-baseline).
