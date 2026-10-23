# Tests

| Folder | Content | Tool |
|---|---|---|
| `acceptance/` | Acceptance scenarios (Given/When/Then) derived from docs/06; source for automated tests | Gherkin text |
| `unit/` | Pure domain logic: pathway eligibility and priority, Elo updates and item selection, stopping rule, schema validation, iCalendar parsing | Vitest + fast-check |
| `integration/` | API + PostgreSQL + job queue: ownership, idempotency, concurrency, consent, cascade deletion, video job states with fake providers | Vitest + test database |
| `e2e/` | Browser scenarios S1–S6 at 320/390/1440 px, accessibility checks | Playwright + @axe-core/playwright |
| `load/` | Load and latency scenarios | k6 |
| `benchmarks/` | B1 simulated learners, B2 public assessment dataset split and simulation, B3 video batch and seeded-error scripts, B4 content validity sets, B5 open-answer reference set, `.ics` fixtures | scripts + data with README |

Test plan, thresholds and the requirement-to-test matrix: [docs/09-verification-evaluation-plan.md](../docs/09-verification-evaluation-plan.md).
