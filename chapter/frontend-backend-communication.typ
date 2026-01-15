#import "@preview/cetz:0.4.2"
#import "../utils.typ": *

For communication between the front end and back end data two different types are needed: static data and dynamic data.
It is important to differentiate for each information what its scope is.
==== Static data
Static data represents information that is loaded once per initial request of the page.
Without any user specific interaction the back end embeds data into the HTML via Jinja's rendering like follows:
#align(center)[
  ```<script id="py-data" type="application/json">{{ py_data|safe }}</script>```
]
Usually Jinja escapes HTML characters for safety reasons.
For that reason and only because we know what exactly we passed Jinja to fill in we specify it as safe for Jinja so that the json string remains healthy.
To ease declaring the layout of this data, `dataclasses` are used in python and `zod` in typescript, where both declarations need to represent the same structure.
They are located in files named `py_data.py` (see @py-data-py) and `py_data.ts` (see @py-data-ts) respectively as what they really represent is data sent from the python back end, received by the front end.

#figure(
  code(
"class JsonData:
    def json(self):
        return orjson.dumps(self).decode('utf-8')

@dataclass
class ModuleType(JsonData):
    module_type: str
    vue_component_file: str

@dataclass
class ModuleInstance(JsonData):
    name: str
    module_type: str
    fetch_init_data: bool = False
    refresh_interval_ms: int = -1
    icon_path: str = \"\"

@dataclass
class EmergencySchema:
    name: str
    modules: list[ModuleInstance]

@dataclass
class PyData(JsonData):
    emergencies: list[EmergencySchema]
    module_types: dict[str, ModuleType]
",
  "python",
  path: "src/py_data.py"),
  supplement: [Code],
  caption: [The python file (without imports) containing the declarations for data sent to the front end. The `py_data.ts` file needs to reflect this data layout.],
  placement: auto,
) <py-data-py>

#figure(
  code(
"export const ModuleTypeSchema = z.object({
    module_type: z.string(),
    vue_component_file: z.string(),
});

export const ModuleInstanceSchema = z.object({
    name: z.string(),
    module_type: z.string(),
    fetch_init_data: z.boolean().default(false),
    refresh_interval_ms: z.number().default(-1),
    icon_path: z.string(),
});

export const EmergencySchema = z.object({
    name: z.string(),
    modules: z.array(ModuleInstanceSchema),
});

const PyDataSchema = z.object({
    emergencies: z.array(EmergencySchema),
    module_types: z.record(z.string(), ModuleTypeSchema),
});

export type PyData = z.infer<typeof PyDataSchema>;

let cachedData: PyData | null = null;

export function getPyData(): PyData {
    if (cachedData == null) {
	cachedData = PyDataSchema.parse(
	    JSON.parse(document.getElementById('py-data')?.innerText ?? '{}')
	);
    }
    return cachedData;
}",
  "typescript",
  path: "app/py_data.ts"),
  supplement: [Code],
  caption: [The typescript file (without imports) containing declarations of data received from the back end. These declarations reflect the data layout defined by the back end in file `py_data.py`.],
  placement: auto,
) <py-data-ts>

While the back end code provides functionality to output the code into json via the class `JsonData` which every `dataclass` object inherits from, the front end code implements the function `getPyData()` in line 28 to 35.
The previously mentioned Jinja rendered variable put into the DOM Element `py-data` will be queried here.
Its contents parsed from json are then validated by `zod` according to the declared data layout.
Furthermore the result is cached (see line 26), hence subsequent calls do not have to undergo parsing again.

Almost at every point on the front end this data can be expected to be available.
Therefore it represents critical data that is needed for basic functionality.
For this project this means the app needs to know what emergencies exist and what modules it can show for each one.

==== Dynamic data
In contrast dynamic data is only required after certain user interactions.
In this case for example once a module is requested to be loaded by the user, the `ModuleContainer` will check whether the module type is defined to request dynamic data from the back end.
@module-workflow visualizes what routes lead to what type of data being send to the front end.
Once the route `module/:moduleKey` is appended to the index route the `ModuleContainer` will try to fetch data from the back end.
If cached data is present it will show this data immediately until the asynchronous fetch comes back, otherwise it indicates that the module is loading.
When a module is defined to request such data, we treat this data as critical to that module and therefore not mount any of its elements until that data is fetched successfully.
It is important to understand that the semantics of that fetched data cannot be validated by the `ModuleContainer`.
Due to this it needs to be validated by the module itself.
If successful it will replace the stale data with the received fresh data automatically.
Noteworthy is that a module can be shown on its own page or as a tile on the dashboard.
In both cases the same cache will be used.
The use-case of adding a module tile to the dasboard and then wanting to fullscreen this module on its own page, therefore results in immediate presentation of that same data.
Additionally the user can specify whether the data needs to be continously refreshed defined by a time interval $i$ in miliseconds.
The same procedure will be repeated every $i$ miliseconds accordingly, while the module is mounted on the dashboard or on its own page.

#figure(
  image("../assets/module_workflow.drawio.svg"),
  placement: auto,
  caption: [],
) <module-workflow>
