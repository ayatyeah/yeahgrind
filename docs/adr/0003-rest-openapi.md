# ADR-0003: REST + OpenAPI with shared Zod schemas

- **Status:** Accepted · 2026-10-21 · Owner: Yernar Katyshev
- **Context:** The API needs:
  - a contract that testers, reviewers and the committee can read;
  - per-endpoint authorization, rate limits and idempotency keys;
  - long-running jobs (video, generation) with status resources.
- **Decision:**
  - REST/JSON under `/api/v1`, documented in [`api/openapi.yaml`](../../api/openapi.yaml), with errors in `application/problem+json`.
  - Long-running work returns `202` and a job/status resource. `Idempotency-Key` is required on answer submissions.
  - Zod schemas are shared between client and server.
- **Alternatives:** tRPC (3.45): no contract for non-TS clients; GraphQL (3.05): complexity limits, caching, single-endpoint security.
- **Consequences:**
  - (+) simple security per route, cacheable reads, easy contract testing;
  - (−) types are derived from schemas rather than inferred end to end.
