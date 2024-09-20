# Service dial test

Service dial testing is a monitoring method to detect the availability of services (applications). The target service is periodically detected through dial testing nodes, and the status of the service (application) is mainly measured through availability and response time.

Service dial testing realizes the transformation from passive complaints to active discovery by simulating user login/query. The currently supported dial testing protocols include HTTP (including HTTPS, GET and POST methods), TCP, and UDP.

## Preliminary steps

**working principle**:

![-w2021](media/15769111230760.jpg)

* **Remote Object remote monitoring object**: can be HTTP(s), TCP, UDP, ICMP
* **Dial test node**: This is the location where bkmonitorbeat is deployed, which is to set the source of detection. Multiple different location nodes detecting the same target can better reflect the availability of the service in the region.

![-w2021](media/15754459844425.jpg)

**Configuration main process**:

* (1) Configure the dial test node
* (2) Create a new dial test task
* (3) Select protocol
* (4) Fill in the target address
* (5) Set strategy
* (6) View dial test tasks

## List of main functions

* Dial-up test node and dial-up test task management
* Import batch testing tasks
* Supported protocols: TCP, UDP, HTTP(s), ICMP
* Supported targets: CMDB host, external network IP, domain name
* Indicators for measuring services: availability, response time, expected response code, expected response content
     * Availability rate: Within a dial-test cycle, the number of normal nodes/the total number of dial-test nodes * 100% (normal judgment conditions: expected return status code, expected return content, timeout time)
     * Response time: request time, timeout setting
     * Expected response code: 200 3xx 4xx 5xx
     * Expected response content: whether the response content matches
* Supported chart types: trend chart, map
* Others: Support import and task grouping

## Function Description

### Create a new dial test node

When there is no ready-available dial-test node, you need to create a dial-test node before adding a dial-test task.

**Function location**: Navigation → Service Dial Test → Node → New Dial Test Node

![-w2021](media/15771084983223.jpg)

* [1] The administrator can set it as a public node, which can be viewed by other businesses. By default, only this business can be used.
* [2] The default is to build a self-built node, and cloud dialing test nodes can be supported in the future.
*【3】If it is a self-built node, the selected IP information will be configured with the region and operator of the platform simultaneously.

![-w2021](media/15771090963329.jpg)

> Note: Of course, it can be customized without configuration in the configuration platform, but it is recommended that this kind of information can be maintained in CMDB to facilitate the use of other SaaS.

### Dial test task view mode

**Function location**: Navigation → Service Dial Test → Task

* The default is card mode and group management mode

![-w2021](media/15754459509275.jpg)

* Switch to list mode

![-w2021](media/15771078754865.jpg)

* Batch Import

![-w2021](media/15771532908360.jpg)

### Create a new dial test task

**Function location**: Navigation → Service Dial Test → Task → New Dial Test Task

![-w2021](media/15754460310042.jpg)

*TCP, UDP, and ICMP support five ways of filling in the target IP:
     * Dynamic topology: automatically obtain IP from CMDB topology, and automatically configure monitoring targets when new IP is added
     * Static topology: Only the selected topology will take effect. If a child node is added, the monitoring target will not be automatically covered.
     * Service template: Configure according to service template
     * Cluster template: configure according to the cluster template
     * Custom input: Supports manual input of internal network IP and external network IP. The external network IP address will not be checked by CMDB as long as it conforms to the IP format.

![image-20210421150942585](media/image-20210421150942585.png)

### View dial test details

*【1】Association editing operation and association policy configuration
*【2】Can switch between curve and map view

![-w2021](media/16044653735836.jpg)