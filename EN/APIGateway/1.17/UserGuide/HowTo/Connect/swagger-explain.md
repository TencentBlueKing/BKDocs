Swagger is a specification for describing API protocols and is widely used to describe the definition of API interfaces. BlueKing API Gateway uses Swagger 2.0 protocol to manage the configuration files for importing and exporting gateway resources.

## Swagger Configuration Instructions

### paths

paths represents a collection of resource configurations
- Below paths is the resource request path, such as /users/
- Below the request path is the request method, which supports the following request methods
- get
- post
- put
- patch
- delete
- head
- options
- x-bk-apigateway-method-any (`x-bk-apigateway-method-any` is a Swagger extension field, indicating the request method ANY)
- operationId, indicating the resource name, (composed of alphanumeric underscores, starting with a letter, cannot end with an underscore (_) or a hyphen (-), and the length is less than 256)
- description, indicating the resource description
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

x-bk-apigateway-resource is a Swagger extension field, which indicates resource custom configuration. The meanings of each field are as follows:

```
- isPublic: Whether the resource is public, optional values: true, false

- backend: resource backend configuration
  - type: backend interface type, required, optional value: HTTP

  # Configuration supported by backend interface type HTTP
  - method: backend interface method, required, optional values: get, post, put, patch, delete, head, options, any
  - path: backend interface path, required
  - timeout: backend interface timeout
  - upstreams: backend interface Hosts
    - loadbalance: load balancing type, supports roundrobin, weighted-roundrobin
    - hosts: backend interface Hosts
      - host: domain name or IP of the backend interface
      - weight: responsible for the weight of the current host when the balancing type is weighted-roundrobin
  - transformHeaders: request header transformation
    - set: set request header information
    - delete: Deleted request header information

- authConfig: Security settings
  - userVerifiedRequired: Whether to authenticate the user, optional values: true, false
  - disabledStages: List of disabled environment names
```

Example of HTTP backend interface type
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

## Swagger example

### Swagger example with HTTP backend interface type
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
            - x-env
        authConfig:
          userVerifiedRequired: false
        disabledStages:
        - prod
        - test
```

For more Swagger protocol descriptions, please refer to [Swagger 2.0 Resources Docs](https://swagger.io/docs/specification/2-0/basic-structure/)

## Recommendations

- Use apigw-manager sdk/image and complete [automatic access](./auto-connect-gateway.md) through swagger yaml
- It is recommended to maintain resource configuration through the management end in a fixed environment, and then export the resource configuration yaml file (manual maintenance of resource yaml files is not recommended)