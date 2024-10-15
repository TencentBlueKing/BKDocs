# Request Header conversion

When the gateway API is accessed, the gateway will pass the request header passed in by the user to the backend interface.
If the gateway needs to pass a fixed request header or delete a specified request header, it can be achieved through request header conversion.

Request Header transformation, configurable in environment and resources:
- Environment Header conversion, as the default configuration for requesting Header conversion in this environment
- Resource Header conversion, you can use the default environment Header conversion configuration, or add environment configuration to merge the resource custom configuration with the environment default configuration

Header conversion supports two configurations: `set` and `delete`:
- Setting: means setting the request header to the specified value, for example, you can set Header X-Token to test
- Delete: means to delete the specified request header, for example, you can delete Header X-Debug

## Configure Header conversion in the environment

![](../../assets/apigateway/reference/stage-request-headers.png)

## Configure Header conversion in resources

![](../../assets/apigateway/reference/resource-request-headers.png)