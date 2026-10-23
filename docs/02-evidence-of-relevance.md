# 2. Evidence of the Relevance

## 2.1 Evidence base

| Evidence type | Source | What it informs | Where |
|---|---|---|---|
| Analysis of available data: published studies | 28 verified sources, 27 peer-reviewed, 20 from 2021–2026 | Size and nature of the problems; which design choices work; limitations to respect | §2.2, [03](03-literature-review.md) |
| Analysis of available data: existing products | 5 systems × 10 criteria, official documentation checked on 21 Oct 2026 | Gaps G1–G8 that no current product covers | §2.2, [04](04-existing-systems-comparison.md) |
| Observation of a relevant process | Walkthrough of how an AITU student gets personal deadlines and course names out of the Moodle LMS | Integration requirements and their constraints | §2.3 |
| Interviews with potential users | 3 semi-structured interviews with AITU students (I-01 … I-03), October 2026 | Study habits, needs, acceptance of video, adaptive quizzes, AI feedback and social features; priorities | §2.4, [research/](research/) |
| Academic stakeholder | Supervisor review of deliverables | Scope, evaluation design | [11](11-supervisor-feedback.md) |

There is no external client. The users are students, and their needs are established through the interviews in §2.4.

## 2.2 Analysis of available data

| ID | Finding | Key figures | Sources | Requirements |
|---|---|---|---|---|
| E1 | Microlearning (single-objective units of a few minutes) is associated with gains in knowledge, retention, engagement and motivation, especially on mobile devices | 40 studies (2020–2024) and 26 studies (2015–2020) in two systematic reviews | Monib et al. 2025 (L1); Lee 2023 (L2) | FR-05, FR-09, FR-11 |
| E2 | Attention to video falls after about six minutes; video added to practice helps far more than video that replaces teaching | Median engagement ≤ 6 min over 6.9 M sessions; *g* = 0.80 (added) vs 0.28 (replacing), 105 RCTs | Guo et al. 2014 (L3); Noetel et al. 2021 (L4); Mayer 2024 (L5) | FR-19, FR-24 |
| E3 | AI-generated teaching videos produce learning comparable to human-made ones | Similar exam results, 447 participants; no difference in gains with a synthetic presenter, n = 83 | Netland et al. 2025 (L6); Leiker et al. 2023 (L7) | FR-19 |
| E4 | LLM-generated learning items are mostly good, but their failures are predictable and must be checked | 81.7 % of 651 GPT-4 MCQs passed all criteria; more items with several correct options (4.9 % vs 1.1 %) | Doughty et al. 2024 (L8) | FR-06, FR-21, FR-25, FR-35, FR-36 |
| E5 | Retrieval practice with corrective feedback improves achievement; spacing schedules improve recall | Quizzing *g* = 0.499 (222 studies, 48,478 students); trained spacing: 45 %+ lower prediction error | Yang et al. 2021 (L14); Settles & Meeder 2016 (L15) | FR-15, FR-25, FR-30 |
| E6 | Adaptive assessment can estimate ability and item difficulty online with simple models; adaptive tests need fewer items | Elo used with > 15 M answers; ≈ 100 answers per item for stable difficulty | Pelánek 2016 (L10); Corbett & Anderson 1995 (L9); Zhuang et al. 2026 (L12) | FR-08, FR-10, FR-11, FR-26, FR-27 |
| E7 | Unrestricted AI answers harm later unaided performance; hint-only tutoring removes the harm | Practice grades +48 %, but the later exam −17 % with unrestricted GPT; no harm with a guarded tutor (≈ 1,000 students) | Bastani et al. 2025 (L19) | FR-21, FR-29, FR-36 |
| E8 | A grounded, scaffolded AI tutor can outperform active learning in class | Effect 0.63–1.3 SD, N = 194 | Kestin et al. 2025 (L18) | FR-28 |
| E9 | Feedback is powerful but variable; LLM grading agrees moderately with humans and is weakest on partially correct answers | Feedback effect 0.79; 32 % of effects negative in one meta-analysis; GPT-4 precision 0.91 on fully correct answers | Hattie & Timperley 2007 (L21); Grévisse 2024 (L22) | FR-28 |
| E10 | Gamification helps on average, but broken streaks reduce later engagement | Cognitive *g* = .49; intact vs broken streak effects in 7 studies | Sailer & Homner 2020 (L25); Silverman & Barasch 2023 (L26) | FR-34, FR-37, FR-38 |
| E11 | Structured collaboration improves learning and collaboration skills; social presence mostly raises perceived learning | Scripts: *g* = 0.24 (learning), 0.72 (collaboration skills); social presence r = .199 with actual learning | Radkowitsch et al. 2020 (L17); Martin et al. 2022 (L16) | FR-31 – FR-34 |
| E12 | Procrastination is driven by task aversiveness, delay and low self-efficacy; time management relates to less procrastination and better well-being | 691 correlations; r = .490 with (lower) procrastination, r = .262 with achievement | Steel 2007 (L23); Aeon et al. 2021 (L24) | FR-12, FR-39 |
| E13 | Students' willingness to share learning data depends on perceived risk and control; generative AI in education needs labeling and human accountability | 132 students (PLS-SEM); UNESCO guidance | Mutimukwe et al. 2022 (L27); UNESCO 2023 (L28) | FR-03, FR-04, FR-41, NFR-06 |
| E15 | Educational recommenders are mostly evaluated on accuracy, rarely on learning; transparency and control raise trust | Pedagogical effect evaluated in 37.5 % of reviewed systems | da Silva et al. 2023 (L13); L27 | FR-13, evaluation design ([09](09-verification-evaluation-plan.md)) |
| G1–G8 | No existing product combines an adaptive microlearning pathway over an arbitrary university subject, generated short video, adaptive assessment, cooperative social learning, fitting into the student's day and Kazakh support | 5 systems × 10 criteria; best coverage 5 ● of 10 | [04](04-existing-systems-comparison.md) | see [06 §6.5](06-requirements-specification.md#65-traceability) |

## 2.3 Observation of the current process

**Process:** how an AITU student gets personal assessment deadlines and course names from the university Moodle LMS into a personal calendar or study tool. The steps were walked through on the AITU LMS (lms.astanait.edu.kz) with a student account.

| Step | Action |
|---|---|
| 1 | Open the LMS and choose sign-in with the university Microsoft account (OpenID Connect, with MFA) |
| 2 | Open *Calendar* |
| 3 | Choose *Export calendar* |
| 4 | Select events: *All events* |
| 5 | Select the period: *Recent and next 60 days* or a custom range |
| 6 | Press *Get calendar URL* |
| 7 | Copy the personal URL and paste it into a calendar application |

**Observations.**

- **O1.** The export works only through a manual, seven-step procedure that has to be found inside the calendar settings.
- **O2.** The URL is personal and gives access to the student's events without further sign-in, so it behaves like a secret. It must be stored encrypted and never shown again (FR-17).
- **O3.** The export covers a chosen time window. A one-time import becomes outdated, so the feed needs regular refresh (FR-17: three times a day).
- **O4.** The feed contains assessment events (deadlines, quizzes) with the course name in the event category. It therefore gives a partial list of the student's courses, those with events in the window, which can seed the subject list (FR-05). It is not a list of enrollments, so manual entry of subjects remains necessary.
- **O5.** The LMS calendar shows *what is due*, but not *what to study next* or *how ready the student is*. Turning deadlines into study steps is left entirely to the student, which is the gap the pathway engine addresses (FR-11, FR-12).
- **O6.** Signing in with the university Microsoft account is the established identity at AITU. Offering the same sign-in in YeahGrind, restricted to the university tenant, matches the existing student habit (FR-02).

## 2.4 Interviews with potential users

**Purpose.** To understand, from specific recent episodes, how students fit study into their day, choose what to study, learn new topics, check their knowledge, study with others and feel about AI feedback and gamification. The interviews test hypotheses H1–H10 (§2.5) and set requirement priorities.

**Protocol.**
- Three semi-structured interviews were held in October 2026 with AITU students who are not involved in the project: two conversations (Russian and English, transcribed) and one set of written answers (English).
- Questions followed parts A–E and G of the guide in [research/interview-guide.md](research/interview-guide.md). The concept probe with prototype screens (part F) was not run, so no hypothesis relies on it.
- Consent and pseudonymized notes follow [research/consent-and-recruitment.md](research/consent-and-recruitment.md). Names, teachers and courses are removed; Russian quotes are translated.
- Notes are written one file per interview using the [template](research/interview-notes/TEMPLATE.md). Audio recordings are kept only on the interviewer's encrypted device, never in the repository, and deleted within 48 hours after the notes are written. The notes are kept outside the public repository, as promised in the consent text; the supervisor and the committee can see them on request.

**Participants.**

| Code | Profile | Date | Mode / language | Notes |
|---|---|---|---|---|
| I-01 | IT student, second year or above; frequent AI user; studies mostly alone | Oct 2026 | Conversation, audio-recorded · RU | On request |
| I-02 | Student who prepares mainly for hard disciplines shortly before exams; fluent in RU and EN | Oct 2026 | Written answers · EN | On request |
| I-03 | Student who studies with friends and holds a scholarship; heavy AI user | Oct 2026 | Conversation, transcribed · EN | On request |

**Limitations.** The sample is small and not representative: three AITU students, two of whom use AI frequently or heavily (I-01, I-03). This raises the weight of AI use in H9 and in the new theme N1, so these results describe students who already use AI rather than all students. The interview results are used as design input for this project, not as general claims.

**Synthesis method.**
1. Every observation is tagged with H1–H10 or a new theme (N1, N2, …).
2. For each hypothesis, participants who give a concrete supporting or contradicting episode are counted.
3. The hypothesis is then classified:
   - *supported*: ≥ 3 participants support it and none contradict;
   - *contradicted*: ≥ 3 contradict it;
   - *mixed*: any other result.
4. New themes mentioned by ≥ 2 participants become candidate requirements.
5. H10 asks for a preference rather than testing a claim, so it is reported without a status.

**Findings.**

| Hypothesis | Evidence from interviews (participant codes, episode) | Status | Effect on requirements |
|---|---|---|---|
| H1 Study happens in short, fragmented windows | All three study in long focused sessions: I-01 finishes a task in one sitting and "needs full immersion"; I-02 reads all materials 1–2 days before an exam, never while travelling; I-03 works 2–3 hours per session and in short breaks only watches topic videos | **Contradicted** | FR-09 kept (E1); FR-12 plans a focused session made of several micro-units; videos suit short breaks (FR-19) |
| H2a Deadlines come from several channels | All three use Moodle as the only deadline source (I-01, I-02, I-03) | **Contradicted** | Consolidation of other channels is not needed |
| H2b Keeping track of deadlines takes manual effort | I-01 checks Moodle every day "in a rush"; I-02 checks it briefly; I-03 gives no episode | **Mixed** | FR-17 kept: the calendar import replaces the manual check |
| H3 Choosing the next study step is a barrier | I-02 follows the closest deadline; I-03 sometimes does not know "where to start or what subject to do first"; I-01 works down a to-do list | **Mixed** | FR-11, FR-13 kept; deadline proximity stays in the priority (N3) |
| H4 Short video is preferred for new topics if its sources are visible | All three combine text and video: video when tired (I-01), for examples (I-02), to visualize how something works (I-03); none prefers video alone | **Mixed**: video as a complement, not a replacement | FR-19 – FR-24 kept; video is added to the text unit, as in E2 |
| H5 Gaps are discovered late; short adaptive quizzes would be used | I-02 sometimes finds topics not understood; I-01 "assumes" understanding after finishing a task; I-03 never finds gaps late and checks understanding by answering questions | **Mixed** | FR-26, FR-30 kept: question-based checking is the method I-03 already uses |
| H6 Feedback that explains mistakes is preferred to full answers | All three want an explanation of the mistake; I-01 and I-03 want the correct answer right away | **Mixed**: explanation yes, withholding the answer no | FR-28 kept; FR-29 clarified: hints are optional before an attempt, the correct answer and the reason are shown right after it |
| H7 Students want to learn with peers, keep scores private and cooperate rather than compete | I-03 studies with friends and keeps scores private; I-02 works with others in projects and wants to compare quiz scores to discuss mistakes; I-01 mostly studies alone and is motivated by leaderboards | **Mixed** | FR-32: scores private by default, shared on purpose; FR-34 cooperative goal kept; ranking stays out of release 1 |
| H8 Punitive mechanics (streak loss, league demotion) demotivate | I-01 is motivated by competition; I-03 by the risk of losing a scholarship; I-02 is not affected by points or streaks | **Mixed**: no participant supports it; I-01 and I-03 contradict it | FR-38 kept on published evidence (E10) and as an ethical rule |
| H9 Students share context and answers, but not identity, with AI services and want control | All three upload study notes to AI; I-02 expects that personal info does not leak; I-03 shares only non-private information | **Supported** | FR-03, FR-04, NFR-06 kept; no personal data is needed to build a pathway |
| H10 Preferred interface and narration language | English is acceptable to all three (I-01 at an English-medium university, I-03 because most videos are in English); I-02 also Russian; I-01 wants Kazakh only for a Kazakh-language class | Preference question, no status: EN first, RU second, KK by subject | FR-23 priorities confirmed (EN M, RU S, KK C); language is chosen per goal |
| New themes | N1 AI answers can be wrong or over-general (I-01, I-02); N2 video for tired moments and short breaks (I-01, I-03); N3 deadlines and grade stakes set priorities (I-02, I-03); N4 friends help to stay focused (I-03) | — | N1 → FR-21, FR-24 (grounding, sources); N2 → FR-12 suggests the unit video at low energy; N3 → FR-11 deadline factor |

## 2.5 Verified findings and design hypotheses

Verified findings are kept apart from design hypotheses. **E**-items are verified (published data, observation, product analysis); **H**-items are design hypotheses confirmed or rejected by the interviews in §2.4.

| ID | Statement | Basis | Status |
|---|---|---|---|
| E1–E13, E15 | See §2.2 | Peer-reviewed studies and official guidance ([03](03-literature-review.md)) | Verified |
| E14 | Getting LMS deadlines into a study tool takes a manual seven-step export; the personal URL is a secret; the feed needs regular refresh; course names can be derived | Process observation (§2.3) | Verified |
| G1–G8 | Existing products leave the gaps listed in [04 §4.5](04-existing-systems-comparison.md#45-gap-analysis-and-implications-for-requirements) | Official product documentation | Verified |
| H1 | Students study in short, fragmented windows (≤ 30 min) on most days | Interviews I-01 … I-03 | Contradicted |
| H2a | Deadlines come from several channels | Interviews | Contradicted |
| H2b | Keeping track of deadlines takes manual effort | Interviews | Mixed |
| H3 | Choosing the next study step is a real barrier to starting | Interviews | Mixed |
| H4 | For a new topic, students prefer a short video to long text, provided its sources are visible | Interviews | Mixed |
| H5 | Students discover gaps late and would use short adaptive quizzes that show progress | Interviews | Mixed |
| H6 | Students prefer feedback that explains mistakes to receiving the full answer | Interviews | Mixed |
| H7 | Students want to learn with peers, but keep scores private and prefer cooperation to ranking | Interviews | Mixed |
| H8 | Punitive mechanics demotivate | Interviews | Mixed |
| H9 | Students accept sharing study context and answers with AI services, not their identity, and want control | Interviews | Supported |
| H10 | Preferred language for interface and narration (KK / RU / EN) | Interviews | Preference recorded without a status (EN, RU; KK by subject) |

## 2.6 From findings to requirements

| Finding / hypothesis | Need | Requirement | Design decision |
|---|---|---|---|
| E1, H1 | Learn in focused sessions without overload | FR-09, FR-12 | Micro-units of 2–5 min with one objective; the day plan groups them into one session fitted to free minutes |
| E6, E15, H3, G2 | Know what to study next and why | FR-11, FR-13 | Prerequisite-gated pathway with reasons ([07 §7.6](07-architecture.md#76-personalized-microlearning-pathway)) |
| E2, E3, H4, G1 | Short explanations of one's own subject | FR-19 – FR-24 | 60–120 s generated videos with captions and a sources panel |
| E4, E7 | Generated content must be correct | FR-21, FR-25, FR-35, FR-36 | Grounding check, item validation, moderation queue |
| E5, E6, H5, G2 | Find gaps early | FR-25 – FR-30 | Adaptive quizzes (Elo), mastery report, spaced review |
| E7, E8, E9, H6, G3 | Feedback that teaches | FR-28, FR-29 | Optional hints before an attempt; correct answer and the reason right after it; rubric-based feedback; second pass and appeal |
| E10, E11, H7, H8, G4 | Learn together without pressure | FR-31 – FR-34, FR-38 | Friends, scores private by default and shared on purpose, cooperative group goals, no penalties |
| E12, E14, H2, G5 | Deadlines in one place, study placed in the day | FR-12, FR-16, FR-17 | Moodle iCalendar import, refresh 3×/day, micro-plan |
| E13, H9, G8 | Trust and control over data | FR-03, FR-04, NFR-06 | Opt-in analytics, export and deletion, no identifiers in AI requests |
| H10, G7 | Study in one's own language | FR-23, FR-40 | EN/RU/KK interface; Kazakh narration after a native-speaker check |

After the interviews, priorities in [06](06-requirements-specification.md) were reviewed. H1 was contradicted, but FR-09 keeps its priority because it rests on published evidence (E1); only the design of the day plan changed (one focused session of several units). H6 clarified FR-29: hints stay optional before an attempt, and the correct answer is shown right after it. H9 confirmed FR-03, FR-04 and NFR-06, and the language preferences recorded under H10 confirmed the priorities of FR-23. No requirement was dropped. Each change is recorded in the pull request for task YG-3.
