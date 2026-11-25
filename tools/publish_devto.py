"""Publish or update chapters on dev.to.

Manuscript files stay clean for Leanpub, so publishing metadata lives in a sidecar
next to each chapter: chapter-01.md -> chapter-01.publish.yml. Article ids are
recorded in .devto-map.json so a second run updates rather than duplicates.

    python tools/publish_devto.py                       every chapter with a sidecar
    python tools/publish_devto.py books/.../chapter-01.md   just one
"""

import json
import os
import sys
import urllib.error
import urllib.request
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent
MAP = ROOT / ".devto-map.json"
API = "https://dev.to/api/articles"


def request(method, url, payload, key):
    body = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(url, data=body, method=method)
    req.add_header("api-key", key)
    req.add_header("content-type", "application/json")
    try:
        with urllib.request.urlopen(req, timeout=30) as response:
            return json.load(response)
    except urllib.error.HTTPError as err:
        sys.exit(f"dev.to {method} {url} failed: {err.code} {err.read().decode('utf-8', 'replace')}")


def chapters(argv):
    if argv:
        return [ROOT / argv[0]]
    return sorted(ROOT.glob("books/*/manuscript/chapter-*.md"))


def main():
    key = os.environ.get("DEVTO_API_KEY")
    if not key:
        sys.exit("DEVTO_API_KEY is not set — it comes from the Actions secret store, never the repo.")

    published = json.loads(MAP.read_text(encoding="utf-8")) if MAP.exists() else {}

    for chapter in chapters(sys.argv[1:]):
        sidecar = chapter.with_suffix(".publish.yml")
        if not sidecar.exists():
            print(f"skip {chapter.name} — no sidecar")
            continue

        meta = yaml.safe_load(sidecar.read_text(encoding="utf-8"))
        if not meta.get("devto", True):
            print(f"skip {chapter.name} — devto disabled")
            continue

        article = {
            "title": meta["title"],
            "body_markdown": chapter.read_text(encoding="utf-8"),
            "published": bool(meta.get("published", False)),
            "tags": meta.get("tags", []),
            "series": meta.get("series", "AI Apprentice"),
        }
        if meta.get("canonical_url"):
            article["canonical_url"] = meta["canonical_url"]

        rel = str(chapter.relative_to(ROOT)).replace("\\", "/")
        existing = published.get(rel)
        if existing:
            result = request("PUT", f"{API}/{existing}", {"article": article}, key)
            print(f"updated {rel} -> {result.get('url')}")
        else:
            result = request("POST", API, {"article": article}, key)
            published[rel] = result["id"]
            print(f"created {rel} -> {result.get('url')}")

    MAP.write_text(json.dumps(published, indent=2, sort_keys=True) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
