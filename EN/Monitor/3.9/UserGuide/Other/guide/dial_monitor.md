# Service dial test

How to proactively detect the availability of website/application services through the monitoring platform.

## Preliminary steps

Dependent components: configuration platform, management and control platform, node management.

Users need to import the controlled host into the configuration platform and install the Agent (Quick Start for Hyperlink Configuration Platform), or directly install the Agent under the corresponding business through node management and import it into the host (Quick Start for Hyperlink Node Management). In the configuration platform, you need to add region information to the host attributes.

![-w2021](media/15773295803825.jpg)

## Collection

The collection of service dialing test is mainly divided into two parts, first: `adding dialing test node`, and then `adding dialing test task`.

### Dial test node

The `dial-test node` is the host where BlueKing Gse_Agent is deployed. The logic of service dial-test is to detect the service availability from the `dial-test node` to the `target address`.

### Add dial test node

Filter hosts from the configuration platform as dial test nodes through host attributes: `Country`, `Region` and `External Network Operator`.

In the `External Network Operator` field, select `Intranet`: It is designed to detect the availability of internal network services. Only the internal network IP will be used, and external network attributes such as operators will not be filtered. Select other operators such as `Telecom`: only Use external network IP to detect external network service availability.

> As an administrator, you can add default nodes for use by nodes across business scenarios.

### Dial test task

After selecting the node, configure different protocols to actively dial and test the website/application service. This is the second step of service dialing and testing collection: adding a dialing and testing task.

#### HTTP(S) protocol

The default new dial-up test protocol is HTTP(S), which is HTTP or HTTPS protocol.

   - GET method

     - 1. Enter the URL address of the Web service to be tested in the address bar.
     - 2. Select the node. If the default node is not satisfied, you can add a new node
     - 3. Set the expected response time: Set the normal response time range of the service, such as 3000ms. If it exceeds, an alarm will be generated.
     - 4. Set up task groups to distinguish different types of dialing and testing tasks
     - 5. Set the task name for easy identification

     ![-w2021](../media/15299999202180.jpg)

   - POST method

     - Compared with the GET method, there is one more `submission content`: enter the request content that needs to be submitted


> The POST request can be tested locally on the dial-up test node through the operating platform in advance. After the test is successful, the service dial-up test can be carried out through the monitoring platform.

   - advanced settings

     Set advanced features of HTTP dial testing here, such as dial testing cycle, expected return code, expected response information, geographical location (for large screen display) or request header information.

     - Expected return code: can be: `200`, `301`, etc. If the return code is inconsistent with the filled-in expected value, an alarm will be generated
     - Matching response information: for example `Welcome`, if the content returned by the web page does not contain `Welcome`, an alarm will be generated
     - Geographical location: In the [Large Screen Display] (../Product Functions/Uptime_Check_desc.md) function, dial the destination for data transfer
     - Header information: request header information, such as `Cookies`


#### TCP protocol

   - Detect the availability of TCP services from the dial test node.

     ![-w2021](../media/15301099924864.jpg)

   - For advanced options, please refer to `HTTP Dial Test`.


#### UDP dial test

   - Detect the availability of UDP service from the dial test node.

   - Since UDP is stateless, you need to send the request content that the UDP service is allowed to accept, and at the same time, the UDP service returns the content to detect whether the service is connected.

   - For advanced options, please refer to HTTP dial test.

> Please convert the request content to hexadecimal.

## View

### Service dial test menu

By default, all service dial test availability rates in the last hour will be displayed.

### Dial test details page view

Click the block of the above dial-test task to enter the details page of a single dial-test task.

### Optional: You can add views to the dashboard


## Policy configuration
### Create a dial test task

After success, 2 policies will be created by default: availability less than 100% and response time less than 3000ms (this time is not a fixed value and depends on the expected response time configured in the dial test task).

### Configure service dialing test alarm policy

You can create or modify policies by dialing the service tab on the monitoring configuration page.

Since the policy for HTTP status code and response content needs to be delivered to Gse_Agent, please create the policy in the advanced settings of the dial test task. After creation, you can modify the alarm rules, notification methods, etc. on the policy configuration page.

### View dial test alarms

You can find service dialing test alarms in the event center.

Click the alarm ID to find the alarm details of a single dial test task.