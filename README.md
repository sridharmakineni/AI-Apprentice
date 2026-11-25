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
| III | 9–16 | Agents in Production — Tool Calling, MCP, LangGraph, and Azure AI Foundry | $39 |

Bundle: $69.

Three volumes rather than four: a four-book series is a lot to ask of a first-time
author's readers, and agents and deployment are one arc, not two. Three also fits
Leanpub's free tier exactly.

## Layout

```text
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

## Distribution

**Undecided until Book I is finished.** Names are claimed on both Leanpub and Gumroad;
neither is paid for. Gumroad takes ~10% and hands over buyer emails, which matters when
Book I exists to funnel readers toward II–IV. Leanpub offers discovery and a
buy-early-get-updates model, but its Git writing mode needs a Pro membership
(~$216/year), so the sync below is dormant until that is worth paying for.

### Leanpub sync (built, dormant)

Leanpub's Git writing mode wants `manuscript/` at the root of a repository, one book
per repo. This repo keeps manuscripts under `books/<slug>/manuscript/` so chapters sit
beside the curriculum and gates that produce them, and
[sync-leanpub.yml](.github/workflows/sync-leanpub.yml) bridges the two — it mirrors
each book into a thin repo that Leanpub watches. The mirror also serves a pandoc build
if distribution goes elsewhere.

**The monorepo is the source of truth. Never edit a thin repo by hand.**

One-time setup per book:

1. Create the empty target repo named in that book's `meta.yml` (`leanpub_repo`)
2. If it's private, add `leanpub` as a collaborator so Leanpub can read it
3. Create a fine-grained PAT with **Contents: read and write** scoped to that repo
4. Save it in this repo as the `LEANPUB_SYNC_TOKEN` secret
5. In Leanpub, create the book in **Git/GitHub writing mode** pointed at the thin repo

Until the secret exists the workflow skips with a note instead of failing.

## Status

Week 1 — in progress. Nothing shipped yet.
