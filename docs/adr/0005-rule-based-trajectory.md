# ADR-0005: Transparent rule-based pathway scoring

- **Status:** Accepted · 2026-10-21 · Owner: Yernar Katyshev
- **Context:** The pathway must work from the first day with no interaction history (cold start). Every recommendation must be explainable (FR-13) and testable deterministically. The pilot has tens to hundreds of users.
- **Decision:**
  - Eligibility by prerequisite mastery.
  - Weighted priority: 0.35 gap, 0.25 goal relevance, 0.20 review due, 0.20 deadline proximity.
  - Greedy fitting into the free minutes; the reason is generated from the top factor.
  - Weights live in configuration and are compared in benchmark B1.
- **Alternatives:** collaborative filtering (2.00): cold start, uninterpretable factors; contextual bandit (2.85): needs large interaction data, adds exploration to students' plans.
- **Consequences:**
  - (+) deterministic, explainable and unit-testable;
  - (−) no automatic learning of weights; consented interaction logs allow offline evaluation of learned policies later.
