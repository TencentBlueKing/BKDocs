## Term explanation

## System

Refers to the platform or SaaS connected to the audit center, the "system" connected or the "system" from which the audit log is sourced

## Operation

Specific operations triggered by users in various forms in each system, such as job creation, host transfer, menu viewing, etc. An operation is preferably the smallest atomic function and must meet audit requirements

## Resource

The objects associated with the operations generated in each system, such as the object associated with job creation is the job, the object associated with host transfer is the host, etc., jobs and hosts are both types of resources

## Event

It is divided into operation events and audit events. Operation events refer to an event in which a specific operation of a user in each system is recorded in the audit center, while audit events refer to abnormal events detected by audit policies.