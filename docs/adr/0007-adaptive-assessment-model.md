# ADR-0007: Elo-style rating per learner–skill and per item

- **Status:** Accepted · 2026-10-21 · Owner: Yernar Katyshev
- **Context:**
  - Adaptive quizzes must pick the next item near a target success band and estimate mastery per skill (FR-26, FR-27).
  - At launch there are no answer logs to calibrate items.
  - Updates must be fast (≤ 500 ms) and explainable to students.
- **Decision:**
  - One ability *θ* per (learner, skill), with a global prior per learner, and one difficulty *b* per item. Both are updated online after every answer with an uncertainty-based step size.
  - Open answers contribute their graded score in [0, 1].
  - The next item is the one whose predicted success is closest to 0.7.
  - Mastery is the predicted success on a typical item of the skill; ≥ 0.85 with at least 3 answers counts as mastered.
  - Details: [07 §7.7](../07-architecture.md#77-adaptive-knowledge-assessment).
- **Alternatives** ([05 D13](../05-technology-comparison.md#d13-adaptive-knowledge-assessment-model)):
  - Bayesian Knowledge Tracing (3.90): models skills, not items, and needs parameter fitting;
  - IRT-based CAT (3.05): needs a calibrated item pool and assumes constant ability;
  - deep knowledge tracing: excluded, as it needs large training logs and is not explainable.
- **Consequences:**
  - (+) works from cold start, O(1) updates, deterministic tests, close to the Rasch model (Pelánek, 2016);
  - (−) a less rigorous mastery probability than BKT and weaker psychometrics than calibrated IRT. Benchmark B2 compares all three offline, and consented logs allow refitting after the pilot.
