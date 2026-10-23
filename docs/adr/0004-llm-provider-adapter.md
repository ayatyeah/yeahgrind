# ADR-0004: LLM behind a provider adapter

- **Status:** Accepted · 2026-10-21 · Owner: Yernar Katyshev
- **Context:** The LLM produces skill maps, units, video scripts and questions, and grades open answers. All of these need JSON-schema output; timetable import needs image input. Further constraints:
  - cost must stay low (NFR-13);
  - no personal identifiers may be sent, and providers must not train on the data (NFR-06);
  - provider outages must not break unrelated features (NFR-11).
- **Decision:** A `LlmProvider` interface (`generateStructured(schema, prompt, images?)`).
  - **Primary:** OpenAI Responses API with strict JSON schema and `store: false`.
  - **Fallback:** Anthropic Claude API.
  - Model IDs live in configuration.
  - Every call is metered (tokens, latency, outcome) and rate-limited per user and globally.
- **Alternatives:** Anthropic as primary (4.45; ~30 % more tokens for the same text); self-hosted open-weight model (3.00; GPU cost ≈ 20× the API cost at pilot scale, plus operations).
- **Consequences:**
  - (+) switching providers is a configuration change, and benchmarks B3–B5 can be re-run per provider;
  - (−) prompts must avoid provider-specific features beyond JSON schema and images.
