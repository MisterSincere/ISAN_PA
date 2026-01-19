#import "../utils.typ": *

== Environment and Technologies Used
The project is developed as a web application using, alongside others, TypeScript @typescript-web and Vue @vue-web on the front end and Python @python-web and Flask @flask-web on the back end (see @techstack).
TypeScript expands JavaScripts dynamic and weak typing system with a gradual and strong one.
Strong typing can be described like follows by Liskov and Zilles @strong_typing_quote: "whenever an object is passed from a calling function to a called function, its type must be compatible with the type declared in the called function."
A gradual typing system lies between a dynamic and static typing system.
In the case of TypeScript it introduced type annotations to do static type checking:
```typescript
let x: number;
```
But it also allows the following examples:
```typescript
let x: any;
let x: number | Car;```
That special use-case of a variable being either a number or a `Car` object is hopefully never encountered, but the point is that in these two examples the type needs to be determined during runtime.
TypeScript  and JavaScript use the infamous duck test for this: "If it walks like a duck and it quacks like a duck, then it must be a duck" @duck_quote.
This can result in failed function calls during runtime or a deducted prototype being wrong.
If an object's properties are iterated over by a for-loop, additional properties could appear due to duck typing, making such code unpredictable and hard to read.
So even though in the end it is still in the hands of the developer to utilize the static typing properties of TypeScript, it also makes code more readable knowing what the type is; e.g. of an argument passed to a callback you need to implement.
Additionally while CSS is not possible to workaround when designing web applications, variants like Sass @sass-web introduce syntactic sugar making styling easier and ensuring scalability through reusable design components.
Vue offers great reactivity with a component-based architecture ensuring great modularity.
As a build tool using Vite @vite-github accelerates development by being a very fast build tool with optimized bundling in general while it also provides hot-module reloading which especially accelerates UI development.
The templating engine of Flask, Jinja @jinja-web, is good for flexible integration between the Python back end and the local client app.

The back end relies on Python which is widely adopted and has an extensive ecosystem. Flask offers a minimal yet flexible framework for rapid service development, while Connexion @connexion-web enforces OpenAPI-driven design, enabling automatic validation, documentation and maintainable APIs.

Together, this stack provides strong reactivity for fast interactive visualizations on the front end and robust workflows on the back end while enabling well-supported maintenance through comprehensive tooling.

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 5pt,
    align: horizon,
    table.header(
      [], [*Front-end*], [*Back-end*],
    ),
    [*Languages*], [HTML, SASS, TS, Jinja], [Python],
    [*Frameworks*], [Vue.js (with Vite)], [Flask/Connexion],
  ),
  caption: [Technology stack],
) <techstack>

=== Development Setup

To streamline front-end development, hot reloading is an essential tool.
Vite's development server can track changes and reloads the webpage automatically.
For Flask I found the project flask-vite @flask-vite-web.
It is a recently developed tool, maintained by only a single person, not considered to be stable, because the release is labeled to be a beta testing release.
Therefore helper functions have been implemented for a better integration into the ISAN environment.
With another advantage being full transparency of what happens to make extending functionality of the build environment easier.

Why not just start the vite development server and access it directly? The vite development server will serve the application to the client. Requests made from that app to the server are typically handled by the back end with the route resolving to the host that served the app.
This could be solved by a proxy setting inside vite (see @config_vite_proxy). That way requests matching a certain pattern will be sent to the back-end server or the defined server respectively.
However this still doesn't account for template rendering happening in the back end before the app is served to the client. Creating DOM Nodes and filling them with content happens to some degree on the back end.
#todo("Elaborate why it makes sense to be on the back end")
The solution is to access the flask server with our back end directly instead of the vite server.
Hot reloading of changes inside the back end is now natively handled by the flask server.
In order for hot reloading on the front end to work we first detect whether the vite development server is running (see @src_is_vite_running).
If no vite development server is detected the statically built assets are included as they should for production too.
Otherwise the assets will be requested from the vite development server.
The function `script_entries()` (see @src_script_entries) returns the script elements for each asset accordingly.
Additionally a client for the vite development server needs to be imported.
Since the same-origin policy @same-origin-policy forbids such requests, they need to be specifically allowed for the according assets via the `crossorigin` attribute.

#figure(
  code(
"export default defineConfig({
  server: {
    proxy: {
      '/api': 'http://localhost:5000',
    },
  },
})",
    "typescript",
    path: "vite.config.ts",
  ),
  supplement: [Code],
) <config_vite_proxy>

#figure(
  code(
"def is_vite_running() -> bool:
  try:
    requests.get(VITE_SERVER, timeout=0.2)
    return True
  except requests.RequestException:
    return False",
    "python", 
    path: "app/vite_integration.py",
  ),
  caption: "Dynamically checking wether the development server is responsive",
  supplement: [Code],
) <src_is_vite_running>

#figure(
  code(
    "def script_entries():
        vite_dev = is_vite_running()
        urls = get_script_entries(vite_dev)
    
        if vite_dev:
            urls.append(VITE_SERVER + '@vite/client')
    
        cors = \"crossorigin\" if vite_dev else \"\"
    
        return Markup(\"\".join(
            f'<script type=\"module\" src=\"{path}\" {cors}></script>'
            for path in urls
        ))",
    "python",
    path: "app/vite_integration.py",
  ),
  caption: "Returns the current known scripts either from the development server via crossorigin or with a direct path to the prebuilt assets.",
  supplement: [Code],
) <src_script_entries>
