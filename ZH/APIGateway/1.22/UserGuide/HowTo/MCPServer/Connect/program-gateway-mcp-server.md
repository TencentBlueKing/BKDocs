# 可编程网关使用 MCP Server

通过编程网关可以实现 mcpserver 配置化，通过代码的配置实现 mcpserver 的注册发布

### 前置资料

[可编程网关](https://github.com/TencentBlueKing/bk-apigateway-framework/blob/master/docs/design.md)

### 配置

创建好编程网关之后，注意设置 BK_APIGW_STAGE_ENABLE_MCP_SERVERS=True 开启 MCP Server 功能

### **API To MCP 声明定义**

#### python

api 声明时通过 enable_mcp=True 开启 MCP 功能，并且注意确认请求参数

```python
class DemoRetrieveApi(generics.RetrieveAPIView):
    ......
    @extend_schema(
       extensions=gen_apigateway_resource_config(
             # 是否开启 MCP
            enable_mcp=True,
             # 是否有请求参数，对于已经声明：parameters，requestBody 参数的不用设置
             none_schema=True,
        )
    )
    def get(self, request, id, *args, **kwargs):
         ......
```

具体 demo 见：[https://github.com/TencentBlueKing/bk-apigateway-framework/tree/master/templates/python/%7B%7Bcookiecutter.project_name%7D%7D](https://github.com/TencentBlueKing/bk-apigateway-framework/tree/master/templates/python/{{cookiecutter.project_name}})

#### go

注册 api 路由时 通过：basicConfig.WithMcpEnable(true) 来开启 mcp 功能

```go
util.RegisterBkAPIGatewayRouteWithGroup(
		userRouter, "POST", "",
		model.NewAPIGatewayResourceConfig(basicConfig, basicConfig.WithAuthConfig(
			model.AuthConfig{
				UserVerifiedRequired: false, // 用户认证
				AppVerifiedRequired:  true,  // 应用认证
			}),
			basicConfig.WithPluginConfig(headerWriterPlugin),
			basicConfig.WithBackend(model.BackendConfig{
				Timeout: 10,
				Path:    "/api/v1/users",
			}),
			// 开启 mcp
			basicConfig.WithMcpEnable(true),
			// 确认参数 Schema
			basicConfig.WithMcpEnable(true),
		),
		handler.CreateUser,
	)
```

具体 demo 见： https://github.com/TencentBlueKing/bk-apigateway-sdks/tree/main/gin_contrib/example
