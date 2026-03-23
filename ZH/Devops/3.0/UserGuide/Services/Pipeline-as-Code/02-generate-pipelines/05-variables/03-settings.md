# 在YAML文件中引用凭据

## 关键字 settings

通过表达式 `${{ settings.<var-name>.<property-name> }}` 访问凭据服务下配置的凭据的内容。如何创建和使用凭据指引：[凭据管理](../../../Ticket/ticket.md)

`<var-name>` 为凭据管理下用户自定义的凭据 key。

每种类型的凭据对应的内容如何引用见下表：

| 属性名 | 值类型 | 说明 | 备注 |
| --- | --- | --- | --- |
| ${{ settings.<key>.password }} | String | type=PASSWORD 时的 password | |
| ${{ settings.<key>.access_token }} | String | type=ACCESSTOKEN 时的 access_token | |
| ${{ settings.<key>.username }} | String | type=USERNAME_PASSWORD 时的 username | |
| ${{ settings.<key>.password }} | String | type=USERNAME_PASSWORD 时的 password | |
| ${{ settings.<key>.secretKey }} | String | type=SECRETKEY 时的 secretKey | |
| ${{ settings.<key>.appId }} | String | type=APPID_SECRETKEY 时的 appId | |
| ${{ settings.<key>.secretKey }} | String | type=APPID_SECRETKEY 时的 secretKey | |
| ${{ settings.<key>.privateKey }} | String | type=SSH_PRIVATEKEY 时的 privateKey | |
| ${{ settings.<key>.passphrase }} | String | type=SSH_PRIVATEKEY 时的 passphrase | |
| ${{ settings.<key>.token }} | String | type=TOKEN_SSH_PRIVATEKEY 时的 token | |
| ${{ settings.<key>.privateKey }} | String | type=TOKEN_SSH_PRIVATEKEY 时的 privateKey | |
| ${{ settings.<key>.passphrase }} | String | type=TOKEN_SSH_PRIVATEKEY 时的 passphrase | |
| ${{ settings.<key>.token }} | String | type=TOKEN_USERNAME_PASSWORD 时的 token | |
| ${{ settings.<key>.username }} | String | type=TOKEN_USERNAME_PASSWORD 时的 username | |
| ${{ settings.<key>.password }} | String | type=TOKEN_USERNAME_PASSWORD 时的 password | |
| ${{ settings.<key>.cosappId }} | String | type=COS_APPID_SECRETID_SECRETKEY_REGION 时的 cosappId | |
| ${{ settings.<key>.secretId }} | String | type=COS_APPID_SECRETID_SECRETKEY_REGION 时的 secretId | |
| ${{ settings.<key>.secretKey }} | String | type=COS_APPID_SECRETID_SECRETKEY_REGION 时的 secretKey | |
| ${{ settings.<key>.region }} | String | type=COS_APPID_SECRETID_SECRETKEY_REGION 时的 region | |
| ${{ settings.<key>.password }} | String | type=MULTI_LINE_PASSWORD 时的 password | |
