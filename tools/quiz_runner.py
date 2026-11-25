"""Run a week's multiple-choice quiz and record the score as a gate event.

    python tools/quiz_runner.py 1
    python tools/quiz_runner.py 1 --review    show explanations for every question

A pass writes progress.json, which is what gate_check.py reads. Wrong answers are
listed at the end so the retake is targeted rather than a full re-sit.
"""

import argparse
import datetime as dt
import json
import random
import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent
PROGRESS = ROOT / "progress.json"


def load_quiz(week):
    path = ROOT / "curriculum" / f"week-{week:02d}" / "quiz.yml"
    if not path.exists():
        sys.exit(f"No quiz at {path.relative_to(ROOT)}")
    return yaml.safe_load(path.read_text(encoding="utf-8"))


def ask(index, total, question):
    print(f"\nQ{index}/{total}. {question['q']}")
    for key, text in question["options"].items():
        print(f"   {key}) {text}")
    valid = set(question["options"])
    while True:
        answer = input("   > ").strip().lower()
        if answer in valid:
            return answer
        print(f"   Pick one of: {', '.join(sorted(valid))}")


def record(week, score, missed):
    state = json.loads(PROGRESS.read_text(encoding="utf-8"))
    state.setdefault("weeks", {}).setdefault(str(week), {})["quiz"] = {
        "score": score,
        "missed": missed,
        "taken": dt.datetime.now().isoformat(timespec="seconds"),
    }
    state.setdefault("started", state.get("started") or dt.date.today().isoformat())
    PROGRESS.write_text(json.dumps(state, indent=2) + "\n", encoding="utf-8")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("week", type=int)
    parser.add_argument("--review", action="store_true", help="explain every question, not just misses")
    args = parser.parse_args()

    quiz = load_quiz(args.week)
    questions = list(quiz["questions"])
    random.shuffle(questions)
    need = quiz.get("pass_score", 80)

    print(f"\n{quiz['title']} — {len(questions)} questions, {need}% to pass")
    print("=" * 56)

    missed = []
    for i, question in enumerate(questions, 1):
        given = ask(i, len(questions), question)
        correct = given == question["answer"]
        if correct:
            print("   correct")
        else:
            print(f"   wrong — answer was {question['answer']})")
            missed.append(question["q"])
        if args.review or not correct:
            print(f"   {question['why']}")

    score = round(100 * (len(questions) - len(missed)) / len(questions))
    record(args.week, score, missed)

    print("\n" + "=" * 56)
    print(f"Score: {score}%  ({'PASS' if score >= need else 'FAIL'}, need {need}%)")
    if missed:
        print("\nWorth re-reading:")
        for question in missed:
            print(f"  - {question}")
    print(f"\nRecorded in progress.json. Next: python tools/gate_check.py {args.week}\n")
    sys.exit(0 if score >= need else 1)


if __name__ == "__main__":
    main()
