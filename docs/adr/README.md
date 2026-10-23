# Architecture Decision Records

Each record states the context, the decision, the alternatives considered and the consequences. Scoring matrices are in [05-technology-comparison.md](../05-technology-comparison.md).

| ADR | Decision | Status |
|---|---|---|
| [0001](0001-modular-monolith-nextjs.md) | Modular monolith on Next.js + TypeScript; background jobs in the web process | Accepted |
| [0002](0002-postgresql-prisma.md) | PostgreSQL 18 with Prisma ORM 7 | Accepted |
| [0003](0003-rest-openapi.md) | REST + OpenAPI with shared Zod schemas | Accepted |
| [0004](0004-llm-provider-adapter.md) | LLM behind a provider adapter (OpenAI primary, Anthropic fallback) | Accepted |
| [0005](0005-rule-based-trajectory.md) | Transparent rule-based pathway scoring | Accepted |
| [0006](0006-authentication.md) | Auth.js v5 with Microsoft Entra ID tenant restriction (Better Auth as migration target) | Accepted |
| [0007](0007-adaptive-assessment-model.md) | Elo-style rating per learner–skill and per item | Accepted |
| [0008](0008-video-generation-pipeline.md) | Grounded script → Gemini narration → slides rendered and recorded in the browser | Accepted (revised) |
| [0009](0009-job-queue-in-postgresql.md) | Background jobs as PostgreSQL rows; schedules from GitHub Actions; pg-boss as the target | Accepted (revised) |
| [0010](0010-media-object-storage.md) | Narration audio in PostgreSQL for release 1; object storage as the target | Accepted (revised) |
| [0011](0011-hosting-railway.md) | Railway for the web service and PostgreSQL | Accepted (revised) |
