1.10/UserGuide/apigateway/reference/swagger.md# Swagger 说明文档

Swagger 是一种 API 协议描述的规范，被广泛用于描述 API 接口的定义。蓝鲸 API 网关采用 Swagger 2.0 协议管理网关资源导入、导出的配置文件。


## Swagger 配置说明

### paths

paths 表示资源配置的集合
- paths 下面为资源请求路径，如 /users/
- 请求路径下面为请求方法，支持以下请求方法
    - get
    - post
    - put
    - patch
    - delete
    - head
    - options
    - x-bk-apigateway-method-any (`x-bk-apigateway-method-any`为Swagger扩展字段，表示请求方法 ANY）
- operationId，表示资源名称
- description，表示资源描述
- tags，表示标签

示例
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

x-bk-apigateway-resource 为 Swagger 扩展字段，表示资源自定义配置，其中各字段含义如下：

```
- isPublic: 资源是否公开，可选值：true、false

- backend: 资源后端配置
  - type: 后端接口类型，必填，可选值：HTTP、MOCK

  # 后端接口类型为 HTTP 支持的配置
  - method: 后端接口 method，必填，可选值：get、post、put、patch、delete、head、options、any
  - path: 后端接口 path，必填
  - timeout: 后端接口超时时间
  - upstreams：后端接口Hosts
    - loadbalance: 负载均衡类型，支持 roundrobin, weighted-roundrobin
    - hosts: 后端接口Hosts
      - host: 后端接口的域名或IP
      - weight: 负责均衡类型为 weighted-roundrobin 时，当前 host 的权重
  - transformHeaders: 请求头转换
    - set: 设置的请求头信息
    - delete: 删除的请求头信息

  # 后端接口类型为 MOCK 支持的配置
  - statusCode: Mock响应状态码
  - responesBody: Mock响应内容
  - headers: Mock响应头

- authConfig: 安全设置
  - userVerifiedRequired: 是否用户认证，可选值：true、false
  - disabledStages: 禁用的环境名称列表
```

后端接口类型为 HTTP 的样例
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

后端接口类型为 MOCK 的样例
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

## Swagger示例

### 后端接口类型为HTTP的Swagger示例
```yaml
# Swagger yaml 格式模板示例
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

### 后端接口类型为 MOCK 的 Swagger 示例
```yaml
# Swagger yaml 格式模板示例
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

更多 Swagger 协议说明请参考 [Swagger 2.0 Resources Docs](https://swagger.io/docs/specification/2-0/basic-structure/)
