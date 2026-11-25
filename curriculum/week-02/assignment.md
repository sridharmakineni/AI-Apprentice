# Week 2 Assignment — Employee Directory Search

**Deliverable:** a working Python program in `projects/week-02/`, with a README and a
`requirements.txt`.

## The brief

Build a command-line tool that loads a directory of people from JSON and lets you search
it. No AI, no web framework, no database.

That is deliberate. This project exists to make dicts, lists, functions, file handling
and JSON *boring* to you — because in week 6 you will be debugging why a chatbot can't
read its own configuration, and you do not want to be learning what `.get()` does at
that moment.

## Requirements

Your program must:

1. **Load** `employees.json` into a list of dicts
2. **Search** by partial name, case-insensitively — `"bru"` finds Bruno
3. **Filter** by department
4. **List** unique departments, sorted
5. **Export** filtered results back to a JSON file
6. **Fail gracefully** when the file is missing or malformed — a clear message, not a
   stack trace

Requirement 6 is the one that teaches you something. The others are mechanics.

## Starter data

Create `employees.json` with at least eight people across three departments. Include
Bruno (IT Operations) and Willie (Human Resources) so your examples match the book's.

Deliberately include one record missing the `dept` field. Your code should survive it.

```json
[
  {"name": "Bruno",  "dept": "IT Operations",   "email": "bruno@example.ca",  "location": "Toronto"},
  {"name": "Willie", "dept": "Human Resources", "email": "willie@example.ca", "location": "Guelph"}
]
```

## Rules

- **No copying the chapter's version wholesale.** Read it, close it, write your own. The
  gap between recognising code and producing it is the entire point of this week.
- **Every function returns a value**, rather than printing. Printing happens in one place
  at the end. Functions that return data can be tested; functions that print can only be
  watched.
- **Specify `encoding="utf-8"`** on every file operation.
- **No credentials anywhere**, even though this project has none. Build the habit now.

## Stretch goals

Only after the six requirements work:

- Export to CSV as well as JSON
- Add a `--department` command-line flag using `argparse`
- Write three tests with `pytest`

The tests are the most valuable of the three, and they will matter enormously by Book
III.

## What goes in the repo

```text
projects/week-02/
├── README.md           what it does, how to run it, what broke and how you fixed it
├── requirements.txt
├── employees.json
└── directory.py
```

## The README matters most

Write it last, and be specific about failure. "I spent 40 minutes on a
`TypeError: 'NoneType' object is not subscriptable` because `load_employees` returned
`None` when the file was missing" is worth more than a paragraph describing what the
program does.

That paragraph becomes chapter 2's revision. The debugging story is the thing a reader
cannot get from the Python documentation, and it is the reason your book is worth paying
for.

## The gate

```bash
python tools/gate_check.py 2
```

Passes when `projects/week-02/` contains `README.md` and `requirements.txt`. The checker
verifies the files exist, not that the program is good — that part is on you.
