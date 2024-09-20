# Preparation

If you do some preparation work before officially using monitoring, you will get twice the result with half the effort.

## Understand the monitoring platform

For a basic understanding of a monitoring platform, you can read:

* [Architecture diagram](../Architecture/architecture.md)
* [Data Model](../Architecture/datamodule.md)
* [Term explanation](../Term/glossary.md)

## Create a business or apply for a business

The data of the monitoring platform all use **business** as the namespace. Therefore, to start using the monitoring platform, you first need to apply for an existing business or create a new business.

Create a business: [How to create a business and import the host into the business](../../../../CMDB/3.10/UserGuide/QuickStart/case1.md)

Apply for a business: Apply for viewing or editing permissions for the business through the permission center.

## Monitoring platform permission application

The monitoring platform has been connected to the permission center and no longer relies on the role of the configuration platform. You need to go to the permission center to apply for permissions according to the prompts. The granularity of permissions can be finer than before.

For details, please view [Permission Application](perm.md)

## CMDB configuration information

The monitoring platform's host monitoring, process monitoring, and multi-instance monitoring all rely on the configuration of the CMDB. Only after configuring the CMDB can you use the monitoring platform correctly.

  * [How CMDB manages processes](../../../../CMDB/3.10/UserGuide/UserCase/CMDB_management_process.md)
  * [CMDB How to configure service instances](../../../../CMDB/3.10/UserGuide/Feature/Instance.md)

## Monitoring data collector plug-in installation

The data collection of the monitoring function depends on plug-ins. Some plug-ins are enabled by default, and others are enabled on demand.

* bkmonitorbeat collector for monitoring indicators, events, and dial tests
* bkunifylogbeat log collector
* bk-collecoter Push collector, remote reporting of Prometheus SDK and Opentelemetry SDK.

Node management SaaS installation plug-in interface