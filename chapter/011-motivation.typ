== Motivation
Emergency response scenarios are characterized by extreme time pressure, high cognitive load, and the need for rapid, well-informed decision-making.
In such contexts, the timely availability of accurate information is critical.
Shorter emergency response times are significantly associated with reduced mortality in urgent medical cases, and real-time data acquisition and rapid alerting systems can improve response capabilities and potentially save lives by enabling faster, more informed decision-making by first responders @response-time-matters.
This emphasize that effective emergency response depends not only on operational capabilities but also stressing the importance of how information is provided to human operators for example to not overload them with information @role-of-information-systems-review.

In addition to that, substantial progress has been made in the digitalization of emergency response infrastructures and the medical sector in general.
Modern fire departments and emergency services operate a wide range of specialized systems, including alerting, dispatch, and reporting platforms.
A standard like the International Standard Accident Number (ISAN) allows incidents to be uniquely identified and to correlate data from different systems and data silos @spicher2021proposing.
From a technical standpoint, the infrastructure required to exchange life-saving data across heterogeneous systems is largely available.
However, the existence of such systems alone does not ensure that information can be accessed and interpreted efficiently in real-world emergency situations.

The user interface represents the critical link between complex backend systems and human decision-makers.
Research regarding human-computer interaction (HCI) shows that user interface design has measurable effects on user performance, error rates, and cognitive workload.
Variations in interface design have been demonstrated to influence task completion speed and accuracy.
Simpler and better-organized interfaces using recognizable patterns tend to reduce cognitive load and enhance performance compared to more complex and cluttered designs @web-interface-design-objective-impact.

In emergency contexts, responders operate under stress and time constraints that might limit working memory and increase the risk of errors @decision-making-under-stress-01.
Poorly designed user interfaces can amplify these limitations by presenting information in an unstructured or unintuitive manner, leading to delayed responses or even misinterpretation of critical data.

Emergency responders are often required to consult multiple systems to obtain a complete picture of an incident, increasing cognitive effort and response time @role-of-information-systems-review.
Such interaction patterns conflict with fundamental HCI principles, including the reduction of cognitive load and the prioritization of critical information.

This thesis addresses these challenges by designing and implementing a user-centered curing system web interface that consolidates incident-related data from multiple sources into a single web application.
It follows a component-based architecture built with Vue and TypeScript on the front end and a Python/Flask back end, applying established software engineering principles.
By leveraging standardized identifiers such as ISAN and applying accessibility requirements, the system aims to support faster, intuitive and more informed decision-making.
Ultimately, this work seeks to develop a thoughtful web-interface design that can contribute to more effective emergency response, while laying a foundation for easily adding critical information without the need to re-iterate accessibility patterns and their implementation from a systematic point of view.
