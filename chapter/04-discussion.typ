#import "../utils.typ": *

= Discussion

The implementation and design process already happened planning to meet certain requirements.
This chapter recalls some of these procedures for contrast ratio of texts and discusses their results and investigates further guidelines of the WCAG 2.1 for target area sizes.
Additionally small navigation details that have been thought of are mentioned and brought into context.

== Target area sizes
#include("target-area-size-discussion.typ")

== Text contrast
#include("text-contrast-discussion.typ")

== General design choices 
In general the application has been designed to make it easy for users to move between emergencies and other interface elements like different module pages.
On the _emergency selection page_, users are forwarded directly if only one emergency is available.
When multiple emergencies exist, each one is shown as a button containing the raw ISAN to not artificially hide any information.
Another approach could be to extract that information and to put it into a more human-readable form.

In the _emergency view_, the weather is always visible in the top bar.
This allows for quick checking of local conditions and has been added especially for weather warnings.
Although no API has been implemented that delivers weather warnings, since those are mostly paid services, the layout is prepared for easy future extension; thanks to the component system only the according `Weather.vue` component needs to be changed for that.
Clicking the current emergency in the top bar opens a dropdown menu showing raw ISAN as opposed to the reduced one that is shown as the current one.
To not cause confusion the selected emergency's ISAN is highlighted with a blue color.

The sidebar uses only large icons at first to preserve as much screen space as possible for the main content.
Especially for new users who may not yet know what module each icon represents, the sidebar can be extended to show text labels with the module name.
This expanded view floats over the interface without resizing the main area.
This prevents the user's dashboard layout from shifting or being compressed.
Bot the top bar and the sidebar remain fixed in position so users always have a consistent reference point, regardless of which module they open.

On the _dashboard_, the dropzones are highlighted in green to clearly show where tiles can be placed.
If a user drags a tile across a dropzone but does not want to attach it, pressing Escape cancels attaching entirely for the current drag action.
This is not available on touch devices and might need further iteration in the future.
The initial dropzones only allow for half-splits because adding options to place quads would double the amount of dropzones to eight and make interacting with them actually more difficult.

Designing the tile headers required special consideration.
The headers show the module name and contain buttons for opening the according module page and removing the tile from the dashboard.
Especially with tiles only using a quarter of the screen, the header occupies a lot of space that could be used for module information instead.
The existence of the header is very important mostly because of the need to show what module that tile represents.
Once the header is added to show the module name, the buttons themselves do not occupy more space from the module tile.
Thus they have been kept for now with additionally adding a dropzone a tile can be dragged onto to remove it from the dashboard.

