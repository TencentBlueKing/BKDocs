# How to implement multi-instance collection

Multiple instances refer to the same service deployed in different configurations on the same server or different servers. For example: redis has deployed two instances 6379 and 6380 on the same server, and the passwords of the two instances are different.

Configuration method:

* 1) CMDB configures multiple service instances
* 2) Collection configuration uses CMDB variables

## CMDB configures multiple service instances

![-w2021](media/15782889239728.jpg)

**Configuration path**: Navigation → Business → Business Topology → Module Settings → Service Instance Settings → Process Settings → Label Settings (optional)

The configuration of the service instance is in the service topology (identification 1)

> **Note**: If there are multiple instances under the same module (identification 2), the template function cannot be used. Need to use free configuration mode.

As shown in the figure, two redis service instances are set up, and the ports are 6379 and 6380 (identification 3). For details on the concept of service instances, please see [Explanation of Terms](../../Term/glossary.md).

And the `label` function (identification 4) is set because the passwords of the two redis instances are different. Tag: `redis_password`.

> **Note**: From a security perspective, it is generally not recommended to store passwords in tags.

## Collection configuration uses variable parameters

![-w2021](media/15782891786421.jpg)

* Identification 1: The variables filled in the running parameters can be viewed `Click to view recommended variables`
* Identification 2: Choose a different binding IP and port.

   `{{target.process["redis-server"].bind_ip}}`
   `{{target.process["redis-server"].bind_info[0].port}}` #The first port of the service instance

> Note: `redis-server` is the process name, and the plug-in classification must be the type of `service instance`

* Logo 3: Get the corresponding password and use the label function
   `{{target.service.labels['redis_password']}}`

For more variable lists, see [Variable List](../integrations-metrics/variables.md).

## Dynamic collection and monitoring

The collection target is selected dynamically, based on a certain service module or even any node.

The monitoring target also chooses a dynamic method.