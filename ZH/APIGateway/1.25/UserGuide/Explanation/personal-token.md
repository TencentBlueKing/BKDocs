# 个人 token

蓝鲸 bkauth 支持生成个人 token

入口: https://bkauth.example.com ( example.com 替换成蓝鲸环境主域名 )

个人令牌（Personal Access Token，PAT）是代表用户本人的访问凭证。界面名称是「个人令牌」。用于在 IDE、脚本等非浏览器场景中，以本人身份调用已授权的 MCP Server 或网关 API。

## 创建与使用

1. 打开对应环境地址，点击「新增个人令牌」。
2. 填写名称、选择过期时间，勾选允许访问的 MCP Server / API，点击「生成令牌」。
3. 在弹窗中复制令牌明文。明文仅在创建时展示一次，关闭后无法再次查看。


MCP 配置示例 (前提：MCP Server 开启支持个人 token)


```json
{
  "mcpServers": {
    "your-mcp-server": {
      "url": "<从目标 MCP Server 页面的使用指引复制>",
      "headers": {
        "Authorization": "Bearer <your-personal-token>"
      }
    }
  }
}
```

调用网关 API： (前提：API 开启用户认证，并且配置支持个人 token。 发布到对应环境)

```bash
curl -H "Authorization: Bearer <your-personal-token>" \
  https://bkapi.example.com/api/<gateway>/prod/<api>
```

Bearer 首字母大写，与令牌之间有一个空格。url 请从目标 MCP Server / API 页面复制，不要使用本文示例地址。


## 注意事项

- 明文仅创建时可见，丢失后只能撤销并重新创建。
- 令牌代表个人身份，禁止共享，禁止写入聊天、文档或工单。
- 授权范围按实际需要勾选。怀疑泄露时立即撤销。
- 续期不改变令牌明文。每人最多 20 个有效令牌。

