# ADR-0001: Modular monolith on Next.js + TypeScript

- **Status:** Accepted · 2026-10-21 · Owner: Yernar Katyshev · Reviewer: Ayat Balmagambet
- **Context:** Two developers and seven months. Mobile-first PWA. ACID transactions are needed across mastery, attempts and rewards. Video rendering is CPU-heavy and must not block requests. One shared language is required (R1).
- **Decision:** One Next.js 16 + TypeScript (strict) codebase. A web process serves the UI and REST API and runs background jobs after the response (ADR-0009); video frames are rendered in the browser (ADR-0008). Domain modules own their tables and expose functions only.
- **Alternatives:**
  - NestJS API + Vite SPA (3.70): two projects and deploys;
  - Django + DRF + React (3.30): two languages.
- **Consequences:**
  - (+) shared types and validation, one deployment pipeline, server rendering for mobile;
  - (−) less built-in backend structure, mitigated by module boundaries enforced in code review and lint rules;
  - (±) the video pipeline can later be split into its own service without changing domain modules.
