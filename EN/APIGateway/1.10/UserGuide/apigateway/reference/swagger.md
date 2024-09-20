1.10/UserGuide/apigateway/reference/swagger.md# Swagger documentation

Swagger is a specification for API protocol description and is widely used to describe the definition of API interfaces. BlueKing API Gateway uses the Swagger 2.0 protocol to manage configuration files for importing and exporting gateway resources.


## Swagger configuration instructions

### paths

paths represent a collection of resource configurations
- The following paths are resource request paths, such as /users/
- Below the request path is the request method, and the following request methods are supported
     - get
     - post
     - put
     -patch
     -delete
     - head
     - options
     - x-bk-apigateway-method-any (`x-bk-apigateway-method-any` is a Swagger extension field, indicating the request method ANY)
- operationId, indicating the resource name
- description, indicating resource description
- tags, indicating tags

Example
```yaml
...
paths:
   /users/:
     get:
       operationId: get_users
       description: get users
       tags:
       - test
       ...
   /users/{id}/:
     x-bk-apigateway-method-any:
       operationId: user
       description: user
...
```

### x-bk-apigateway-resource

x-bk-apigateway-resource is a Swagger extension field, which represents resource custom configuration. The meaning of each field is as follows:

```
- isPublic: whether the resource is public, optional values: true, false

- backend: resource backend configuration
   - type: backend interface type, required, optional values: HTTP, MOCK

   # Backend interface type is HTTP supported configuration
   - method: backend interface method, required, optional values: get, post, put, patch, delete, head, options, any
   - path: backend interface path, required
   - timeout: backend interface timeout
   - upstreams: backend interface Hosts
     - loadbalance: load balancing type, supports roundrobin, weighted-roundrobin
     - hosts: backend interface Hosts
       - host: domain name or IP of the backend interface
       - weight: Responsible for the weight of the current host when the balancing type is weighted-roundrobin
   - transformHeaders: request header conversion
     - set: set request header information
     - delete: deleted request header information

   # The backend interface type is the configuration supported by MOCK
   - statusCode: Mock response status code
   - responsesBody: Mock response content
   - headers: Mock response headers

- authConfig: security settings
   - userVerifiedRequired: whether to authenticate the user, optional values: true, false
   - disabledStages: list of disabled environment names
```

Example with backend interface type HTTP
```
...
x-bk-apigateway-resource:
   isPublic: true
   backend:
     type: HTTP
     method: get
     path: /users/
     timeout: 30
     upstreams:
       loadbalance: roundrobin
       hosts:
       - host: http://0.0.0.1
         weight: 100
   authConfig:
     userVerifiedRequired: false
...
```

Example of backend interface type MOCK
```
...
x-bk-apigateway-resource:
   isPublic: true
   backend:
     type: MOCK
     statusCode: 200
     responseBody: pong
     headers:
       x-token: test
   authConfig:
     userVerifiedRequired: false
...
```

## Swagger Example

### Swagger example with backend interface type HTTP
```yaml
# Swagger yaml format template example
swagger: '2.0'
basePath: /
info:
   version: '0.1'
   title: API Gateway Resources
schemes:
- http
paths:
   /users/:
     get:
       operationId: get_users
       description: get users
       tags:
       - test
       x-bk-apigateway-resource:
         isPublic: true
         backend:
           type: HTTP
           method: get
           path: /users/
           timeout: 30
           upstreams:
             loadbalance: roundrobin
             hosts:
             - host: http://0.0.0.1
               weight: 100
           transformHeaders:
             set:
               x-token: test
             delete:
             -x-env
         authConfig:
           userVerifiedRequired: false
         disabledStages:
         -prod
         - test
```

### Swagger example with backend interface type MOCK
```yaml
# Swagger yaml format template example
swagger: '2.0'
basePath: /
info:
   version: '0.1'
   title: API Gateway Resources
schemes:
- http
paths:
   /users/:
     get:
       operationId: get_users
       description: get users
       tags:
       - test
       x-bk-apigateway-resource:
         isPublic: true
         backend:
           type: MOCK
           statusCode: 200
           responseBody: pong
           headers:
             x-token: test
         authConfig:
           userVerifiedRequired: false
```

For more Swagger protocol description, please refer to [Swagger 2.0 Resources Docs](https://swagger.io/docs/specification/2-0/basic-structure/)