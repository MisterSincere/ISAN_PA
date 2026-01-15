#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

In general there are two different ways to approach this: via back end or front end rendering.
Typically rendering is better handled in the front end, our browsers are well-optimized for that today (WebGL, WebGPU).
Moreover the reactivity is important on the front end anyways.
So reactivity handled by back-end rendering means the back-end needs to send and re-render the whole page again and again.
Frameworks like Vue are optimized updating only the important changed reactive parts of a website.
Updating something small like a text would result in requesting the page again from the back end being re-rendered with new data.
Instead it is more robust to let Vue handle rendering and updating the page with the single entry point being the `index.html` (single page application).
Data requests and writes can be send to the back end asynchronously being potentially more complicated.
But for the curing systems data writes are not a typical use-case as its main purpose is to *display* data collected from different data silos.
Therefore a SPA (single page application) with front-end rendering is the architecture that was used to develop the curing system.

The general flow as illustrated in @general-architecture includes the following steps:
1. SPA shell requests module list after an emergency was selected and renders sidebar accordingly
2. user clicks module -> `ModuleContainer` dynamically imports Vue component and fetches data if configured to do so
3. `ModuleContainer` renders UI using the data, imports any required JS/TS libraries internally and let's the Vue module component render it's contents

#figure(
  image("../assets/general_architecture.drawio.svg"),
  caption: [Graph showing the workflow inside the SPA to load the modules.],
  placement: auto,
) <general-architecture>
#nh("Add route definitions")
