# ADR-0008: Video generation with a grounded script, Gemini narration and client-side rendering

- **Status:** Accepted · 2026-10-21, revised 2026-10-23 · Owner: Yernar Katyshev
- **Context:** Requirements for the videos:
  - every micro-unit needs a 60–120 s explainer in English, Russian and Kazakh (FR-19, FR-23);
  - videos must be grounded in the unit (FR-21) and captioned (NFR-09);
  - generation must be asynchronous and cheap (FR-20, NFR-03, NFR-13).
- **Decision:**
  1. The LLM returns a JSON script of 4–8 scenes and 120–280 words; every spoken sentence names the unit paragraph it comes from.
  2. A second model pass checks each sentence against its paragraph; a script with issues goes to `needs_review` and is narrated only after the goal owner approves or rewrites it.
  3. Narration: Gemini TTS reads the whole script in one request behind a `TtsProvider` adapter, with a fallback chain of Gemini TTS models; every video is labeled "AI-generated voice". Kazakh narration stays off until the native-speaker check passes.
  4. Scene and sentence timings follow from the audio length and word counts; WebVTT captions are generated from them.
  5. The browser draws 9:16 slides on a canvas in sync with the narration (captions on by default, transcript, sources panel) and records the same frames with MediaRecorder into an MP4 or WebM file on request.

  One video is generated per (unit, version, language) and reused by everyone who studies the unit.
- **Alternatives** ([05 D9–D10](../05-technology-comparison.md#d9-short-form-video-generation-approach)):
  - video: server template pipeline with FFmpeg (4.45), the upgrade path if videos must exist as server-side files; Remotion (4.35);
  - TTS: Azure AI Speech (4.70), the target before the pilot (dedicated kk-KZ voices, no storage of inputs); ElevenLabs (3.55).
- **Consequences:**
  - (+) no server rendering or video storage; the player and the downloaded file look the same; only the TTS provider sees the script;
  - (−) slide-style visuals; the file container depends on the browser and recording takes real time; the free Gemini tier limits narrations per day and may use content to improve Google products, so the paid tier is enabled before the pilot;
  - (±) a native-speaker listening test decides whether Kazakh narration uses Gemini or moves to Azure.
