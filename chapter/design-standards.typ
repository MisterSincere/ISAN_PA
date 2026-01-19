
The design of interactive systems, especially in safety-critical domains such as emergency response, is guided by international standards that aim to ensure usability, accessibility, and reliability in general.
In the context of human–computer interaction, these standards provide a shared framework for evaluating and designing user interfaces that support effective human performance under diverse conditions.

One of the most prevalent standards in the EU regarding this area is the DIN EN ISO 9241 series, which defines ergonomic requirements for human–system interaction.
It serves as an umbrella standard covering both hardware and software systems up to workplace ergonomics, with a strong emphasis on usability principles such as effectiveness, efficiency and user satisfaction @9241_general.
ISO 9241-11 employs different definitions and concepts regarding usability.
Usually ISO 9241-110 is of particular relevance, which formulates core dialogue principles including suitability for the task, self-descriptiveness, conformity with user expectations, and error tolerance @9241_110_essay.
However, ISO 9241-110:2020 explicitly states that its principles are not universally applicable to every usage context and must be interpreted in relation to the specific task domain and user group like in safety-critical domains @9241_110_whole.
This limitation is especially relevant in the case of emergency response systems, where users operate under extreme time pressure, high stress, and potentially degraded perceptual conditions.
As a result, while ISO 9241 provides valuable general guidance, it does not prescribe concrete design solutions tailored to emergency scenarios, leaving significant room for domain-specific interpretation and adaptation.

In addition to usability standards, accessibility regulations play a central role in contemporary user interface design.
In Germany, the Barrierefreie-Informationstechnik-Verordnung (BITV 2.0) defines legal requirements for accessible digital systems used by public institutions.
BITV 2.0 is closely aligned with EN 301 549, a European standard that specifies accessibility requirements for information and communication technology @bitv-site.
EN 301 549 incorporates the Web Content Accessibility Guidelines (WCAG) in Chapter 9, which address web-based user interfaces @en-301-549.

WCAG defines success criteria across different conformance levels (A, AA, and AAA), with EN 301 549 encouraging AAA compliance where feasible, while also stating in chapter 9.5 that it is not recommended to be required as a general policy.
Criteria such as enhanced contrast ratios, scalable text, and clear visual hierarchy are particularly relevant for emergency response interfaces, as they support readability in challenging environments and reduce visual strain.
While accessibility standards are often associated with permanently impaired users, W3C guidelines also list situational impairments as a barrier @wcag-situation-impairment and HCI research emphasizes reduced analytical thinking that are common in emergency operations @decision-making-under-stress-01.

Existing standards thus establish an important foundation for usability and accessibility, but they do not fully address the specific interaction challenges of emergency response software or mention it only as a side note.
The need to prioritize critical information, support rapid situation assessment, and minimize cognitive load requires design decisions that go beyond general-purpose standards.
Consequently, this thesis builds upon established usability and accessibility guidelines, implementing and adapting  them within the context of an emergency-focused web application interface.
