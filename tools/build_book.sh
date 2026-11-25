#!/usr/bin/env bash
# Build a book as a typeset PDF and a Word file for proofreading.
#
#   ./tools/build_book.sh book-1-foundations
#
# PDF  -> designed, via typst + tools/book.typ. This is what the book looks like.
# DOCX -> plain styles, for proofreading with track changes and comments.
#
# Chapter order comes from manuscript/Book.txt, so the build never drifts from
# what Leanpub would publish.

set -euo pipefail

SLUG="${1:-book-1-foundations}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MANUSCRIPT="$ROOT/books/$SLUG/manuscript"
META="$ROOT/books/$SLUG/meta.yml"
OUT="$ROOT/build"

[ -d "$MANUSCRIPT" ] || { echo "No manuscript at books/$SLUG/manuscript"; exit 1; }

# Windows user-scoped installs; LOCALAPPDATA comes through as C:\Users\...
LOCAL_WIN="${LOCALAPPDATA:-}"
if [ -n "$LOCAL_WIN" ]; then
  LOCAL_POSIX="/$(echo "$LOCAL_WIN" | sed 's|\\|/|g; s|^\([A-Za-z]\):|\1|')"
else
  LOCAL_POSIX="$HOME/AppData/Local"
fi

pick() {
  if command -v "$1" >/dev/null 2>&1; then command -v "$1"; return 0; fi
  shift
  for candidate in "$@"; do
    [ -f "$candidate" ] && { echo "$candidate"; return 0; }
  done
  return 1
}

PANDOC=$(pick pandoc \
  "$LOCAL_POSIX/Pandoc/pandoc.exe" \
  "/c/Program Files/Pandoc/pandoc.exe") \
  || { echo "pandoc not found -- winget install JohnMacFarlane.Pandoc"; exit 1; }

TYPST_DIR="$LOCAL_POSIX/Microsoft/WinGet/Packages/Typst.Typst_Microsoft.Winget.Source_8wekyb3d8bbwe/typst-x86_64-pc-windows-msvc"
TYPST=$(pick typst "$TYPST_DIR/typst.exe") \
  || { echo "typst not found -- winget install Typst.Typst"; exit 1; }

# pandoc shells out to `typst`, so it has to be on PATH for the PDF step.
export PATH="$(dirname "$TYPST"):$PATH"

mkdir -p "$OUT"

# typst resolves imports relative to the working directory and rejects absolute
# Windows paths, so the build runs from the repo root with a relative template.
cd "$ROOT"

read_meta() {
  python -c "import yaml,sys;print(yaml.safe_load(open(sys.argv[1],encoding='utf-8'))['$1'])" "$META"
}

TITLE="$(read_meta title)"
TITLE="${TITLE#AI Apprentice: }"
SUBTITLE="$(read_meta subtitle)"

# Chapter order from Book.txt, so the build matches what Leanpub would publish.
CHAPTERS=()
while IFS= read -r line || [ -n "$line" ]; do
  line="${line%$'\r'}"
  [ -n "$line" ] && CHAPTERS+=("$MANUSCRIPT/$line")
done < "$MANUSCRIPT/Book.txt"

echo "Building \"$TITLE\" from ${#CHAPTERS[@]} chapters"

# The stock template is what imports tools/book.typ; regenerate it if missing.
[ -f "$OUT/_default.typ" ] || "$PANDOC" --print-default-template=typst > "$OUT/_default.typ"

FORMAT="markdown+pipe_tables+fenced_code_blocks+backtick_code_blocks"

echo "  -> PDF"
"$PANDOC" "${CHAPTERS[@]}" \
  --from="$FORMAT" --to=pdf --pdf-engine=typst \
  --template="$OUT/_default.typ" \
  -V template="tools/book.typ" \
  -V title="$TITLE" \
  -V subtitle="$SUBTITLE" \
  -V author="Sridhar Makineni" \
  -V date="$(date +'%B %Y')" \
  -o "$OUT/$SLUG.pdf"

echo "  -> DOCX"
"$PANDOC" "${CHAPTERS[@]}" \
  --from="$FORMAT" --to=docx \
  --metadata title="AI Apprentice: $TITLE" \
  --metadata subtitle="$SUBTITLE" \
  --metadata author="Sridhar Makineni" \
  --toc --toc-depth=2 \
  -o "$OUT/$SLUG.docx"

echo
ls -lh "$OUT/$SLUG.pdf" "$OUT/$SLUG.docx" | awk '{printf "  %-46s %s\n", $9, $5}'
