# Week 4 — Prompt Engineering

**Book I, Chapter 4.** Estimated 8–12 hours. The last week of Book I.

## Why this week exists

Everyone thinks they can prompt. Most people can produce a prompt that works on the
example they thought of, and have no way of knowing whether it works on the other
nineteen.

This week is about the second half of that sentence. Writing prompts is the easy part
and takes an afternoon. **Knowing whether a prompt is any good** is a real skill, it is
rare, and it is the thing that separates people who ship reliable AI systems from people
who ship demos that fail quietly in production.

If you only properly do one week of Book I, do this one.

## Learning objectives

By the end of the week you can:

1. Name the five components of a specified prompt and spot which is missing
2. Choose between zero-, one- and few-shot, and know which examples to add
3. Get reliably parseable structured output
4. Explain prompt injection and why wording cannot fix it
5. Write a refusal path that actually prevents invention
6. **Build a test set and use it to decide whether one prompt beats another**

Objective 6 is the week. The rest is preparation for it.

## Reading

- [Chapter 4](../../books/book-1-foundations/manuscript/chapter-04.md) — the core material
- [Prompt engineering techniques](https://learn.microsoft.com/azure/ai-foundry/openai/concepts/prompt-engineering)
- Revisit [chapter 1](../../books/book-1-foundations/manuscript/chapter-01.md)'s section
  on hallucination. It reads differently now, and the refusal path is the answer to it

## Notes to take

In `curriculum/week-04/notes.md`:

- A prompt you were sure would work, that didn't, and your diagnosis
- The smallest change that produced the biggest improvement
- A case where few-shot beat a longer explanation
- Any output that would have broken your parser, and what fixed it

## The gates

| Gate | What it takes | Where |
|---|---|---|
| Quiz | 20 MCQs, 80% to pass | `python tools/quiz_runner.py 4` |
| Project | Prompt library + evaluation | [assignment.md](assignment.md) |
| Chapter | 2,500 words drafted | `books/book-1-foundations/manuscript/chapter-04.md` |

```bash
python tools/gate_check.py 4
git tag week-04-complete && git push origin week-04-complete
```

## What happens when this week closes

`week-04-complete` is not an ordinary tag. It means **Book I is finished** — four
chapters, four projects, four passed assessments.

At that point the publishing pipeline has something to publish: an EPUB build, a cover
to commission, and two storefronts already waiting with the name claimed. The gap
between here and a book on sale is this one week.

## A warning about week 4

The failure mode is writing twenty prompts and calling it done. Twenty prompts written
is an afternoon's typing. Twenty prompts *evaluated* — against real inputs, scored
against expectations you committed to in advance, with one documented iteration — is
genuinely hard and genuinely rare.

The exam asks for the second thing. Do the first and you will have learned nothing you
couldn't have read in a blog post.
