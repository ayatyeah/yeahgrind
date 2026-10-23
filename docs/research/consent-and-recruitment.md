# Recruitment and Consent

Applies to the requirement interviews (I-01 … I-05) and the learning and usability study ([09 §9.5](../09-verification-evaluation-plan.md#95-learning-and-usability-study-against-the-baseline)).

## Selection

- Adult (18+) AITU students who are **not** involved in the project and are not close friends of the interviewer.
- Aim for variety across the 3–5 interviews:

| Slot | Target profile |
|---|---|
| I-01 | 1st- or 2nd-year Software Engineering student |
| I-02 | Student from a non-IT program |
| I-03 | Student who works part-time or has another regular commitment |
| I-04 | Student who regularly uses a learning app or video courses (Duolingo, Quizlet, Khan Academy, YouTube) |
| I-05 | Student who usually prepares for exams together with friends |

- Participants of the requirement interviews do not take part in the learning and usability study later, so that earlier exposure to the concept does not bias the comparison.

## Recruitment message

> Hi! We are Software Engineering students at AITU working on our diploma project about how students learn on their own and with friends. We are looking for students for a 25–30 minute conversation about how you study. There are no right or wrong answers, and no preparation is needed. Your name will not appear anywhere. Would you be up for it this week? You can choose the time and do it online or on campus.

## Consent script (read aloud before starting)

> Thank you for joining. This conversation is part of our diploma project at AITU. We want to understand how students organize their studies so that we can design a better tool.
>
> - Taking part is voluntary. You can skip any question or stop at any moment without giving a reason.
> - We will take notes. With your permission we will also record audio, only to check our notes. The recording will be deleted after the notes are written.
> - Your name will not be written in the notes. We use a code such as I-02. Quotes in our documents will not contain anything that identifies you.
> - Notes are stored in our project repository and are accessible only to the team, our supervisor and the diploma committee.
> - You can ask us to delete your notes until the final defense by contacting Ayat Balmagambet at 240075@astanait.edu.kz.
>
> Do you agree to take part? May we record audio?

Record the answers in the notes file: `Consent: yes/no`, `Audio: yes/no`.

## Data handling

| Data | Where stored | Retention |
|---|---|---|
| Audio recording (if allowed) | Interviewer's encrypted device, not in Git | Deleted after the notes are written (≤ 48 h) |
| Pseudonymized notes | The team's private copy, outside the public repository; shown to the supervisor and the committee on request | Until the end of the diploma project |
| Mapping of codes to real names | Not created | — |
| Study measurements (tests, timings, SUS) | `docs/evaluation/` (pseudonymized CSV) | Until the end of the diploma project |

The project repository is public, so completed notes are not committed to it; this keeps the promise in the consent text that only the team, the supervisor and the committee can read them.

Personal data is handled according to the Law of the Republic of Kazakhstan "On Personal Data and Their Protection" (No. 94-V, 21 May 2013).
