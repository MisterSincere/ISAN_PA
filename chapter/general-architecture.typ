#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

The architecture of this thesis' project is based on the patterns of single page applications.
In general, there are two different ways of rendering: via back end or front end rendering.
Typically rendering is better handled on the front end, our browsers are well-optimized for that today (WebGL, WebGPU).
Moreover the developed interface should react fast to user interactions.
If this reaction requires aysnchronous requests to the back end every time due to back end rendering, the resulting reactivity of the interface is too slow.
Vue minimizes the part of the website that need to be updated on data changes, reducing render times.
Instead it is more robust to let Vue handle rendering.
Data requests and writes can be sent to the back end asynchronously being potentially more complicated.
But for the curing systems data writes are not a typical use-case as its main purpose is to display data collected from different data silos.
Therefore a single page application (SPA) with front-end rendering is the architecture that was used to develop the curing system.

The general flow as illustrated in @general-architecture includes the following steps:
1. SPA requests module list after an emergency was selected and renders sidebar accordingly.
2. user clicks module -> `ModuleContainer` dynamically imports Vue component and fetches data if configured to do so.
3. `ModuleContainer` imports the Vue component for the selected module dynamically, instructing it to render its contents with optionally requested dynamic data from the back end.

#figure(
  image("../assets/general_architecture.drawio.svg"),
  caption: [Graph showing the workflow inside the SPA to load the modules.],
  placement: auto,
) <general-architecture>
#nh("Add route definitions")
