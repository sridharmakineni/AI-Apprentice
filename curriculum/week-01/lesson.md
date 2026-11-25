# Week 1 — What is AI?

**Book I, Chapter 1.** Estimated 6–9 hours. Take longer if you need it; the gates don't
watch the clock.

## Why this week exists

You will spend the next fifteen weeks building things. This week is the only one with no
code in it, and skipping it is tempting. Don't.

The reason is narrow and practical: for the rest of the programme you will be making
*choices* — RAG or fine-tuning, agent or workflow, frontier model or small one — and
every one of those choices is made badly by people who never learned what the words
mean. Vocabulary here is not academic. It is the difference between recommending the
right architecture in a meeting and being the person who said "let's just fine-tune it"
about 50,000 PDFs.

## Learning objectives

By the end of the week you can, without notes:

1. Place AI, ML, deep learning and generative AI in their correct nesting
2. Say whether a given system is automation or machine learning, and defend it
3. Explain what makes something an *agent* rather than a chatbot
4. Name three tasks generative AI is good at and three it is bad at — and say why
5. Explain hallucination to a non-technical stakeholder without apologizing for it
6. Separate "the model learns from my prompts" (technical) from "my data is retained"
   (contractual)

## The hierarchy

```
Artificial Intelligence ............ any system doing things that need intelligence
  └─ Machine Learning .............. learns patterns from data instead of being told
       └─ Deep Learning ............ ML using many-layered neural networks
            └─ Generative AI ....... produces new content rather than labels
                 └─ LLMs ........... generative models over text
```

The containment is real, not a diagram convention. Every LLM is generative AI; every
generative model is deep learning; not every AI is machine learning. That last one is
where most enterprise confusion lives.

## Reading

Work through these before the quiz:

- [Microsoft AI learning hub](https://learn.microsoft.com/en-us/ai/) — start here
- [Azure AI Fundamentals (AI-900) skills outline](https://learn.microsoft.com/en-us/credentials/certifications/azure-ai-fundamentals/)
  — you sit this in week 13, but read the outline now so you know what is coming
- [AI training catalogue](https://learn.microsoft.com/en-us/training/browse/?subjects=artificial-intelligence)

## Notes to take as you read

Keep these in `curriculum/week-01/notes.md` — they become the raw material for your
chapter, so write them in sentences, not bullets.

- One system at your workplace you previously called "AI" that is actually automation
- One task in your current job generative AI would genuinely do well
- One task people keep *asking* for that it would do badly, and why
- The clearest sentence you can write explaining hallucination to your director

That fourth one is the hardest and the most valuable. If you can't write it, you don't
understand it yet.

## The three gates

| Gate | What it takes | Where |
|---|---|---|
| Quiz | 20 MCQs, 80% to pass | `python tools/quiz_runner.py 1` |
| Scenarios | 3 of 10 answered | [scenarios.md](scenarios.md) |
| Project | The deck, committed | [assignment.md](assignment.md) |
| Chapter | 2,500 words drafted | `books/book-1-foundations/manuscript/chapter-01.md` |

Check status any time:

```bash
python tools/gate_check.py 1
```

When all four report pass:

```bash
git tag week-01-complete && git push origin week-01-complete
```

That tag is the event. Everything downstream — the EPUB build, the publish checklist,
the dev.to draft — runs off it.

## A warning about week 1

The failure mode here is reading for three days and never answering anything, because
reading feels like progress and being assessed doesn't. Take the quiz early, fail it,
and let the wrong answers tell you what to read. That is cheaper than reading
everything.
