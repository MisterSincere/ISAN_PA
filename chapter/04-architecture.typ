#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

= Architecture
- regarding vue components
- module views ????

== Design philosophies
Single Page Application (SPA)
\
flow:
emergency selection --> request ermergency data --> show emergency dashboard and module selection

=== Data flow
For communication of data dataclasses are used in python and zod in typescript

== Modular system

#nh("requirements and purpose")
=== General architecture

In general there are two different ways to approach this: via back end or front end rendering.
Typically rendering is better handled in the front end, our browsers are well-optimized for that today (WebGL, WebGPU). So they can handle that way better #nh("elaborate").

1. SPA Shell requests module list after an emergency was selected and renders sidebar accordingly
2. User clicks module -> `ModuleContainer` dynamically import Vue component and fetches data
3. `ModuleContainer` renders UI using the data, loads any required JS libraries internally and let's the vue component render it's contents

#figure(
```
                    ┌─────────────────────┐
                    │   Backend (Flask)   │
                    │---------------------│
                    │ /api/module-data/...│ <- module-specific JSON
                    └─────────┬───────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│ SPA Shell    │       │ Sidebar      │       │ Module       │
│ (Vue + TS)   │       │              │       │ Container    │
│              │       │              │       │              │
│ Handles      │       │ Shows list   │       │ Dynamically  │
│ routing,     │       │ of modules   │       │ loads module │
│ layout,      │       │ based on     │       │ components   │
│ global libs  │       │ API data     │       │ Fetches JSON │
└───────┬──────┘       └─────┬────────┘       └───────┬──────┘
        │                    │                        │
        │ Click menu         │                        │
        │------------------->│                        │
        │                    │                        │
        │                    │                        │
        │            Load moduleName                  │
        │-------------------------------------------->│
        │                    │                        │
        │                    │                        │
        │                moduleData JSON <------------│
        │                    │                        │
        ▼                    ▼                        ▼
┌────────────────────────────────────────────────────────────┐
│ Modules (Self-contained Vue components)                    │
│ - Render UI dynamically                                    │
│ - Import dependencies locally (GLTFLoader, Chart.js, etc.) │
│ - Receive data as props                                    │
└────────────────────────────────────────────────────────────┘
```
)

=== Module container
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

Most of the loading logic is put away in the `ModuleLoader` composable. The component itself only manages the rendering according to what `LoadState` has been set. The `ModuleLoader` implements a prefetching method for the loading the vue component and for fetching the according module data seperately. Moreover the vue component and module data are cached. While the vue component is a static asset and will not change during a client session, the module data will get outdated (`LoadState.StaleData`). Therefore fresh data will always be fetched, but if cached data is available the module will already be shown.

The ModuleContainer has a dynamic `component` object from vue. The container will read in the url parameter and will try to import the correct module, which will then be passed to the `component` object. Then data is requested from the backend for that module, which gets automatically passed into the component.

Adding a module might include the following files:
#figure(
  table(
    columns: 3,
    inset: 5pt,
    align: horizon,
    table.header(
      [*Filename*], [*Description*], [*Obligatory*],
    ),
    [ `<module-name>.vue` ],
    [],
    [Y],
    [ `<module-name>.ts` ],
    [],
    [N],
    [`<module-name>.py` ],
    [],
    [N],
  )
)

The vue file is needed, because the `ModuleContainer.vue` tries to load this file. It is the main entry point to render anything as you like for that module.
