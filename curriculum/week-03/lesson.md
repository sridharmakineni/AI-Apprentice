# Week 3 — Inside the Model

**Book I, Chapter 3.** Estimated 6–9 hours.

## Why this week exists

Week 1 gave you vocabulary. Week 2 gave you a language. This week gives you the four
dials that every cost estimate, latency complaint and architecture argument in the rest
of this programme turns on: **tokens**, the **context window**, **temperature**, and
**embeddings**.

There is a specific moment this week is preparing you for. Someone senior will ask what
an AI feature will cost to run, and the people who can answer that question credibly are
a small minority of the people who can build the feature. Being in that minority is
worth more to your career than knowing another framework.

## Learning objectives

By the end of the week you can:

1. Explain why a prompt of employee IDs costs more than the same length of English
2. State why the context window is not memory, and what that implies for cost
3. Give the economic argument against putting 50,000 PDFs in a prompt
4. Choose a temperature for a given task and defend it
5. Explain embeddings and cosine similarity to a non-technical colleague
6. Recite the Azure embedding limits and recognise what each error code means
7. Estimate the annual token cost of a described system, roughly, out loud

Objective 7 is the one that changes how people treat you in meetings.

## Reading

- [Chapter 3](../../books/book-1-foundations/manuscript/chapter-03.md) — the core material
- [Understand embeddings in Azure OpenAI](https://learn.microsoft.com/azure/ai-foundry/openai/concepts/understand-embeddings)
- [Azure OpenAI quotas and limits](https://learn.microsoft.com/azure/ai-services/openai/quotas-limits)
  — skim, then keep the tab. You will come back to it repeatedly

## Do this before you read

Open a tokenizer tool and paste in three things: a paragraph of your own writing, a
block of JSON from a real system at work, and a list of twenty employee IDs or ticket
numbers. Note the token counts against the character counts.

Five minutes, and it makes the entire chapter concrete before you read a word of it.

## Notes to take

In `curriculum/week-03/notes.md`:

- The ratio of tokens to characters for your three samples, and which surprised you
- A system at your workplace where conversation history would quietly inflate cost
- The clearest one-sentence explanation of embeddings you can write for a manager
- A task you would run at temperature 0, and one you would not

## The gates

| Gate | What it takes | Where |
|---|---|---|
| Quiz | 20 MCQs, 80% to pass | `python tools/quiz_runner.py 3` |
| Chapter | 2,500 words drafted | `books/book-1-foundations/manuscript/chapter-03.md` |

No project gate this week — the exercise in [assignment.md](assignment.md) is worth
doing but isn't gated, because the chapter and quiz already demand the understanding.

```bash
python tools/gate_check.py 3
git tag week-03-complete && git push origin week-03-complete
```

## A warning about week 3

This is the most abstract material in Book I, and the temptation is to read it, nod, and
move on. The nodding is the problem — these concepts feel obvious on the page and turn
out to be genuinely unintuitive the first time you have to apply them to a real cost
question.

Do the tokenizer exercise. Do the cost arithmetic by hand, on a system you actually
know. Abstract understanding of tokens is worth very little; arithmetic you have done
yourself sticks.
