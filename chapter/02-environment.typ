= Environment

Modern options in frontend like vue. Backend stays to use python like the rest of the project's modules since it is an easy language. Moreover connexion and flasks are the options, they are easy to use and enough for the scope of this project. So no switch to something like FastApi.

The techstack is the following.\
*Backend*:
- python
- flask wrapped in connexion
- jinja

*Frontend*:
- typescript, html, sass css
- vue, vite compiled

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 5pt,
    align: horizon,
    table.header(
      [], [*Frontend*], [*Backend*],
    ),
    [*Languages*], [HTML, SASS, TS, Jinja], [Python],
    [*Frameworks*], [Vue.js (with Vite)], [Flask/Connexion],
  ),
  caption: [Techstack],
) <techstack>

== Development setup

The @techstack shows blablabla\
To ease developing especially for frontend hot reloading is an important tool. Vite's development server can track changes and reload the webpage automatically.
