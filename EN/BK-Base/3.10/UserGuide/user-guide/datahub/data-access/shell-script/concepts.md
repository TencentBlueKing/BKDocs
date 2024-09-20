# Script access

## Introduction

Script collection supports user-defined scripts to report data. The user writes the script and then sends the script to the target machine for execution.

Not suitable for reporting large amounts of data

## Collection principle

The script is hosted on gseAgent. The hosting configuration includes a call cycle, and gseAgent executes the script regularly.

The script encapsulates the reporting logic, and the data is reported through the gsecmdline command line tool.

The data reporting format is json format, and the json data processing in the script depends on the jq command.

## Access preparation

* Job execution permissions. The collector delivery depends on job execution, so the user needs job execution permissions.
* Please confirm that the jq command has been installed on the server before use

## Data access

### Data information

It defines the basic information of the source data, including business, source data name, etc. The data source name is defined by the user and cannot be repeated in the same business.

### Access object

Each access object defines the HTTP configuration that needs to be collected

* Collection range: access by module or IP
* Script: Users write scripts here.

Each data source supports configuring multiple access objects.

### Script debugging

Click the test button to test the data collection situation

![](../../../../assets/click_debug_script.png)



Waiting for execution

![](../../../../assets/wait_debug_script.png)

The result is returned successfully after debugging, with a green mark in front of it.

![](../../../../assets/debug_success_script.png)

When debugging fails, the result is returned with a red mark in front. This machine does not have the jq command installed, so an error is reported.

![](../../../../assets/debug_error_script.png)



### Access method

The collection period can be configured in minutes, hours, and days

#### The access interface example is as follows

![](../../../../assets/new_script_access.png)