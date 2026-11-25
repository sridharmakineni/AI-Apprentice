// Book design for the AI Apprentice series.
//
// Pandoc's default typst template imports `conf` from here when invoked with
// -V template=tools/book.typ. Everything pandoc passes arrives through the
// argument sink, so this stays compatible as pandoc's variable list changes.
//
//   Body      Constantia / Georgia  -- serif, for sustained reading
//   Headings  Segoe UI Semibold     -- sans, so structure is visible at a glance
//   Code      Cascadia Mono         -- boxed, tinted, never breaking mid-block

#let accent = rgb("#1F6F8B")      // Book I. II amber, III magenta.
#let rule-grey = rgb("#D8DCE0")
#let code-bg = rgb("#F6F7F9")
#let quote-bg = rgb("#F0F6F8")

#let conf(..args) = {
  let o = args.named()
  let doc = args.pos().at(0)

  let title = o.at("title", default: [Untitled])
  let subtitle = o.at("subtitle", default: none)
  let authors = o.at("authors", default: ())
  let date = o.at("date", default: none)
  // pandoc does not forward its --toc flag to conf; the Contents page below is ours.

  set document(title: if type(title) == str { title } else { "AI Apprentice" })

  set page(
    paper: "us-letter",
    margin: (inside: 2.8cm, outside: 2.4cm, top: 2.6cm, bottom: 2.4cm),
    numbering: "1",
    number-align: center,
    header: context {
      // No running head on a chapter opening page.
      let here-page = here().page()
      let chapters = query(heading.where(level: 1))
      let opening = chapters.any(c => c.location().page() == here-page)
      if here-page > 2 and not opening {
        let before = chapters.filter(c => c.location().page() <= here-page)
        let current = if before.len() > 0 { before.last().body } else { [] }
        set text(size: 8.5pt, fill: rgb("#6B7280"))
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [AI Apprentice · Foundations],
          current,
        )
        v(-0.5em)
        line(length: 100%, stroke: 0.4pt + rule-grey)
      }
    },
  )

  set text(
    font: ("Constantia", "Georgia", "Cambria", "Times New Roman"),
    size: 10.5pt,
    lang: "en",
    region: "CA",
  )
  set par(justify: true, leading: 0.78em, spacing: 1.1em)

  // ---- headings -------------------------------------------------------
  show heading: set text(font: ("Segoe UI", "Calibri", "Arial"))

  // Chapters are numbered by the template, so the source headings carry only
  // the title -- which is also what Leanpub and dev.to want.
  counter(heading.where(level: 1)).update(0)

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(heading.where(level: 1)).step()
    v(2.2cm)
    block(breakable: false)[
      #set text(size: 9pt, fill: accent, weight: "bold", tracking: 1.6pt)
      #context upper("Chapter " + str(counter(heading.where(level: 1)).get().at(0)))
      #v(0.3em)
      #set text(size: 24pt, fill: black, weight: "bold", tracking: 0pt)
      #it.body
      #v(0.4em)
      #line(length: 28%, stroke: 2.2pt + accent)
    ]
    v(1.0cm)
  }

  show heading.where(level: 2): it => {
    v(1.1em)
    block(breakable: false)[
      #set text(size: 14pt, fill: rgb("#111827"), weight: "bold")
      #it.body
    ]
    v(0.25em)
  }

  show heading.where(level: 3): it => {
    v(0.8em)
    block(breakable: false)[
      #set text(size: 11.5pt, fill: accent, weight: "bold")
      #it.body
    ]
    v(0.1em)
  }

  show heading.where(level: 4): it => {
    v(0.6em)
    block(breakable: false)[
      #set text(size: 10.5pt, style: "italic", weight: "bold")
      #it.body
    ]
  }

  // ---- code: always in a box, never split across pages -----------------
  show raw.where(block: true): it => {
    v(0.35em)
    block(
      width: 100%,
      fill: code-bg,
      stroke: (left: 2.5pt + accent, rest: 0.6pt + rule-grey),
      radius: 2pt,
      inset: (x: 11pt, y: 10pt),
      breakable: false,
    )[
      #set text(font: ("Consolas", "DejaVu Sans Mono", "Courier New"), size: 8.6pt)
      #set par(justify: false, leading: 0.62em)
      #it
    ]
    v(0.35em)
  }

  show raw.where(block: false): it => box(
    fill: code-bg,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 1.5pt,
    text(font: ("Consolas", "DejaVu Sans Mono"), size: 9pt, it),
  )

  // ---- pull quotes as tinted callout boxes ----------------------------
  show quote.where(block: true): it => {
    v(0.4em)
    block(
      width: 100%,
      fill: quote-bg,
      stroke: (left: 3pt + accent),
      radius: (right: 2pt),
      inset: (x: 13pt, y: 11pt),
      breakable: false,
    )[
      #set text(size: 10.5pt, style: "italic")
      #set par(justify: false)
      #it.body
    ]
    v(0.4em)
  }

  // ---- tables ---------------------------------------------------------
  set table(
    stroke: (x, y) => (
      top: if y == 0 { 1pt + rgb("#374151") } else if y == 1 { 0.7pt + rule-grey } else { 0.4pt + rule-grey },
      bottom: none, left: none, right: none,
    ),
    inset: (x: 8pt, y: 6pt),
  )
  show table.cell.where(y: 0): set text(weight: "bold", size: 9pt)
  show table: set text(size: 9.2pt)
  show table: set par(justify: false, leading: 0.6em)

  show link: set text(fill: accent)
  set list(indent: 0.6em, spacing: 0.75em)
  set enum(indent: 0.6em, spacing: 0.75em)

  // ---- title page -----------------------------------------------------
  page(header: none, numbering: none, margin: (x: 2.8cm, y: 3.2cm))[
    #v(3.5cm)
    #set par(justify: false)
    #text(size: 10pt, fill: accent, weight: "bold", tracking: 3pt,
          font: ("Segoe UI", "Calibri"))[#upper("AI Apprentice")]

    #v(0.9cm)
    #line(length: 100%, stroke: 2.5pt + accent)
    #v(0.7cm)

    #text(size: 38pt, weight: "bold", font: ("Segoe UI", "Calibri"))[#title]

    #if subtitle != none [
      #v(0.5cm)
      #text(size: 14pt, fill: rgb("#4B5563"), font: ("Segoe UI", "Calibri"))[#subtitle]
    ]

    #v(1fr)

    #if authors.len() > 0 [
      #text(size: 12pt, weight: "bold")[
        #authors.map(a => if type(a) == dictionary { a.at("name", default: "") } else { a }).join(", ")
      ]
      #v(0.2cm)
    ]
    #if date != none [
      #text(size: 9.5pt, fill: rgb("#6B7280"))[#date]
    ]
    #v(0.4cm)
    #text(size: 9pt, fill: rgb("#9CA3AF"))[Book I of three · Draft for review]
  ]

  // ---- contents -------------------------------------------------------
  // Always rendered here rather than by pandoc's --toc: pandoc's #outline()
  // emits its title as a level-1 heading, which the chapter rule above would
  // format as "Chapter 1: Contents" and push the numbering out by one.
  {
    page(header: none, numbering: none)[
      #v(1.2cm)
      #text(size: 19pt, weight: "bold", font: ("Segoe UI", "Calibri"))[Contents]
      #v(0.8cm)
      #line(length: 100%, stroke: 1pt + accent)
      #v(0.6cm)
      #set par(justify: false)
      #show outline.entry.where(level: 1): e => {
        v(0.75em, weak: true)
        text(font: ("Segoe UI", "Calibri"), size: 11pt, weight: "bold", e)
      }
      #show outline.entry.where(level: 2): e => text(size: 9.5pt, fill: rgb("#4B5563"), e)
      #outline(title: none, depth: 2, indent: 1.2em)
    ]
  }

  counter(page).update(1)
  doc
}
