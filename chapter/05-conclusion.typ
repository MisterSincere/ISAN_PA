= Conclusion
This thesis presented the design and implementation of a modular web-based curing system interface for the International Standard Accident Number (ISAN) system.
The focus lay on improving information accessibility in emergency situations by integrating data from different systems into a single, coherent application allowing for easy extensibility in the future.
The project followed a component-based architecture built with Vue and TypeScript on the front end and a Python/Flask back end, applying established software engineering principles. Central contributions of this work is the development of an asynchronous module loading mechanism and a freely configurable dashboard to show information from multiple modules on the same page in a layout the user desires.

The module loading mechanism loads modules dynamically, and their components are cached to reduce unnecessary workload and improve responsiveness.
If configured to do so, modules can also retrieve data from the loader, loaded asynchronously and refreshed at specified intervals without the need to implement anything of that functionality.
This data is cached across different views, ensuring that users can switch between the dashboard and full module pages without causing redundant requests.
To simplify configuration, a YAML-based file was introduced, allowing module types and instances to be defined with minimal effort.
This structure also provides a clear separation between module behavior and module implementation, suporting future extensibility.

The dashboard represents the core of the interface designed to allow flexible arrangement of module tiles.
Users can position tiles freely or attach them to predefined dropzones, enabling them to create a layout that fits their preferences during an ongoing emergency.
While the initial dropzones only allow half-screen splits, further splits into quads can be created by dropping tiles onto already attached ones.
This approach avoids visual clutter and keeps the interaction predictable for the user.
Module tiles can present reduced information, since they are viewed through smaller sizes, which encourages future module implementations to support adaptive visualization.

To evaluate accessibility and interaction quality, target area sizes and text contrast were examined.
Most interface elements meet or exceed the WCAG 2.1 AAA recommendations or the calculated finger-width thresholds for touchscreen use.
Where certain areas do not fully meet these metrics, like the tile header buttons, redundant interaction paths or deliberate design choices have been argued to justify these exceptions.
Text contrast was also analyzed, showing that all essential text meets the required ratios, while minor deviations occur only in optional hover states.

The navigation and general layout were designed to remain stable regardless of the module or dashboard state.
The topbar and sidebar stay fixed, providing consistent reference points during use.
The sidebar can be collapsed to icons or expanded with labels, allowing users to choose between compactness and clarity.
Although only basic weather data is currently included, the design anticipates future integration of warning systems with no structural changes needed.

Several areas for future work remain.
Integrating a weather API that includes official warning data would make the topbar more informative.
The emergency selection page could be improved by parsing and presenting ISANs in a more human-readable way without removing access to the raw identifier.
On touch devices, adding a mode to drag tiles without triggering attachment would improve dashboard flexibility.
Finally, future module developers can extend the system by providing additional compact visualizations tailored to the dashboard's reduced space.

In conclusion, the curing system interface of this thesis was developed with a modular UI design, combined with thoughtful concepts and adherence to accessibility principles, to support clearer, faster, and more reliable information access in emergency context.
By providing a flexible architecture and a consistent visual framework, the system offers a foundation for further enhancements and integration into larger ISAN-based rescue chain workflows.
