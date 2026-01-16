#import "../utils.typ": *

The color choices have already been shown in @color-contrast and the contrast ratios between text colors overlapping has been computed (see @text-color-contrasts).

#figure(
  table(
    columns: (auto, auto, auto),
    align: (x, y) => 
      if y == 0 or x == 1 { center + horizon }
      else { left + horizon },
    fill: (x, y) =>
      if y == 1 and x == 2 { success }
      else if y == 2 and x == 2 { success }
      else if y == 3 and x == 2 { success }
      else if y == 4 and x == 2 { failure }
      else if y == 5 and x == 2 { success }
      else if y == 6 and x == 2 { failure }
      else { none },
    table.header(
      [*Context*], [*Contrast ratio*], [*AAA*],
    ),
    [Standard text on standard background], [11.94], [yes],
    [Module button text/icons on sidebar background], [10.31], [yes],
    [Module button text/icons on hovered background], [8.91], [yes],
    [Module button text/icons when active], [6.94], [no],
    [Emergency selection], [7.81], [yes],
    [Emergency selection when hovered], [4.55], [no],
  ),
  placement: auto
) <contrast-success-table>

WCAG 2.1 in chapter 1.4.6 requires a contrast ratio of at least 7:1 for text and images of text @wcag_contrast.
@text-color-contrasts shows low contrasts for the text color on the accentuated color (orange), this has been avoided because of this and the accentuated foreground color is used instead, which achieves the required contrast ratio.
This is the case for the emergency selection button, where when hovered the background color transitions to a slightly darker orange, which does not reach the intended contrast ratio.
Hovering is not a typical use-case on touchscreens and only an edge case, which is why this is regarded as not that important.
Similar to the module button text and icon having slightly less of a contrast ratio once that module's page is currently visible.
The information on that button is redundant information to the module's page displaying its module name as a big headline and the contrast ratio only misses the requirement by less than 0.1, which is why this also should not worsen the user experience.
