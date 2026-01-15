#import "@preview/drafting:0.2.2": margin-note, inline-note;

#let todo(text) = margin-note(text)
#let inline-todo(text) = inline-note(text)
#let nh(text) = margin-note(stroke: green, text)
#let vs(text) = margin-note(stroke: blue, text)

#let code(
  code,
  language,
  path: none,
  highlight: none
) = {
  if type(code) != str {
    return
  }
  let lines = code.split("\n")
  if lines.last().trim()  == "" {
    lines.pop()
  }

  grid(
    fill: white,
    columns: (1fr),
    rows: 2,
    stroke: 1.5pt + rgb(210,210,210),
    align: left,
    if path != none {
      box(
        fill: rgb(230,230,230),
        width: 100%,
        inset: (x: 0.25em, y: 0.35em),
        text(0.8em, strong(path)),
      )
    },
    grid(
      columns: (auto, 1fr),
      rows: 1em,
      inset: ((x: 0.25em), (y: 0.3em)),
      fill: (x, y) => {
        if y+1 == highlight { rgb(252,209,176) }
        else if calc.even(y) { rgb(245,245,245) }
        else { white }
      },
      align: (right + horizon, left + horizon),
      ..for (i, line) in lines.enumerate() {
        (
          text(size: 0.85em, fill: rgb(120,120,120))[
            #str(i+1): #h(1em)
          ],
          text(size: 0.9em)[
            #raw(line, lang: language)
          ],
        )
      }
    )
  )
}
