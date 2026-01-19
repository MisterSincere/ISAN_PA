#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

The heart of this project is the dashboard, which is why most of the code lies here (~1000 lines).
The goal is to give the user the possibility to arrange all available information in a way he or she wants to.
To fulfill that purpose each module can be added as a tile to the dashboard.
This tile can then either get attached to a `dropzone` or just float anywhere where the user desires it to be.
If tiles overlap, clicking a tile will always bring it to the top.
Those tiles will give its module less space for the same data.
Therefore modules should implement different visualizations, filtering their visualized data by importance in regards to how much space they have.
This can be done via media queries for example.

The dashboard provides at most four `dropzones` to which only one tile each can be attached to.
However the initial `dropzones` only have the capability to attach to one half of the dashboard area (horizontally or vertically).
This is related to the size of `dropzones` on a smaller touch pad and trying to keep splitting simple.
This allows tiles to take up as much screen space as available until additional tiles are attached.
Once a tile is attached to one half, another tile can be dragged onto:
- its center to replace that tile
- the left or right third of a tile to split vertically on a horizontal tile
- the top or bottom third of a tile to split it horizontally on a vertical tile

The implementation utilizes `pointerdown`, `pointermove` and `pointerup` events.
These events combine mouse button events with touch pad events @pointer-events.
To differentiate whether a tile is currently being dragged or has only been clicked to bring it to the foreground, for every `pointermove` event it is checked whether the pointer movement exceeds a certain threshold:
#align(center)[
  ```typescript
const dx = evt.clientX - d.start_x;
const dy = evt.clientY - d.start_y;
if (!d.moved && Math.hypot(dx, dy) > DRAG_THRESHOLD) {
    d.moved = true;
}
  ```
]

This is stored inside the `dragging` variable, which also stores the following dragging state information:
#table(
  columns: (auto, auto),
  table.header(
    [*Variable*], [*Purpose*],
  ),
  [`moved`], [Initially false, but set to true once the `DRAG_THRESHOLD` is exceeded. Determines what happens once `pointerup` is triggered.],
  [`attaching_disabled`], [Initially false, but once the user presses `Escape` the currently dragged tile will not attach to any `dropzone` and can be moved anywhere.],
  [`index`], [The index of the tile being dragged inside the main array of all tiles that currently need to be rendered by Vue.],
)

Since arranging these tiles to the users preference takes some time, the layout is cached and automatically reloaded.
The `LayoutState` is comprised of two variables:
```typescript
interface LayoutState {
    tiles: Tile[];
    quadrant_occupation: QuadrantOccupation;
};
```
So it stores the tiles, which hold their exact position if floating, and the current quadrant occupation to be able to render the attached tiles too.
The `QuadrantOccupation` is a simple type that stores the tile index for each quadrant:
```typescript
export interface QuadrantOccupation {
    left_top: number | null;
    left_bottom: number | null;
    right_top: number | null;
    right_bottom: number | null;
}
```
Each `dropzone` correlates to a certain quadrant or half. 
Dropping a tile on a `dropzone` correlating to a half results in two quadrants being set to that tile's index as opposed to one if the `dropzone` only identifies one quarter of the dashboard.
To differentiate to what area a `dropzone` belongs to, the `DZTargetDirection` is added as a property:
```typescript
export type DZTargetDirection = "left" | "right" | "top" | "bottom" | "whole" | "none";
```
The `dropzone` has its own type:
```typescript
export interface DropZone {
    zone: AABB;
    target: AABB;
    direction: DZTargetDirection[];
    preview: boolean;
}
```
The `zone` defines coordinates for the area that needs to be hovered to activate the `dropzone` as a candidate once the tile is dropped onto it.
If a tile is attached to a `dropzone` the according instance is set as a property on that tile.
In that case the coordinates of the `target` property are used to render that tile.
The type is treated as a single source of truth, which is why the `preview` field is set to true once the `dropzone` is hovered.
The template is implemented so that a preview for that `dropzone` will be rendered if `preview` is set to true.
Coming back to the target direction, the field `direction` is desired to not guess the quadrant based on actual coordinates, but on actual semantics and definitions.
The property is an array to represent multiple things:
- array containing one element, represents a half split at the according position
- array containing two elements, represents a quadrant at the according position

Once a tile is attached to a `dropzone` the according quadrant or two quadrants need to be set to that tile's index.
Afterwards the available `dropzone` instances need to be updated for the remaining available quadrants.
The following are some of `dropzone` permutations with attached tiles that are possible:
#figure(
  image("../assets/attached_tile_left.drawio.svg"),
  caption: [A tile has been attached to the left dropzone, making it span the left half. The recomputed dropzone 2 represents the right half, while 1 and 3 represent the top and bottom right quadrant respectively.]
) <attached-tile-left>
#figure(
  image("../assets/two_attached_tiles_left.drawio.svg"),
  caption: [This state could be achieved if a new tile has been dropped onto the bottom third of the attached tile in @attached-tile-left. No recomputation of dropzones needed.]
) <two-attached-tiles-left>
#figure(
  image("../assets/attached_tile_top_left.drawio.svg"),
  caption: [If the bottom attached tile in @two-attached-tiles-left is removed a dropzone needs to added specifically for that quadrant.]
)


