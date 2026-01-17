#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

The main purpose of implementing a modular system is to remove redundancy.
While code redundancy is hailed as one of the biggest evils in programming, the most important redundancy to mitigate in this project is the one of implementing complex processes managing UI/UX specific tasks.
As a core property of rather complex tasks that are re-used, comes the necessity of some of their behavior being configurable.
Thus it is necessary to differentiate configurable properties and make them easy to configure for any developer who wants to implement a module.

The available data received by the alerting system is categorized by a module type and a specific module name.
For example specific module names (or instances as we are going to call it) could be "doorcode" or "DAR" (digital accident report), but both have the same module type "text". 
The following properties can be defined on the scope of a module instance or the whole type.
#align(center)[
  #table(
    columns: (auto, auto, auto),
    align: (left + horizon, left + horizon, center + horizon),
    table.header(
      [*Property name*], [*Description*], [*Default*],
    ),
    [icon_path], [Server root path to the .svg file containing the desired icon to represent that module.], [fa-diamond],
    [fetch_init_data], [If set to `true`, data will be requested from the back end as explained earlier.], [false],
    [refresh_interval_ms], [Only read if `fetch_init_data` is set to true. The interval in miliseconds in which the data will be refreshed from the back end.], [-1]
  )
]

==== Module container
The whole implementation of the `ModuleContainer.vue` is too big to include it here.
The heart of it is the `module_loader.ts` which implements the asynchronous loading process and spans over 150 lines.
Instead @module-container-template just shows the `template` implementation of the `ModuleContainer.vue`, which demonstrates what is shown at what state of loading.

#figure(
  code(
"
<template>
    <div v-if=\"handle?.data_state === DataLoadState.Stale\">
        Stale Data
    </div>
    <div class=\"d-flex flex-column\">
        <header><h1>{{ module_name }}</h1></header>
        <component
              v-if=\"handle &&
                    handle.component_state === ComponentLoadState.Loaded &&
                    showable_data_state\"
              :is=\"handle.component\"
              v-bind=\"handle.data ? { data: handle.data } : {}\"
        />
    </div>
    <div v-if=\"handle?.component_state === ComponentLoadState.Loading\">
        Loading module..
    </div>
    <div v-if=\"handle?.data_state === DataLoadState.Loading\">
        Loading data...
    </div>
    <div v-if=\"
        handle &&
        (handle.component_state === ComponentLoadState.Error ||
        handle.data_state === DataLoadState.Error)\"
    >
        <strong>Error:</strong> {{ handle.error_message }}
    </div>
</template>
",
  "vue",
  path: "app/components/ModuleContainer.vue"
  ),
  supplement: [Code],
  caption: [The template part of the module container SFC.],
) <module-container-template>

Most important here is Vue's `component` element (see @module-container-template, line 8), which will be whatever component is set to the `:is` property.
So once the SFC representing the desired module is loaded, `handle.component` will be set and the `component` element can be shown as indicated by the condition in `v-if`.

Most of the loading logic is put away in the `module_loader.ts` composable.
The component itself only manages the rendering according to what `DataLoadState` and `ComponentLoadState` has been set.
The `module_loader.ts` implements a `load_module` method for importing/loading the Vue component file and for fetching the according module data separately if desired.
Moreover the Vue component and module data are cached.
While the Vue component is a static asset and will not change during a client session, the module data can get outdated and if defined by the previously discussed property `refresh_interval_ms` will be refreshed.

To determine what module is currently desired the `ModuleContainer.vue` will determine the module name and type from the current route parameter `moduleKey`.
The container will then try to import the correct module, which is after successful loading set to the `component` object.
If data has been requested and received it gets automatically passed into the component via a conditional `v-bind`.

==== Defining a module
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

The Vue file is needed, because the `ModuleContainer.vue` tries to load this file, since it is the main entry point to render a module type.
Hence it is necessary to point the front end to that file for a specific module type.
For that the back end has a global variable `registered_modules`, which can be expanded by a `ModuleType` as follows:
#align(center)[
  ```python
registered_modules = {
    "interactive_map": ModuleType("interactive_map", "modules/interactive_map/Map.vue"),
    ...
}
    ```
]

This will correlate the implemented SFC `Map.vue` with the module type "interactive_map"

Additionally the discussed properties can be configured in the file `module_defaults.yaml`.
YAML is a more readable version of json.
The top keys of that file are `module_instance_defaults` and `module_type_defaults`.
When defining a default for a whole module type, it can be done by setting the desired property for the module type as a key under `module_type_defaults`. For example to set an icon for all modules that are an instance of the module type `text`:
#align(center)[
```yaml
module_type_defaults:
  text:
    icon_path: "/static/icons/text.svg"
```
]

Setting a property for a specific module instance is similar only that the instance name needs to be specified before the property name.
The following example will set a different icon for the module instance `doorcode` of type text:
#align(center)[
```yaml
module_instance_defaults:
  text:
    Doorcode:
      icon_path: "/static/icons/doorcode.svg"
```
]

With these examples configuration, any `text` module that has no further specified icon, will always use the `text.svg`.
The exception being the `doorcode` module here, which is of type `text`, but because of the instance default being set to a different value, the type default will be overwritten.
