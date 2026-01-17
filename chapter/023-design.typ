#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

== Design

=== Top Level Design

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

Sidebar and topbar are represented by a Vue component respectively.
They will and should always be visible, since they are essential to navigate between visualizations of desired information.
The dashboard and module view will take most of the screen as they will show the important emergency information.

=== Color contrast design  <color-contrast>
Defining colors throughout even a medium-sized application can result in a mess of same purpose colors defined at multiple locations in code resulting difficult maintainability and even inconsistent colors.
A central file defining the color scheme ensures maintainability and scalability.
If desired a different theme could be added, through a media query for dark themes for example, just in this file replacing the values for the same variables; no further changes needed.
In this thesis the file `colors.scss` (see @color-file) defines all the used colors connecting them with the purpose-named variables.

#figure(
  code(
"$black-0:     #212529;
$black-1:      #2b3035;
$grey-0:       #343a40;
$grey-1:       #444a50;
$white-0:      #e2e2e6;
$green:        #080;
$green-darker: #060;
$red:          #CC1213;
$tile-bg:      #222;
$acc-0:        #ffa500;
$acc-1:        #cf7500;
$acc-blue:     #0d2edd;

:root {
  --body-bg:                #{$black-0};
  --text-color:             #{$white-0};
  --sidebar-bg:             #{$black-1};
  --sidebar-color:          #{$white-0};
  --sidebar-btn-hover:      #{$grey-0};
  --sidebar-btn-active:     #{$grey-1};
  --content-view-header-bg: #{$black-1};
  --content-view-bg:        #{$black-0};
  --dropzone:               #{$green-darker};
  --tile-border:            #{$green-darker};
  --tile-btn-hover:         #{$green-darker};
  --tile-bg:                #{$tile-bg};
  --warn:                   #{$red};
  --acc:                    #{$acc-0};
  --acc-secondary:          #{$acc-1};
  --acc-foreground:         #{$black-0};
  --acc-alt:                #{$acc-blue};
}
",
  "scss",
  path: "@css/colors.scss"
  ),
  supplement: [Code],
  caption: [Central scss file defining color variables used throughout the website.],
) <color-file>

What follows is a contrast analysis of those colors that overlap and contrast is needed to provide important information.
WCAG 2.1 defines contrast ratio as follows:
#align(
  center
)[$frac(L_1 + 0.5, L_2 + 0.5, style: "horizontal")op(", ") L_1 > L_2$]
where $L_1$ and $L_2$ are the relative luminance. The relative luminance is computed as follows:
#align(center)[
  $L = 0.2126 dot R + 0.7152 dot G + 0.0722 dot B$
]
Each of the channels $R, G, B$ in this formula are computed by taking the original normalized color channel $overline(c)$ and applying the following computation to them:
#align(center)[
  $C = cases(
    frac(overline(c), 12.902, style: "horizontal") op(",") quad overline(c) thin  <= thin 0.04045,
    (frac(overline(c) + 0.055, 1.055, style: "horizontal"))^2.4 op(", otherwise")
  )$
]
The important color variables used for text are `--text-color` and `--acc-foreground`. Both of them need to be compared to the background colors they are displayed on. As the css-style variables are purpose-named and hence would result in redundant comparisons the contrast ratio is computed relative to the color values that are used for background purposes.

#figure(
  image("../assets/text_color_contrasts.drawio.svg"),
  caption: [Table of color contrast ratios. The rows are color variables used for foreground / text, while the columns represent the color values used as a background throughout the website.],
) <text-color-contrasts>

According to these contrasts, some color choices have been avoided.
The `--acc-foreground` has been for example added to avoid the weak contrast of the normal text color on any accentuated background.

