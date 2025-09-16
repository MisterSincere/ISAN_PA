= Environment

Typescript: *type safety*, better maintainability, reducing common errors associated with dynamic typing.
Sass introduces advanced styling capabilities ensuring scalable styling through reusable design components.
Vue.js offers great reactivity with a component-based architecture ensuring great modularity.
As a build tool using Vite accelerates development with fast build and its hot-module reloading, optimized bundling.
The templating engine of Flask is Jinja good for flexible integration between the python back-end and the local client app.

Back-end relies on Python which is widely adopted and has an extensive ecosystem. Flask offers a minimal yet flexible framework for rapid service development, while Connexion enforces OpenAPI-driven design, enabling automatic validation, documentation and maintainable APIs.

Together this stack ensures good reactivity for interactive visualization with robust computation workflows in the back-end and good tooling for ensuring maintainability.

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

The @techstack shows blablabla\
To ease developing especially for front-end hot reloading is an important tool. Vite's development server can track changes and reload the webpage automatically.
