# Week 4 Assignment — Prompt Library and Evaluation

**Deliverable:** a version-controlled prompt library plus a real evaluation, in
`projects/week-04/`.

Two parts. The second is the one that matters.

---

## Part 1 — The Prompt Library

Build a structured collection of prompts that work, across four categories:

| Category | Example task |
|---|---|
| Email | Draft a reply declining a meeting, keeping the relationship |
| SQL | Generate a query from a plain-English description of a report |
| Code | Explain an unfamiliar function to someone who didn't write it |
| Meetings | Turn a transcript into decisions, owners and deadlines |

At least three prompts per category. For each one record:

```yaml
name: ticket-classifier
category: code
purpose: Route incoming IT tickets to one of four queues
template: |
  Classify this IT support ticket as exactly one of: {categories}.
  ...
variables: [categories, ticket_text]
model: gpt-4o-mini
temperature: 0
example_input: "Laptop won't boot after the password reset."
example_output: "Hardware"
rejected:
  - "Tried listing categories in the system message instead — worse on ambiguous cases"
  - "Tried 'be accurate' — no measurable effect"
```

**The `rejected` field is the one with long-term value.** In three months you will
consider a change you already tested and discarded, and this is what stops you doing it
twice.

Store them as files, in the repo, not in a document. Prompts are code.

---

## Part 2 — The Evaluation (the actual exam)

Pick **one** prompt from your library — ideally the classifier, because it has
objectively right answers.

### Step 1: Build a test set

**Twenty real inputs.** Real tickets, real emails, real text from your workplace,
redacted of anything identifying a person. Include the awkward ones — especially the
ones you are not sure about yourself.

### Step 2: Write down expected outputs first

Before running anything, record what the correct answer is for each of the twenty.

If you cannot decide what the right answer is for some of them, that is the single most
valuable finding of the week: **the task is underspecified**, and no amount of prompt
engineering will fix a task nobody has defined. Write that down.

### Step 3: Run the baseline

Run all twenty at temperature 0. Record every output. Score it.

### Step 4: Iterate once, properly

Look at the failures. Identify the pattern. Make **one** change — add few-shot examples
targeting those cases, or add a tie-break rule, or constrain the output space.

Re-run all twenty. Score again.

### Step 5: Report

```text
projects/week-04/evaluation/
├── test-set.csv          20 inputs + expected outputs
├── baseline-results.csv  run 1 outputs + scores
├── revised-results.csv   run 2 outputs + scores
└── findings.md           what failed, what you changed, what happened
```

`findings.md` should answer:

- What was the baseline score?
- What pattern did the failures share?
- What single change did you make, and why that one?
- What was the revised score?
- Which cases still fail, and do you understand why?
- What would tell you this prompt had stopped working in six months?

---

## Rules

- **Twenty inputs minimum.** Ten is not enough to distinguish signal from luck.
- **Expectations written before running.** Scoring after the fact is marking your own
  homework with the answers visible.
- **One change per iteration.** Change three things and you learn nothing about which
  mattered.
- **Redact personal data** from anything real you use. Replace names and identifiers;
  the exercise works identically.

## What goes in the repo

```text
projects/week-04/
├── README.md             what you built, the headline result, what surprised you
├── prompts/              the library, one file per prompt
└── evaluation/           the four files above
```

## The gate

```bash
python tools/gate_check.py 4
```

Passes when `projects/week-04/README.md` exists. The checker cannot tell whether you
did the evaluation honestly — only you will know that, and only you will carry the
consequence.

## Why this is the last assignment of Book I

Because it is the one that transfers. Chapters 1 through 3 give you understanding that
a good reader could get elsewhere. This gives you a *method* — specify, test, iterate,
keep the failures — and that method is what every remaining book in this series applies
to progressively harder problems.

The evaluation you run this week is also the first entry in a discipline that becomes a
first-class product feature in Azure AI Foundry. Starting it with a spreadsheet and
twenty rows costs you nothing and makes the later material feel like something you
already understood.
