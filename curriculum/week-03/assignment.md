# Week 3 Assignment — The Token Audit

**Deliverable:** a short written analysis in `projects/week-03/README.md`. Ungated, but
the single most useful exercise in Book I.

## The brief

Pick a real system at your workplace that someone has suggested "adding AI" to. A
service desk. A policy lookup. A document summarizer. Something that actually exists and
has actual volume.

Then answer, in writing, the question you will eventually be asked out loud: **what
would this cost to run for a year?**

## Part 1 — Measure, don't estimate

Take real data from that system. Not a sample sentence — real tickets, real policy text,
real email.

| Measure | Your number |
|---|---|
| Characters in a typical input | |
| Tokens in that same input | |
| Ratio (tokens per character) | |
| Same ratio for a block of JSON or IDs | |

Use a tokenizer tool rather than guessing. The gap between the two ratios is the point
of this exercise.

## Part 2 — Build the arithmetic

Write out, showing your working:

```text
input tokens per request  = system prompt + retrieved context + user question
output tokens per request = typical answer length
requests per day          = users × requests each
annual                    = requests per day × 250 working days
```

Then state which component dominates, and what you would change first if asked to halve
the cost.

Most people discover the answer is "retrieved context," which is the finding that makes
chunking strategy in Book II feel urgent rather than academic.

## Part 3 — Test temperature yourself

Take one real task with a correct answer — classifying ten tickets, extracting a field
from ten documents. Run it three times at temperature 0, then three times at 1.0.

Record how many of the thirty results differ. Then answer in one sentence: could you
have tested this system at 1.0?

## Part 4 — The conversation multiplier

Rerun your Part 2 arithmetic assuming it is a multi-turn conversation that resends the
full history, averaging six turns.

Compare the two annual figures. That gap is the cost of statelessness, and it is the
number most proposals omit entirely.

## What goes in the repo

```text
projects/week-03/
└── README.md       the four parts, with your actual numbers
```

## Why this one matters disproportionately

Everything else in Book I teaches you to build. This teaches you to answer the question
that decides whether anything you build gets approved.

It is also the chapter material you are most likely to be asked about in an interview,
because it is the fastest way to distinguish someone who has shipped an AI system from
someone who has followed a tutorial. Tutorials never mention cost.

Keep the numbers. They become a worked example in your chapter, and a worked example
with real figures from a real system is exactly the thing a reader cannot get from
Microsoft Learn.
