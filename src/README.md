# Source code

Planned layout of the modular monolith ([docs/07-architecture.md](../docs/07-architecture.md)). One TypeScript codebase builds the **web** app (PWA + REST API), which also runs background jobs after the response; video frames are drawn in the browser. Each domain module owns its tables and exposes functions only.

```
src/
├── web/                      # PWA: screens, components, state store, service worker, i18n (EN/RU/KK)
│   ├── app/                  # today, path, unit (+ video player), quiz, mastery, friends, groups, settings, moderation
│   ├── components/
│   └── i18n/
├── server/
│   ├── api/                  # REST handlers, Zod validation, Problem JSON errors (api/openapi.yaml)
│   ├── auth/                 # e-mail + Microsoft Entra ID, session, ownership guard
│   └── modules/
│       ├── identity/         # profile, consent, export, deletion                  FR-01–FR-04
│       ├── content/          # goals, material, skill map, micro-units            FR-05–FR-09
│       ├── pathway/       # eligibility, priority, micro-plan, spaced review    FR-10–FR-15
│       ├── planning/         # day plan, calendar, LMS deadlines, timetable import FR-16–FR-18
│       ├── video/            # video records, job API, reuse                       FR-19–FR-24
│       ├── assessment/       # item bank, Elo ability/difficulty, mastery, reportsFR-25–FR-30
│       ├── social/           # friends, feed, sharing, comments, groups           FR-31–FR-34
│       ├── moderation/       # reports, review queue, audit                       FR-35–FR-36
│       ├── rewards/          # ledger, XP, levels, skins                           FR-37–FR-38
│       └── notifications/    # reminders, quiet hours                             FR-39
├── jobs/
│   ├── runner/               # claim, renewal and retry of job rows; started after the response
│   ├── generation/           # skill maps, units, questions (LLM + validation)
│   └── video/                # script → grounding check → narration → timings and captions
├── player/                   # canvas renderer shared by playback and MediaRecorder export
├── adapters/
│   ├── ai/                   # LLM and TTS provider adapters, prompts, JSON schemas, limits, metering
│   ├── storage/              # narration audio with range responses (object storage later)
│   ├── lms-ical/             # iCalendar fetch, parse, encrypt
│   └── push/                 # VAPID web push
├── shared/                   # pure functions shared by client and server (scoring, Elo math, schemas)
└── db/
    ├── schema.prisma         # matches diagrams/src/04-data-model.puml
    └── migrations/
```

Implementation starts in sprint S1 (task YG-14). Setup, run and test commands will be added to the root README together with the first runnable code.
