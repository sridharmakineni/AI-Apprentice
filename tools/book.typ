// Book design for the AI Apprentice series.
//
// Pandoc's default typst template imports `conf` from here when invoked with
// -V template=tools/book.typ. Everything pandoc passes arrives through the
// argument sink, so this stays compatible as pandoc's variable list changes.
//
//   Body      Constantia / Georgia  -- serif, for sustained reading
//   Headings  Segoe UI Semibold     -- sans, so structure is visible at a glance
//   Code      Cascadia Mono         -- boxed, tinted, never breaking mid-block

#let accent = rgb("#F0B323")      // Book I. II teal, III magenta.
#let ink = rgb("#26292B")         // full-bleed panels
#let accent-ink = rgb("#8A6410")  // amber is unreadable as text on white;
                                  // this is the same hue, darkened to pass contrast
#let rule-grey = rgb("#D8DCE0")
#let code-bg = rgb("#F6F7F9")
#let quote-bg = rgb("#FDF8EC")

// Front-matter opener. Called from a raw typst block in front-matter.md so the
// section gets the full-bleed treatment without an H1 -- which would otherwise
// be numbered as a chapter.
#let frontmatter-open(line1, line2) = {
  pagebreak(weak: true)
  page(margin: (x: 0cm, y: 0cm), header: none, footer: none, fill: ink)[
    #place(left + top, dx: 2.6cm, dy: 6.5cm)[
      #set par(justify: false, leading: 0.42em)
      #text(size: 10pt, fill: accent, weight: "bold", tracking: 3pt,
            font: ("Segoe UI", "Calibri"))[#upper("Introduction")]
      #v(1.1cm)
      #block(width: 14cm)[
        #set par(leading: 0.34em)
        #text(size: 40pt, fill: white, weight: "bold", tracking: -0.8pt,
              font: ("Segoe UI", "Calibri"))[#line1]
        #linebreak()
        #text(size: 40pt, fill: accent, weight: "bold", tracking: -0.8pt,
              font: ("Segoe UI", "Calibri"))[#line2]
      ]
    ]
    #place(left + bottom, dx: 2.6cm, dy: -2.4cm)[
      #text(size: 8.5pt, fill: rgb("#8A939C"), font: ("Segoe UI", "Calibri"))[
        AI Apprentice · Foundations
      ]
    ]
  ]
}

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
    numbering: none,
    footer: context {
      let n = counter(page).get().at(0)
      set text(size: 8pt, fill: rgb("#8A939C"), font: ("Segoe UI", "Calibri"))
      grid(columns: (1fr, 1fr), align: (left, right),
        [AI Apprentice · Foundations],
        text(weight: "bold", fill: rgb("#4B5563"))[#n])
    },
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

  // Full-bleed chapter opener: dark field, oversized two-tone type. Borrowed
  // from brand handbooks, but spent only on the four opener pages -- behind
  // 10,000 words of teaching prose it would exhaust the reader, and serif body
  // on white is measurably better for sustained reading.
  show heading.where(level: 1): it => {
    counter(heading.where(level: 1)).step()
    pagebreak(weak: true)
    page(
      margin: (x: 0cm, y: 0cm),
      header: none,
      footer: none,
      fill: ink,
    )[
      #place(left + top, dx: 2.6cm, dy: 6.5cm)[
        #set par(justify: false, leading: 0.42em)
        #text(size: 10pt, fill: accent, weight: "bold", tracking: 3pt,
              font: ("Segoe UI", "Calibri"))[
          #context upper("Chapter " + str(counter(heading.where(level: 1)).get().at(0)))
        ]
        #v(1.1cm)
        #block(width: 13cm)[
          #text(size: 40pt, fill: white, weight: "bold", tracking: -0.8pt,
                font: ("Segoe UI", "Calibri"))[#it.body#text(fill: accent)[.]]
        ]
      ]
      #place(left + bottom, dx: 2.6cm, dy: -2.4cm)[
        #text(size: 8.5pt, fill: rgb("#8A939C"), font: ("Segoe UI", "Calibri"))[
          AI Apprentice · Foundations
        ]
      ]
    ]
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
      #set text(size: 11.5pt, fill: accent-ink, weight: "bold")
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

  show link: set text(fill: accent-ink)
  set list(indent: 0.6em, spacing: 0.75em)
  set enum(indent: 0.6em, spacing: 0.75em)

  // ---- title page -----------------------------------------------------
  page(header: none, footer: none, numbering: none, margin: (x: 0cm, y: 0cm), fill: ink)[
    #place(left + top, dx: 2.6cm, dy: 5.2cm)[
      #set par(justify: false, leading: 0.42em)
      #text(size: 10pt, fill: rgb("#8A939C"), weight: "bold", tracking: 3.5pt,
            font: ("Segoe UI", "Calibri"))[#upper("AI Apprentice")]
      #v(1.3cm)
      #block(width: 14cm)[
        #text(size: 54pt, fill: accent, weight: "bold", tracking: -1.5pt,
              font: ("Segoe UI", "Calibri"))[#title#text(fill: white)[.]]
      ]
      #v(1.0cm)
      #block(width: 12cm)[
        #set text(size: 14pt, fill: white, weight: "bold",
                  font: ("Segoe UI", "Calibri"))
        #set par(leading: 0.55em)
        #subtitle
      ]
    ]
    #place(left + bottom, dx: 2.6cm, dy: -3.0cm)[
      #set par(justify: false, leading: 0.5em)
      #if authors.len() > 0 [
        #text(size: 12pt, fill: white, weight: "bold", font: ("Segoe UI", "Calibri"))[
          #authors.map(a => if type(a) == dictionary { a.at("name", default: "") } else { a }).join(", ")
        ]
        #linebreak()
      ]
      #if date != none [
        #text(size: 9pt, fill: rgb("#8A939C"), font: ("Segoe UI", "Calibri"))[#date]
        #linebreak()
      ]
      #text(size: 9pt, fill: rgb("#8A939C"), font: ("Segoe UI", "Calibri"))[
        Book I of three · Draft for review
      ]
    ]
  ]

  // ---- contents -------------------------------------------------------
  // Always rendered here rather than by pandoc's --toc: pandoc's #outline()
  // emits its title as a level-1 heading, which the chapter rule above would
  // format as "Chapter 1: Contents" and push the numbering out by one.
  {
    page(header: none, footer: none, numbering: none, margin: (x: 0cm, y: 0cm))[
      // Dark band across the top, so the contents page carries the same
      // language as the title page and the chapter openers.
      #block(width: 100%, height: 7.5cm, fill: ink)[
        #place(left + bottom, dx: 2.6cm, dy: -1.9cm)[
          #set par(justify: false, leading: 0.4em)
          #text(size: 9pt, fill: accent, weight: "bold", tracking: 3pt,
                font: ("Segoe UI", "Calibri"))[#upper("Book I")]
          #v(0.75cm)
          #text(size: 34pt, fill: white, weight: "bold", tracking: -0.6pt,
                font: ("Segoe UI", "Calibri"))[Contents#text(fill: accent)[.]]
        ]
      ]
      #v(1.3cm)
      #block(inset: (x: 2.6cm))[
      #set par(justify: false)
      #show outline.entry.where(level: 1): e => {
        v(0.75em, weak: true)
        text(font: ("Segoe UI", "Calibri"), size: 11pt, weight: "bold", e)
      }
      #show outline.entry.where(level: 2): e => text(size: 9.5pt, fill: rgb("#4B5563"), e)
      #outline(title: none, depth: 2, indent: 1.2em)
      ]
    ]
  }

  counter(page).update(1)
  doc
}
