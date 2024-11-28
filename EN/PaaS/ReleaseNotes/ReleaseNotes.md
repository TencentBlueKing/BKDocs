# Product Announcement

>**Blueking Cloud PaaS Platform Product Roadmap**

|Category |Current Status |Open Source Status |Open Source Address |Blueking Cloud Main Version |Release Time |
|:--|:--|:--|:--|:--|:--|
|PaaS3.0 |Mainline version, updating and maintaining |Open Sourced |https://github.com/tencentblueking/blueking-paas |V7 |2022 |
|PaaS2.0 |Stopped updating, maintenance only |Open Sourced |https://github.com/tencent/bk-paas |V6 |2019 |
|PaaS1.0 |Maintenance stopped |Not open sourced |None |None |2012 |

<br>

|Module List |PaaS2.0 (Stopped Updating, Maintenance Only) |PaaS3.0 (Active Open Source Project) |
|:--|:--|:--|
|esb: Blueking API Gateway |Integrated in main repository (paas-ce/paas/esb) |Spun off as a separate product, APIGateway |
|login: Blueking Unified Login Service |Integrated in main repository (paas-ce/paas/login) |Spun off as a separate product, [Unified Login User Management](https://github.com/TencentBlueKing/bk-user) |
|paas: Blueking Developer Center |Integrated in main repository (paas-ce/paas) |Spun off as a separate product, [PaaS-Developer Center](https://github.com/TencentBlueKing/blueking-paas) |
|paas: Web Workbench |Integrated in main repository (paas-ce/paas) |Spun off as a separate product, "Workbench" optimized as [Desktop](https://github.com/TencentBlueKing/blueking-console) |
|LessCode: Blueking Visual Development Platform |Integrated in main repository lesscode-master branch |Spun off as a separate product, [Visual Development Platform](https://github.com/TencentBlueKing/bk-lesscode) |

<br>

>**How to migrate SaaS developed before V6.0 to V7.0?**

The PaaS platform's "Developer Center" provides a "one-click migration" feature, which only supports SaaS developed using Blueking's official "Python development framework". See developer documentation [Things You Must Pay Attention to When Migrating from PaaS2.0 to PaaS3.0](../DevelopTools/BaseGuide/topics/paas/legacy_migration.md).

<br>

>**What are the functional differences between PaaS platform versions?**

|Feature |PaaS2.0 |PaaS3.0 |
|:--|:--|:--|
|Platform & Application Cluster Minimum Scale |Platform (1 server) / Application (1 server)<br>Can be mixed<br>No high availability |Platform (1 server) / Application (1 server)<br>Can be mixed |
|Underlying Technology |Native Docker |Kubernetes |
|Application Cluster Extensibility |Manual |Automatically call cluster node expansion |
|Application Scalability |Manual, cumbersome |Automatically scale by adjusting replica count |
|Application Types |Mainly web applications |Supports different programming languages, complex application architectures |
|Supported Programming Languages |Python (PHP, Java not mature) |Python, Go, Node.JS |
|Image Deployment Support | |Yes (supports any programming language) |
|Source Code Repository Support |SVN, Git |SVN, Git (supports Oauth authorization) |
|Custom Process Startup Command Support | |Yes |
|Multi-module Application Management and Deployment Support | |Yes |
|Real-time Process Log Viewing | |Yes |
|Online Process Stopping | |Yes |
|Inter-process Communication Settings Support | |Yes |
|Online Process Instance Count Adjustment | |Yes |
|Deployment Restrictions (Only Administrators Can Deploy) | |Yes |
|Real-time CPU/Memory Resource Information Viewing | |Yes (Phase 2, based on BCS) |
|Webconsole Support | |Yes |
|Access Methods |Only sub-paths, special configuration for independent domain names |Sub-paths + Independent subdomains |
|Independent Domain Name Support | |Yes |
|MySQL Enhanced Service |Yes, only for S-Mart applications |Yes |
|Redis Enhanced Service | |Yes |
|RabbitMQ Enhanced Service | |Yes |
|bkrepo Enhanced Service | |Yes |