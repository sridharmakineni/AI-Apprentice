# Week 1 Assignment — The "What is AI?" Deck

**Deliverable:** a 10-slide deck, committed to `projects/week-01/` alongside a README.

## The brief

You are presenting to a room of colleagues in your own organization — IT staff, business
analysts, a couple of managers. They are not stupid and not technical. Several of them
have been told by a vendor this year that something is "AI-powered" and privately
suspect it isn't.

Your job is not to impress them. It is to leave them able to ask better questions.

## Why a deck and not an essay

Because you cannot hide in slides. An essay lets you write four paragraphs that sound
informed around a concept you only half-grasp. Ten slides force you to compress each
idea to its load-bearing sentence, and compression is where you find out what you
actually know.

You will also do exactly this at work within six months. Practise now.

## Required slides

| # | Slide | The test it sets |
|---|---|---|
| 1 | Title + the question the deck answers | Can you state the point in one line? |
| 2 | The hierarchy — AI → ML → DL → GenAI | Can you draw it from memory? |
| 3 | Automation vs machine learning, with a real example from your workplace | Do you see the distinction in the wild? |
| 4 | What generative AI actually does | Can you say it without saying "it understands"? |
| 5 | Three things it does well | Grounded in your own job, not generic |
| 6 | Three things it does badly | Harder and more valuable than slide 5 |
| 7 | Hallucination — what and why | Explain the cause, not just the symptom |
| 8 | What an agent is, and how it differs from a chatbot | The loop, not the model size |
| 9 | Five questions to ask any AI vendor | Your actual contribution |
| 10 | Where this is going in our organization | An opinion, held honestly |

## Rules

- **No slide may contain the phrase "AI understands."** It doesn't, and the shortcut
  will cost you clarity later when you are debugging why it got something wrong.
- **Slide 6 must be specific.** "It makes mistakes" is not an answer. "It cannot be
  trusted to compute payroll deductions, because token prediction is not arithmetic" is.
- **Slide 9 is yours.** Don't copy a list. Write the five questions you would actually
  ask, having read this week's material.
- Every claim on a slide should survive someone asking "how do you know that?"

## What goes in the repo

```text
projects/week-01/
├── README.md          what the deck argues, what you got wrong first, what you'd redo
└── what-is-ai.pptx    (or .pdf / .md — format is yours)
```

The README matters more than the deck. Write it *after* you build the slides, and be
honest in it — what did you believe on Monday that you no longer believe? That paragraph
is the one that ends up in the published chapter, because it's the only part a reader
can't get from the documentation.

## The gate

```bash
python tools/gate_check.py 1
```

Passes once `projects/week-01/README.md` exists. The checker verifies the file is there,
not that the deck is good — that part is on you.

## If you want to push further

Present it to one actual human being. A colleague, a friend, your manager. The questions
they ask will show you which slides are weak far faster than re-reading them will, and
the good ones belong in your chapter.
