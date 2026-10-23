# ADR-0002: PostgreSQL 18 with Prisma ORM 7

- **Status:** Accepted · 2026-10-21 · Owner: Yernar Katyshev
- **Context:** Several requirements depend on database guarantees:
  - relational domain: goals, skills (DAG), units, items, attempts, mastery, friendships, groups, ledger;
  - exactly-once rewards and idempotent answers (NFR-07);
  - cascade deletion (FR-04);
  - flexible JSON for generated content.
- **Decision:**
  - PostgreSQL 18 with unique and check constraints, foreign keys with `ON DELETE CASCADE` and `jsonb` for generated content.
  - Prisma ORM 7, pinned to `prisma@7`; the team's Prisma 6 starter schema is upgraded in sprint S1 (YG-15), before Prisma 6 security support ends on 19 Nov 2026. Hot paths (answer + mastery + reward) run as Serializable transactions with retry on SQLSTATE 40001.
- **Alternatives:**
  - storage: MongoDB (3.50), Cloud Firestore (2.50);
  - data access: Drizzle ORM (4.25, within noise of Prisma's 4.30), raw `pg` (3.55).
- **Consequences:**
  - (+) integrity in the database, mature migrations;
  - (−) Prisma's major-version churn (v8 release candidate), mitigated by pinning and a planned upgrade after it is generally available.
