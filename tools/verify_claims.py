"""Execute the factual claims made in the week 2 quiz and chapter 2.

Each check asserts what the quiz says is true. A failure means the book is wrong.
"""
import json
import sys
import timeit

results = []


def check(claim, fn):
    try:
        fn()
        results.append(("PASS", claim))
    except Exception as e:
        results.append(("FAIL", f"{claim}  -> {type(e).__name__}: {e}"))


# Q1: JSON object maps to dict
def q1():
    d = json.loads('{"a": 1}')
    assert isinstance(d, dict), type(d)
    assert isinstance(json.loads("[1,2]"), list)


# Q2: .get() returns None vs KeyError
def q2():
    p = {"name": "Bruno"}
    assert p.get("email") is None
    assert p.get("email", "n/a") == "n/a"
    try:
        p["email"]
        raise AssertionError("expected KeyError")
    except KeyError:
        pass


# Q3: load takes a file, loads takes a string
def q3():
    assert json.loads('{"a":1}') == {"a": 1}
    try:
        json.load('{"a":1}')  # a string, not a file
        raise AssertionError("expected failure passing a string to json.load")
    except AttributeError:
        pass


# Q4: JSON null becomes Python None
def q4():
    assert json.loads('{"x": null}')["x"] is None
    assert json.dumps({"x": None}) == '{"x": null}'
    assert json.loads('{"b": true}')["b"] is True


# Q5: the chat-completion access path
def q5():
    r = {"choices": [{"message": {"role": "assistant", "content": "Hello."}}]}
    assert r["choices"][0]["message"]["content"] == "Hello."


# Q6: list comprehension yields a list
def q6():
    employees = [{"name": "Bruno"}, {"name": "Willie"}]
    names = [p["name"] for p in employees]
    assert names == ["Bruno", "Willie"] and isinstance(names, list)


# Q7: dict lookup is faster than scanning a list
def q7():
    records = [{"name": f"p{i}"} for i in range(10_000)]
    by_name = {r["name"]: r for r in records}
    scan = timeit.timeit(
        lambda: next(r for r in records if r["name"] == "p9999"), number=200
    )
    lookup = timeit.timeit(lambda: by_name["p9999"], number=200)
    assert lookup < scan, f"lookup {lookup:.6f} not faster than scan {scan:.6f}"
    results.append(("INFO", f"scan {scan:.4f}s vs dict lookup {lookup:.6f}s over 200 runs"))


# Q8: sets discard duplicates, and are unordered
def q8():
    assert len({"IT", "HR", "IT"}) == 2


# Q9: type hints are NOT enforced at runtime
def q9():
    def f(x: int) -> str:
        return x
    assert f("not an int") == "not an int"  # no error raised


# Q15: indexing None raises TypeError with that exact message
def q15():
    v = None
    try:
        v["key"]
        raise AssertionError("expected TypeError")
    except TypeError as e:
        assert "not subscriptable" in str(e), str(e)


# Q16: importing a missing module raises ModuleNotFoundError
def q16():
    try:
        __import__("definitely_not_a_real_module_xyz")
        raise AssertionError("expected ModuleNotFoundError")
    except ModuleNotFoundError:
        pass


# Q18: empty list is safe to iterate, None is not
def q18():
    for _ in []:
        pass
    try:
        for _ in None:
            pass
        raise AssertionError("expected TypeError")
    except TypeError:
        pass


# Chapter claim: malformed JSON raises JSONDecodeError
def ch_json_error():
    try:
        json.loads("{not json}")
        raise AssertionError("expected JSONDecodeError")
    except json.JSONDecodeError:
        pass


# Chapter claim: f-strings evaluate expressions
def ch_fstring():
    role, task = "recruiter", "Summarize."
    assert f"You are a {role}. {task}" == "You are a recruiter. Summarize."


checks = [
    ("Q1  JSON object -> dict, array -> list", q1),
    ("Q2  .get() returns None; [] raises KeyError", q2),
    ("Q3  json.load takes a file, loads takes a string", q3),
    ("Q4  JSON null <-> Python None, true <-> True", q4),
    ("Q5  response['choices'][0]['message']['content']", q5),
    ("Q6  list comprehension yields a list", q6),
    ("Q7  dict lookup faster than list scan", q7),
    ("Q8  set discards duplicates", q8),
    ("Q9  type hints NOT enforced at runtime", q9),
    ("Q15 indexing None -> 'not subscriptable' TypeError", q15),
    ("Q16 missing import -> ModuleNotFoundError", q16),
    ("Q18 empty list iterable, None is not", q18),
    ("Ch2 malformed JSON -> JSONDecodeError", ch_json_error),
    ("Ch2 f-string evaluates expressions", ch_fstring),
]

for claim, fn in checks:
    check(claim, fn)

print(f"Python {sys.version.split()[0]}\n")
failed = 0
for status, claim in results:
    print(f"  {status:5} {claim}")
    if status == "FAIL":
        failed += 1
print(f"\n{len(checks) - failed}/{len(checks)} claims verified")
sys.exit(1 if failed else 0)
