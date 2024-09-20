# Monitor space

The monitoring space capability has been introduced since version V3.8 to support the namespace capabilities of different platforms, such as CMDB business, container management platform projects, PaaS developers' SaaaS applications, CI-built projects, etc.

## Spatial selector

![](media/16910485650364.jpg)


## Space management

![](media/16910486719824.jpg)


## Capabilities and relationships

What functions a space has are related to the resources it has.

* The business space has host resources and has all functions. The host cannot cross businesses.
* 1 business contains multiple container projects, so the container project can see all k8s resources and Node resources of itself, and all k8s resources of all related container projects can be seen under the business
* R&D projects and PaaS applications do not depend on host and container resources, so they only have the function of active PUSH reporting, such as custom indicators, events, logs, Trace and other functions