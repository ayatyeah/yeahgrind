# 5. Technology Comparison

Thirteen key technical decisions are compared, each with three alternatives (four for authentication). Criteria are derived from the requirements; every version number and price was checked on an official page on **21 October 2026** (references [T1]–[T116] at the end; [T117]–[T127] on 22–23 October 2026). Each decision is also recorded as a short Architecture Decision Record in [`docs/adr/`](adr/).

## 5.1 Method

### Requirement drivers

| Driver | Meaning | Requirements |
|---|---|---|
| R1 | Two-person team, ~7 months, **one shared language (TypeScript)** | constraint (01 §1.10), NFR-10 |
| R2 | Idempotent answers, mastery updates and rewards; no double-spend | FR-27, FR-37, NFR-07 |
| R3 | Privacy: secrets on the server, minimal data to AI providers, no training on user data, export and deletion | FR-03, FR-04, NFR-06 |
| R4 | Mobile performance of the PWA and video delivery | NFR-09, NFR-10 |
| R5 | Small budget; pilot load of tens to a few hundred users | NFR-01, NFR-13 |
| R6 | E-mail + password and Microsoft Entra ID SSO restricted to the university tenant | FR-01, FR-02 |
| R7 | Background and scheduled work: video rendering, generation, LMS refresh 3×/day, reminders | FR-17, FR-20, FR-39 |
| R8 | JSON-schema output for skill maps, units, scripts and questions; rubric grading; image input for timetable import | FR-08, FR-09, FR-18, FR-21, FR-25, FR-28 |
| R9 | Transparent "why this unit" recommendations from day one | FR-11, FR-13 |
| R10 | 60–120 s videos per micro-unit in English, Russian and Kazakh, under a monthly cost cap | FR-19 – FR-23, NFR-03, NFR-13 |
| R11 | Adaptive assessment: next item in a target success band, mastery per skill, no calibration data at launch | FR-25 – FR-30, NFR-02 |

### Scoring

- Weights per decision sum to 100 %.
- Scores run from 1 to 5:
  - 5 meets the requirement with no extra work;
  - 4 meets it with minor work;
  - 3 meets it with notable effort or a trade-off;
  - 2 meets it only partly;
  - 1 does not meet it.
- Weighted total = Σ(weight × score) / 100, with a maximum of 5.00. Totals were computed with a script. ✅ marks the chosen option.
- **Release-1 choices.** Where the team deliberately starts with a simpler option than the top-scoring one, the summary shows both the release-1 choice and the target, and the decision names the condition for switching (D6, D10–D12). The release-1 reason is always one of three: an integration the team has already tested, no paid subscription during development, or a scale at which a second system adds more work than it saves. Team readiness is deliberately kept out of the weighted criteria, so that it does not change the comparison of the technologies themselves.

### Summary

| # | Decision | ✅ Chosen (score) | Alternative (score) | Alternative (score) |
|---|---|---|---|---|
| D1 | Application platform | **Next.js 16 (App Router) — 4.60** | NestJS 12 API + React/Vite SPA — 3.70 | Django 6.1 + DRF + React — 3.30 |
| D2 | Primary data storage | **PostgreSQL 18 — 4.80** | MongoDB — 3.50 | Cloud Firestore — 2.50 |
| D3 | Data access layer | **Prisma ORM 7 — 4.30** | Drizzle ORM — 4.25 | Raw SQL (node-postgres) — 3.55 |
| D4 | Component interaction / API style | **REST + OpenAPI — 4.70** | tRPC — 3.45 | GraphQL — 3.05 |
| D5 | LLM provider | **OpenAI API behind an adapter — 4.70** | Anthropic Claude API — 4.45 (fallback) | Self-hosted Qwen3-VL-8B — 3.00 |
| D6 | Authentication | **Auth.js v5 — 4.25** (kept for release 1: tested AITU Entra ID integration) | Better Auth — 4.70 (migration target) | Keycloak 26 — 4.10; Clerk — 3.85 |
| D7 | Hosting / deployment | **Railway — 4.40** | Vercel — 3.65 | VPS + Docker Compose — 3.60 |
| D8 | Pathway / recommendation approach | **Rule-based weighted scoring — 4.70** | Contextual bandit — 2.85 | Collaborative filtering (MF) — 2.00 |
| D9 | Short-form video generation | **Client-side rendering (canvas + MediaRecorder) — 4.60** | Server template pipeline + FFmpeg — 4.45 (upgrade path) | Remotion — 4.35 |
| D10 | Text-to-speech | **Gemini TTS behind an adapter — 4.05** (release 1: working key, no cloud subscription) | Azure AI Speech — 4.70 (target before the pilot) | ElevenLabs — 3.55 |
| D11 | Media storage | **PostgreSQL `bytea` for narration audio — 3.80** (release 1: ≈1.3 GB, one system) | S3-compatible object storage (R2) — 4.55 (target as media grow) | Volume on app host — 3.20 |
| D12 | Background jobs | **In-process jobs with a database claim + GitHub Actions schedules — 4.20** (release 1) | pg-boss on a worker service — 4.35 (target) | BullMQ + Redis — 3.70 |
| D13 | Adaptive assessment model | **Elo-style rating per (learner, skill) and item — 4.70** | BKT per skill — 3.90 | IRT-based CAT — 3.05 |

---

## D1. Application platform / server framework

**Facts.**
- **Next.js 16** is the current major version; release 16.4 came out on 6 Oct 2026 and npm `latest` is 16.4.2 [T1, T2].
- Route Handlers (`route.ts`) implement GET/POST/PUT/PATCH/DELETE over Web `Request`/`Response` and are not cached by default [T3]. One codebase therefore serves both the UI and the REST API.
- NestJS runs on Express by default, with Fastify as an option; the current major is v12 [T4, T5]. Vite is at 8.3.5 [T8].
- Django 6.1.2 is the latest release (5.2 LTS until April 2028), and DRF is at 3.18.3 [T6, T7]. This stack means a second language next to the TypeScript frontend.

| Criterion | W | ✅ Next.js 16 | NestJS 12 + Vite SPA | Django 6.1 + DRF + React |
|---|---|---|---|---|
| Single-language TypeScript fit (R1) | 20 % | **5** one repo, shared types and validation schemas | **4** TypeScript on both sides, but two projects | **1** Python + TypeScript, two toolchains |
| Delivery speed for 2 people in 7 months (R1) | 20 % | **5** pages, API and auth in one app; one build and deploy | **3** DI boilerplate, CORS, two builds and deploys | **3** productive backend, but separate SPA integration |
| Mobile performance / PWA (R4) | 15 % | **5** server rendering and Server Components cut client JS | **3** client-only SPA | **3** same SPA trade-off |
| Structure for domain logic and jobs (R2, R7) | 15 % | **3** no built-in DI; needs a disciplined module layer and a separate worker process | **5** modules, DI, guards, scheduler | **5** mature ORM, `atomic()`, admin |
| Security defaults and auth integration (R3, R6) | 10 % | **4** secrets stay server-side; explicit checks needed in handlers | **4** guards; CORS/CSRF are ours | **5** mature built-ins |
| Hosting simplicity and cost (R5) | 10 % | **5** one Node service | **3** two services | **3** two runtimes |
| Ecosystem maturity | 10 % | **5** | **4** | **5** |
| **Weighted total** | 100 % | **4.60** | 3.70 | 3.30 |

**Decision.** Next.js 16 with TypeScript (strict). One language and one deployable unit fit a two-person team and mobile-first rendering best. To make up for the weaker backend structure, the design uses an explicit domain-module layer ([07 §7.1](07-architecture.md#71-architectural-style)) and a separate worker process for jobs (D12).

## D2. Primary data storage

**Facts.**
- **PostgreSQL 18** is the current stable major (18.6, 13 Aug 2026); version 19 is only at RC 1 [T9].
- Serializable isolation (SSI) makes conflicting transactions fail with SQLSTATE 40001 so they can be retried [T10].
- `jsonb` with GIN indexes is "the preferred choice for most applications" [T11].
- MongoDB supports multi-document ACID transactions, but its manual warns that they "should not be a replacement for effective schema design" [T12]. Prisma 7 does not support MongoDB [T69].
- Firestore bills per document operation [T14]; its transaction functions "may run more than once" and fail when offline [T15].

| Criterion | W | ✅ PostgreSQL 18 | MongoDB | Cloud Firestore |
|---|---|---|---|---|
| Transactional integrity for rewards and purchases (R2) | 25 % | **5** ACID, SSI, UNIQUE and CHECK constraints, foreign keys | **3** transactions exist but are discouraged as a design basis; no FKs | **2** optimistic re-run transactions; no unique constraints or FKs |
| Fit to a relational domain: users, tasks, quests, ledger, teams (R2) | 20 % | **5** normalized schema with joins | **3** embedding / `$lookup`; integrity in app code | **2** no joins; denormalisation |
| Flexibility for AI-generated JSON (R8) | 10 % | **4** `jsonb` + GIN | **5** | **5** |
| TypeScript ORM ecosystem (R1) | 10 % | **5** Prisma, Drizzle, `pg` | **3** no Prisma 7, no Drizzle [T69, T70] | **2** vendor SDK only |
| Cost at pilot scale (R5) | 10 % | **4** small container + volume | **5** free tier | **5** free daily quota |
| Lock-in / portability (R3) | 10 % | **5** open source, standard SQL | **4** | **1** proprietary |
| Analytics queries, export, cascade deletion (R3) | 15 % | **5** SQL aggregates, `ON DELETE CASCADE` | **3** | **2** manual erasure across collections |
| **Weighted total** | 100 % | **4.80** | 3.50 | 2.50 |

**Decision.** PostgreSQL 18. Exactly-once rewards and no double-spend need database-level constraints and serializable transactions. `jsonb` is used only for content that genuinely has no fixed schema (quest content, rubric, import drafts).

## D3. Data access layer

**Facts.**
- **Prisma ORM 7** has a Rust-free TypeScript client and `prisma.config.ts`. The current release is 7.10.1, and interactive transactions accept `isolationLevel: Serializable` [T16, T18, T19].
- **Release churn:** Prisma 8 is a release candidate, and `npm install prisma` already installs the Prisma 8 CLI, which does not read `schema.prisma`. Projects must therefore pin `prisma@7`. Prisma 6 security patches end on 19 Nov 2026 [T17].
- Drizzle ORM stable is 0.45.4 (1.0 is in beta), and its transactions support isolation levels and savepoints [T20, T21].
- `pg` 8.23.1 has no transaction abstraction: BEGIN/COMMIT must be issued on one pooled client [T22, T23].

| Criterion | W | ✅ Prisma ORM 7 | Drizzle ORM 0.45 | Raw SQL (`pg`) |
|---|---|---|---|---|
| Type safety and developer experience (R1) | 20 % | **5** generated client from declarative schema | **5** TypeScript schema, inferred types | **2** hand-written types |
| Transactions and concurrency (R2) | 20 % | **4** Serializable interactive transactions; raw SQL for row locks | **5** close to SQL | **5** full control, all manual |
| Migrations and schema management | 15 % | **5** `prisma migrate` | **4** `drizzle-kit` | **2** separate tool needed |
| Learning curve for two people (R1) | 15 % | **5** | **4** assumes strong SQL | **3** |
| Release stability for 7 months | 15 % | **3** 6→7→8 within a year; pin v7 | **3** still 0.x | **5** stable for years |
| SQL control for analytics queries | 10 % | **3** typed raw SQL as escape hatch | **4** | **5** |
| Integration with auth adapters and tooling | 5 % | **5** Auth.js and Better Auth Prisma adapters [T54], Prisma Studio | **4** | **3** |
| **Weighted total** | 100 % | **4.30** | 4.25 | 3.55 |

**Decision.** Prisma ORM 7, pinned to `prisma@7` / `@prisma/client@7`. The team's previous coursework used Prisma 6; the starter schema is upgraded to Prisma 7 in sprint S1 (task YG-15), before Prisma 6 security support ends on 19 November 2026. The 0.05 margin over Drizzle is within scoring noise. Prisma wins on migrations and onboarding. The reward and purchase hot paths are written as explicit Serializable transactions with retry on 40001.

## D4. Component interaction / API style

**Facts.**
- The current OpenAPI Specification is v3.2.1 (10 Sep 2026) [T24], and Route Handlers implement REST natively [T3].
- tRPC works "without schemas or code generation" for full-stack TypeScript, so non-TypeScript consumers get no contract [T25, T26].
- GraphQL guidance warns about N+1 queries, POST-only caching (persisted queries are needed) and the need for depth/complexity limits [T27].

| Criterion | W | ✅ REST + OpenAPI | GraphQL | tRPC |
|---|---|---|---|---|
| Fit with Route Handlers, no extra runtime (R1, R5) | 15 % | **5** | **3** | **4** |
| End-to-end type safety (R1) | 15 % | **3** shared Zod schemas, generated types | **4** | **5** |
| Documented contract for testers, reviewers, committee | 15 % | **5** `api/openapi.yaml` | **4** | **2** |
| HTTP caching and debuggability (R4) | 10 % | **5** | **2** | **3** |
| Per-endpoint authorization, rate limits, idempotency keys (R2, R3) | 15 % | **5** | **2** | **4** |
| Interoperability with non-TS clients (future native app, exports) | 15 % | **5** | **4** | **2** |
| Learning curve and effort (R1) | 15 % | **5** | **2** | **4** |
| **Weighted total** | 100 % | **4.70** | 3.05 | 3.45 |

**Decision.** REST over Next.js Route Handlers, described in OpenAPI ([`api/openapi.yaml`](../api/openapi.yaml)), with request/response schemas defined once in Zod and reused for validation and documentation. The `Idempotency-Key` header is used on reward-bearing and import endpoints.

## D5. LLM provider for content generation, video scripts, questions and grading

**Facts.** Small current models were compared:

| Capability | OpenAI (gpt-6-luna) | Anthropic (Claude Haiku 5.5) | Self-hosted Qwen3-VL-8B |
|---|---|---|---|
| Price per 1M tokens (input / output) | $0.10 / $0.50 [T28, T29] | $0.10 / $0.50 for prompts ≤ 100k tokens [T33] | GPU server, e.g. 24 GB VRAM at €214/month + €209 setup [T43] |
| Image input | Yes [T29, T31] | Yes [T34] | Yes [T39, T40] |
| JSON-schema structured output | Yes, `json_schema` with `strict: true` [T30] | Yes, GA constrained decoding [T35] | vLLM guided decoding / Ollama `format` [T41, T42] |
| Training on API data | No by default [T32] | No by default [T37] | Data stays on own server |
| Retention | Abuse logs up to 30 days; Responses state stored 30 days unless `store: false` [T32] | Not retained by default except for specific models; ≤ 30 days [T36, T38] | Own control |
| Note | — | Newer tokenizer produces ~30 % more tokens for the same text [T33] | 9B parameters in BF16 ≈ 18 GB of weights → 24 GB-class GPU [T39] |

**Cost estimate for the pilot.** 300 users × 3 AI calls/day × 30 days = 27,000 calls/month. At about 2,000 input and 400 output tokens per call, that is 54M input and 10.8M output tokens:
- OpenAI: ≈ USD 11/month.
- Anthropic: ≈ USD 14/month (same list price, but more tokens for the same text).
- Self-hosting: ≈ EUR 214/month fixed.

This is consistent with the NFR-11 cap of USD 0.30 per active user per month.

| Criterion | W | ✅ OpenAI | Claude | Self-hosted |
|---|---|---|---|---|
| Reliable JSON-schema output (R8) | 20 % | **5** | **5** | **4** |
| Image input for timetables (R8) | 15 % | **5** | **5** | **3** |
| Quality for content generation and rubric grading (R8) | 15 % | **4** verified on benchmark B2 | **4** | **3** |
| Cost at pilot scale (R5) | 15 % | **5** | **4** | **1** |
| Privacy: no training, minimal retention (R3) | 15 % | **4** with `store: false` | **4** | **5** |
| Operational effort for two people (R1) | 10 % | **5** | **5** | **1** |
| TypeScript SDK and ecosystem (R1) | 10 % | **5** | **4** | **3** |
| **Weighted total** | 100 % | **4.70** | 4.45 | 3.00 |

**Decision.** The OpenAI Responses API is called through a provider-neutral `LlmProvider` adapter, with the Claude API configured as a fallback ([ADR-0004](adr/0004-llm-provider-adapter.md)). The design accepts a third-party processor with up to 30 days of abuse-monitoring retention. In return it avoids the ~20× higher cost and the GPU operations of self-hosting. Calls are made only from the server, without names, e-mails or account IDs, and with `store: false`.

## D6. Authentication

**Facts.**
- Auth.js has a Microsoft Entra ID provider with a tenant-specific issuer [T44].
- The Auth.js project is now part of Better Auth, and its maintainers "strongly recommend new projects to start with Better Auth" [T46].
- `next-auth` v5 is still `5.0.0-beta.32` [T47], and the Auth.js Credentials provider leaves password hashing and rate limiting to the developer [T45].
- Better Auth 1.7.12 supports a Microsoft provider with `tenantId`, built-in e-mail + password and a Prisma adapter [T53 – T55].
- Clerk's Microsoft connection uses the `common` audience; restricting it to one tenant requires SAML on the USD 25/month Pro plan [T48, T49].
- Keycloak 26.8.1 brokers OIDC and SAML but needs a separate JVM service with ≥ 750 MB of memory [T50 – T52].

| Criterion | W | Better Auth 1.7 | ✅ Auth.js v5 | Keycloak 26 | Clerk |
|---|---|---|---|---|---|
| Entra ID restricted to the university tenant (R6) | 20 % | **5** `tenantId` | **5** tenant issuer | **5** | **3** SAML on Pro only |
| E-mail + password with users in own DB (R2, R3) | 15 % | **5** built in | **3** hashing, reset, rate limits are ours | **5** | **5** |
| Cost at pilot scale (R5) | 15 % | **5** | **5** | **3** extra container | **3** |
| Privacy, data ownership, lock-in (R3) | 15 % | **5** in own PostgreSQL | **5** | **5** | **2** third-party SaaS |
| Integration effort with Next.js + Prisma (R1) | 15 % | **4** adapter and schema generation; younger project | **5** | **2** separate service | **5** |
| Maintenance status and maturity | 15 % | **4** very active, younger | **2** beta, maintenance only | **5** | **5** |
| Operational effort (R1) | 5 % | **5** library | **5** library | **2** JVM service | **5** SaaS |
| **Weighted total** | 100 % | **4.70** | 4.25 | 4.10 | 3.85 |

**Decision.** Auth.js v5 with the Microsoft Entra ID provider restricted to the university tenant (tenant-specific issuer), the Credentials provider with bcrypt hashing and rate limiting, and the Prisma adapter. On library criteria Better Auth scores higher (4.70 vs 4.25). For release 1 the team keeps Auth.js because it already has a tested Auth.js integration with the AITU Entra ID tenant from previous coursework, and sign-in is the main delivery risk of sprints S1–S2. The maintenance-only status of Auth.js is handled by pinning the exact version and isolating authentication in one `auth/` module. Better Auth is the planned migration target and is reassessed at milestone M6 ([ADR-0006](adr/0006-authentication.md)).

## D7. Hosting and deployment

**Facts.**

Railway [T56 – T60]:
- Plans: Hobby USD 5/month (includes USD 5 of usage), Pro USD 20/month. Usage costs about USD 10 per GB of RAM-month and USD 0.15 per GB-month of volume.
- Cron services can run as often as every 5 minutes.
- The PostgreSQL template is private by default, with daily, weekly or monthly backups.

Vercel [T61 – T64]:
- Hobby cron jobs run at most once per day, so more frequent expressions fail at deployment.
- Functions run for at most 300 s on Hobby.
- "Vercel Postgres is no longer available"; the database must come from a marketplace partner.

VPS [T65, T66]:
- Hetzner from EUR 6.49/month, DigitalOcean from USD 6/month.
- Database, TLS, backups and patching are self-managed.

| Criterion | W | ✅ Railway | Vercel | VPS + Docker Compose |
|---|---|---|---|---|
| Managed PostgreSQL on the same platform (R2) | 20 % | **4** | **3** external vendor | **2** self-managed |
| Background and scheduled jobs: generation, LMS 3×/day, reminders (R7) | 20 % | **5** long-lived Node service; worker service possible; cron ≥ 5 min | **3** Hobby: daily only; no persistent process | **5** |
| Cost at pilot scale (R5) | 15 % | **4** ≈ USD 10–15/month | **3** Pro USD 20 + DB vendor | **5** |
| Operations burden for two people (R1) | 20 % | **5** git-push deploys, TLS, logs | **5** | **2** |
| Next.js support (R4) | 10 % | **4** long-lived Node server | **5** | **4** |
| Lock-in / portability (R3) | 10 % | **4** standard container + Postgres | **3** | **5** |
| Security of secrets and DB exposure (R3) | 5 % | **4** private DB | **4** | **3** |
| **Weighted total** | 100 % | **4.40** | 3.65 | 3.60 |

**Decision.** Railway: a web service and PostgreSQL in one private project. The web service is a long-lived Node process, so background jobs can continue after a response (D12); schedules for the three LMS refreshes a day and reminders come from GitHub Actions, and a worker service is added when jobs move to pg-boss. Vercel Hobby limits functions to 300 s and cron to once a day. The cost is slightly higher than a bare VPS, and there is no global edge network, but the team does not have to operate servers.

## D8. Pathway recommendation approach

**Facts.**
- Collaborative filtering "suffers from what is called the cold start problem" with new users and items, and its latent factors can be uninterpretable (Koren et al., 2009) [T67].
- Contextual bandits handle changing content, but the reference evaluation used more than 33 million events (Li et al., 2010) [T68], far beyond a pilot's data.

| Criterion | W | ✅ Rule-based weighted scoring | Collaborative filtering (MF) | Contextual bandit |
|---|---|---|---|---|
| Works from day one without history (R9) | 25 % | **5** | **1** textbook cold start | **3** exploratory at first |
| Explainability: "why this action?" (R9) | 20 % | **5** factor contributions shown | **2** latent factors | **3** exploration adds randomness |
| Data needs vs pilot size (R5) | 15 % | **5** none | **1** | **2** |
| Implementation and evaluation effort (R1) | 15 % | **5** pure, unit-testable function | **3** | **2** reward design, off-policy evaluation |
| Personalization over time | 10 % | **2** static weights, rule-based adaptation | **4** | **5** |
| Privacy and ethics (R3) | 10 % | **5** own data only, no random experiments on users | **2** cross-user data | **3** |
| Testability and determinism | 5 % | **5** | **3** | **2** |
| **Weighted total** | 100 % | **4.70** | 2.00 | 2.85 |

**Decision.** Transparent rule-based weighted scoring of eligible micro-units, with prerequisite gating, plan fitting and generated reasons ([07 §7.6](07-architecture.md#76-personalized-microlearning-pathway)). With consent, *(context, recommendation, accepted/completed)* events are logged from the start, so a contextual bandit can be evaluated offline as future work.

## D9. Short-form video generation approach

**Requirement (R10):** a 60–120 s explainer per micro-unit, generated from an LLM script, narrated in Russian, Kazakh or English, with a hard monthly cost cap. Videos are generated **once per micro-unit version and language**, then shared by everyone who studies that unit.

**Alternatives:**
- **(A) Client-side rendering:** the LLM returns a JSON script (scenes, on-screen text, and narration in which every sentence names the unit paragraph it comes from). TTS (D10) produces **one narration track**. The browser draws 9:16 slides on a `<canvas>` in sync with the audio, and the same drawing function records a video file with `MediaRecorder` when the learner downloads it. WebVTT captions are computed from the scene timings.
- **(B) Server template pipeline:** the same script and narration; server-side SVG templates are rasterized to frames, and FFmpeg composes frames and audio with burned-in subtitles.
- **(C) Remotion:** programmatic video rendering from React components.

*Excluded:* third-party AI avatar video APIs. HeyGen costs ≈$1–4 per video minute [T78] and Synthesia lists no Kazakh voice [T80][T81], i.e. ≈$450–1,350 for 300 videos of 90 s, with talking-head visuals that are hard to tie to diagrams and code.

**Facts.**

* **Browser APIs:**
  - `HTMLCanvasElement.captureStream()` returns a `MediaStream` with a real-time video capture of the canvas [T117].
  - `MediaRecorder` records such a stream [T118]. `MediaRecorder.isTypeSupported()` reports which container and codecs the browser can record, so the file is MP4 where supported and WebM otherwise [T119].
  - `AudioContext.createMediaStreamDestination()` turns the decoded narration into an audio track that is recorded together with the canvas [T120].
* **FFmpeg 9.0.2** was released on 18 Sep 2026 [T76]. Its `subtitles` filter draws subtitles with libass, requires a build with `--enable-libass`, and needs a `fontsdir` with fonts covering Kazakh Cyrillic letters (ә, ғ, қ, ң, ө, ұ, ү, һ, і) [T77]. It runs on a server, so every render needs a worker container and CPU time.
* **Remotion 4.0.537** was released on 19 Oct 2026 [T75]. It renders with **Chrome Headless Shell** [T116] via Node.js, AWS Lambda, Docker or a server [T74].
  - The Free License covers "an individual" and "a for-profit organization with up to 3 employees" [T71]; automated rendering otherwise costs "$0.01 per render, $100/mo minimum" [T72].
  - A 1-minute video costs about **$0.017–0.021** in Lambda compute [T73].

**Cost illustration** (100 micro-units × 3 languages = 300 videos × 90 s; TTS is extra, D10):
* **(A):** no rendering cost on the server; playback needs only the narration file (≈4 MB per video, D11). Recording a downloadable file takes about the video's length on the learner's device.
* **(B):** if a render takes ~60 vCPU-seconds, ≈$0.0005 per video at $0.00000772 per vCPU-second [T56], or ≈$0.15 for all 300, plus a worker service.
* **(C):** ≈$8–9 for all 300 on Lambda, plus an AWS account, or a heavier self-hosted headless browser.

| Criterion (requirement) | W | ✅ A: Client-side rendering | B: Server template pipeline + FFmpeg | C: Remotion |
|---|---|---|---|---|
| Russian/Kazakh/English narration and subtitles (R10) | 20% | **5** — narration from any TTS (D10); captions drawn with the device's system fonts, which cover Kazakh Cyrillic; WebVTT file | **5** — same TTS; libass subtitles with our own fonts | **5** — same TTS; subtitles rendered as React elements |
| Cost per video and cost cap (R5, R10) | 20% | **5** — no server rendering; only TTS is paid | **5** — CPU-only, ≈$0.15 for 300 videos (estimate) | **4** — ≈$8–9 per 300 videos on Lambda; Company License if the team grows past 3 |
| Pedagogical control: diagrams, code, formulas, timing tied to the script (R10) | 15% | **4** — template slides drawn on canvas; limited animation | **4** — template slides and diagrams; limited animation | **5** — any React/SVG animation with frame-exact timing |
| Implementation effort for 2 developers (R1) | 15% | **4** — standard web APIs (Canvas 2D, MediaRecorder, Web Audio) known to the frontend developer; one renderer for the player and the file | **3** — FFmpeg filter graphs, subtitle timing and font handling to learn | **4** — reuses React skills; Remotion APIs to learn |
| Rendering infrastructure and operations (R1, R7) | 10% | **5** — nothing to deploy: frames are rendered on the viewer's device | **4** — FFmpeg in a worker container | **3** — headless Chrome needs more RAM/CPU, or an AWS Lambda setup |
| Privacy and vendor lock-in (R3) | 10% | **5** — only the TTS provider sees the script; the renderer is our code | **5** — only the TTS provider sees the script; all assets are ours | **4** — self-hostable; depends on license terms (and on AWS if Lambda is used) |
| Accessibility and mobile delivery: subtitles, small files (R4) | 10% | **4** — captions on by default, searchable transcript, WebVTT; streams a small audio file instead of a video; the saved file is MP4 or WebM depending on the browser and takes real time to record | **5** — H.264 MP4 everywhere, burned-in subtitles and a WebVTT sidecar | **5** — same control as B |
| **Weighted total** | **100%** | **4.60** | 4.45 | 4.35 |

**Decision.** We choose **client-side rendering**: the server produces a validated script and one narration track (D10, D12), and the browser plays the slides in sync with the audio and records the same frames to a file on request. This removes server rendering, the worker container and video file storage, and the player and the downloaded file look the same. We accept browser-dependent containers (MP4 or WebM) and real-time recording for downloads. The server template pipeline (B) stays the upgrade path if videos must exist as server-side files, for example for previews outside the app.

## D10. Text-to-speech provider

**Critical criterion:** availability and quality of **Kazakh (kk-KZ)** and **Russian** voices. **Alternatives:** (A) **Gemini TTS** (Google AI); (B) **ElevenLabs**; (C) **Azure AI Speech**.

*Excluded:* **OpenAI TTS.** `tts-1`, `tts-1-hd` and the `gpt-4o-mini-tts` snapshots "will be removed from the API on January 6, 2027"; the replacement `gpt-realtime-2.1-mini` supports only the Realtime API, not `/v1/audio/speech` [T83][T84]. Its language support "generally follows the Whisper model", with voices optimized for English [T82].

**Facts.**

* **Gemini TTS:**
  - Gemini 3.8 Flash TTS offers "studio-grade voice fidelity, expressive acting, and regional dialects across 130 languages"; Gemini 3.8 Flash-Lite TTS is "fast, cost-efficient… across 101 languages"; the 2.5 and 3.1 TTS models remain available [T121].
  - A unary request returns complete WAV audio (24 kHz, mono, 16-bit PCM). A speaking style can be described in natural language, and a prebuilt voice is chosen by name [T122].
  - Free-tier requests are limited per model and day [T123]; on 22 Oct 2026 the limit for `gemini-3.8-flash-tts` was **10 requests per day**, and each model has its own quota. The paid tier is billed per audio output token [T125].
  - On unpaid services, Google may use submitted content to improve its products; on paid services, prompts and responses are not used for this [T124].
  - A test synthesis of a Russian and a Kazakh sentence on 22 Oct 2026 returned audio from both 3.8 models.
* **ElevenLabs:**
  - **Kazakh (`kk`) is available only in Eleven v4, v4 Turbo, v3 and v3 Conversational**, not in Multilingual v2 or Flash v2.5. Russian is in every model except Flash v2 [T85].
  - API price per 1K characters: **$0.08** for v3/v4, $0.04 for v4 Turbo and v3 Conversational [T86], i.e. **$40–80 per 1M characters** for Kazakh-capable models.
  - A commercial license starts at the **Starter plan ($6/month)** [T86][T87].
  - API history preservation is **on by default**. Zero Retention Mode is for **enterprise customers only**, and deleted items stay in backups for up to 30 days [T88].
* **Azure AI Speech:**
  - Dedicated Kazakh neural voices **`kk-KZ-AigulNeural`** (female) and **`kk-KZ-DauletNeural`** (male). Russian voices `ru-RU-SvetlanaNeural`, `ru-RU-DmitryNeural` and `ru-RU-DariyaNeural`, plus HD voices `ru-RU-Lev` / `ru-RU-Masha` (MAI-Voice-2) [T89].
  - The **Free (F0) tier gives 0.5M characters per month** [T90]. The retail price meter shows **$15 per 1M characters** for standard neural TTS and $22 per 1M for Neural HD (East US) [T91].
  - For prebuilt neural voices, "neither input text nor output audio content is stored in Microsoft logs" [T92]. It needs an Azure subscription and a Speech resource.

**Cost illustration** (300 narrations × ~1,500 characters for 90 s of speech, generated once per unit version and language):
* **Gemini:** one request per video, so the free tier allows about 10 narrations a day per model; the paid tier is billed per audio token.
* **Azure:** ≈450,000 characters fit within the 0.5M free characters per month (≈$6.75 if billed at $15/1M).
* **ElevenLabs v3:** ≈$36 plus a $6/month Starter plan.

| Criterion (requirement) | W | ✅ A: Gemini TTS | B: ElevenLabs | C: Azure AI Speech |
|---|---|---|---|---|
| **Kazakh (kk-KZ)** availability and quality (R10) | 25% | **4** — Kazakh synthesized in a test; multilingual prebuilt voices, no dedicated kk-KZ voice | **4** — Kazakh in v3/v4 models | **5** — two dedicated kk-KZ neural voices (female and male) |
| Russian and English quality (R10) | 10% | **5** — expressive voices with natural-language style control | **5** — strongest expressive voices in every current model | **4** — three ru-RU neural voices plus HD voices |
| Cost for the planned volume (R5) | 15% | **4** — free tier covers development and a slow pilot pace at one request per video; then per audio token | **3** — $40–80/1M characters for Kazakh-capable models, plus a plan fee for commercial use | **5** — 0.5M characters free per month, then $15/1M |
| API stability during the project (R1) | 15% | **4** — fast model turnover (3.1 preview is already legacy), but several TTS models run side by side and the adapter falls back between them | **4** — several current model generations | **5** — long-standing neural TTS service with stable locales |
| Privacy and data retention (R3) | 15% | **3** — free-tier content may be used to improve Google products; the paid tier excludes this [T124]; scripts hold course content only | **2** — request history kept by default; zero retention only for enterprise | **5** — real-time synthesis: text and audio not stored |
| Integration effort (R1) | 10% | **5** — one REST call with an API key returns WAV; no subscription or resource to provision | **4** — REST API and official SDK | **4** — REST/SDK, plus an Azure subscription and Speech resource to set up |
| Vendor consolidation (R1, R5) | 10% | **4** — one more vendor; the same key could also serve an LLM fallback (D5) | **3** — one more vendor and contract | **4** — Microsoft is already in the stack for Entra ID SSO (D6), but needs a separate Azure subscription |
| **Weighted total** | **100%** | 4.05 | 3.55 | **4.70** |

**Validation step built into the plan:** before the pilot, 5 native speakers rate 10 sample sentences per voice (1–5 naturalness) for Gemini Kazakh and Azure kk-KZ. If Gemini falls below 3.5/5, the adapter switches Kazakh to Azure. Kazakh narration stays switched off until this check is recorded (FR-23). Every video shows an "AI-generated voice" label.

**Decision.** For release 1 we use **Gemini TTS behind a `TtsProvider` adapter**, with one request per video and a fallback chain across Gemini TTS models, each with its own quota. Azure AI Speech scores higher (4.70) because of its dedicated kk-KZ voices and no storage of synthesis inputs; Gemini comes first because the team already has a working key and integration and needs no cloud subscription to start. Before the pilot, the paid tier is enabled so that content is not used for training, and the native-speaker test decides whether Kazakh moves to Azure kk-KZ voices.

## D11. Media storage for narration audio

**Alternatives:**
- **(A) PostgreSQL `bytea`:** the narration file and the script with timings in the video row.
- **(B) S3-compatible object storage:** Cloudflare R2, or Railway Storage Buckets, which use the same S3 API.
- **(C) Persistent volume on the app host** (Railway volume).

**Delivery requirement:** with client-side rendering (D9), the server stores and streams only the narration (WAV, 24 kHz mono 16-bit ≈ 48 KB/s) and the script; captions are computed from the timings. Seeking needs **HTTP range requests**, and Safari plays audio only with range responses.

**Facts.**

* **PostgreSQL:** TOAST limits any single field value to **1 GB** [T101]. `bytea` stores raw bytes in the table [T100], so audio sits in the database and in every database backup; it is deleted in the same transaction as its row.
* **Cloudflare R2:**
  - Pricing: **$0.015/GB-month**; Class A operations $4.50/M, Class B $0.36/M. The **free tier** is 10 GB-month, 1M Class A and 10M Class B requests per month. **Egress is free** [T93].
  - `GetObject` supports the **`Range`** header [T94]. **Presigned URLs** work for GET/PUT/HEAD/DELETE with up to 7 days' expiry [T95].
  - A custom domain enables **Cloudflare Cache** in front of a bucket. `r2.dev` URLs are rate-limited and "should only be used for development purposes" [T96].
* **Railway Storage Buckets:** "fully S3-compatible", **$0.015/GB-month**, bucket egress free; private only ("public buckets are currently not supported"), reachable **only via public networking**, with **no automatic backups or lifecycle rules** [T97][T98].
* **Railway volumes:** **0.5 GB on Free, 5 GB on Hobby, 50 GB on Pro**; "Each service can only have a single volume" and "Replicas cannot be used with volumes"; redeploys cause "a small amount of downtime" [T99]; about $0.15/GB-month [T56].

**Volume estimate:** 90 s of narration ≈ 4.3 MB, so 300 videos ≈ **1.3 GB** (a 90 s 720p H.264 video file would be ≈17 MB, ≈5 GB for 300).

| Criterion (requirement) | W | ✅ A: PostgreSQL `bytea` | B: S3-compatible object storage | C: Volume on app host |
|---|---|---|---|---|
| Cost per GB stored and delivered (R5) | 20% | **3** — ≈1.3 GB at volume-priced storage ($0.15/GB-month) plus backup copies; bytes leave through the service | **5** — $0.015/GB-month, free egress (R2 free tier covers the pilot) | **3** — $0.15/GB-month; service egress $0.05/GB |
| Streaming delivery: range requests, CDN (R4) | 20% | **3** — range responses from an authenticated route; every byte passes through Node, acceptable for ≈4 MB files | **5** — native `Range`; presigned URLs straight to the browser; CDN through a custom domain (R2) | **3** — served by our Node process; single instance; no CDN |
| Scalability and decoupling from the app server | 15% | **3** — database size and backup time grow ≈1.3 GB per 300 videos | **5** — stateless app; replicas and redeploys unaffected | **1** — the volume blocks replicas and causes redeploy downtime |
| Durability and backup | 10% | **4** — included in database backups | **3** — managed durable storage; no automatic backups on Railway Buckets (narration can be regenerated from stored scripts) | **3** — volume backups available; single node |
| Consistency with database metadata and erasure (R3) | 10% | **5** — deleted in the same transaction as the row, by cascade from the goal | **4** — DB row holds the object key; a deletion job removes both (eventually consistent) | **4** — same pattern as B |
| Implementation effort (R1) | 15% | **5** — no SDK, no CORS, no second system | **4** — AWS S3 SDK v3 plus presigner; CORS configuration | **5** — plain filesystem writes |
| Access control (R3) | 10% | **5** — served through an authenticated route that checks membership | **5** — private bucket, short-lived presigned URLs | **4** — served through the app; path-handling care needed |
| **Weighted total** | **100%** | 3.80 | **4.55** | 3.20 |

**Decision.** For release 1 we store narration in **PostgreSQL `bytea`**: one file and the script with timings per (unit, version, language), served by an authenticated route with range support and deleted together with the goal. Object storage scores higher (4.55) and becomes the target when stored media exceed about 5 GB, when server-side video files are added (D9 upgrade path) or when media must be served through a CDN; Railway Buckets are a drop-in alternative through the same S3 SDK. At ≈1.3 GB for the pilot, a second storage system would add more operations than it saves.

## D12. Background job processing (AI generation, narration, scheduled imports)

**Alternatives:**
- **(A) In-process jobs with a database claim:** the domain row is the job (for example, one video row per unit, version and language). Work starts in the web process right after the HTTP response; a conditional update claims the row, the job renews its claim between steps, and a job without a renewal for 10 minutes (for example, after a redeploy) is restarted by the next status request, with at most 3 attempts. Schedules (LMS refresh 3×/day, reminders) come from GitHub Actions calling authenticated endpoints.
- **(B) pg-boss** (queue stored in PostgreSQL) on a dedicated worker service.
- **(C) BullMQ + Redis.**

*Excluded:* **Railway cron-only polling**: runs must be ≥5 min apart, the job must exit, and an overlapping run is skipped [T58].

**Facts.**

* **Next.js `after()`** schedules work "to be executed after a response… is finished" [T126]. On Railway the web service is a long-lived Node process (D7), so such work runs to completion unless the process restarts.
* **GitHub Actions `schedule`** triggers workflows on a cron expression; the shortest interval is once every 5 minutes, and runs can be delayed during periods of high load [T127].
* **pg-boss 12.38.0** was released on 13 Oct 2026 [T105].
  - Its README states that it "relies on Postgres's SKIP LOCKED". It offers "automatic retries with exponential backoff", dead-letter queues, and "Cron and RRULE scheduling".
  - Jobs **can be created inside an existing database transaction**, with adapters for Prisma, Drizzle, Knex and Kysely. Requirements: Node 22.12+ and PostgreSQL 13+ [T102].
  - Queue policies include `singleton`, `stately` and `exclusive`; options include `retryLimit`, `retryBackoff`, `expireInSeconds` and `deadLetter` [T103]. `singletonKey` and `singletonSeconds` throttle or deduplicate per key [T104].
* **BullMQ 6.4.0** was released on 21 Oct 2026 [T109]. It is "built on top of Redis" and offers retries, per-worker concurrency, cron-repeatable jobs and parent–child flows [T106]. It "cannot work properly if Redis evicts keys arbitrarily": `maxmemory-policy noeviction` is required, and AOF persistence is recommended [T107]. Deduplication modes: simple, throttle, debounce [T108].
* **Railway Redis** "deploys a single node", from the `redis` image; HA is optional [T110]. That would be an extra always-on service billed for its RAM (~$10/GB-month [T56]).

| Criterion (requirement) | W | ✅ A: In-process jobs with a DB claim | B: pg-boss on a worker | C: BullMQ + Redis |
|---|---|---|---|---|
| Retries, backoff, dead letter (R7, R10) | 15% | **3** — attempt counter, at most 3 attempts with backoff, `failed` status; hand-written | **5** — built in | **5** — built in |
| Idempotency and deduplication; enqueue atomic with the domain write (R2) | 20% | **5** — the job is the domain row; a unique key per (unit, version, language); conditional-update claim | **5** — enqueue in the same Prisma transaction; `singletonKey` per (unit, language) | **3** — dedup modes exist, but Redis enqueue is not atomic with the PostgreSQL write (needs an outbox) |
| Concurrency limits: renders, LLM/TTS rate limits (R5) | 15% | **3** — per-user and global daily limits; no global concurrency cap | **4** — queue policies plus worker concurrency settings | **5** — per-worker concurrency and global rate limiter |
| Latency for user-triggered jobs (open-answer grading, video request) | 10% | **5** — starts right after the response | **4** — polling workers, seconds | **5** — push-based, milliseconds |
| Visibility and monitoring | 10% | **4** — status, attempts and errors are SQL rows | **4** — jobs are SQL rows, queryable from admin pages | **4** — metrics and telemetry guides, third-party dashboards |
| Extra infrastructure and cost (R5) | 20% | **5** — none; schedules run on GitHub Actions | **4** — a worker service, needed only for the queue once rendering moved to the browser (D9) | **2** — extra Redis service with `noeviction` + AOF configuration and its RAM cost |
| Learning curve and operations (R1) | 10% | **4** — no new library; the claim and renewal protocol needs tests | **4** — small API; SQL-inspectable | **3** — Redis operations plus BullMQ concepts |
| **Weighted total** | **100%** | 4.20 | **4.35** | 3.70 |

**Decision.** For release 1 we run **in-process jobs with a database claim**, and GitHub Actions schedules for the 3×/day Moodle refresh and reminders. After D9 moved rendering to the browser, the remaining jobs are short API calls (script, check, one narration request), so a separate worker adds little. pg-boss scores slightly higher (4.35) and becomes the target when server-side rendering returns (D9-B), when job types grow or when global concurrency limits are needed. We accept hand-written retries and a claim protocol that must be covered by tests.

## D13. Adaptive knowledge assessment model

**Alternatives:**
- **(A) Elo-style rating:** a learner ability θ per skill and a difficulty *d* per item, updated after every answer (Pelánek, 2016).
- **(B) IRT-based computerized adaptive testing (CAT):** 1PL/2PL item parameters calibrated offline, then maximum-information item selection.
- **(C) Bayesian Knowledge Tracing (BKT) per skill** (Corbett & Anderson): a two-state hidden Markov model with learning, guess and slip parameters.

*Excluded:* **deep knowledge tracing** (Piech et al., 2015), which uses recurrent neural networks [T115]. It needs large interaction logs to train, its estimates are not explainable to learners, and we have no training data at launch.

**Facts.**

* **Pelánek (2016)** [T111] treats each answer as "a match between the student and the item", so the system can "easily dynamically estimate the skill of students and difficulty of items". He concludes that Elo is "simple, robust, and effective". In the paper's formulation Elo is "closely related to the Rasch model (one parameter model) used in IRT… they differ only in the parameter estimation procedure". The paper further states:
  - IRT models "were… developed in the context of computerized adaptive testing and are typically based on the assumption of a constant skill".
  - Those models and BKT "may require calibration on large samples".
  - Elo "gives nearly the same estimates as joint maximum likelihood, which is a much more computationally demanding procedure (unsuitable for online updating of parameters)".
* **Corbett & Anderson** [T112] introduced knowledge tracing for estimating, per production rule (skill), the probability that a student has learned it. This is the basis of BKT.
* **Weiss & Kingsbury (1984)** [T113] describe CAT applications that "use item response theory to select test questions from an item pool". They report that adaptive mastery testing gives "more accurate mastery classifications than do conventional mastery tests, while using fewer test questions". This assumes a pre-calibrated item pool.
* **Klinkenberg, Straatemeier & van der Maas (2011)** [T114] present "a new item response model for on the fly ability and difficulty estimation" for computer adaptive maths practice. Pelánek describes this work as an extension of Elo applied "in an online system for adaptive practice of mathematics" [T111], which is evidence that the approach works in deployed practice systems.

| Criterion (requirement) | W | ✅ A: Elo-style rating | B: IRT-based CAT (1PL/2PL) | C: BKT per skill |
|---|---|---|---|---|
| Cold start: calibration data needed before launch (R11) | 25% | **5** — no prior calibration; item difficulties start at 0 and are learned online [T111] | **2** — item parameters must be calibrated on a sample before adaptive selection is valid [T111][T113] | **3** — four parameters per skill need fitting; literature defaults are possible at first |
| Per-skill mastery estimate that tracks learning (R11) | 20% | **4** — θ per skill follows learning through the K / uncertainty function; mastery = predicted P(correct) on a reference-difficulty item | **2** — assumes constant ability; suited to testing, not learning [T111] | **5** — explicit P(skill mastered), updated after each answer |
| Adaptive item selection (pick the next question in the target success band) | 15% | **5** — item difficulty available, so items can be chosen for ≈70–80% expected success | **5** — maximum-information selection, the strongest psychometrics | **3** — models skills, not items; needs a separate difficulty heuristic |
| Explainability to learners and teachers (FR-13) | 10% | **5** — "your rating rose because you solved a harder item"; one formula | **3** — logit-scale ability needs explanation | **4** — probability of mastery is intuitive; guess/slip less so |
| Compute cost and online updates (R5) | 10% | **5** — O(1) update per answer, no batch jobs [T111] | **3** — cheap per-answer ability update, but periodic calibration jobs | **4** — O(1) update; periodic refit |
| Ease of testing: deterministic unit tests, simulation (R1) | 10% | **5** — pure function; easy to test on simulated learners | **3** — estimation code plus calibration pipeline | **4** — small HMM update; fitting harder to test |
| Evidence in comparable systems | 10% | **4** — review plus case study [T111]; online maths-practice system [T114] | **5** — decades of CAT research [T113] | **5** — foundational tutoring-system model [T112] |
| **Weighted total** | **100%** | **4.70** | 3.05 | 3.90 |

**Design note:** LLM-graded free-text/code answers (D5) produce a graded score *s* ∈ [0, 1]. The Elo update θ ← θ + K·(s − P(correct)) accepts this directly. That is our design choice: the formula in [T111] is written for binary correctness. Answer logs (consented, FR-41) are stored so that a 1PL/2PL IRT calibration and a BKT fit can be evaluated after the pilot.

**Decision.** We choose an **Elo-style rating per (learner, skill) and per item**, because it needs no calibration data at launch, updates in constant time, and is easy to explain and test. We accept less psychometric rigour than a calibrated IRT-CAT and a less direct "mastery probability" than BKT, and plan both as post-pilot evaluations once enough answers are logged.

## 5.2 Supporting choices (not scored)

| Area | Choice | Reason |
|---|---|---|
| Validation | Zod schemas shared by client and server | One source for validation, types and OpenAPI generation |
| Styling and motion | Tailwind CSS + Framer Motion | Fast iteration; motion respects `prefers-reduced-motion` |
| 3D avatar | Three.js, lazy-loaded in its own bundle chunk, 2D fallback | Keeps other screens light (NFR-08) |
| Testing | Vitest, fast-check, Playwright, axe-core, k6, Lighthouse CI | Covers all verification levels in [09](09-verification-evaluation-plan.md) |
| Runtime | Node.js 24 LTS | Current long-term support line |

## 5.3 Risks found during the comparison

| Risk | Evidence | Mitigation |
|---|---|---|
| ORM major-version churn | `npm install prisma` installs the Prisma 8 CLI; Prisma 6 patches end on 19 Nov 2026 [T17] | Upgrade from Prisma 6 to 7 in S1 (YG-15) and pin it; plan the move to Prisma 8 after it is generally available |
| Authentication library in maintenance mode | Auth.js v5 is still a beta and upstream recommends Better Auth for new projects [T46, T47] | Pin the exact version; isolate auth in the `auth/` module; integration tests for both sign-in methods; reassess migration to Better Auth at M6 |
| Cron limits on serverless hosts | Vercel Hobby allows daily cron only [T62] | Long-lived web service on Railway; GitHub Actions schedules (≥5 min) calling idempotent endpoints [T127] |
| AI data retention | Responses state is kept for 30 days unless `store: false` [T32] | `store: false`; no personal data in prompts; provider adapter |
| TTS model retirement | OpenAI `tts-1`, `tts-1-hd` and `gpt-4o-mini-tts` are removed on 6 Jan 2027 [T83]; Gemini preview TTS models become legacy quickly [T121] | `TtsProvider` adapter with a fallback chain of Gemini models; Azure AI Speech as the target (D10) |
| Kazakh voice quality | Language lists and a test synthesis confirm Kazakh availability [T85, T89, T121], not quality | Native-speaker listening test before the pilot; Kazakh narration off until it passes; Azure kk-KZ voices as fallback |
| Video cost runaway | Avatar APIs cost ≈ USD 1–4 per video minute [T78] | Client-side rendering (D9); one video per (unit, version, language); per-user and global daily limits |
| TTS quota on the free tier | ≈10 requests per day per Gemini TTS model on the free tier [T123] | One request per video; fallback across models; paid tier before the pilot |
| AI provider uses content on the free tier | Unpaid Gemini services may use content to improve products [T124] | Scripts contain course content only, no personal data; paid tier before the pilot |
| Browser support for recording | Containers differ by browser [T119] | `isTypeSupported()` picks MP4 or WebM; in-app playback does not depend on recording |
| Job lost on redeploy | In-process work stops when the process restarts | Claim renewal; stale jobs restarted by the next status request; at most 3 attempts (D12) |
| Media on app volumes blocks scaling | Railway: "Replicas cannot be used with volumes" [T99] | Narration in PostgreSQL (D11), object storage as media grow; stateless web service |
| Redis eviction would break queues | BullMQ requires `maxmemory-policy noeviction` [T107] | pg-boss on PostgreSQL (D12) |

## References (accessed 21 October 2026)

**Platform.**
- [T1] Next.js Blog, https://nextjs.org/blog
- [T2] npm *next*, https://registry.npmjs.org/next
- [T3] Next.js Docs: Route Handlers, https://nextjs.org/docs/app/getting-started/route-handlers
- [T4] NestJS Docs, https://docs.nestjs.com/
- [T5] NestJS releases, https://github.com/nestjs/nest/releases
- [T6] Download Django, https://www.djangoproject.com/download/
- [T7] DRF releases, https://github.com/encode/django-rest-framework/releases
- [T8] npm *vite*, https://registry.npmjs.org/vite

**Storage.**
- [T9] PostgreSQL releases, https://www.postgresql.org/
- [T10] PostgreSQL 18 Docs §13.2 Transaction Isolation, https://www.postgresql.org/docs/current/transaction-iso.html
- [T11] PostgreSQL 18 Docs §8.14 JSON Types, https://www.postgresql.org/docs/current/datatype-json.html
- [T12] MongoDB Manual: Transactions, https://www.mongodb.com/docs/manual/core/transactions/
- [T13] MongoDB Atlas Pricing, https://www.mongodb.com/pricing
- [T14] Cloud Firestore pricing, https://firebase.google.com/docs/firestore/pricing
- [T15] Firestore transactions, https://firebase.google.com/docs/firestore/manage-data/transactions

**Data access.**
- [T16] Announcing Prisma ORM 7.0.0, https://www.prisma.io/blog/announcing-prisma-orm-7-0-0
- [T17] Prisma ORM release status, https://www.prisma.io/docs/orm/release-status
- [T18] Prisma v7 Transactions, https://www.prisma.io/docs/orm/v7/prisma-client/queries/transactions
- [T19] Prisma releases, https://github.com/prisma/prisma/releases
- [T20] Drizzle Transactions, https://orm.drizzle.team/docs/transactions
- [T21] npm *drizzle-orm*, https://registry.npmjs.org/drizzle-orm
- [T22] node-postgres Transactions, https://node-postgres.com/features/transactions
- [T23] npm *pg*, https://registry.npmjs.org/pg

**API style.**
- [T24] OpenAPI Specification v3.2.1, https://spec.openapis.org/oas/latest.html
- [T25] tRPC Docs, https://trpc.io/docs
- [T26] npm *@trpc/server*, https://registry.npmjs.org/@trpc/server
- [T27] GraphQL Performance, https://graphql.org/learn/performance/

**LLM.**
- [T28] OpenAI API Pricing, https://developers.openai.com/api/docs/pricing
- [T29] OpenAI model page, https://developers.openai.com/api/docs/models/gpt-6-luna
- [T30] OpenAI Structured Outputs, https://developers.openai.com/api/docs/guides/structured-outputs
- [T31] OpenAI Images and vision, https://developers.openai.com/api/docs/guides/images-vision
- [T32] OpenAI Data controls, https://developers.openai.com/api/docs/guides/your-data
- [T33] Claude pricing, https://platform.claude.com/docs/en/about-claude/pricing
- [T34] Claude models overview, https://platform.claude.com/docs/en/about-claude/models/overview
- [T35] Claude structured outputs, https://platform.claude.com/docs/en/build-with-claude/structured-outputs
- [T36] Claude API and data retention, https://platform.claude.com/docs/en/manage-claude/api-and-data-retention
- [T37] Anthropic: Is my data used for model training?, https://privacy.claude.com/en/articles/7996868-is-my-data-used-for-training
- [T38] Anthropic: How long do you store my organization's data?, https://privacy.claude.com/en/articles/7996866-how-long-do-you-store-my-organization-s-data
- [T39] Qwen3-VL-8B-Instruct model card, https://huggingface.co/Qwen/Qwen3-VL-8B-Instruct
- [T40] Ollama qwen3-vl, https://ollama.com/library/qwen3-vl
- [T41] Ollama structured outputs, https://docs.ollama.com/capabilities/structured-outputs
- [T42] vLLM structured outputs, https://docs.vllm.ai/en/latest/features/structured_outputs.html
- [T43] Hetzner GPU server, https://www.hetzner.com/dedicated-rootserver/gex44/

**Authentication.**
- [T44] Auth.js Microsoft Entra ID provider, https://authjs.dev/getting-started/providers/microsoft-entra-id
- [T45] Auth.js Credentials, https://authjs.dev/getting-started/authentication/credentials
- [T46] Auth.js is now part of Better Auth, https://better-auth.com/blog/authjs-joins-better-auth
- [T47] npm *next-auth*, https://registry.npmjs.org/next-auth
- [T48] Clerk pricing, https://clerk.com/pricing
- [T49] Clerk Microsoft connection, https://clerk.com/docs/authentication/social-connections/microsoft
- [T50] Keycloak downloads, https://www.keycloak.org/downloads
- [T51] Keycloak Server Administration Guide, https://www.keycloak.org/docs/latest/server_admin/index.html
- [T52] Keycloak in containers, https://www.keycloak.org/server/containers
- [T53] Better Auth Microsoft, https://better-auth.com/docs/authentication/microsoft
- [T54] Better Auth Prisma adapter, https://better-auth.com/docs/adapters/prisma
- [T55] npm *better-auth*, https://registry.npmjs.org/better-auth

**Hosting.**
- [T56] Railway pricing, https://railway.com/pricing
- [T57] Railway plans, https://docs.railway.com/reference/pricing/plans
- [T58] Railway cron jobs, https://docs.railway.com/reference/cron-jobs
- [T59] Railway PostgreSQL, https://docs.railway.com/databases/postgresql
- [T60] Railway backups, https://docs.railway.com/reference/backups
- [T61] Vercel pricing, https://vercel.com/pricing
- [T62] Vercel cron usage and pricing, https://vercel.com/docs/cron-jobs/usage-and-pricing
- [T63] Vercel Functions limits, https://vercel.com/docs/functions/limitations
- [T64] Postgres on Vercel, https://vercel.com/docs/postgres
- [T65] Hetzner Cloud CPX, https://www.hetzner.com/cloud/regular-performance/
- [T66] DigitalOcean Droplet pricing, https://www.digitalocean.com/pricing/droplets

**Recommendation.**
- [T67] Koren, Y., Bell, R., & Volinsky, C. (2009). Matrix factorization techniques for recommender systems. *Computer, 42*(8), 30–37. https://doi.org/10.1109/MC.2009.263
- [T68] Li, L., Chu, W., Langford, J., & Schapire, R. E. (2010). A contextual-bandit approach to personalized news article recommendation. *WWW '10*, 661–670. https://doi.org/10.1145/1772690.1772758

**MongoDB support in ORMs.**
- [T69] Upgrade to Prisma ORM 7, https://www.prisma.io/docs/guides/upgrade-prisma-orm/v7
- [T70] Drizzle overview, https://orm.drizzle.team/docs/overview

**Short-form video generation (D9)**

- [T71] Remotion. *LICENSE.md* (Free License eligibility; Company License). https://github.com/remotion-dev/remotion/blob/main/LICENSE.md
- [T72] Remotion. *Remotion Company License pricing*. https://www.remotion.pro/license
- [T73] Remotion. *Lambda: cost examples*. https://www.remotion.dev/docs/lambda/cost-example
- [T74] Remotion. *Server-side rendering*. https://www.remotion.dev/docs/ssr
- [T75] npm registry. *remotion* (latest 4.0.537). https://registry.npmjs.org/remotion
- [T76] FFmpeg. *Download* (FFmpeg 9.0.2, 18 Sep 2026). https://ffmpeg.org/download.html
- [T77] FFmpeg. *FFmpeg Filters Documentation: subtitles*. https://ffmpeg.org/ffmpeg-filters.html#subtitles-1
- [T78] HeyGen. *AI Video Generator Pricing Compared (2026): Cost Per Minute* (last updated 20 Oct 2026). https://www.heygen.com/blog/ai-video-generator-pricing
- [T80] Synthesia. *Pricing*. https://www.synthesia.io/pricing
- [T81] Synthesia Help Center. *Synthesia stock voices*. https://help.synthesia.io/en/articles/7194908-synthesia-stock-voices

**Text-to-speech (D10)**

- [T82] OpenAI. *Text to speech guide*. https://developers.openai.com/api/docs/guides/text-to-speech
- [T83] OpenAI. *Deprecations* (2026-10-01: Text-to-speech models). https://developers.openai.com/api/docs/deprecations
- [T84] OpenAI. *Model: gpt-realtime-2.1-mini*. https://developers.openai.com/api/docs/models/gpt-realtime-2.1-mini
- [T85] ElevenLabs. *Models* (language support per model). https://elevenlabs.io/docs/overview/models
- [T86] ElevenLabs. *API pricing*. https://elevenlabs.io/pricing/api
- [T87] ElevenLabs. *Pricing* (plans and commercial licence). https://elevenlabs.io/pricing
- [T88] ElevenLabs. *Zero Retention Mode (Enterprise)*. https://elevenlabs.io/docs/eleven-api/resources/zero-retention-mode
- [T89] Microsoft Learn. *Language and voice support for the Speech service* (text to speech). https://learn.microsoft.com/en-us/azure/ai-services/speech-service/language-support?tabs=tts
- [T90] Microsoft Azure. *Azure AI Speech pricing*. https://azure.microsoft.com/en-us/pricing/details/cognitive-services/speech-services/
- [T91] Microsoft. *Azure Retail Prices API* (Azure Speech meters "S1 Neural Text To Speech Characters", "Neural HD Text to Speech Characters", East US). https://prices.azure.com/api/retail/prices
- [T92] Microsoft Learn. *Data, privacy, and security for text to speech*. https://learn.microsoft.com/en-us/azure/ai-foundry/responsible-ai/speech-service/text-to-speech/data-privacy-security

**Media storage (D11)**

- [T93] Cloudflare. *R2 pricing*. https://developers.cloudflare.com/r2/pricing/
- [T94] Cloudflare. *R2: S3 API compatibility*. https://developers.cloudflare.com/r2/api/s3/api/
- [T95] Cloudflare. *R2: Presigned URLs*. https://developers.cloudflare.com/r2/api/s3/presigned-urls/
- [T96] Cloudflare. *R2: Public buckets*. https://developers.cloudflare.com/r2/buckets/public-buckets/
- [T97] Railway Docs. *Storage Buckets*. https://docs.railway.com/storage-buckets
- [T98] Railway Docs. *Storage Buckets: Billing*. https://docs.railway.com/storage-buckets/billing
- [T99] Railway Docs. *Volumes*. https://docs.railway.com/reference/volumes
- [T100] PostgreSQL 18 Documentation. *Binary Data Types*. https://www.postgresql.org/docs/current/datatype-binary.html
- [T101] PostgreSQL 18 Documentation. *TOAST*. https://www.postgresql.org/docs/current/storage-toast.html

**Background jobs (D12)**

- [T102] pg-boss (GitHub repository timgit/pg-boss). *README*. https://github.com/timgit/pg-boss
- [T103] pg-boss. *API: Queues* (policies and options). https://pgboss.io/api/queues
- [T104] pg-boss. *API: Jobs* (singletonKey, throttling, debouncing). https://pgboss.io/api/jobs
- [T105] npm registry. *pg-boss* (latest 12.38.0). https://registry.npmjs.org/pg-boss
- [T106] BullMQ. *What is BullMQ*. https://docs.bullmq.io/
- [T107] BullMQ. *Going to production*. https://docs.bullmq.io/guide/going-to-production
- [T108] BullMQ. *Deduplication*. https://docs.bullmq.io/guide/jobs/deduplication
- [T109] npm registry. *bullmq* (latest 6.4.0). https://registry.npmjs.org/bullmq
- [T110] Railway Docs. *Redis*. https://docs.railway.com/databases/redis

**Adaptive assessment (D13)**

- [T111] Pelánek, R. (2016). Applications of the Elo rating system in adaptive educational systems. *Computers & Education*, 98, 169–179. https://doi.org/10.1016/j.compedu.2016.03.017 (accepted manuscript: https://www.fi.muni.cz/~xpelanek/publications/CAE-elo.pdf)
- [T112] Corbett, A. T., & Anderson, J. R. (1995). Knowledge tracing: Modeling the acquisition of procedural knowledge. *User Modeling and User-Adapted Interaction*, 4(4), 253–278. https://doi.org/10.1007/BF01099821
- [T113] Weiss, D. J., & Kingsbury, G. G. (1984). Application of computerized adaptive testing to educational problems. *Journal of Educational Measurement*, 21(4), 361–375. https://doi.org/10.1111/j.1745-3984.1984.tb01040.x
- [T114] Klinkenberg, S., Straatemeier, M., & van der Maas, H. L. J. (2011). Computer adaptive practice of Maths ability using a new item response model for on the fly ability and difficulty estimation. *Computers & Education*, 57(2), 1813–1824. https://doi.org/10.1016/j.compedu.2011.02.003
- [T115] Piech, C., Spencer, J., Huang, J., Ganguli, S., Sahami, M., Guibas, L., & Sohl-Dickstein, J. (2015). Deep knowledge tracing. arXiv:1506.05908. https://arxiv.org/abs/1506.05908

**Supplementary (D9)**

- [T116] Remotion. *Chrome Headless Shell*. https://www.remotion.dev/docs/miscellaneous/chrome-headless-shell

**Added on 22–23 October 2026 (D9, D10, D12)**

- [T117] MDN Web Docs. *HTMLCanvasElement: captureStream() method*. https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement/captureStream
- [T118] MDN Web Docs. *MediaRecorder*. https://developer.mozilla.org/en-US/docs/Web/API/MediaRecorder
- [T119] MDN Web Docs. *MediaRecorder: isTypeSupported() static method*. https://developer.mozilla.org/en-US/docs/Web/API/MediaRecorder/isTypeSupported_static
- [T120] MDN Web Docs. *AudioContext: createMediaStreamDestination() method*. https://developer.mozilla.org/en-US/docs/Web/API/AudioContext/createMediaStreamDestination
- [T121] Google AI for Developers. *Gemini models* (audio models: Gemini 3.8 Flash TTS, Gemini 3.8 Flash-Lite TTS). https://ai.google.dev/gemini-api/docs/models
- [T122] Google AI for Developers. *Speech generation (text-to-speech)*. https://ai.google.dev/gemini-api/docs/speech-generation
- [T123] Google AI for Developers. *Rate limits*. https://ai.google.dev/gemini-api/docs/rate-limits
- [T124] Google AI for Developers. *Gemini API Additional Terms of Service* (use of data on unpaid and paid services). https://ai.google.dev/gemini-api/terms
- [T125] Google AI for Developers. *Gemini Developer API pricing*. https://ai.google.dev/gemini-api/docs/pricing
- [T126] Next.js. *Functions: after*. https://nextjs.org/docs/app/api-reference/functions/after
- [T127] GitHub Docs. *Events that trigger workflows: schedule*. https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#schedule
