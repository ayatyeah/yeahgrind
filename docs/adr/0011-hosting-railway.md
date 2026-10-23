# ADR-0011: Railway for the web service and PostgreSQL

- **Status:** Accepted · 2026-10-21, revised 2026-10-23 · Owner: Yernar Katyshev
- **Context:** The project needs:
  - a long-lived Node process that can finish background jobs after a response (ADR-0009);
  - scheduled jobs (LMS refresh 3×/day, review reminders);
  - managed PostgreSQL on a private network;
  - a small budget and git-push deployment for two people.
- **Decision:** A Railway project with a web service (Next.js, which also runs background jobs) and PostgreSQL 18 (daily backups). Scheduled jobs run as GitHub Actions workflows calling authenticated endpoints. A merge to `main` deploys the web service; a worker service is added only if jobs move to pg-boss.
- **Alternatives:**
  - Vercel (3.65): daily cron only on Hobby, functions limited to 300 s, no first-party Postgres;
  - VPS + Docker Compose (3.60): cheapest, but all operations are on the team.
- **Consequences:**
  - (+) the database on a private network, simple deploys, no worker to operate;
  - (−) no global edge network; narration is streamed by the web service (ADR-0010);
  - (±) standard containers remain portable to a VPS.
