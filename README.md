# AI Apprentice™

A 16-week, gate-based path from beginner to AI agent builder on the Microsoft stack —
learned in the open, published as a four-book series.

**aiapprentice.io** (primary) · **aiapprentice.app** (reserved, future home of the app)

| | |
|---|---|
| **Curriculum** | 16 weeks, 4 phases, gated by artifacts rather than dates |
| **Books** | Four volumes, each built from one phase |
| **App** | An AI tutor that grows alongside the curriculum (starts week 5) |

## The rule

Progress is proven by artifacts, not by the calendar. Week N+1 unlocks when week N
emits `week.completed` — never because it happens to be Monday. A week may take five
days or fifteen; nothing downstream cares.

## The series

| Book | Weeks | Title | Price |
|---|---|---|---|
| I | 1–4 | Foundations — LLMs, Prompts, and Python for Microsoft Developers | $9 (funnel) |
| II | 5–8 | Building AI Applications — Chatbots, Vector Search, and RAG on Azure | $29 |
| III | 9–12 | Agents — Tool Calling, MCP, LangGraph, and CrewAI | $29 |
| IV | 13–16 | Production — Azure AI Foundry, Copilot, and Shipping Real Systems | $29 |

Bundle: $69.

## Layout

```
curriculum/week-NN/     lesson, quiz, scenarios, assignment
projects/week-NN/       the thing you built that week
books/book-N-*/         Leanpub manuscript, one project per book
tools/                  gate checker, quiz runner
.github/workflows/      content checks, release, publishing
progress.json           gate state — written by the tools, not by hand
```

## Daily loop

```bash
python tools/quiz_runner.py 1        # take the week's quiz
python tools/gate_check.py 1         # see which gates are still closed
git tag week-01-complete && git push --tags   # when all gates pass
```

That tag is the keystone event: it triggers the chapter build, the EPUB/PDF preview,
and the draft publish PR.

## Status

Week 1 — in progress. Nothing shipped yet.
