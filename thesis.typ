#import "@local/tubs-thesis-template:0.1.0": tu-braunschweig-thesis, titlepage, disclaimer
#import "metadata.typ": *
#import "@preview/drafting:0.2.2": note-outline

#show: tu-braunschweig-thesis.with(
  title: international-title,
  author: author,
  lang: lang,
  is-doublesided: is-doublesided,
)
#set page(
  numbering: "I",
  margin: (left: 3cm, top: 3cm, bottom: 2cm, right: 2cm)
)
#set text(
  size: 12pt
)

#show heading.where(level: 1): set text(size: 16pt)
#show heading.where(level: 2): set text(size: 14pt)
#show heading.where(level: 3): set text(size: 12pt)
#show heading.where(level: 4): set text(size: 12pt, style: "normal")

#titlepage(
  title: international-title,
  document-type: document-type,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  city: city,
  date: date,
  organisation: organisation,
  organisation-logo: organisation-logo,
  header-logo: header-logo,
  is-doublesided: is-doublesided,
  lang: lang,
)

#counter(page).update(2)

#include "chapter/abstract.typ"
#pagebreak()

#outline(depth: 3)

//#note-outline()

#set page(numbering: "1")
#counter(page).update(1)

#include "chapter/01-introduction.typ"
#include "chapter/02-method.typ"
#include "chapter/03-results.typ"
#include "chapter/04-discussion.typ"
#include "chapter/05-conclusion.typ"

#bibliography("bibliography.yml", style: "vancouver")

//#include "chapter/98-statutory-declaration.typ"
//#include "chapter/99-Appendix.typ"


#disclaimer(
  title: title,
  international-title: international-title,
  author: author,
  city: city,
  is-doublesided: is-doublesided,
  lang: lang,
)
