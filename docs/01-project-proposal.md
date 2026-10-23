# 1. Project Proposal

## 1.1 Title

**Development of an Intelligent Social Learning Platform with Personalized Microlearning Pathways, Short-Form Video Generation, and Adaptive Knowledge Assessment**

Product name: **YeahGrind**.

## 1.2 Team and supervisor

| Role | Name | Main responsibility |
|---|---|---|
| Team member | Yernar Katyshev, SE-2425 | Backend and business logic: data model, REST API, content ingestion, pathway engine, adaptive assessment engine, video generation pipeline, AI gateway, LMS integration |
| Team member | Ayat Balmagambet, SE-2425 | Frontend and UX: PWA, user research and prototype, learning/video/quiz interfaces, social features UI, gamification UI, localization (EN/RU/KK) |
| Supervisor | Arstan Makatov | Academic supervision, review of deliverables at agreed checkpoints |

Institution: Astana IT University (AITU), Software Engineering, academic year 2026–2027. Both members co-own requirements, verification and project management. Detailed allocation: [10-project-management-risks.md](10-project-management-risks.md).

## 1.3 Problem statement

Students who learn independently face five connected problems:

1. **Material does not fit real study sessions.** Lectures, chapters and slide decks are long and follow one order, while students mostly study in focused sessions shortly before deadlines and choose what to study by the nearest deadline ([02](02-evidence-of-relevance.md), interviews I-01 … I-03). Microlearning (small units with one objective each) lets a session be planned from units that fit its length, but its effect depends on how units are designed and sequenced ([03](03-literature-review.md), theme A).
2. **One sequence for everyone.** Students start from different levels and have different goals and deadlines, yet most materials follow a fixed order. Nobody tells the student *which* small step to take next, given what they already know, the time they have today and the next deadline in the LMS.
3. **Long or missing explanations in a convenient format.** Short instructional videos are an effective and popular format ([03](03-literature-review.md), theme B), but producing them for a student's own course material is expensive. Recent studies show that AI-generated instructional videos can approach the learning outcomes of human-made ones ([03](03-literature-review.md), theme C), which makes on-demand short videos feasible if their content is checked.
4. **Late, non-diagnostic feedback.** Students often discover gaps only at the exam. Retrieval practice and adaptive assessment are well established, and knowledge tracing can estimate mastery per skill ([03](03-literature-review.md), themes D–E). These methods are rarely packaged for self-study with the learner's own material. General chatbots give answers instantly, but unrestricted answer access can harm later unaided performance, while tutoring that gives hints instead of solutions does not (Bastani et al., 2025).
5. **Studying alone, or competing instead of cooperating.** Peer learning helps, but social features in learning apps often reduce to public leaderboards and streaks, and losing a streak can lower later engagement ([03](03-literature-review.md), themes F and J).

Each of the analyzed systems ([04](04-existing-systems-comparison.md)) covers part of this: courses with video, adaptive practice in fixed curricula, AI flashcards, AI video authoring or social competition. None combines a personalized microlearning pathway over the learner's own subject, generated short videos, adaptive assessment with mastery estimation and cooperative social learning, all fitted into the student's day.

## 1.4 Target users

| Group | Description | Key needs |
|---|---|---|
| **Primary: university students (18+)** | AITU undergraduates who study for courses and exams on their own or in small groups | Short units that fit free time; a clear next step; explanations in video form; honest feedback on what they do not know yet; studying with friends |
| Secondary: study-group members | 2–8 students preparing together for the same course or exam | Shared goal and progress, sharing units and videos, discussion, cooperative challenges |
| Secondary: content moderator | Project team member during the pilot | Review reported or unverified generated content (scripts, videos, questions) |

Personas and the interview study that refines them: [02](02-evidence-of-relevance.md) and [research/interview-guide.md](research/interview-guide.md).

## 1.5 Aim

Design, implement and evaluate a web platform that does five things:
- turns a learning goal or university subject, optionally with the student's own material, into micro-units;
- orders the units into a personalized pathway that fits the student's available time and deadlines;
- explains each unit with a short generated video;
- assesses knowledge adaptively, updating mastery after every answer;
- supports cooperative learning with friends and study groups.

The evaluation shows whether this gives better learning efficiency and usability than a non-adaptive baseline.

## 1.6 Objectives

| ID | Objective | Measurable result |
|---|---|---|
| O1 | Derive requirements from literature, comparable systems, process observation and 3–5 user interviews | Every *Must* requirement traces to at least one evidence item ([06](06-requirements-specification.md)) |
| O2 | Design architecture, data model and API | Context, use-case, component, data-model and sequence diagrams; OpenAPI contract ([07](07-architecture.md)) |
| O3 | Implement content ingestion: skill map and micro-unit segmentation from a goal, subject or pasted material | Skill graph acyclic in 100 % of cases; ≥ 90 % of units within length limits and mapped to a skill |
| O4 | Implement the personalized microlearning pathway with daily scheduling and spaced review | No unit scheduled before its prerequisites are mastered; daily plan never exceeds the stated free time; explanation for every recommended unit |
| O5 | Implement the short-form video generation pipeline with content validation | 60–120 s video with narration and captions; ≥ 90 % job success; p90 generation time ≤ 5 min; ≥ 80 % of seeded factual errors caught |
| O6 | Implement adaptive knowledge assessment | Next-item selection ≤ 500 ms; mastery model beats a non-adaptive baseline in predicting answers on a public dataset (AUC); quizzes stop within 10 items |
| O7 | Implement social learning features and moderation | Friends, feed, sharing, study groups with cooperative goals, reporting and review queue work end to end |
| O8 | Evaluate the platform | Learning and usability study (n = 12, one session + 1-week retention test) against a non-adaptive baseline: higher learning gain, SUS ≥ 70 |

## 1.7 Expected outcomes

1. A deployed, installable web application (PWA) with the full cycle *goal → pathway → micro-unit with video → adaptive quiz → mastery update → next step → share with friends*.
2. A pathway engine and an adaptive assessment engine whose decisions are explainable to the student ("why this unit", "why this question").
3. An asynchronous video generation pipeline with grounding checks, captions and caching.
4. Documentation in this repository: proposal, evidence, literature review, comparisons, requirements, architecture decisions, diagrams, prototype, API contract, test plan.
5. An evaluation report with automated test results, component benchmarks and the learning and usability study against the baseline.
6. A traceable record of individual contributions through YouTrack tasks, branches, pull requests and reviews.

The contribution of the diploma is the **engineering integration** of these components into one platform and its evaluation; a new learning-science theory or a new machine-learning model is not claimed.

## 1.8 Scope

**In scope**

- Responsive web application and PWA; accounts with e-mail and Microsoft Entra ID sign-in for the university tenant.
- Learning goals and university subjects (subject list from the student's Moodle calendar export or entered manually); optional source material as pasted text (≤ 20,000 characters) or text-based PDF (≤ 10 MB).
- Skill map with prerequisites and micro-units (one objective, 2–5 min).
- Personalized pathway: ordering by prerequisites and mastery, a daily check-in (energy, free minutes), placement into the day plan considering LMS deadlines, spaced review, an explanation for every recommendation.
- Short videos (60–120 s) per micro-unit: grounded script, narration (English, Russian; Kazakh after a native-speaker quality check), slide visuals and captions; asynchronous jobs; reuse of generated videos.
- Adaptive assessment:
  - a question bank per skill (LLM-assisted with validation);
  - a placement test;
  - adaptive item selection;
  - mastery estimation per skill;
  - AI grading of open answers with formative feedback;
  - hints that do not reveal the answer;
  - mastery reports.
- Social learning: friends, an activity feed, sharing units and videos, comments, study groups with cooperative goals, reporting and moderation.
- Engagement: XP, levels, avatar and cosmetic rewards without penalties for missed days; push reminders with quiet hours.
- Privacy controls: consent, data export and deletion. Interface in English, Russian and Kazakh.

**Out of scope**

- Native mobile apps (the PWA covers mobile use); live or synchronous video.
- Training or fine-tuning generative models; photorealistic avatar video; deep knowledge tracing.
- Reading course content or grades from Moodle (only the student's own calendar export is used).
- Official grading, proctoring or certification; payments; public social network beyond friends and groups.

## 1.9 Engineering complexity

| Area | Why it is non-trivial |
|---|---|
| Content ingestion | LLM-assisted skill extraction and segmentation with schema validation, acyclicity checks, length limits and source grounding |
| Pathway engine | Constrained ordering (prerequisites, mastery thresholds, time budget, deadlines, review due dates), explanation of each choice, recomputation after every quiz within 2 s |
| Adaptive assessment | Online Elo-style estimation of learner ability per skill and item difficulty without prior calibration, mastery estimate per skill, item selection near a target success probability, stopping rules, offline evaluation on a public dataset |
| Video pipeline | Asynchronous multi-step jobs: script, grounding validation, narration, timings and captions, plus slide rendering and recording in the browser. Needs retries, idempotency, cost limits and failure states |
| AI safety and quality | Prompt-injection defense for user material and answers, hidden rubrics, hint-not-answer guardrails, human review queue for flagged content |
| Social module | Privacy-aware feed (visibility settings, blocking), cooperative group goals, reporting and moderation |
| Consistency | Exactly-once rewards and mastery updates under retries and multiple devices (idempotency keys, transactions) |
| Integrations and PWA | OpenID Connect with tenant restriction, iCalendar parsing and scheduled refresh, web push with quiet hours, offline view |
| Privacy and localization | Data minimization to AI providers, consent, export and deletion under the Law of the RK No. 94-V; three interface languages including Kazakh |

## 1.10 Assumptions and constraints

- Two-person team, about seven months of development (November 2026 – May 2027), three pre-defense checkpoints.
- LLM and TTS are consumed through paid APIs under a monthly budget cap. Requests contain no personal identifiers and provider-side storage is disabled.
- Pilot content uses the team's own or openly licensed material and students' own notes; third-party copyrighted content is not redistributed.
- Interview and evaluation participants are adult volunteers who give informed consent ([research/consent-and-recruitment.md](research/consent-and-recruitment.md)).

References use author–year citations; the full list with DOIs is in [03-literature-review.md](03-literature-review.md).
