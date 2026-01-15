== Motivation
Emergency response scenarios are characterized by extreme time pressure, high cognitive load, and the need for rapid, well-informed decision-making.
In such contexts, the timely availability of accurate information is critical.
Studies have shown that shorter emergency response times are significantly associated with reduced mortality in urgent medical cases, and that real-time data acquisition and rapid alerting systems can improve response capabilities and potentially save lives by enabling faster, more informed decision-making by first responders @response-time-matters.
These findings emphasize that effective emergency response depends not only on operational capabilities but also stressing the importance of how information is provided to human operators and to not overload them with informations @role-of-information-systems-review.

At the same time, substantial progress has been made in the digitalization of emergency response infrastructures.
Modern fire departments and emergency services operate a wide range of specialized systems, including alerting, dispatch, and reporting platforms.
A standard like the International Standard Accident Number (ISAN) allows incidents to be uniquely identified and to correlate data from different systems / data silos.
From a technical standpoint, the infrastructure required to exchange life-saving data across heterogeneous systems is largely available.
However, the existence of such systems alone does not ensure that information can be accessed and interpreted efficiently in real-world emergency situations.

The user interface represents the critical link between complex backend systems and human decision-makers.
Human–computer interaction (HCI) research shows that user interface design has objective effects on user performance, error rates, and cognitive workload.
Variations in interface design have been empirically demonstrated to influence task completion speed, accuracy, and mental effort; simpler or better-organized interfaces with easily recognizable design patterns tend to reduce cognitive load and enhance performance compared to more complex designs @web-interface-design-objective-impact.

In emergency contexts, responders operate under stress and time constraints that limit working memory and increase the risk of errors.
Poorly designed user interfaces can amplify these limitations by presenting information in an unstructured, fragmented, or unintuitive manner, leading to delayed responses or misinterpretation of critical data.

Emergency responders are often required to consult multiple systems to obtain a complete picture of an incident, increasing cognitive effort and response time @role-of-information-systems-review.
Such interaction patterns conflict with fundamental HCI principles, including the reduction of cognitive load and the prioritization of critical information.

The motivation for this thesis is to address these challenges by designing and implementing a user-centered curing system interface that consolidates incident-related data from multiple sources into a single web application.
By leveraging standardized identifiers such as ISAN and applying established HCI principles, the system aims to support situational awareness and enable faster, more informed decision-making.
Ultimately, this work seeks to demonstrate how thoughtful interface design can contribute to more effective emergency response and support the overarching goal of saving lives.
