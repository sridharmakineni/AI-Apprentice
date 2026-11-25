# Week 2 — Python for AI

**Book I, Chapter 2.** Estimated 8–12 hours. More if Python is genuinely new to you.

## Why this week exists

You are not becoming a Python developer. You are becoming fluent in the roughly fifteen
percent of the language that every AI tutorial, SDK and code sample silently assumes.

The test of this week is not whether you can write Python from memory. It is whether you
can look at twenty unfamiliar lines and say *I know what that does* rather than *I hope
that works*. That distinction matters more than it sounds, because from week 5 onward
you will be reading far more code than you write — documentation, samples, and code a
model generated for you that may quietly embed a credential or swallow an error.

If you write PowerShell or build Power Platform solutions, you are closer to this than
you think. You have been modelling processes and handling failure cases for years. What
follows is new syntax for ideas you already hold.

## Learning objectives

By the end of the week you can, without looking anything up:

1. Choose correctly between a list, dict, tuple and set
2. Read a value out of a nested API response, safely
3. Convert between JSON and Python in both directions
4. Write a function with a default argument and a docstring
5. Read a list comprehension without translating it in your head
6. Explain why credentials never go in source and why `timeout` matters
7. Create a virtual environment and record dependencies

## Reading

- [Chapter 2](../../books/book-1-foundations/manuscript/chapter-02.md) — the core material
- [Python's official tutorial, sections 3–5](https://docs.python.org/3/tutorial/) — data
  structures, control flow, functions. Skim; don't complete it
- [The `json` module](https://docs.python.org/3/library/json.html) — short, worth reading
  properly

Do not take a 40-hour Python course. You will spend the time and arrive at week 5 having
learned decorators and metaclasses while still being unsure what `response.json()`
returns.

## Set up your environment

Do this before anything else — it is where people lose an afternoon.

```bash
cd projects/week-02
python -m venv .venv
.venv\Scripts\activate          # Windows
pip install requests
pip freeze > requirements.txt
```

If `python` is not found, install from python.org and tick **"Add Python to PATH"**
during setup. If activation fails in PowerShell with an execution-policy error, run
`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` and try again.

You will know it worked when your prompt shows `(.venv)`.

## Notes to take as you read

Keep these in `curriculum/week-02/notes.md` — they feed your chapter revisions.

- The error message that confused you longest, and what it actually meant
- One thing you assumed worked like PowerShell and didn't
- The moment a comprehension stopped looking like noise
- Something a coding assistant generated that was subtly wrong

That last one is the most valuable note you will take all week.

## The gates

| Gate | What it takes | Where |
|---|---|---|
| Quiz | 20 MCQs, 80% to pass | `python tools/quiz_runner.py 2` |
| Project | Directory search + README | [assignment.md](assignment.md) |
| Chapter | 2,500 words drafted | `books/book-1-foundations/manuscript/chapter-02.md` |

```bash
python tools/gate_check.py 2
git tag week-02-complete && git push origin week-02-complete
```

## A warning about week 2

The failure mode here is tutorial drift — following along with videos, feeling
productive, and never writing anything from a blank file. Typing someone else's code
teaches you the syntax and none of the judgment.

Build the directory project early and badly. Then fix it. The bugs are the lesson.
