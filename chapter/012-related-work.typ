#import "../utils.typ": *

== Related Work

=== Existing Emergency Response Software
A number of software systems have been developed to support emergency response operations by aggregating incident-related information and assisting coordination.
Analyzing such systems provides insight into established design patterns, interaction paradigms, and functional priorities within the domain.
\
\
_rescueTABLET_ is a digital emergency management platform widely adopted by fire departments and emergency organizations in Germany, reportedly used by more than 750 organizations @rescue-tablet-website.
The system is designed to support incident command by providing an overview of operational data, resource allocation, and situational information.

From an interaction design perspective, rescueTABLET follows a dashboard-oriented layout combined with a persistent sidebar navigation.
Core information is presented using tiles and panels that group related data, allowing users to access different functional areas with minimal navigation depth.
This design reflects a common pattern in emergency software, where information is spatially organized to support rapid scanning and recognition.
The use of consistent visual structures across views supports user orientation and reduces the need for relearning during high-stress situations.
\
\
_TabletCommand_ is an incident management software primarily used by fire services in the United States and Canada.
According to their website more than 50,000 emergency responders across North America use Tablet Command @tablet-command-overview.
The system is explicitly designed for fire service operations, with a strong emphasis on unit and resource management.

The user interface of Tablet Command also adopts a dashboard-centric structure with a sidebar-based navigation model.
The system places particular focus on tracking units, assignments, and incident progression, reflecting its operational priorities.
They claim that one of their advantages is early notification of structure fires and cardiac arrests of up to 30 to 60 seconds before traditional station alerting .

In addition to its client-facing interface, Tablet Command provides a web-based portal for configuration and management tasks.
The release of a major version update in 2021 introduced a revised interface structure, further emphasizing modular dashboards and centralized access to incident data.
From an HCI standpoint, this separation between operational and administrative interfaces reflects a role-based interaction model, which can reduce complexity for users in the field.
\
\
_D4H_ is a comprehensive emergency management platform used globally by over 100,000 responders across hundreds of organizations in more than 37 countries and six continents @d4h.
According to their website, it has been recognized as a market leader in winter 2025 and ranked the number one emergency management software on G2 @d4h-g2-winner.
These adoption metrics indicate that D4H serves a wide variety of operational contexts, from local fire departments to multinational emergency response organizations.

From a design perspective, D4H emphasizes a modular and role-based interface.
Operational dashboards consolidate key incident information, resource allocation, and communication channels in a single view, while secondary modules allow task-specific interaction, such as personnel management, equipment tracking, or post-incident reporting.
This separation of concerns reflects a deliberate attempt to reduce cognitive load for users who must make rapid, high-stakes decisions.

Navigation within D4H relies on persistent sidebar menus and context-sensitive panels, similar to other emergency platforms such as rescueTABLET and Tablet Command.
Information is typically presented through tiles, tables, and summary panels, facilitating quick scanning and recognition of critical incident details.
The configurable nature of the interface allows organizations to tailor the layout and functionality to their operational procedures, which supports adoption across diverse user groups but may require careful user training to maintain consistency.

The global reach of D4H also highlights the importance of flexible localization and adherence to accessibility and usability standards.
In emergency contexts where users operate under stress, cognitive load, or adverse environmental conditions, interface clarity, consistency, and predictability are crucial.
D4H’s design exemplifies how large-scale emergency software can implement these principles at both operational and strategic levels.

//*rescueTABLET:*
//- over 750 organisations in germany
//- dashboard, sidebar menu, tiles
//
//*tablet command:*
//- https://www.fireengineering.com/fdic-coverage/tablet-command-introduces-two-new-features/
//- more than 800 public safety agencies across us and canada
//- managed over 170,000+ incidents (2024)
//- purpose built for fire service
//- more focus on unit management
//- custom configurable
//- web portal backend
//  - 2.0 released in 2021
//  - dashboard and sidebar



