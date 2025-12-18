#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

= Design

== Top Level Design

- fairly simple
- sidebar: for modules (and dashboard?)
- topbar: emergency selection (and dashboard?)

#figure(
  cetz.canvas({
    import cetz.draw: *

    scale(90%)

    rect((0,0),(10,5))
    line((0,4.4),(10,4.4), name: "topbar_line")
    line((0.8,4.4),(0.8,0), name: "sidebar_line")

    content(
      ("sidebar_line.start", 50%, "sidebar_line.end"),
      angle: "sidebar_line.start",
      padding: 0.25,
      anchor: "south",
      [Sidebar]
    )

    content(
      ("topbar_line.start", 50%, "topbar_line.end"),
      angle: "topbar_line.end",
      padding: 0.05,
      anchor: "south",
      [Topbar]
    )

    content(
      (5, 2),
      [Dashboard/Module View]
    )
  }),
  caption: [Top Level Design]
) <top-level-design>

Sidebar and topbar are represented by a vue component respectively. They will and should always be visible, since they are essential to navigate between desired informations.
The dashboard and module view will take most of the screen as they will show the emergency information.
The module view is supposed to be as generic as possible to integrate different kind of projects. This way extending functionality at a later point should not result in rewriting the code base of this project.
