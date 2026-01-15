#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

The main purpose of implementing a modular system is to remove redundancy.
While code redundancy is hailed as one of the biggest evils in programming, the most important redundancy to mitigate in this project is the redundancy of implementing complex processes managing UI/UX specific tasks.
As a core property of rather complex tasks comes the necessity of configuring some of their behavior.
Thus it is necessary to define configurable properties and make them easy to configure for any developer who wants to implement a module.

The available data received by the alerting system is categorized by a module type and a specific module name, for example specific module names (or instances as we are going to call it) could be "doorcode" or "DAR" (digital accident report), but both have the same module type "text". 
The following properties can be defined on the scope of a module instance or the whole type.
#align(center)[
  #table(
    columns: (auto, auto, auto),
    align: (left + horizon, left + horizon, center + horizon),
    table.header(
      [*Property name*], [*Description*], [*Default*],
    ),
    [icon], [Server root path to the .svg file containing the desired icon to represent that module.], [fa-diamond]
  )
]
#nh("requirements and purpose")

==== Module container
The following is how the ModuleContainer.vue looks like:


#figure(
```typescript
<template>
    <component
	v-if="state === LoadState.Ready || state === LoadState.StaleData"
	:is="module_component"
	:data="module_data"
    />
    <div v-else-if="state === LoadState.LoadingModule">
	Loading module..
    </div>
    <div v-else-if="state === LoadState.LoadingData">
	Loading data...
    </div>
    <div v-else-if="state === LoadState.Error">
	<strong>Error:</strong> {{ error_message }}
    </div>
</template>
<script lang="ts" setup>
import { useModuleLoader, LoadState } from '../module_loader';

const { module_component, module_data, state, error_message} = useModuleLoader();

</script>
```
)

Most of the loading logic is put away in the `ModuleLoader` composable. The component itself only manages the rendering according to what `LoadState` has been set. The `ModuleLoader` implements a prefetching method for the loading the vue component and for fetching the according module data separately. Moreover the vue component and module data are cached. While the vue component is a static asset and will not change during a client session, the module data will get outdated (`LoadState.StaleData`). Therefore fresh data will always be fetched, but if cached data is available the module will already be shown.

The ModuleContainer has a dynamic `component` object from vue. The container will read in the url parameter and will try to import the correct module, which will then be passed to the `component` object. Then data is requested from the backend for that module, which gets automatically passed into the component.

Adding a module might include the following files:
#figure(
  table(
    columns: 3,
    inset: 5pt,
    align: (horizon, left, horizon),
    table.header(
      [*Filename*], [*Description*], [*Obligatory*],
    ),
    [ `<module-name>.vue` ],
    [The core SFC of the module that implements the logic, design and interactivity to fulfill the purpose this module is supposed to serve.],
    [Y],
    [ `<module-name>.ts` ],
    [Some logic regarding e.g. subtasks or re-usable logic through different components might be recommended to move to an external file, which can then be imported.],
    [N],
    [`<module-name>.py` ],
    [For adding back-end data responses to the SFC at the moment always requires at least expanding the `fetch_module_data` function inside the `app.py`. But it is recommended to outsource any deeper logic in a separate python file.],
    [N],
  )
)

The vue file is needed, because the `ModuleContainer.vue` tries to load this file, since it is the main entry point to render a module.


==== Defining a module
