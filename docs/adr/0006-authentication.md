# ADR-0006: Auth.js v5 with Microsoft Entra ID tenant restriction

- **Status:** Accepted · 2026-10-22 · Owner: Yernar Katyshev · Reviewer: Ayat Balmagambet
- **Context:** Requirements:
  - e-mail + password accounts and single sign-on with Microsoft Entra ID, restricted to the university tenant (FR-01, FR-02);
  - users stored in our own PostgreSQL;
  - no extra paid service.

  Sign-in is the main delivery risk of sprints S1–S2.
- **Decision:** Auth.js v5 (NextAuth) with the Microsoft Entra ID provider and a tenant-specific issuer, the Credentials provider (bcrypt hashing, lockout, rate limits) and the Prisma adapter. Authentication is isolated in `src/server/auth/`.
- **Why not the highest library score:** Better Auth scored higher on library criteria (4.70 vs 4.25, [05 D6](../05-technology-comparison.md#d6-authentication)). However, the team already has a tested Auth.js integration with the AITU Entra ID tenant from previous coursework, which removes most of the sign-in risk.
- **Alternatives:**
  - Better Auth (4.70): the planned migration target;
  - Keycloak (4.10): a separate JVM service;
  - Clerk (3.85): tenant restriction only through SAML on a paid plan; user data in a third-party SaaS.
- **Consequences:**
  - (+) identities in our database and a proven tenant restriction;
  - (−) Auth.js v5 is still beta and in maintenance mode under the Better Auth team [T46, T47];
  - mitigation: pin the exact version, keep auth behind one module interface, run integration tests for both sign-in methods, and reassess the migration to Better Auth at milestone M6.
