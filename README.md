# YeahGrind

**Development of an Intelligent Social Learning Platform with Personalized Microlearning Pathways, Short-Form Video Generation, and Adaptive Knowledge Assessment**

Diploma project · Software Engineering · Astana IT University (AITU) · group SE-2425 · 2026–2027

YeahGrind turns a learning goal or a university subject, optionally with the student's own lecture notes, into a personal path of micro-units. Each unit:
- fits the time the student actually has today;
- is explained by a short generated video;
- is checked with an adaptive quiz that updates mastery per skill.

Students learn together with friends and study groups through shared progress and cooperative goals.

**Status:** analysis and design complete for pre-defense 1 (24 October 2026); implementation starts in sprint S1 (27 October 2026). See [Current status](#current-status).

## Problem, users and expected outcomes

**Problem.** Students study independently, mostly in focused sessions shortly before deadlines, choosing what to study by the nearest deadline, while their materials are long and follow one fixed order. Explanations in a convenient format are missing, and gaps in knowledge show up only at the exam. Social features in learning apps are mostly competitive. The existing systems analyzed cover only parts of this ([comparison](docs/04-existing-systems-comparison.md)).

**Target users.** AITU undergraduate students (18+) who study on their own or in small groups. Secondary users: study-group members and a content moderator.

**Expected outcomes.**
1. A deployed PWA with the cycle *goal → personalized pathway → micro-unit with short video → adaptive quiz → mastery update → next step → share with friends*.
2. Explainable pathway and assessment engines (Elo-style ability per skill and item difficulty, adaptive item selection).
3. An asynchronous, validated video generation pipeline.
4. An evaluation against a non-adaptive baseline: component benchmarks plus a learning and usability study with a one-week retention test.

Details: [project proposal](docs/01-project-proposal.md).

## Team

| Member | Responsibility | GitHub |
|---|---|---|
| Yernar Katyshev | Backend and business logic: data model, API, content generation, pathway engine, adaptive assessment, video pipeline, AI gateway, LMS integration, CI/CD | [@Yera0008](https://github.com/Yera0008) |
| Ayat Balmagambet | Frontend and UX: PWA, user research, prototype, learning, video and quiz interfaces, social features, accessibility, localization (EN/RU/KK) | [@ayatyeah](https://github.com/ayatyeah) |
| **Supervisor:** Arstan Makatov | Review of deliverables at agreed checkpoints | access by invitation |

Both members co-own requirements, verification and project management. The full allocation is in [project management](docs/10-project-management-risks.md#102-responsibilities).

## Scope

**In scope:**
- responsive web app / PWA; e-mail and Microsoft Entra ID sign-in;
- goals and subjects, with own material (text, PDF);
- skill maps and micro-units;
- a personalized pathway with daily check-in, Moodle deadlines and spaced review;
- 60–120 s generated videos with narration and captions (EN, RU; KK after a quality check);
- adaptive assessment with placement test, mastery reports and AI feedback on open answers;
- friends, feed, sharing, study groups with cooperative goals, moderation;
- non-punitive gamification; privacy controls;
- interface in English, Russian and Kazakh.

**Out of scope:** native apps, model training, deep knowledge tracing, photorealistic avatar video, reading Moodle course content or grades, official grading or proctoring, payments.

## Selected technologies

Comparison and scoring: [technology comparison](docs/05-technology-comparison.md) · decisions: [ADRs](docs/adr/)

| Layer | Choice |
|---|---|
| Application | Next.js 16 + React + TypeScript (strict), modular monolith; background jobs in the web process |
| Data | PostgreSQL 18, Prisma ORM 7 (upgraded from 6 in sprint S1); jobs as PostgreSQL rows with a claim; schedules from GitHub Actions |
| API | REST + OpenAPI ([`api/openapi.yaml`](api/openapi.yaml)), Zod validation |
| Authentication | Auth.js v5 (e-mail + password, Microsoft Entra ID restricted to the university tenant); Better Auth as migration target |
| AI | LLM via a provider adapter (OpenAI primary, Anthropic fallback); Gemini TTS for narration behind an adapter (Azure AI Speech as the target) |
| Video | LLM script → grounding check → one narration track → slides drawn on a canvas in the browser, recorded to MP4/WebM on request, WebVTT captions |
| Assessment | Elo-style rating per learner–skill and per item; next item near 70 % expected success |
| Media | Narration audio in PostgreSQL (release 1); S3-compatible object storage as media grow |
| Hosting | Railway (web service, PostgreSQL); GitHub Actions CI and scheduled workflows |
| Testing | Vitest, fast-check, Playwright, axe-core, k6, Lighthouse CI |

## Links

| | |
|---|---|
| YouTrack project (YG) | Backlog of 56 assigned and prioritized tasks for import: [`project-management/youtrack-backlog.csv`](project-management/youtrack-backlog.csv) |
| Documentation | [`docs/`](docs/) — index below |
| Diagrams | [`diagrams/`](diagrams/) (editable PlantUML + SVG/PNG) |
| Prototype | [`prototype/index.html`](prototype/index.html) (clickable mockups), [screens](prototype/screens/) |
| API contract | [`api/openapi.yaml`](api/openapi.yaml), [examples](api/examples/) |
| Pre-defense 1 submission | [`docs/submission/pre-defense-1.md`](docs/submission/pre-defense-1.md) |
| Pre-defense 1 document (Word) | [`docs/PreDefense_YeahGrind.docx`](docs/PreDefense_YeahGrind.docx) |

### Documentation index

1. [Project proposal](docs/01-project-proposal.md)
2. [Evidence of relevance](docs/02-evidence-of-relevance.md) · [interview kit](docs/research/)
3. [Literature review](docs/03-literature-review.md)
4. [Existing system comparison](docs/04-existing-systems-comparison.md)
5. [Technology comparison](docs/05-technology-comparison.md) · [ADRs](docs/adr/)
6. [Requirements specification](docs/06-requirements-specification.md)
7. [Architecture and diagrams](docs/07-architecture.md)
8. [UX and prototype](docs/08-ux-prototype.md)
9. [Verification and evaluation plan](docs/09-verification-evaluation-plan.md)
10. [Project management and risks](docs/10-project-management-risks.md)
11. [Supervisor feedback](docs/11-supervisor-feedback.md)

## Repository layout

```
docs/                 proposal, evidence, literature, comparisons, requirements, architecture, UX, verification, management
  research/           interview guide, consent and recruitment, pseudonymized interview notes
  adr/                architecture decision records
  submission/         pre-defense summaries and talk outline
diagrams/src          editable PlantUML sources         diagrams/export   SVG and PNG exports
prototype/            clickable HTML mockups + PNG       api/              OpenAPI contract + examples
src/                  application code by component (see src/README.md)
tests/                acceptance scenarios, test plan structure (see tests/README.md)
config/               .env.example with placeholders
project-management/   YouTrack backlog import
.github/              pull request template, issue template, CODEOWNERS
```

## Current status

| Area | Status |
|---|---|
| Analysis and design (proposal, evidence, literature, comparisons, requirements, architecture, prototype, verification plan, plan and risks) | Complete for pre-defense 1, under review |
| User interviews | Guide, consent and note template in [`docs/research/`](docs/research/); the notes of interviews I-01 … I-03 are kept outside the public repository, as promised in the consent text; the supervisor and the committee can see them on request (task YG-3) |
| Implementation | Starts in sprint S1 (27 Oct – 9 Nov 2026): skeleton, CI, data model, authentication, PWA shell |
| Setup, run and test instructions | Added together with the first runnable code (task YG-14) |

## Contributing

Branch per YouTrack task (`YG-29-assessment-engine`), commit messages `YG-29: <what changed>`, pull request reviewed by the other team member before merge to `main`. Pre-defense submissions are tagged. Details: [CONTRIBUTING.md](CONTRIBUTING.md).
