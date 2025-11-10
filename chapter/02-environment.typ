#import "../utils.typ": *

= Environment

Typescript: *type safety*, better maintainability, reducing common errors associated with dynamic typing.
Sass introduces advanced styling capabilities ensuring scalable styling through reusable design components.
Vue.js offers great reactivity with a component-based architecture ensuring great modularity.
As a build tool using Vite accelerates development with fast build and its hot-module reloading, optimized bundling.
The templating engine of Flask is Jinja good for flexible integration between the python back-end and the local client app.

Back-end relies on Python which is widely adopted and has an extensive ecosystem. Flask offers a minimal yet flexible framework for rapid service development, while Connexion enforces OpenAPI-driven design, enabling automatic validation, documentation and maintainable APIs.

Together, this stack provides strong reactivity for fast reactive visualization on the front end and robust workflows on the back end while enabling well-supported maintenance through comprehensive tooling.

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

== Development setup

To streamline front-end development, hot reloading is an essential tool. Vite's development server can track changes and reloads the webpage automatically.
Frameworks like Symfony have integrations and project skeletons for development and production, which configures everything.
For Flask I found the project flask-vite. This project provides only beta versions yet and is maintained by one person, with only few contributions from other people. I decided to write my own helper functions for a better integration in the environment of the already existing ISAN environment and full transparency of what happens to make extending functionality easier.

Why not just start the vite development server and access it directly? The vite development server will serve the application to the client. Requests made from that app to the server are typically handled by the back end with the route resolving to the host that served the app.
This could be solved by a proxy setting inside vite (see @config_vite_proxy). That way requests matching a certain pattern will be sent to the back-end server or the defined server respectively.
However this still doesn't account for template rendering happening in the back end before the app is served to the client. Creating DOM Nodes and filling them with content happens to some degree on the back end.
#todo("Elaborate why it makes sense to be on the back end")
The solution is to access the flask server with our back end directly instead of the vite server. Hot reloading of changes inside the back end is now natively handled by the flask server. In order for hot reloading on the front end to work we first detect whether the vite development server is running (see @src_is_vite_running). If no vite development server is detected the statically built assets are included as they should for production too. Otherwise the assets will be requested from the vite development server. The function `script_entries()` (see @src_script_entries) returns the script elements for each asset accordingly. Additionally a client for the vite development server needs to be imported. Since the same-origin policy forbids such requests, they need to be specifically allowed for the according assets via the `crossorigin` attribute.

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
  caption: "Returns the current known scripts either from the development server via crossorigin or with a direct path to the built assets.",
  supplement: [Code],
) <src_script_entries>
