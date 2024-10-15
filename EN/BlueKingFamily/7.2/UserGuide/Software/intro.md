According to the overall architecture of BlueKing, products are divided into two categories: atomic platform and scenario SaaS. The difference between the two is that the products of "scenario SaaS" are all developed based on the "atomic platform" and use the core capabilities provided by the atomic platform. In this way, not only the scenario-based capabilities of the "atomic platform" are realized, but also the R&D threshold of "scenario SaaS" is lowered.

The following will introduce which products belong to the "atomic platform" and which products belong to the "scenario SaaS".

# Atomic Platform

## GSE

The BlueKing GSE is the underlying control system of the BlueKing system. It is the connector between the upper-level operation and maintenance service system and the underlying IaaS. It provides channels for instructions, files, and data for the upper layer. It supports direct connection mode, proxy mode, and the mode of specifying cascade routes to achieve optimal connection. The GSE is a typical two-layer distributed C/S structure, which mainly includes BlueKing Agent, Server that provides various services, and peripheral guarantee modules such as ZooKeeper, Redis, and MySQL. Among them, BlueKing Agent is a program deployed on the business machine. Each business machine only deploys one BlueKing Agent. There are no specific requirements for the deployment of other modules. Users can deploy them separately or in a mixed manner.

In the entire BlueKing system, the GSE does not need to face users directly, but it is indispensable in the system. It provides channels and capabilities for human-computer interaction for other platform modules. The GSE mainly provides three types of service capabilities: file distribution and transmission capabilities, command real-time execution and feedback capabilities, and big data collection and transmission capabilities.

For details of its functions, see [BlueKing GSE Product](../../../../GSE/2.0/UserGuide/Introduce.md).

## CMDB

BlueKing CMDB (CC) is an application-oriented CMDB. In the ITIL system, the configuration management database (CMDB) is the basis for building other processes. As a business-oriented CMDB, the CMDB provides configuration data services for various operation and maintenance scenarios for other platforms in the BlueKing system, and stores and manages various configuration information of devices in the enterprise IT architecture. It is closely linked to all service support and service delivery processes, supports the operation of these processes, and exerts the value of configuration information. At the same time, it relies on related processes to ensure the accuracy of data. The main functions provided by the CMDB include host management, business topology, business management, resource pool management, custom attribute management, operation audit, etc.

For details of its functions, see [《BlueKing CMDB Product》](../../../../CMDB/3.10/UserGuide/Introduce/Overview.md).

## JOB

The BlueKing Job Platform (Job) is a basic operation and maintenance platform based on the underlying management and control, and has a large amount of concurrent processing capabilities. In addition to supporting a series of basic operation and maintenance scenarios that can be realized, such as script execution, file pulling/distribution, and scheduled execution, it also uses the concept of process-based assembly to assemble fragmented individual tasks into a job process. At the same time, the API provided by the platform can be used to call and view any job, and it can be linked with other platforms or systems to achieve scheduling automation. The main functions of the job platform include: fast file transfer, web-based script management, support for batch efficient execution, process-based management, and everything is "job".

For details of its functions, see ["BlueKing Job Platform Product"](../../../../JOB/3.7/UserGuide/Introduction/What-is-Job.md).

## PaaS Platform

The BlueKing PaaS platform is an open platform, also known as BlueKing PaaS, which allows users to create, deploy and manage applications simply and quickly. It provides a complete front-end and back-end development framework, service bus (ESB), scheduling engine, common components and other modules to help users quickly, low-cost and maintenance-free build support tools and operation systems. The PaaS platform provides a complete self-service and automated service for an application from creation to deployment, and then to subsequent maintenance and management, such as log query, monitoring alarm, etc., so that users can devote all their energy to application development. The main functions of the PaaS platform include: support for multi-language development framework/samples, maintenance-free hosting, SaaS operation data visualization, enterprise service bus (API Gateway), draggable front-end service (MagicBox), etc.

For details of its functions, see [《BlueKing PaaS Platform Product》](../../../../PaaS/1.0/UserGuide/Overview/README.md).

## BCS

The BlueKing BCS is a platform used to support business containerization and microservices, and is a DevOps practice. The BlueKing BCS provides the specific implementation of continuous integration, continuous construction, and continuous deployment, and on this basis, builds distributed configuration management, service discovery, warehouse management (compatible with JFrog and docker hub), security health check, network configuration services and other major functions. The BlueKing BCS will provide interaction in the form of SaaS services, and users can complete the construction and release of business images by simply clicking on the page.

For details of its functions, see [《BlueKing BCS Product》](../../../../BCS/1.28/UserGuide/Introduction/README.md).

## BKMonitor

The BKMonitor is a business observation product officially launched by Tencent BlueKing , which has rich data collection capabilities, big data processing capabilities, and powerful platform expansion capabilities. Relying on BlueKing PaaS, a complete closed-loop observation capability can be formed in the entire BlueKing ecosystem, helping businesses to truly establish a business operation system covering CI-CD-CO. The BKMonitor has the characteristics of ease of use, timeliness, accuracy, intelligence, openness, and ecology. It is committed to meeting the needs and capabilities of different monitoring scenarios, escorting online businesses, and helping businesses "strategize in the tent and win thousands of miles away."

For detailed information about its functions, see [BlueKing BKMonitor Product](../../../../Monitor/3.9/UserGuide/Overview/README.md).

## BKCI

The BKCI (codenamed BK-CI) is a free and open source CI service that helps you automate the build-test-release workflow and deliver your products continuously, quickly, and with high quality. BK-CI provides seven core services: pipeline, code inspection, code repository, credential management, environment management, R&D store, and compilation acceleration. Multiple combinations can meet the needs of different scenarios of enterprises.

For details of its functions, see [BlueKing BKCI Product](../../../../Devops/2.0/UserGuide/intro/README.md).

## LessCode

The LessCode provides online visual drag-and-drop assembly of front-end pages, configuration editing, source code generation, secondary development and other capabilities. It aims to help users quickly design and develop SaaS with as little handwriting as possible.

For details of its functions, see [《BlueKing LessCode Product》](../../../../LessCode/1.1/UserGuide/intro.md).

## User Management

User Management (BKUSER) is a centralized user management solution provided by BlueKing for enterprise organizational structure, multi-user directory, etc., providing authentication source services for enterprise unified login.

For detailed information on its functions, see [《BlueKing User Management Product》](../../../../UserManage/2.5/UserGuide/Introduce/README.md).


## BKIAM

The IAM (BKIAM) is a centralized permission management service provided by Tencent BlueKing. It supports permission control access to SaaS and enterprise third-party systems based on the BlueKing development framework, as well as fine-grained permission management.

For details of its functions, see [《BlueKing IAM Product》](../../../../IAM/1.16/UserGuide/Introduce/README.md).

## Mobile Platforms

With the help of WeChat official account solutions, the BlueKing mobile platform integrates the functional features of BlueKing to help operations and maintenance maximize work efficiency and convenience. It supports users to manage/execute tasks, create/modify scheduled tasks, and other operations on mobile phones, truly achieving "work and life, in a blink of an eye."


# Scenario SaaS

## Node Management

An application designed for backend service management on the browser side. In the current version, it supports the installation and upgrade of gse_agent, which allows users to deploy agents and manage GSE plug-ins on controlled hosts intuitively and easily.

This SaaS has been launched. For usage documents, please refer to [《Node Management》](../../../../NodeMan/2.2/UserGuide/Introduce/Overview.md).

## LogSearch

The log system is a log product designed to solve the difficulties in log collection and query under a distributed architecture. It is based on the industry's mainstream full-text search engine and collects logs through BlueKing exclusive Agent, providing a variety of scenario-based collection and query functions.

This SaaS has been launched. For usage documentation, please refer to [《Log Platform》](../../../../LogSearch/4.6/UserGuide/Intro/README.md).

## SOPS

SOPS is a SaaS application that integrates work between multiple systems into one process through a mature and stable task scheduling engine, helping operation and maintenance to achieve cross-system scheduling automation.

This SaaS has been launched. For usage documents, please refer to [《Standard Operation and Maintenance》](../../../../SOPS/3.28/UserGuide/Overview/README.md).

## DBM
TODO

For detailed information on its functions, see [BlueKing DBM Product](TODO).

## BKNotice
The BKNotice is a basic service of the BlueKing PaaS platform, which aims to provide platform managers and application developers with an in-site message notification channel, such as platform announcements, event notifications, personal messages, etc.

For details of its functions, see [《BlueKing BKNotice Product》](../../../../BKNotice/1.5/UserGuide/Introduction/What-is-BKNotice.md).

## BSCP

The BSCP provides service configuration management functions for the business. The product is connected with other BlueKing products to provide a one-stop solution for the business.

For detailed information on its functions, see [BlueKing BSCP Product](../../../../BSCP/1.29/UserGuide/Introduction/product_introduction.md).
