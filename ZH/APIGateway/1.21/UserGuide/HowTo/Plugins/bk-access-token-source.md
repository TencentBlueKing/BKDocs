# Access token 来源

## 网关版本

bk-apigateway >= 1.17.1x

## 背景

蓝鲸的认证体系中，需要拼接 X-Bkapi-Authorization 头 ([认证](../../Explanation/authorization.md))。

而在某些场景中，例如 AI Agent，在配置调用蓝鲸 API 网关服务例如 MCP Server 的时候，无法生成这个头；只能配置 Bearer Token 或者 X-API-KEY。

这个插件支持将 Bearer token 或者 X-API-KEY 转换成 X-Bkapi-Authorization 给到认证服务使用。

插件功能： 从请求 header 中获取 Authorization: Bearer {access_token} 或 X-API-KEY: {access_token} 转成 X-Bkapi-Authorization: {"access_token": "{access_token}"}

## 步骤

### 选择资源

在资源上新建 【access_token 来源】插件
入口：【资源管理】- 【资源配置】- 找到资源 - 点击插件名称或插件数 - 【添加插件】

![image.png](./media/bk-access-token-source-01.png)

### 配置【access_token 来源】插件

![image.png](./media/bk-access-token-source-02.png)

注意，默认转换类型为 Bearer Token

1.19.3 支持 allow_fallback 参数，默认为 True

- allow_fallback=True，接口配置这个插件，如果用户没有按照来源传递对应的 header 头，会 fallback 到 X-Bkapi-Authorization
- allow_fallback=False，如果用户没有按照来源传递对应的 header 头，会报错返回

### 确认是否生效

- 如果是在环境上新建插件，立即生效
- 如果是在资源上新建插件，需要生成一个资源版本，并且发布到目标环境

原先调用示例：

```bash
curl -H 'X-Bkapi-Authorization: {"access_token": "yBnxr6qWvk35FikZMWz2LEkatnxyiL"}' https://example.com/...
```

新调用示例：

```bash
curl -H 'Authorization: Bearer yBnxr6qWvk35FikZMWz2LEkatnxyiL' https://example.com/...
```

如果选择转换类型是 X-API-KEY， 那么新调用示例：

```bash
curl -H 'X-API-KEY: yBnxr6qWvk35FikZMWz2LEkatnxyiL' https://example.com/...
```

### 其他

### 校验存在及非空

启用该插件之后，将会检查来源头是否存在/值非空，不存在直接 400

```json
{
  "message": "Parameters error [reason=\"No `Authorization` header found in the request\"]",
  "code": 1640001,
  "data": null,
  "result": false,
  "code_name": "INVALID_ARGS"
}
```

#### 如果同时都传递，将会覆盖 X-Bkapi-Authorization

```bash
curl 
  --H 'Authorization: Bearer abc' \ 
  --H 'X-Bkapi-Authorization: {"access_token": "def"}' 
```

生效的 access_token 将会是 abc
