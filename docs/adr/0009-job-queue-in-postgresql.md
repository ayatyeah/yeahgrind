# ADR-0009: Background jobs as PostgreSQL rows, schedules from GitHub Actions

- **Status:** Accepted · 2026-10-21, revised 2026-10-23 · Owner: Yernar Katyshev
- **Context:** Background work needs retries, deduplication and visibility, without extra infrastructure:
  - skill-map, unit and question generation;
  - video scripts, the grounding check and narration;
  - open-answer grading;
  - the LMS refresh three times a day;
  - reminders.

  Since video frames are rendered in the browser (ADR-0008), no CPU-heavy job runs on the server.
- **Decision:**
  - The domain row is the job (for example, one video row per unit, version and language, with a unique key). Work starts in the web process right after the HTTP response (Next.js `after()`).
  - A conditional update claims the row; the claim is renewed between steps, and only the current claim holder may write the result. A job whose claim is not renewed for 10 minutes (for example, after a redeploy) is restarted by the next status request; at most 3 attempts, then `failed` with a message.
  - Scheduled work (LMS refresh, reminders) runs as GitHub Actions workflows that call authenticated, idempotent endpoints.
- **Alternatives** ([05 D12](../05-technology-comparison.md#d12-background-job-processing-ai-generation-narration-scheduled-imports)):
  - pg-boss on a worker service (4.35): the target when server-side rendering returns, job types grow or global concurrency limits are needed;
  - BullMQ + Redis (3.70): an extra Redis service that needs `noeviction` and AOF, and is not atomic with PostgreSQL writes.
- **Consequences:**
  - (+) no new infrastructure; jobs are queryable with SQL; deduplication by the row's unique key;
  - (−) hand-written retries and a claim protocol that must be covered by tests; no global concurrency cap beyond daily limits.
