"""Report which gates are still closed for a week, and whether it can be tagged complete.

A week emits `week.completed` only when every gate passes. Nothing here is time-based.

    python tools/gate_check.py 1      status for week 1
    python tools/gate_check.py        status for every defined week
"""

import json
import re
import sys
from pathlib import Path

import yaml

# Windows consoles still default to cp1252, which mangles the em-dashes in week titles.
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(__file__).resolve().parent.parent
GATES = ROOT / "curriculum" / "gates.yml"
PROGRESS = ROOT / "progress.json"

PASS, FAIL = "PASS", "FAIL"


def load():
    gates = yaml.safe_load(GATES.read_text(encoding="utf-8"))
    progress = json.loads(PROGRESS.read_text(encoding="utf-8")) if PROGRESS.exists() else {}
    return gates, progress


def word_count(path):
    text = re.sub(r"```.*?```", "", path.read_text(encoding="utf-8"), flags=re.S)
    text = re.sub(r"^---.*?^---", "", text, flags=re.S | re.M)
    return len(re.findall(r"\b[\w'-]+\b", text))


def check_quiz(spec, state):
    score = (state.get("quiz") or {}).get("score")
    need = spec.get("pass_score", 80)
    if score is None:
        return FAIL, f"not taken (need {need}%)"
    verdict = PASS if score >= need else FAIL
    return verdict, f"scored {score}% (need {need}%)"


def check_scenario(spec, _state):
    path = ROOT / spec["file"]
    if not path.exists():
        return FAIL, "scenarios file missing"
    blocks = re.findall(r"\*\*Your answer:\*\*\s*(.*?)(?=\n## |\Z)", path.read_text(encoding="utf-8"), flags=re.S)
    # Match the bare word, not the marked-up form, so the gate survives a change of
    # emphasis style in the template.
    answered = sum(1 for b in blocks if b.strip() and "unanswered" not in b.lower())
    need = spec.get("min_answered", 1)
    verdict = PASS if answered >= need else FAIL
    return verdict, f"{answered}/{len(blocks)} answered (need {need})"


def check_artifact(spec, _state):
    path = ROOT / spec["path"]
    if not path.is_dir():
        return FAIL, "project folder missing"
    missing = [f for f in spec.get("requires", []) if not (path / f).exists()]
    if missing:
        return FAIL, f"missing {', '.join(missing)}"
    return PASS, "project present"


def check_manuscript(spec, _state):
    path = ROOT / spec["path"]
    if not path.exists():
        return FAIL, "chapter not started"
    words = word_count(path)
    need = spec.get("min_words", 0)
    verdict = PASS if words >= need else FAIL
    return verdict, f"{words:,} words (need {need:,})"


CHECKS = {
    "quiz": check_quiz,
    "scenario": check_scenario,
    "artifact": check_artifact,
    "manuscript": check_manuscript,
}


def report(week, state):
    print(f"\nWeek {week['id']:02d} — {week['title']}")
    print("-" * 56)
    results = []
    for name, spec in week["gates"].items():
        verdict, detail = CHECKS[spec["kind"]](spec, state)
        results.append(verdict)
        mark = "[x]" if verdict == PASS else "[ ]"
        print(f" {mark} {name:<12} {detail}")

    if all(v == PASS for v in results):
        tag = f"week-{week['id']:02d}-complete"
        print(f"\n All gates open. Ship it:\n   git tag {tag} && git push origin {tag}\n")
        return True

    closed = sum(1 for v in results if v == FAIL)
    print(f"\n {closed} gate(s) still closed.\n")
    return False


def main():
    gates, progress = load()
    weeks = gates["weeks"]
    if len(sys.argv) > 1:
        wanted = int(sys.argv[1])
        weeks = [w for w in weeks if w["id"] == wanted]
        if not weeks:
            sys.exit(f"No week {wanted} defined in curriculum/gates.yml")

    states = progress.get("weeks", {})
    ok = [report(w, states.get(str(w["id"]), {})) for w in weeks]
    sys.exit(0 if all(ok) else 1)


if __name__ == "__main__":
    main()
