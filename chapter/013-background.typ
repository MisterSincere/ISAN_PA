#import "../utils.typ": *

== Background
To understand some of the development choices, it is important have basic knowledge about the ISAN project, which gets utilized on the back end, and the Vue framework, which is used on the front end. Furthermore design choices are made according to related standard and accessibility guidelines, mentioned in this chapter.

=== Design Standards and Accessibility in Interactive Software
#include("design-standards.typ")

=== The ISAN Project
This thesis is build on the International Standard Accident Number (ISAN) project by the Peter L. Reichertz Institute (PLRI) of Braunschweig and Hannover.

The rescue chain is typically comprised of three different information and communication technology (ICT) systems: a curing system, responding system and an alerting system.
With the substantial increase of smart devices in the last decade, the alerting system can span all kinds of technology from a smart watch or any kind of smart wearable to a smart car or complete smart home.
The responding system to such an emergency is a composite of any kind of units like: firefighter, ambulances and air or sea rescue units.
Medical institutions like hospitals, a specific emergency room or a reha clinic are part of the curing system.
These institutions could provide better health care, if provided with personal data, medications or vital signs before the subject's delivery @haghi2021automatic.
Today, these stages are supported by largely isolated systems, resulting in manual data re-entry, delays and information loss.

The ISAN functions as a shared unique identifier linking distributed systems without requiring tight coupling or a centralized architecture. Instead of attempting to standardize all emergency data formats, ISAN provides a minimal common reference, similar in spirit to a primary key in distributed databases. The goal of the ISAN project has two core objectives:
1. establish a fully automatic emergency alert system, particularly from IoT devices such as smart cars or wearables.
2. ensure interoperability across isolated ICT systems operated by different organizations, vendors and even countries.
This proposed unique identifier aims to work with a multiplicity of different scenarios and hardware @spicher2021proposing.

==== ISAN Structure
The ISAN embeds accident metadata and a unique identifier directly into a compact string following the fixed-order paradigm @spicher2021proposing.
The metadata consists of time, location and altitude of the accident and also models the uncertainty of each of these values.
The altitude is optional.
This results in a total of seven data fields, each following a tag-value paradigm, meaning a value field is preceeded by a tag field.
Those tags and values are separated by the "|" character.
The tag is a single-character literal indicating the format, with "0" always indicating the preferred choice.
The following shows a list with all the discussed formats for time, location, altitude and unique identifiers with the preferred once in bold by Spicher et al. @spicher2021proposing:

#table(
  columns: (auto, auto),
  inset: 5pt,
  align: (left, left),
  table.header(
    [*Value field*], [*Supported format*]
  ),
  [Time], [*ISO 8601b (basic)*, ISO 8601e (extended), Unixtime, RFC 5322s, RFC 5322l, ISO 8601bu],
  [Time uncertainty], [*ISO 8601bu (basic)*, ISO 8601eu (short)],
  [Location], [*ISO 6709*, Open Location Code, ISO 19160 subset],
  [Location uncertainty], [*RFC 5870*],
  [Altitude], [*ISO 6709*, ISO 4157],
  [Altitude uncertainty], [*RFC 5870*, ISO 4157],
  [Unique identifier], [*MAC address*, bluetooth device address, international mobile equipment identity (IMEI), international mobile station equipment identity (IMSI), manufacturer serial number (MSN), vehicle identification number (VIN), random number],
)

//==== Master case index
//The emergency care chain is comprised of a great number of heterogeneous systems resulting in siloed data. Looking at combined data of a patient's accident and emergency case, including data of is or her treatment and care plus corresponding outcomes in a comprehensive way across all sectors is difficult. Emergency medical services (EMS) collect rescue data, initial findings and continuous health monitoring data during a patient's transport.
//A patients medical data is recorded in a hospital forming an electronic health record (EHR)


=== Vue: Components and Composables
Modern web-based user interfaces are  more and more commonly developed using component-based frameworks, which support the construction of complex interfaces through the composition of smaller, self-contained units.
Component-based UI development has been widely adopted due to its benefits for modularity, maintainability, and consistency @reusable_design_patterns.
Vue is a JavaScript framework that follows this paradigm and is particularly suited for developing interactive, state-driven web applications with re-usability and scalability in mind.
In this thesis, Vue provides the structural foundation for implementing a user interface that must present dynamic and time-critical information in a distinct, clear and reliable way.

Components lie at the core of Vue, more specifically single file components (SFC).
A SFC encapsulates a specific part of the user interface, including its visual structure, interactive behavior, and local state.
For that it is essentially comprised of three parts: the template, script and style.
Where the template defines the document structure, the script any logic and state and style can be any type of css or derivative of css.
By decomposing the interface into reusable components, developers can manage complexity and enforce consistent interaction patterns across the application.
This approach aligns with principles such as consistency, visibility, and predictability, which are essential for reducing cognitive load and supporting rapid information processing @hci_usability_engineering.
In emergency response systems, where users operate under stress and time pressure, such consistency enables faster recognition of interface elements and more reliable interaction.

Conceptually, a component-based user interface can be understood as a hierarchical structure, where higher-level components compose and coordinate lower-level elements, as illustrated in @component_hierarchy.

#figure(
  image("../assets/component_hierarchy.drawio.svg"),
  caption: [Conceptual hierarchy of a component-based user interface with an example in the broader context of this thesis.]
) <component_hierarchy>

While components structure the user interface, Vue further supports the separation of concerns through the use of composables.
Composables are reusable functions that encapsulate stateful logic and can be shared across multiple components.
Introduced as part of Vue’s Composition API, this concept reflects broader software engineering principles such as separation of concerns and functional abstraction.
Composables allow application logic—such as data retrieval, state synchronization, or domain-specific behavior—to be implemented independently of the visual representation.

From an HCI-oriented software engineering perspective, composables contribute indirectly but significantly to usability.
By externalizing complex logic from UI components, composables enable components to remain focused on presentation and interaction.
This clearer separation supports a closer alignment between the system’s internal structure and the user’s mental model of the interface, an important factor for usability in safety-critical systems.

The relationship between components and composables can be visualized as shown in @composable_example, where multiple components rely on shared composables for logic and state.
#figure(
  image("../assets/composable_example.drawio.svg"),
  caption: [Reuse of stateful logic through composables across multiple SFCs.]
) <composable_example>

Together, components and composables form an architectural pattern that supports modularity, scalability, and clarity in user interface development.
In the context of this thesis, these concepts provide the technical and conceptual basis for designing a user interface that integrates information from multiple data sources while adhering to established HCI principles.
By leveraging component-based UI design and reusable logic abstractions, the system aims to reduce cognitive load, support rapid information access, and improve interaction efficiency in emergency response scenarios.
