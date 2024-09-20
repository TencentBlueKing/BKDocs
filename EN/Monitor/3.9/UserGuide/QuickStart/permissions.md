# Authority management

In the actual business operation process, from product/development/testing to operation and maintenance, everyone needs to participate in the entire product business operation; but apart from operation and maintenance, other partners do not necessarily know the situation of the business deployment environment, but they need to log in The monitoring system checks some business key indicator curves or alarm events; in order to avoid misoperations as much as possible, the permissions of the monitoring and alarm system need to be split into "read-only" or "read-write".

The permission assignment function allows users to assign two different levels of "query" or "change" permissions to different roles, which can not only meet the needs of only viewing key business indicators, but also avoid the risk of misoperation by other personnel.

## Preliminary steps

**Navigation path**: Navigation → System Management → Permission Settings

## Function Description

By default, monitoring will synchronize four roles: operation and maintenance, developers, product personnel, and testers. Therefore, if you need to add people, you can go to CMDB to add them. Viewing or editing permissions can be set in monitoring. This means that developers who want to have editing permissions for monitoring can also be set.

![-w2021](media/15754477019854.jpg)

> **Note: Business roles and corresponding personnel lists are all obtained from the BlueKing configuration platform.**

## Other permission descriptions

* **Public plug-in for plug-ins**: Only administrators can set plug-ins as public plug-ins, and only administrators can import public plug-ins.

* **Global Configuration**: Only administrators can perform global configuration.