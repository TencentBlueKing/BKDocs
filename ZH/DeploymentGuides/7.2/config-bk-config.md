部分用户有着自定义产品界面的需求。此前只能逐个产品手动调整，维护不便。现在启用“全局配置”后，就可以统一维护了。

这是一个新的方案，部分产品还在陆续接入中。目前支持全局配置的产品如下：
* 基础套餐
  * 作业平台
  * 桌面
  * 权限中心
  * 节点管理
  * API 网关
  * 开发者中心
* 容器管理套餐
  * 容器管理平台
* 监控日志套餐
  * 监控平台
  * 日志平台
* 持续集成套餐
  * 持续集成平台（蓝盾）

# 下载配置文件包
启用全局配置功能后，浏览器界面的默认资源均从指定的 url 下载。故需要将默认配置文件放在指定路径。

## 默认配置文件包
中控机下载，放入 `$INSTALL_DIR/bk-config` 目录：
``` bash
bkdl-7.2-stable.sh -ur latest bk-config
```

## 单产品配置文件包

后续随着产品发布进度更新此章节，提供对应下载命令。


# 上传配置文件模板

你可以将配置文件放在任意 Web 服务器上，维持原始目录结构即可。

## 上传到蓝鲸制品库
蓝鲸制品库可以提供 Web 服务。在上传配置文件包到制品库前，需要提前修改 base.js 里的 url。

### 创建 bk-config 仓库
基于习惯，可以在 `blueking` 项目下创建名为 `bk-config` 仓库，允许 **匿名访问**。

``` bash
cd $INSTALL_DIR/blueking
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)
# 获取 bkrepo admin账户名密码
source <(kubectl get secret -n blueking bkpaas3-apiserver-bkrepo-envs -o go-template='{{range $k,$v := .data}}{{$k}}={{$v|base64decode}}{{"\n"}}{{end}}'] | grep ^ADMIN_)
# 创建仓库。
bkrepo_api_url=http://bkrepo.$BK_DOMAIN/repository/api
req_body='{"projectId": "blueking","type": "GENERIC","category": "LOCAL","public": true,"name": "bk-config", "description": "blueking global config"}'
curl -sS -u "$ADMIN_BKREPO_USERNAME:$ADMIN_BKREPO_PASSWORD" "$bkrepo_api_url/repo/create"  -H 'Content-Type: application/json' -d "$req_body"
```
请求成功后，响应如下：
``` json
{
  "code" : 0,
  "message" : null,
  "data" : {
    "projectId" : "blueking",
    "name" : "bk-config",
    "type" : "GENERIC",
    "category" : "LOCAL",
    "public" : true,
    ...
  }
}
```

最终 bk-config 仓库的访问地址为 `bkrepo.$BK_DOMAIN/generic/blueking/bk-config/`。

### 修改 base.js 里的 url

```bash
# 进入目录
cd bk-config/
TODO
```

### 将目录上传至制品库

``` bash
bucket=bk-config
n=0
while read filepath; do
  remote="/${filepath#../bk-config/}"
  remote="${remote%/*}/"
  echo scripts/bkrepo_tool.sh -u "$USERNAME" -p "$PASSWORD" -P "$PROJECT" -i "$ENDPOINT/generic" -n "$bucket" -X PUT -O -R "$remote" -T "$filepath"
  # 流控，每上传5个文件，sleep 1s。
  let ++n%5 || sleep 1
done < <(find ../bk-config/ -mindepth 2 -type f)
```

# 启用全局配置功能
## 修改配置文件

```bash
# 进入部署目录
cd ~/bkce7.2-install/blueking/
# 修改全局 values 配置
yq -i '.domain.bkSharedResUrl="http://bkrepo.bkce.bktencent.com/generic/blueking/bk-config/bk-config"' environments/default/custom.yaml
```


## 重新部署对应产品
```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-paas apply
```

## 登录页面验证

访问 `base.js?callback` 开头的接口正常完成配置

