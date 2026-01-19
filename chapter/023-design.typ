#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

== Design

=== Top Level Design
The general goal of the interface design is to create a simple structure aligning with familiar interaction patterns following Jakob's Law that states:
#align(center)[
_"Users spend most of their time on other sites."_ @jakobs-law
]
In other words users will transfer knowledge of how to interact with software from other websites trying to apply it.
A menu design appearing in the bottom right as a floating menu with animations might have clever and thoughtful ideas but raises the need to learn specifically those ideas.
Instead more familiar locations of navigation bars at least in the western hemisphere are at the top or the left side of the screen.
Moreover sidebar menus can often toggle between an expanded, more detailed view and a view showing less information but occupying less screen space.

At the highest level, the application is split into two major views: the _emergency selection page_ and the _emergency view page_.
If only a single emergency is available, the selection page is redundant and bypassed entirely forwarding to the corresponding emergency view.
When multiple emergencies are available, the selection page presents the ISAN's of each emergency in a simple list.

The emergency view page forms the core of the interface since it is the primary workspace.
When entering this view, an initially empty dashboard is displayed.
This dashboard serves as the central canvas for arranging modular information tiles related to the selected emergency.
The main content area, which is used for the dashboard and individual module views alike, occupies the majority of the screen's real estate.
To support consistent orientation and uninterrupted navigation the topbar and sidebar remain persistently visible (see @top-level-design).
The dashboard, module view, topbar and sidebar are each implemented as a dedicated Vue component.

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
  caption: [Emergency view page top level design]
) <top-level-design>

The topbar provides quick access to meta-information.
It displays a reduced representation of the currently selected ISAN, while allowing to switch to other emergencies listed in a dropdown upon clicking the current ISAN.
Additionally general weather information has been added to the right of the topbar.

The sidebar provides navigation within the emergency view.
It lists all available modules and a dedicated entry for returning to the dashboard.
To preserve screen space, the sidebar initially shows only icons representing each available module.
Users may expand it via a "burger menu" button to reveal the module names.
Each module can define its own icon.

The dashboard is designed to offer high flexibility while making it easy to maintain order with a lot of information present.
Users can add any module as a tile, with each tile being movable and resizable.
Tiles may be removed either through a dedicated button or by dragging them into a designated remove zone.
Clicking a tile brings it to the foreground, which is especially important when floating tiles overlap.

Freely floating tiles can easily overlap and result in cluttered layouts.
To prevent this a system of dropzones is introduced additionally.
These dropzones represent designated regions on the dashboard where tiles can snap into structures positions.
They enable users to quickly create clean layouts with up to four modules being placed side by side each taking a quadrant of available space.
If a tile is dragged onto the center of another attached tile, it can replace the existing one, or divide it either vertically or horizontally, when dropped onto one of the directional splitting zones.

=== Color Design <color-contrast>
Defining colors throughout even a medium-sized application can result in a mess of same purpose colors defined at multiple locations in code making maintainability difficult and colors sometimes incosistent.
A central file defining the color scheme ensures maintainability and scalability.
Support for different themes (e.g. a dark vs light mode) is achievable through media queries, replacing the color values for the same variable.
In this thesis the file `colors.scss` (see @color-file) defines all the used colors setting them to semantically named variables.
This follows the idea that colors should communicate meaning, which the variable name should represent.
This makes later changes to colors easier.
Take for example the color name `sky-blue`, which now has been referenced everywhere in the code where that color was deemed to be fitting.
Changing that color is difficult now because every reference needs to be changed and additionally validated if the change is appropriate to the context of that usage.
Since it was not a choice by a semantic name, it might have been used for something, where maybe the old color is still a more valid choice @semantic-colors.

#figure(
  code(
"$black-0:      #212529;
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
The important color variables used for text are `--text-color` and `--acc-foreground`. Both of them need to be compared to the background colors they are displayed on. As the CSS-style variables are semantically named and hence would result in redundant comparisons the contrast ratio is computed relative to the color values that are used for background purposes.

#figure(
  image("../assets/text_color_contrasts.drawio.svg"),
  caption: [Table of color contrast ratios. The rows are color variables used for foreground / text, while the columns represent the color values used as a background throughout the website.],
) <text-color-contrasts>

According to these contrasts, some color choices have been avoided.
The `--acc-foreground` has been for example added to avoid the weak contrast of the normal text color on any accentuated background.

