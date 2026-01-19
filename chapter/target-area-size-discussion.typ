#import "../utils.typ": *

As a reference for screen size to evaluate the user interface, the NIDApad will be used @nida-pad.
It is specifically developed for emergency situation by emergency responders.
The screen supports a resolution of 1920x1080 and has a size of 11.6 inch resulting in a screen size rectangle of 25.68cm x 14.45cm.

In chapter 2.5.5 of the WCAG 2.1 it states the target size for pointer inputs for conformance level AAA to be at least 44x44 CSS pixels @wcag.
It continues to specify exceptions, the two most important ones for this project being:
1. an *equivalent* satisfying the specified target size is present on the same page
2. the target is is *inlined* in a sentence or block of text

Since the screen size DPI can vary this does not represent on use-cases in the real world.
The actual size of a target with a fixed size, like a button, on a 10 inch FullHD screen is smaller than on a 20 inch screen with the same resolution.
Therefore, I compare the actual button sizes in centimeter on the NIDApad to the mean of the thumb width and index width, being 1.6cm and 1.2cm respetively @finger-width.
Taking these average finger sizes into account, the following target size range can be computed as pixel per centimeter (ppc):
#align(center)[
  $op("ppc")_x = frac(1920 op("px"), 25.68 op("cm"), style: "horizontal") approx 74.77$\
  $op("ppc")_y = frac(1080 op("px"), 14.45 op("cm"), style: "horizontal") approx 74.74$
]
Since for a 16:9 ratio the DPI is approximately equivalent, we simplify further computations by using $op("ppc") = op("ppc")_x := 74.77 frac("px","cm")$.
The equivalent in pixels for the according finger sizes is:
#align(center)[
  #table(
    columns: (auto, auto),
    table.header(
      [*Thumb*], [*Index finger*]
    ),
    [$1.6"cm" dot "ppc" = 119.632"px" approx 120"px"$], [$1.2"cm" dot "ppc" approx 89.724"px" approx 90"px"$]
  )
]
The thumb pixel size will serve as a maximum and the index finger size as a minimum.
These target sizes are almost three times as high as the highest conformance level of the WCAG 2.1.
Instead of serving as a recommendation for a minimal square area it defines only a recommendation for one dimension, the width of the target area.
This is because the width of our fingers aligns with the width of the screen rather than the height.

#show figure.where(
  kind: table
): set figure.caption(position: bottom)
#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (x, y) =>
      if y == 0 { center + horizon }
      else if x <= 1 { left + horizon }
      else { center + horizon },
    fill: (x, y) =>
      if (y == 1 and x == 2) { success }
      else if (y == 1 and x == 3) { success }
      else if (y == 2 and x == 2) { partial }
      else if (y == 2 and x == 3) { success }
      else if (y == 3 and x == 2) { success }
      else if (y == 3 and x == 3) { failure }
      else if (y == 4 and x == 2) { success }
      else if (y == 4 and x == 3) { success }
      else if (y == 5 and x == 2) { success }
      else if (y == 5 and x == 3) { success }
      else if (y == 6 and x == 2) { success }
      else if (y == 6 and x == 3) { success }
      else if (y == 7 and x == 2) { failure }
      else if (y == 7 and x == 3) { failure }
      else if (y == 8 and x == 2) { success }
      else if (y == 8 and x == 3) { success }
      else if (y == 9 and x == 2) { success }
      else if (y == 9 and x == 3) { failure }
      else { none },
    table.header(
      [*Button*], [*Area (px)*], [*AAA*], [*Finger-width*]
    ),
    [Emergency selection on emergency select screen], [800(min) x 65], [yes], [yes],
    [Emergency selection on emergency view screen], [700(min) x 37.33], [partial], [yes],
    [Sidebar module button], [60 x 55], [yes], [no],
    [Sidebar module button (expanded)], [230 x 55], [yes], [yes],
    [Dashboard add module dropdown], [231 x 50], [yes], [yes],
    [Module selection in dropdown], [240(min) x 45], [yes], [yes],
    [Module tile close and maximize button], [40 x 40], [no], [no],
    [Module tile remove zone], [400 x 100], [yes], [yes],
    [Module tile remove confirm zone], [80 x 80], [yes], [no],
  ),
  caption: [This table lists all buttons and target areas with their fixed or minimal size in pixel and compares them to the discussed WCAG 2.1 (AAA) target area size from chapter 2.5.5 and to the computed finger-width in pixels. For the WCAG comparison meeting the requirement partially means that only one dimension fulfills the minimum size. The finger-width is only compared to the width, where partial means that it matches the minimum width of an index finger but not that of a thumb.]
) <button-sizes>

@button-sizes shows that most target areas fulfill both metrics.
The selection of another emergency while managing the information of one, is deemed as a rare use-case, since the user's focus will typically be directed towards the emergency that has been selected for the time being.
Furthermore, the module tile close and maximum button have redundant target areas present.
To maximize a module the according button on the sidebar can be used and to remove a tile from the dashboard it can be dragged onto a zone at the bottom that fulfills both metrics.
The confirmation zone to remove a tile does not meet the requirement for the finger-width since it is intentionally sized smaller to reduce the likelihood of removing a tile on accident.
Additionally the user is dragging and thus gets continuous feedback whether the confirmation zone is currently hovered.
At last the sidebar module button does only meet the width of the index finger or the thumb once the sidebar is expanded.
