# Load balancing

When API Gateway requests the backend interface, it distributes the traffic to multiple servers through load balancing to optimize resource usage and improve the reliability of the backend interface.

The API gateway configures the backend service Hosts separately to facilitate maintenance. The gateway can configure the default Hosts of the back-end service that the gateway calls in the environment;
In resources, you can use the default Hosts of each environment, or you can override the environment configuration and use resources to customize Hosts.

## Load balancing type

Load balancing type supports the following two types:
- Round-Robin, allocating requests to back-end servers in turn.
- Weighted Round-Robin, assigns different weights to each server based on different processing capabilities, so that it can accept requests with corresponding weight proportions.

Please refer to [What Is Round-Robin Load Balancing](https://www.nginx.com/resources/glossary/round-robin-load-balancing/)

## Environment load balancing configuration

The `Load Balancing Type` and `Hosts` in the environment 『Agent Configuration』 are used to manage the load balancing configuration of the environment.

`Hosts` can configure the domain name or IP (excluding Path) of multiple backend services, such as: http://test.bking.com, http://10.0.0.1:8000.

When the load balancing type is `Weighted Round-Robin`, the weight of each Host can be configured, and the weight value range is: 1 ~ 10000.

![](../../assets/apigateway/reference/stage-proxy-lb-config.png)

## Resource load balancing configuration

The resources use the load balancing configuration of each environment. You can select "Use environment configuration". When the user accesses the resources through the environment, the gateway will use the load balancing configuration of the corresponding environment to access the backend service.

![](../../assets/apigateway/reference/resource-lb-default-config.png)

If the resource does not use the default Hosts in the environment, you can choose `Override environment configuration` to customize the resources' Hosts, and the configuration items are the same as those in the environment.

![](../../assets/apigateway/reference/resource-lb-custom-config.png)