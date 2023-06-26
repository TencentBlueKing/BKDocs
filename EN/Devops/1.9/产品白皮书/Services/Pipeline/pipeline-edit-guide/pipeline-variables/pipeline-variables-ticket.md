# 凭证变量

流水线执行过程中，经常有使用密码、token、appId/secretKey等敏感数据访问有权限的资源的场景。

如果这些敏感数据直接编写到流水线里，有安全风险，容易泄露。

可以通过 BKCI 凭证管理 服务来统一管理敏感数据。

凭据可以在流水线中使用，通常有如下几种使用方式：

## 如何在流水线中使用凭据？

### 在流水线插件中选择或填写凭据名称

此场景下，插件后台封装了获取凭据内容的逻辑，用户编排流水线时仅需选择或填写凭据名称即可。

### 在流水线插件入参中引用凭据内容
此场景一般是在使用脚本插件（如 Bash），或者未封装凭据内容获取的插件。此时，可以通过 settings 上下文来引用具体的凭据内容。

示例：

```
前提：在凭证管理服务下创建了名称为 a，类型为 密码 的凭据

流水线入参中通过  ${{ settings.a.password }} 来获得密码
```

通过表达式 `${{ settings.<var-name>.<property-name> }}` 访问凭据服务下配置的凭据的内容。
- `<var-name>` 为凭据管理下用户自定义的凭据 key
- `<property-name>` 根据凭据类型不同而不同

|  属性名   | 说明  |
|  ----  | ----  |
| `${{ settings.<key>.password }}`  | type=PASSWORD 时的password |
| `${{ settings.<key>.access_token }}`  | type=ACCESSTOKEN 时的access_token |
| `${{ settings.<key>.username}}`  | type=USERNAME_PASSWORD 时的username |
| `${{ settings.<key>.password}}`  | type=USERNAME_PASSWORD 时的password |
| `${{ settings.<key>.secretKey}}`  | type=SECRETKEY 时的secretKey |
| `${{ settings.<key>.appId}}`  | type=APPID_SECRETKEY 时的appId |
| `${{ settings.<key>.secretKey}}`  | type=APPID_SECRETKEY 时的secretKey |
| `${{ settings.<key>.privateKey}}`  | type=SSH_PRIVATEKEY 时的privateKey |
| `${{ settings.<key>.passphrase}}`  | type=SSH_PRIVATEKEY 时的passphrase |
| `${{ settings.<key>.token}}`  | type=TOKEN_SSH_PRIVATEKEY 时的 token |
| `${{ settings.<key>.username}}`  | type=TOKEN_SSH_PRIVATEKEY 时的 username |
| `${{ settings.<key>.password}}	`  | type=TOKEN_SSH_PRIVATEKEY 时的 password	 |
| `${{ settings.<key>.password}}`  | type=MULTI_LINE_PASSWORD 时的 password |

流水线执行时，将自动替换入参中的表达式为实际的凭据值。

### 在脚本插件中启动的脚本文件中使用凭据内容
当使用脚本插件运行指定的 sh、py等脚本时，这些脚本的代码内容并不在插件入参中，不能直接代码中使用表达式引用。

此时，建议的使用方式是在启动脚本文件之前，将凭据设置到当前步骤的环境变量中，脚本文件从环境变量获取凭据。

示例：

bash 插件入参为：将凭据内容设置到环境变量

```
echo "settings.a.password is ${{ settings.a.password }}"

# 先设置环境变量（仅当前step有效）
export GITHUB_PWD="${{ settings.a.password }}"

# 再执行脚本文件
./use_ticket.sh
```

use_ticket.sh 代码为： 从环境变量中引用凭据内容

```
#!/bin/bash

echo $GITHUB_PWD
```
## 注意事项 
日志已脱敏

凭据内容，打印到日志中时，将展示 ****** ，不会明文展示 

注意，仅影响日志中的展示，变量中还是真实的值