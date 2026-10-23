# 4. Existing System Comparison

All ratings come from official sources (product pages, help centers, pricing pages, privacy notices, official blogs and app-store listings) opened on **21 October 2026**. Keys such as [DU3] refer to the reference list in §4.6. The YeahGrind column describes the proposed design.

## 4.1 Selection of systems

The topic combines five capabilities: microlearning with an adaptive path, short educational video, adaptive assessment, AI feedback on open answers, and social learning. One leading product was chosen for each, and every one of them is used by students.

- **Duolingo** represents *gamified microlearning with machine-learning adaptivity and competitive social mechanics*. It has "bite-sized" lessons, an ML model (Birdbrain) that chooses exercises, and weekly leagues and friend features [DU2][DU4][DU9].
- **Khan Academy + Khanmigo** represents *a video library with a mastery system and an AI tutor*. Its short expert videos average 6–9 minutes, it tracks skill-level mastery, and Khanmigo gives feedback on writing and code [KH16][KH17][KH3].
- **Quizlet** represents *AI study-set generation from the learner's own material*. It turns notes, files and lecture audio into flashcards, study guides and practice tests, and adapts practice through Learn mode [QZ5][QZ6][QZ8][QZ2].
- **Coursera** represents *higher-education video courses with assessment*. It has university courses and degrees, AI grading of open-ended work, the Coursera Coach assistant, and LMS integration for campuses [CO10][CO7][CO5][CO11].
- **Google NotebookLM** (now also branded "Gemini Notebook") represents *AI generation of short learning videos from the learner's own sources*.

**Why NotebookLM for the fifth slot.** It was chosen over Synthesia and Coursebox because it is the only one of the three aimed at the *learner*:
- the learner uploads their own sources;
- it produces Video Overviews, including a "Short" format of about 60 seconds, plus flashcards and quizzes;
- it has a free plan [NB2][NB4][NB7].

The other two are authoring tools for course creators:
- **Synthesia** presents itself as a business video platform for L&D, HR, sales and marketing teams, and does not mention students [SY1].
- **Coursebox** targets course creators and training organizations that publish courses for *their* learners [CB1].

**Why no planner is in the set.** A planner (e.g. MyStudyLife or Todoist) would cover only the scheduling side of YeahGrind. That side is assessed for all five systems under criterion C8: fitting lessons into the day and LMS integration.

## 4.2 Criteria

| ID | Criterion | Why it matters for YeahGrind |
|---|---|---|
| C1 | Target users / higher-education focus | Primary users are university students |
| C2 | Personalized learning pathway | Core of the topic (FR-11 – FR-15) |
| C3 | Microlearning format (units ≤ 10 min) | Core of the topic (FR-09) |
| C4 | Short video, and whether it can be generated from the learner's own material or topic | Core of the topic (FR-19 – FR-24) |
| C5 | Adaptive knowledge assessment (item difficulty adapts, mastery estimate) | Core of the topic (FR-25 – FR-30) |
| C6 | AI feedback on the learner's own open answers and code | FR-28, FR-29 |
| C7 | Social and collaborative learning, and whether competition can feel punitive | Social part of the topic (FR-31 – FR-34, FR-38) |
| C8 | Integration with the study schedule and LMS; fitting lessons into the day | FR-12, FR-16, FR-17 |
| C9 | Privacy and data controls (export, deletion, AI training use) | FR-03, FR-04, NFR-06 |
| C10 | Platforms, RU/KK interface, pricing (USD, October 2026) | Local context and cost (FR-23, FR-40) |

Five systems and ten criteria satisfy the committee's requirement of 3–5 systems and 6–10 criteria.

## 4.3 System profiles

**Duolingo** (Duolingo, Inc.) teaches 40+ languages, plus maths, music and chess, through "bite-sized lessons that take just a few minutes to complete" [DU1][DU2]. Its Birdbrain model estimates both the learner's knowledge and how hard each exercise is, and chooses exercises the learner is likely to get right at a useful level of difficulty [DU4]. Motivation is social and competitive: weekly leaderboards with promotion and demotion between leagues, Friend Streaks and Friends Quests [DU9][DU10][DU11]. The app is free with ads and a limited Hearts/Energy budget. Super Duolingo costs $9.99–$12.99/month or $83.99–$119.99/year in the US App Store [DU1][DU3][DU6].

**Khan Academy + Khanmigo** (Khan Academy, non-profit) is a free library of expert-made videos (averaging 6–9 minutes), exercises and articles [KH15][KH16]. A mastery system moves each skill between Attempted, Familiar, Proficient and Mastered, and recommends which skills and videos to try next [KH17][KH15]. The AI tutor Khanmigo guides learners without giving answers and gives feedback on code and writing [KH3][KH23]. Khanmigo costs $4/month or $44/year and is sold only to learners with a US billing address [KH2][KH4]. Khan Academy itself has Kazakh and Russian "demo sites" [KH20].

**Quizlet** (Quizlet, Inc.) is a study platform used, by its own account, by "2 in 3 high schoolers and 1 in 2 college students" [QZ1]. It generates flashcards, study guides, practice tests and audio "Podcasts" from typed notes, uploaded files or recorded lectures [QZ1][QZ5][QZ6][QZ8]. Learn mode builds "a personalized study path based on your goals and how familiar you are with the set's content" using machine learning [QZ2]. "Study with friends" turns a set into a shared session with group results and leaderboards [QZ10]. The core product is free; Learn, practice tests and study guides are limited for free users [QZ16][QZ6][QZ7].

**Coursera** (Coursera, Inc.) offers courses, certificates and degrees from universities and companies, with app access to downloadable lecture videos [CO1][CO10]. In a sample course, 42 videos total 353 minutes, about 8 minutes each [CO4]. Its AI features include Coursera Coach (explanations and risk-free practice with feedback) and AI grading of essays, code and video against rubrics, though some are limited to selected regions or partners [CO5][CO7][CO8]. Coursera for Campus connects to Canvas, Blackboard, Moodle and D2L through native LTI [CO11]. Coursera Plus is shown at $35/month or $239/year to visitors from Kazakhstan (regional price) [CO2].

**Google NotebookLM / Gemini Notebook** (Google LLC) is an AI notebook where the learner uploads PDFs, websites, YouTube videos or text and gets answers grounded in those sources [NB1]. From the same sources it generates Video Overviews (Explainer, a roughly 60-second "Short", and an English-only "Cinematic" format for users 18+), Audio Overviews, flashcards and quizzes [NB2][NB3][NB4]. A "Learning Guide" mode tutors with probing, open-ended questions [NB5]. The Standard plan is free; Google AI Plus ($4.99) and Pro ($19.99) are sold in the App Store [NB7][NB1].

## 4.4 Comparison matrix

**Legend:** ● full · ◐ partial · ○ absent. "Not offered per official docs" means the capability does not appear on the feature, help or FAQ pages cited for that system.

**Rating rules applied to every system:**
- **C1:** ● = built for students including higher education; ◐ = learners in general or school-focused; ○ = not aimed at learners.
- **C2:** ● = the next skill or content is chosen per learner from performance or goals; ◐ = fixed path with personalized practice or recommendations; ○ = no path, or a fixed path only.
- **C3:** ● = units of 10 minutes or less are the main format; ◐ = some short items, but the main unit is longer or unstructured.
- **C4:** ● = short videos *generated from the learner's own material or topic*; ◐ = pre-produced videos only; ○ = no video.
- **C5:** ● = item selection or difficulty adapts *and* a mastery estimate is kept; ◐ = one of the two, or difficulty chosen by the user.
- **C8:** ● = imports the learner's own LMS deadlines *and* fits lessons into free time; ◐ = institutional LMS/roster integration, or reminders or spaced repetition only.
- **C10:** ● = web + mobile, a Russian or Kazakh interface, *and* a usable free tier.

| Criterion | Duolingo | Khan Academy + Khanmigo | Quizlet | Coursera | NotebookLM (Gemini Notebook) | **YeahGrind (proposed)** |
|---|---|---|---|---|---|---|
| **C1 Target users / higher-ed focus** | ◐ General learners. Languages, maths, music, chess [DU1]. Maths units are for grades 6–9 [DU12]. Schools tool is for teachers [DU13]. No higher-ed positioning. | ◐ Students, teachers, homeschoolers, adults [KH15]. "Elementary school through college" [KH1]. Some college-level maths (calculus, linear algebra) [KH15]. | ● Students and teachers. Claims "1 in 2 college students" use it, and covers MCAT prep [QZ1]. | ● Courses, certificates and degrees from universities and companies [CO1]. Coursera for Campus for higher education [CO10]. | ◐ "Students, creators, researchers, professionals" [NB1]. Student features and ready-made notebooks for high-school and college subjects [NB5]. | ● University students, using their own university subjects and Moodle deadlines. |
| **C2 Personalized learning pathway** | ◐ The unit path is the same for everyone [DU3]. The "AI model … adjusts the order and difficulty of the exercises" [DU2], and practice lessons are "unique to each learner" [DU3]. | ● The mastery system recommends "exactly which skills and videos to try next" [KH15], and suggests lessons after each activity [KH18]. Limited to Khan's own catalog. | ◐ Learn builds a "personalized study path based on your goals and how familiar you are" with one set (Plus) [QZ2]. Scope is a single flashcard set. | ◐ Fixed course sequence. Coach gives tailored explanations to fill prerequisite gaps [CO5], plus session milestones and nudges [CO8]. | ○ No learning path per official docs. Outputs are made on request, and the Learning Guide tutors inside a chat [NB5][NB2]. | ● A path of micro-lessons built from the student's goal or subject, their assessment results and the daily check-in (energy, free minutes). |
| **C3 Microlearning format (units ≤10 min)** | ● "Bite-sized lessons that take just a few minutes to complete" [DU2]. | ● Videos average 6–9 minutes [KH16]. Short exercises. A Mastery Challenge has 6 questions [KH19]. | ● Card-based modes (Flashcards, Learn rounds, Match, Charms) and audio Podcasts "on your commute" [QZ1][QZ12]. No unit length is stated. | ◐ Videos are short (about 8 minutes on average in a sample course [CO4]), but a course takes 4–12 hours [CO3] and labs take about 60 minutes each [CO4]. | ◐ "Short" video of about 60 seconds [NB2] and a "bite-sized" Brief video [NB3]. These are separate outputs, not structured lessons. | ● Micro-lessons and quests of 10 minutes or less, sized to the free time the student reports. |
| **C4 Short video, generated from the learner's material/topic** | ○ No video lessons per official docs. Video Call with Lily is an AI conversation partner (Max) [DU8][DU12]. | ◐ Pre-produced expert videos (6–9 minutes) [KH16]. Generating videos from learner material is not offered per official docs [KH3][KH15]. | ○ No video. Generates *audio* Podcasts and study guides from notes and lectures [QZ1][QZ8]. | ◐ Instructor lecture videos, downloadable, with subtitles [CO1][CO4]. AI dubbing is for partners [CO8]. No learner-generated video. | ● Video Overviews generated from notebook sources: Explainer, Short (about 60 s), and Cinematic (18+, English only) [NB2]. AI-illustrated visual styles [NB3]. Narration in Russian but **not Kazakh**. Generation can take "more than 30 minutes" [NB2]. | ● Short learning video (target ≤90 s) generated for each micro-lesson topic or uploaded material, in EN/RU/KK. |
| **C5 Adaptive knowledge assessment** | ● Birdbrain estimates "how much our learners know" and how hard each exercise is, predicts correct answers and picks exercises at the right level [DU4]. Harder final exercises when the learner is doing well [DU5]. | ● Skill levels Attempted→Mastered move up or down after quizzes, unit tests and course challenges [KH17][KH18]. Personalized Mastery Challenges (maths only) [KH19]. Prerequisite skills also move [KH24]. | ● Learn: "adaptive practice that meets you at your level and adjusts as you improve", plus spaced repetition and "retention insights" on mastery [QZ1]. ML-powered path [QZ2]. Free users get limited rounds [QZ11]. | ◐ Graded quizzes are fixed. Coach gives risk-free practice questions with feedback and retries [CO5]. The AI Viva Exam generates follow-up questions on a submission (pilot) [CO9]. Adaptive assessment is not mentioned [CO8]. | ◐ Quizzes and flashcards from sources, with difficulty chosen by the user (easy/medium/hard). Remembers "Got it!"/"Missed it!" and lets the learner retake missed cards [NB4]. No adaptation documented. | ● Item difficulty adapts to the student's answers. A mastery estimate per topic is shown to the student and drives the next micro-lesson. |
| **C6 AI feedback on the learner's own open answers / code** | ◐ Roleplay gives "AI-powered feedback on the accuracy and complexity" of free responses (Max, selected languages) [DU8]. Explain My Answer is free but covers set exercises [DU7]. | ● Khanmigo gives feedback on code (JS, HTML, Python, SQL) and on writing [KH3]. Writing Coach reviews outlines and drafts [KH23]. Only for paying US learners [KH4]. | ◐ "Smart grading" uses NLP to credit meaning, not exact wording (paid) [QZ3][QZ16]. Relaxed grading option [QZ4]. Ask Quizlet explains concepts [QZ9]. No formative feedback on the learner's answer described. | ● AI-graded open-ended essays, code and video with AI-generated rubrics [CO8]. AI peer review returns rubric-based written feedback in about 1 minute and allows resubmission [CO7]. Only in "select regions" or for selected partners [CO7][CO8]. | ◐ Learning Guide asks "probing, open-ended questions" [NB5]. "Explain" for cards and answers [NB4]. Grading of the learner's own open answers is not described. | ● LLM grades free-text and code answers against a rubric and gives formative feedback, with the right to appeal or override. |
| **C7 Social / collaborative learning (and whether competition can feel punitive)** | ● Weekly leaderboards with promotion and **demotion** [DU9][DU3]. Friends, Friend Streak, Friends Quests [DU10][DU11]. Friends shown in leaderboards [DU12]. **Punitive:** a mistake costs a heart, and a missed day breaks the streak unless a Streak Freeze is bought with gems [DU3]. Opt-out: private profile [DU9] or the Friends Quests setting [DU11]. | ◐ Questions and Tips under videos (13+, web only, 5,000 energy points required) [KH21]. Teacher classes [KH22]. Parent and teacher oversight [KH10]. No peer competition. | ● "Study with friends" shared sessions with group results and leaderboards (Blast, Blocks, Match). Each participant's score and missed terms are visible to the group [QZ10]. Classes [QZ14]. | ◐ Peer review of assignments [CO7]. Course forums (e.g. a linked forum in the sample course) [CO4]. No friends or leaderboards described. | ◐ Share notebooks with up to 50 people as viewer or editor, or by public link [NB6]. Share flashcard and quiz sets by link [NB5]. No competition. | ● Study teams with shared goals and team quests. **No demotion or loss for missed days.** Students choose what results they share. |
| **C8 Study-schedule / LMS integration and fitting lessons into the day** | ◐ Daily reminder at a chosen time [DU3]. Duolingo for Schools classrooms run on Duolingo's own site; no LMS mentioned [DU13]. | ◐ Google Classroom roster import, but no assignment sync [KH22]. Khanmigo teacher tools in Canvas (US) [KH14]. Weekly streak reminder [KH9]. No learner calendar. | ◐ Google Classroom classes and assignments with due dates [QZ13]. Spaced repetition decides when to review [QZ1]. The help center has no Moodle or LTI article. | ◐ Coursera for Campus: "Native LTI integrations to connect with Canvas, Blackboard, Moodle, and D2L" [CO11]. "Flexible schedules" [CO1]. Nothing fits lessons into free time. | ◐ Teachers can share notebooks into Canvas, Schoology and **Moodle** via Gemini LTI, and into Google Classroom (Workspace for Education only; students get read-only access) [NB9][NB10]. No scheduling. | ● Imports the student's Moodle deadlines (iCalendar), finds free slots, and places micro-lessons by free time, energy and deadlines, with quiet-hours reminders. |
| **C9 Privacy & data controls (export, deletion, AI training use)** | ◐ Deletion can be requested; app interactions and device IDs are shared for advertising and marketing [DU14]. App Store label: "Data Used to Track You", "Contains Advertising" [DU1]. Privacy policy and help pages render client-side, so **no public info** was readable on export or AI-training use. | ◐ Self-serve deletion with a 48-hour grace period [KH11]. Copy of data via settings or the privacy team. Third-party AI providers may not train on personal data [KH13]. Chats kept up to 365 days, research copies up to 2 years [KH12]. | ◐ Self-serve account deletion [QZ19]. Export only of one's own sets as copied text [QZ18]. Access via settings (GDPR page) [QZ20]. App Store label: tracking includes user content; contains ads [QZ1]. The privacy policy returned HTTP 403, so **no public info** on AI-training use. | ◐ Access, correction, deletion and a copy available in Settings. Deletion "may be disabled for some users" (for-credit). The notice does not address AI training [CO12]. App Store label: usage data used to track [CO1]. | ◐ Content "not used to train … unless you provide feedback"; feedback is human-reviewed and kept up to 3 years [NB8][NB7]. Workspace/Education content is never reviewed or used for training [NB8]. App Store label shows no tracking [NB1]. Deletion steps are not documented on the pages read. | ● Analytics off until the student opts in. Self-serve export and deletion. No ad tracking. A plain statement of what is sent to the LLM provider. |
| **C10 Platforms, RU/KK interface, pricing (USD, Oct 2026)** | ● Web, iOS, Android [DU1][DU9]. 33 interface languages including **Russian**, no Kazakh [DU1]. Free with ads and a Hearts/Energy limit [DU3][DU6]. Super $9.99–$12.99/mo, $83.99–$119.99/yr (App Store) [DU1]. Max: no public price found. | ● Web, iOS, Android [KH9][KH15]. **Kazakh and Russian** web "demo sites" with a subset of content; the app has neither [KH20][KH15]. Khan Academy is free. Khanmigo $4/mo or $44/yr, **US only** [KH2][KH4]. | ● Web, iOS, Android [QZ8][QZ1]. 19 interface languages including **Russian**, no Kazakh [QZ17]. Free tier with limits [QZ16]. App Store: Plus $9.99 / $44.99, Plus Unlimited $44.99 (billing periods not labeled) [QZ1]. AI study guides only in EN/FR/DE [QZ6]. Ask Quizlet US-only [QZ9]. | ● Web, iOS, Android, Apple TV [CO1]. App in 30 languages including **Kazakh and Russian** [CO1]. Many courses "Enroll for free" [CO4]. Coursera Plus $35/mo or $239/yr shown for Kazakhstan [CO2]. US App Store $58.99 [CO1]. | ● Web, iOS [NB1], Android [NB11]. App interface in 65 languages including **Russian**, no Kazakh [NB1]. Free Standard plan [NB7]. Google AI Plus $4.99, Pro $19.99 (App Store) [NB1]. Cinematic video for 18+, English, Ultra only [NB2]. | ● Installable PWA. EN/RU/**KK** interface and generated content. Pricing is not defined in the design. |
| ***Count* (●/◐/○)** | 4 / 5 / 1 | 5 / 5 / 0 | 5 / 4 / 1 | 3 / 7 / 0 | 2 / 7 / 1 | 10 / 0 / 0 *(planned)* |

*The counts are unweighted coverage, not a quality score. The YeahGrind column describes the proposed design.*

### Baseline

**Static course page + fixed quiz:** the lecture files and slides of a course in Moodle, read in the given order, followed by a fixed quiz with correct/incorrect feedback. This is what a student uses today without additional tools, and it is the control condition of the learning study ([09 §9.5](09-verification-evaluation-plan.md#95-learning-and-usability-study-against-the-baseline)).

| Criterion | Static course page + fixed quiz |
|---|---|
| C1 | Yes (university course) |
| C2 | No (same order for everyone) |
| C3 | No (lectures and chapters) |
| C4 | No |
| C5 | No (fixed quiz) |
| C6 | No (correct/incorrect only) |
| C7 | Partial (course forum if enabled) |
| C8 | Partial (deadlines in the Moodle calendar; manual export) |
| C9 | University policy |
| C10 | Web; free for students |

### Academic systems

Described from the verified publications in [03](03-literature-review.md) (L-numbers) and [05](05-technology-comparison.md) ([T114]).

| Criterion | ACT Programming Tutor (L9) | Math Garden [T114] | Outline Maps (L10) | Physics AI tutor (L18) | GPT Tutor (L19) | Synthetic video course (L7) |
|---|---|---|---|---|---|---|
| C1 | Partial (programming courses) | No (school maths) | No (general geography) | Yes (undergraduate physics) | No (high school) | Partial (adults) |
| C2 | Yes (until each rule mastered) | Partial (adaptive items) | Partial (adaptive items) | Partial (fixed lessons, scaffolded) | No | No |
| C3 | Not described | Yes (short items) | Yes (short questions) | No (≈ 49 min lessons) | Not described | Yes |
| C4 | No | No | No | No | No | Partial (made by authors) |
| C5 | Yes (BKT) | Yes (on-the-fly estimation) | Yes (Elo) | Not described | No | No |
| C6 | Partial (fixed exercises) | No (closed items) | No | Yes (grounded GPT-4) | Partial (hints only) | No |
| C7 | No | Not described | Not described | No | No | No |
| C8 | No | No | No | No | No | No |
| Evaluation | Faster completion, equal or better scores | Deployed system | > 15 M answers | RCT, 0.63–1.3 SD | Field experiment, ≈ 1,000 students | Experiment, n = 83 |

Each academic system shows that one component works — mastery-based tutoring, adaptive practice without calibration, grounded AI tutoring, guarded hints, generated video in microlearning — but each was built and evaluated separately on fixed content.

## 4.5 Gap analysis and implications for requirements

- **G1.** **Video generation and adaptivity sit in different products (C4 vs C2/C5).** NotebookLM is the only system that generates short videos from the learner's material, but it has no learning path and no adaptive assessment [NB2][NB4]. The adaptive systems either have no video (Duolingo, Quizlet) [DU8][QZ1] or use a fixed library of pre-produced videos (Khan Academy) [KH16]. NotebookLM also has no Kazakh narration and can take over 30 minutes to generate a video [NB2]. *Implication →* generate a short video (≤90 s) for each micro-lesson inside the adaptive path (script by LLM → slides/visuals → narration in EN/RU/KK). Generation must run in the background with caching, and fall back to a text or audio lesson so the path never waits for a render. *(FR-11, FR-19 – FR-24)*
- **G2.** **Adaptive assessment only works inside each vendor's own content (C5).** Birdbrain models language exercises [DU4]. Khan's mastery levels apply to Khan skills [KH17]. Quizlet Learn adapts within one flashcard set [QZ2]. Coursera's graded quizzes are not adaptive [CO8], and NotebookLM's quiz difficulty is set by the user [NB4]. None estimates mastery for an arbitrary university subject or a goal the learner chose. *Implication →* a topic-level mastery model over *generated* items that selects difficulty from the learner's answers. The mastery estimate should be visible to the student and should decide the next micro-lesson. Item difficulty must be calibrated after generation, because LLM-written items have no prior statistics. *(FR-08, FR-25 – FR-27)*
- **G3.** **AI feedback on open answers exists but is restricted (C6).** Khanmigo's feedback on code and writing is sold only to US learners [KH3][KH4]. Coursera's AI grading launched for text submissions in "select regions" and is limited to selected partners [CO7][CO8]. Duolingo's Roleplay feedback needs Max [DU8]. Quizlet's smart grading only accepts paraphrases and gives no formative feedback [QZ3]. *Implication →* rubric-based LLM grading of free text and code with formative (not just pass/fail) feedback, available to every student. Students need a way to override or appeal, as Quizlet ("I was correct") and Coursera (switch to human grading) provide [QZ3][CO7]. Guardrails must keep feedback guiding rather than handing over answers [KH3]. *(FR-28, FR-29)*
- **G4.** **Social mechanics are mostly competitive and can punish (C7).** Duolingo demotes learners between leagues, takes a heart for each mistake, and breaks streaks unless a Streak Freeze is bought with gems [DU9][DU3]. Its own opt-out is to make the profile private, which also removes friends [DU9]. Quizlet group sessions show every participant's score and missed terms [QZ10]. Khan Academy discussions require 5,000 energy points [KH21]. *Implication →* cooperative study teams (shared goals, team quests, encouragement) with no demotion and no loss for missed days. Results stay private by default and are shared only by the student's choice. *(FR-31 – FR-34, FR-38)*
- **G5.** **No system fits learning into the student's actual day (C8).** Every LMS integration found is set up by teachers or institutions: Coursera LTI and Gemini LTI (both include Moodle), and Google Classroom [CO11][NB9][QZ13][KH22]. On the learner side there are only reminders (Duolingo) [DU3] and spaced-repetition timing (Quizlet) [QZ1]. None uses the learner's free time, energy, or *personal* Moodle deadlines. *Implication →* learner-side Moodle iCalendar import, detection of free slots, a daily energy and time check-in, and automatic placement of micro-lessons before relevant deadlines, with reminders that respect quiet hours. *(FR-12, FR-16, FR-17)*
- **G6.** **Higher-ed content does not come in microlearning form (C1 vs C3).** The microlearning products are general or school-level: Duolingo's maths is for grades 6–9, and Khan Academy targets K-12 through college [DU12][KH1]. The higher-ed product, Coursera, is organized into 4–12-hour courses with labs of about an hour [CO3][CO4]. *Implication →* break university-level subjects into micro-units of 10 minutes or less, each with its own video, check questions and mastery update, linked to the student's actual courses. *(FR-05, FR-06, FR-09)*
- **G7.** **Kazakh support is patchy, and the strongest AI features are paid or regional (C10).** Kazakh appears only in Coursera's app interface, on Khan Academy's demo site, and in Khanmigo's untested chat replies [CO1][KH20][KH6]. NotebookLM's videos, Duolingo and Quizlet do not support it [NB2][DU1][QZ17]. Quizlet's AI study guides are English/French/German only, and Ask Quizlet is US-only [QZ6][QZ9]. Coursera Plus costs $35/month in Kazakhstan [CO2], and Khanmigo is US-only [KH4]. *Implication →* a full EN/RU/KK interface *and* generated content (video narration, questions, feedback) in Kazakh. Free access for students, made affordable by AI cost controls (quotas, caching of generated lessons and videos). *(FR-23, FR-40, NFR-13)*
- **G8.** **No system meets all the data-control points (C9: every system ◐).** Duolingo, Quizlet and Coursera declare tracking data in their App Store labels [DU1][QZ1][CO1]. Coursera's notice does not address AI training [CO12]. NotebookLM keeps human-reviewed feedback for up to 3 years [NB8]. Quizlet's export covers only the text of one's own sets [QZ18]. *Implication →* no advertising trackers, analytics only after opt-in, a self-serve full export and deletion, a clear statement that learner answers sent to the LLM provider are not used for training, and fixed retention periods for answers and check-in data. *(FR-03, FR-04, NFR-06)*

**Conclusion.** Each product is strong in its own area:

| System | Strength |
|---|---|
| Duolingo | Adaptive microlearning |
| Khan Academy | Mastery-based progression and expert videos |
| Quizlet | Study sets generated from the learner's own notes |
| Coursera | Higher-education courses with AI grading |
| NotebookLM | Short videos generated from the learner's sources |

None combines the four parts of the topic for an arbitrary university subject: an adaptive microlearning pathway, generated short videos, adaptive assessment and cooperative social learning. None fits that learning into the student's own day using personal Moodle deadlines, and none supports Kazakh (G1–G7).

YeahGrind reuses patterns these products have validated:
- mastery levels and "next skill" recommendations (Khan Academy);
- difficulty-matched exercise selection (Duolingo Birdbrain);
- generation from own material (Quizlet, NotebookLM);
- rubric-based AI feedback with appeal (Coursera, Quizlet).

It adds the missing combination and avoids the punitive mechanics (demotion, hearts, paid streak repair).

## 4.6 References (all accessed 21 October 2026)

**Duolingo (DU)**
- [DU1] Duolingo — App Store (US) listing (description, 33 interface languages, in-app purchase prices, privacy label). https://apps.apple.com/us/app/duolingo-language-lessons/id570060128
- [DU2] The Duolingo Method: 5 key principles (2 Feb 2023). https://blog.duolingo.com/duolingo-teaching-method/
- [DU3] Duolingo 101: How to learn a language on Duolingo (2 Dec 2024). https://blog.duolingo.com/duolingo-101-how-to-learn-a-language-on-duolingo/
- [DU4] Learning how to help you learn: Introducing Birdbrain! (7 Oct 2020). https://blog.duolingo.com/learning-how-to-help-you-learn-introducing-birdbrain/
- [DU5] Keeping you at the frontier of learning with adaptive lessons (26 May 2020). https://blog.duolingo.com/keeping-you-at-the-frontier-of-learning-with-adaptive-lessons/
- [DU6] Why Duolingo switched to Energy (3 Jul 2025). https://blog.duolingo.com/duolingo-energy/
- [DU7] Explain My Answer is now free for all learners (1 Jan 2026). https://blog.duolingo.com/explain-my-answer-now-free/
- [DU8] Introducing Duolingo Max (14 Mar 2023). https://blog.duolingo.com/duolingo-max/
- [DU9] How Duolingo Leaderboards and Leagues Work (3 May 2023). https://blog.duolingo.com/duolingo-leagues-leaderboards/
- [DU10] Duolingo's Best Social Features (6 Jun 2023). https://blog.duolingo.com/friends-social-features/
- [DU11] Friends Quests Are Duolingo's Newest Social Feature (9 Sep 2022). https://blog.duolingo.com/friends-quests/
- [DU12] 2025 Duolingo Highlights (10 Dec 2025). https://blog.duolingo.com/product-highlights/
- [DU13] Introducing Duolingo for Schools (25 May 2021). https://blog.duolingo.com/introducing-duolingo-for-schools-the-ultimate-partner-for-language-teachers/
- [DU14] Duolingo — Google Play Data safety. https://play.google.com/store/apps/datasafety?id=com.duolingo&hl=en_US&gl=US
- *Notes:*
  - duolingo.com/privacy and duolingo.com/help/* render client-side; only the page title could be retrieved.
  - schools.duolingo.com returned HTTP 500.

**Khan Academy + Khanmigo (KH)**
- [KH1] Khanmigo home page. https://www.khanmigo.ai/
- [KH2] Khanmigo Pricing. https://www.khanmigo.ai/pricing
- [KH3] Khanmigo for learners. https://www.khanmigo.ai/learners
- [KH4] What features are available in the Learner, Parent, and Teacher Khanmigo subscription plans? https://support.khanacademy.org/hc/en-us/articles/25921448458893
- [KH5] How do I sign up for Khanmigo? https://support.khanacademy.org/hc/en-us/articles/13982227159437
- [KH6] Which languages can I use for Khanmigo and free teacher tools? https://support.khanacademy.org/hc/en-us/articles/41626114291469
- [KH7] What are energy points, badges, and avatars? https://support.khanacademy.org/hc/en-us/articles/202487710
- [KH8] Where can I access Khanmigo while working on Khan Academy? https://support.khanacademy.org/hc/en-us/articles/13982530363533
- [KH9] Does Khan Academy have an official mobile app? (v8.5.0 streak reminder, Aug 2026). https://support.khanacademy.org/hc/en-us/articles/202487540
- [KH10] What safety features does Khanmigo have? https://support.khanacademy.org/hc/en-us/articles/14394814244365
- [KH11] How do I delete my account? https://support.khanacademy.org/hc/en-us/articles/360034662972
- [KH12] What are Khan Academy's Deletion Practices? https://support.khanacademy.org/hc/en-us/articles/29415446635021
- [KH13] How does Khan Academy protect the data privacy rights of international users? https://support.khanacademy.org/hc/en-us/articles/47347953719949
- [KH14] AI-Teaching Assistant Khanmigo Now Available in Canvas (Khan Academy Blog). https://blog.khanacademy.org/ai-teaching-assistant-khanmigo-now-available-in-canvas-trusted-ai-to-streamline-prep-right-inside-your-lms/
- [KH15] Khan Academy — App Store (US) listing (description, languages, no in-app purchases). https://apps.apple.com/us/app/khan-academy/id469863705
- [KH16] How Khan Academy Videos Are Made to Help You Learn (Khan Academy Blog). https://blog.khanacademy.org/how-khan-academy-videos-are-made-to-help-you-learn/
- [KH17] How do Khan Academy's Mastery levels work? https://support.khanacademy.org/hc/en-us/articles/5548760867853
- [KH18] What are Course and Unit Mastery? https://support.khanacademy.org/hc/en-us/articles/115002552631
- [KH19] What are Mastery Challenges? https://support.khanacademy.org/hc/en-us/articles/360037494231
- [KH20] What languages is Khan Academy available in? https://support.khanacademy.org/hc/en-us/articles/226457308
- [KH21] How can I access discussions under articles and videos? https://support.khanacademy.org/hc/en-us/articles/4411209335181
- [KH22] How do I import my Google Classroom roster to Khan Academy? https://support.khanacademy.org/hc/en-us/articles/360030760852
- [KH23] How do I use Writing Coach? https://support.khanacademy.org/hc/en-us/articles/47750153633165
- [KH24] How can I understand my progress in Khan Academy? https://support.khanacademy.org/hc/en-us/articles/360032987591
- *Note:* support.khanacademy.org returns HTTP 403 to the page fetcher, so help articles were read through the same help center's public article API (`/api/v2/help_center/en-us/articles/<id>.json`).

**Quizlet (QZ)**
- [QZ1] Quizlet: More than Flashcards — App Store (US) listing (description, languages, in-app purchases, privacy label). https://apps.apple.com/us/app/quizlet-ai-study-flashcards/id546473125
- [QZ2] Studying with Learn. https://help.quizlet.com/hc/en-us/articles/360030986971
- [QZ3] Studying with Write mode (smart grading). https://help.quizlet.com/hc/en-us/articles/360030990531
- [QZ4] Using grading options (US). https://help.quizlet.com/hc/en-us/articles/360048313652
- [QZ5] Creating study sets with Smart Assist. https://help.quizlet.com/hc/en-us/articles/39606772122509
- [QZ6] Studying with Study Guides. https://help.quizlet.com/hc/en-us/articles/18312306436365
- [QZ7] Studying with Practice Tests. https://help.quizlet.com/hc/en-us/articles/25946589648013
- [QZ8] Studying with Audio Notes. https://help.quizlet.com/hc/en-us/articles/47540466130829
- [QZ9] Studying with Ask Quizlet. https://help.quizlet.com/hc/en-us/articles/42790350723725
- [QZ10] Using Study with friends. https://help.quizlet.com/hc/en-us/articles/48158602540685
- [QZ11] Studying with Answer Streaks. https://help.quizlet.com/hc/en-us/articles/40011154960653
- [QZ12] Playing Charms. https://help.quizlet.com/hc/en-us/articles/47712424067341
- [QZ13] Using Quizlet classes with Google Classroom. https://help.quizlet.com/hc/en-us/articles/360030874992
- [QZ14] Guide: Managing classes. https://help.quizlet.com/hc/en-us/articles/360031160932
- [QZ15] Free student access to Learn and Test modes. https://help.quizlet.com/hc/en-us/articles/34270983035149
- [QZ16] Subscribing to Quizlet. https://help.quizlet.com/hc/en-us/articles/360041181691
- [QZ17] Changing language settings. https://help.quizlet.com/hc/en-us/articles/360031056971
- [QZ18] Exporting your sets. https://help.quizlet.com/hc/en-us/articles/360034345672
- [QZ19] Deleting your account. https://help.quizlet.com/hc/en-us/articles/360029768552
- [QZ20] GDPR compliance. https://help.quizlet.com/hc/en-us/articles/360030253571
- *Notes:*
  - quizlet.com pages (/upgrade, /features/ai-study-tools, /privacy) returned HTTP 403. Help articles were read through the help center's public article API.
  - A search of the help center for "Moodle" and "LTI" returned no articles.

**Coursera (CO)**
- [CO1] Coursera: Grow your career — App Store (US) listing (description, 30 app languages incl. Kazakh and Russian, in-app purchases, privacy label). https://apps.apple.com/us/app/coursera-grow-your-career/id736535961
- [CO2] Coursera Plus page. Prices shown as rendered for a visitor from Kazakhstan (page data: priceCountryIsoCode "KZ", currency USD). https://www.coursera.org/courseraplus
- [CO3] How does Coursera work? https://www.coursera.org/about/how-coursera-works
- [CO4] Supervised Machine Learning: Regression and Classification — course page (video counts and durations, forum, "Enroll for free"). https://www.coursera.org/learn/machine-learning
- [CO5] Coursera Coach: Providing Essential Learner Support (18 Dec 2024). https://blog.coursera.org/coursera-coach-providing-essential-learner-support/
- [CO6] Announcing AI-powered capabilities enabling educators to use Coursera Coach (17 Sep 2024). https://blog.coursera.org/announcing-ai-powered-capabilities-enabling-educators-to-use-coursera-coach-to-deliver-interactive-personalized-instruction/
- [CO7] AI Grading in Peer Reviews (5 Sep 2024). https://blog.coursera.org/ai-grading-in-peer-reviews-enhancing-courseras-learning-experience-with-faster-high-quality-feedback/
- [CO8] New AI-powered innovations on Coursera (9 Sep 2025). https://blog.coursera.org/new-ai-powered-innovations-on-coursera/
- [CO9] Coursera launches a new suite of Academic Integrity features (11 Jun 2024). https://blog.coursera.org/coursera-launches-academic-integrity-features-to-help-universities-verify-learning-in-an-age-of-ai-assisted-cheating/
- [CO10] Coursera for Campus. https://www.coursera.org/campus
- [CO11] Coursera for Campus — Compare Plans (native LTI: Canvas, Blackboard, Moodle, D2L). https://www.coursera.org/campus/compare-plans
- [CO12] Coursera Privacy Notice (last updated 14 Oct 2026). https://www.coursera.org/about/privacy
- *Note:* the Coursera Learner Help Center (coursera.support) renders client-side and could not be read, so help-center claims (e.g. web interface languages) are not used.

**Google NotebookLM / Gemini Notebook (NB)**
- [NB1] Gemini Notebook — App Store (US) listing (description, 65 languages, in-app purchases, privacy label). https://apps.apple.com/us/app/google-notebooklm/id6737527615
- [NB2] Generate Video Overviews in Gemini Notebook (Help; formats, language lists, generation time). https://support.google.com/notebooklm/answer/16454555?hl=en
- [NB3] NotebookLM Video Overviews now use Nano Banana, Brief format (Google Blog, 13 Oct 2025). https://blog.google/innovation-and-ai/models-and-research/google-labs/video-overviews-nano-banana/
- [NB4] Generate Flashcards or Quizzes in Gemini Notebook (Help). https://support.google.com/notebooklm/answer/16958963?hl=en
- [NB5] 6 NotebookLM features to help students learn (Google Blog, 8 Sep 2025). https://blog.google/innovation-and-ai/models-and-research/google-labs/notebooklm-student-features/
- [NB6] Create a notebook in Gemini Notebook (Help; sharing roles, 50-user limit, public links). https://support.google.com/gemininotebook/answer/16206563?hl=en
- [NB7] Learn about Gemini Notebook's plans (Help; Standard/Plus/Pro/Ultra limits, training statement). https://support.google.com/notebooklm/answer/16213268?hl=en
- [NB8] Privacy and Terms of Use in Gemini Notebook (Help). https://support.google.com/notebooklm/answer/17004255?hl=en
- [NB9] Share and access notebooks & Gems — Google Workspace LTI Help (Canvas, Schoology, Moodle). https://support.google.com/edu/assignments/answer/16450994?hl=en
- [NB10] Create and assign Gemini Notebook in Google Classroom (Classroom Help). https://support.google.com/edu/classroom/answer/16534159
- [NB11] NotebookLM — Google Play Data safety (confirms the Android app; deletion requests). https://play.google.com/store/apps/datasafety?id=com.google.android.apps.labs.language.tailwind&hl=en_US&gl=US

**Considered for the fifth slot**
- [SY1] Synthesia home page (business video platform for L&D, HR, sales, marketing; free Basic plan). https://www.synthesia.io/
- [CB1] Coursebox home page (AI course builder for course creators; AI videos, quizzes with AI grading, SCORM/LTI export). https://www.coursebox.ai/
