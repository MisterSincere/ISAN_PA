#import "../utils.typ": *

== Related work

- research of design choices and standards in emergency software.
- analysis of other software projects similar to this

=== Design standards and accessibility in interactive software
The design of interactive systems, especially in safety-critical domains such as emergency response, is guided by international standards that aim to ensure usability, accessibility, and reliability in general.
In the context of human–computer interaction, these standards provide a shared framework for evaluating and designing user interfaces that support effective human performance under diverse conditions.

One of the most prevalent standards in the EU regarding this area is the DIN EN ISO 9241 series, which defines ergonomic requirements for human–system interaction.
It serves as an umbrella standard covering both hardware and software systems up to workplace ergonomics, with a strong emphasis on usability principles such as effectiveness, efficiency, user satisfaction @9241_general.
ISO 9241-11 employs different definitions and concepts regarding usability.
Usually ISO 9241-110 is of particular relevance, which formulates core dialogue principles including suitability for the task, self-descriptiveness, conformity with user expectations, and error tolerance @9241_110_essay.
However, ISO 9241-110:2020 explicitly states that its principles are not universally applicable to every usage context and must be interpreted in relation to the specific task domain and user group like in safety-critical domains @9241_110_whole.
This limitation is especially relevant in the case of emergency response systems, where users operate under extreme time pressure, high stress, and potentially degraded perceptual conditions.
As a result, while ISO 9241 provides valuable general guidance, it does not prescribe concrete design solutions tailored to emergency scenarios, leaving significant room for domain-specific interpretation and adaptation.

In addition to usability standards, *accessibility* regulations play a central role in contemporary user interface design.
In the European context, the Barrierefreie-Informationstechnik-Verordnung (BITV 2.0) defines legal requirements for accessible digital systems used by public institutions.
BITV 2.0 is closely aligned with EN 301 549, a European standard that specifies accessibility requirements for information and communication technology.
EN 301 549 incorporates the Web Content Accessibility Guidelines (WCAG), particularly in Chapter 9, which addresses web-based user interfaces.

WCAG defines success criteria across different conformance levels (A, AA, and AAA), with EN 301 549 encouraging AAA compliance where feasible.
Criteria such as enhanced contrast ratios, scalable text, and clear visual hierarchy are particularly relevant for emergency response interfaces, as they support readability in challenging environments and reduce visual strain.
While accessibility standards are often associated with users with permanent impairments, HCI research emphasizes their broader relevance for situational impairments, such as reduced visibility, fatigue, or stress—conditions that are common in emergency operations.

Existing standards thus establish an important foundation for usability and accessibility, but they do not fully address the specific interaction challenges of emergency response software.
The need to prioritize critical information, support rapid situation assessment, and minimize cognitive load requires design decisions that go beyond general-purpose standards.
Consequently, this thesis builds upon established usability and accessibility guidelines while exploring their application and adaptation within the context of an emergency-focused curing system interface.

//*DIN EN ISO 9241:*
//- key umbrealla standard for interactive systems (software and hardware)
//- ISO 9241-110 specifically states it isn't for every situation
//
//*BITV 2.0:*
//- links to EN 301 549 which lists WCAG guidelines in chapter 9 and encourages AAA conformance if possible
//- https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf
//- contrast for example: https://www.w3.org/TR/WCAG21/#contrast-enhanced


=== Existing emergency response software
A number of software systems have been developed to support emergency response operations by aggregating incident-related information and assisting coordination.
Analyzing such systems provides insight into established design patterns, interaction paradigms, and functional priorities within the domain.

==== rescueTablet
rescueTABLET is a digital emergency management platform widely adopted by fire departments and emergency organizations in Germany, reportedly used by more than 750 organizations.
The system is designed to support incident command by providing an overview of operational data, resource allocation, and situational information.

From an interaction design perspective, rescueTABLET follows a dashboard-oriented layout combined with a persistent sidebar navigation.
Core information is presented using tiles and panels that group related data, allowing users to access different functional areas with minimal navigation depth.
This design reflects a common pattern in emergency software, where information is spatially organized to support rapid scanning and recognition.
The use of consistent visual structures across views supports user orientation and reduces the need for relearning during high-stress situations.


==== Tablet Command
Tablet Command is an emergency response platform primarily used by fire services in the United States and Canada.
According to publicly available information, it is employed by more than 800 public safety agencies and has been used to manage over 170,000 incidents as of 2024.
The system is explicitly designed for fire service operations, with a strong emphasis on unit and resource management.

The user interface of Tablet Command also adopts a dashboard-centric structure with a sidebar-based navigation model.
The system places particular focus on tracking units, assignments, and incident progression, reflecting its operational priorities.
A high degree of configurability allows agencies to adapt the interface to local procedures and preferences, which can support organizational fit but may also introduce variability in interaction patterns across deployments.

In addition to its client-facing interface, Tablet Command provides a web-based backend portal for configuration and management tasks.
The release of a major version update in 2021 introduced a revised interface structure, further emphasizing modular dashboards and centralized access to incident data.
From an HCI standpoint, this separation between operational and administrative interfaces reflects a role-based interaction model, which can reduce complexity for users in the field.

==== D4H
D4H is a comprehensive emergency management platform used globally by over 100,000 responders across hundreds of organizations in more than 37 countries and six continents @d4h.
According to their website, it has been recognized as a market leader in winter 2025 and ranked the number one emergency management software on G2.
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

In summary, D4H complements the other examined systems by demonstrating how modularity, role-based access, and configurability can be integrated into globally adopted emergency management software.
Its design provides additional insights into balancing flexibility, usability, and cognitive efficiency in complex, real-time systems—principles that inform the design of the curing system interface developed in this thesis.

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



