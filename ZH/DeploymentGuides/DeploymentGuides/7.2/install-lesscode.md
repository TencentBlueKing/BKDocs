# 部署运维开发平台

## 暂停下载通知
>**注意**
>
>运维开发平台产品维护中，暂停下载，开放时间敬请关注通知。

----

支持 2 种部署方式，请按需查阅对应章节。

## 在中控机使用脚本部署
### 下载安装包
在 **中控机** 运行：
``` bash
bkdl-7.2-stable.sh -ur latest bk_lesscode
```

### 使用脚本部署
在 **中控机** 运行：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
scripts/setup_bkce7.sh -i lesscode
```

部署完成后，即可访问了。

>**提示**
>
>部署如有异常，请先查阅《[SaaS 部署问题案例](troubles/deploy-saas.md)》文档。


## 在开发者中心部署
本章节演示另外一种部署方法：在浏览器完成整个部署过程。效果和上文的“脚本部署”是相同的。

### 下载安装包
当浏览器访问“开发者中心”进行部署时，需要提前在浏览器里下载安装包：
| 名字及 app_code | 版本号 | 下载链接 |
|--|--|--|
| 运维开发平台（bk_lesscode） | 1.1.0-beta.24 | https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_lesscode/bk_lesscode-V1.1.0-beta.24.tar.gz |


### 创建应用
在第一次部署时，需要先在 “开发者中心” 点击 “创建应用”，上传刚才的安装包。

具体步骤可以参考 [《部署步骤详解 —— SaaS》文档的“上传安装包”章节](manual-install-saas.md#upload-bkce-saas)。

### 配置环境变量
在部署前，需要提前配置环境变量。主要分为 2 类：
* `PREVIEW_` 开头的环境变量用于 “数据源管理” 的预览功能，存储着数据库访问信息。当项目创建数据表时，会创建一个前缀为 `bklesscode_` 的数据库来安置这些表。
* `PRIVATE_NPM_` 开头的环境变量用于 “自定义组件管理” 功能。当创建了自定义组件时，会上传到 npm 仓库以便复用。

展开侧栏“应用引擎”，点击进入 “环境配置” 界面。

配置如下环境变量，生效环境请选择`所有环境`：

| KEY | 建议取值 | 描述 | 取值说明 |
| -- | -- | -- | -- |
| `PREVIEW_DB_HOST` | `bk-mysql8.blueking` | 预览环境数据库主机 | 此处取 `bk-mysql8` 服务的域名 |
| `PREVIEW_DB_PORT` | `3306` | 预览环境数据库端口 | 蓝鲸 `bk-mysql8` 服务默认端口 |
| `PREVIEW_DB_USERNAME` | `root` | 预览环境数据库登录用户名, 需要有创建数据库的权限，一般为 root | 蓝鲸 `bk-mysql8` 服务默认用户名 |
| `PREVIEW_DB_PASSWORD` | `blueking` | 预览环境数据库登录密码 | 蓝鲸 `bk-mysql8` 服务默认密码 |
| `PRIVATE_NPM_REGISTRY` | `http://bkrepo.${BK_DOMAIN}/npm/bkpaas/npm` | npm 镜像源地址 | 蓝鲸制品库 bkpaas 项目的 npm 仓库地址，请替换 `${BK_DOMAIN}` 为你的域名 |
| `PRIVATE_NPM_USERNAME` | `bklesscode` | npm 账号用户名 | PaaS values `global.bkrepoConfig.lesscodeUsername` |
| `PRIVATE_NPM_PASSWORD` | `blueking` | npm 账号密码 | PaaS values `global.bkrepoConfig.lesscodePassword` |
| `BKAPIGW_DOC_URL` | `http://apigw.${BK_DOMAIN}/docs` | 云 API 文档地址，填写部署 API 网关时，生成的环境变量 APISUPPORT_FE_URL 的值 | apigw 站点 |


### 部署到生产环境

共有 **一个模块** 需要部署，步骤为：
1. 切换面板到 “生产环境”。
2. 只有 `default` 模块，点击“部署”按钮。
3. 弹出的“选择部署分支”下拉框，会展示最新版本，请注意确认。“镜像拉取策略”选择“`IfNotPresent`”即可。
4. 点击“部署至生产环境”按钮。开始部署，期间会显示进度及日志。
5. 部署成功后，即可点击“访问”按钮了。如果访问出错或者白屏，可能是服务尚未启动完毕，稍等 1 分钟后重试。

在部署完成后，需要配置访问地址，请继续阅读。

### 配置访问地址

运维开发平台预期使用独立域名访问。在部署完成后，需要配置访问地址为 `lesscode.$BK_DOMAIN`。

有命令行和界面 2 种配置方法：
* 在 **中控机** 执行：
  ``` bash
  cd $INSTALL_DIR/blueking/  # 进入工作目录
  BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)
  kubectl exec -in blueking deploy/bkpaas3-apiserver-web -- python manage.py publish_app --app_code bk_lesscode --module_name default --domain lesscode.$BK_DOMAIN --force true
  ```
  看到提示即表示配置成功：
  ``` plain
  paasng.accessories.publish.sync_market.engine(ln:78): 成功更新应用bk_lesscode的数据, 影响记录1条，更新数据:{'external_url': 'http://lesscode.bkce7.bktencent.com/', 'is_already_online': True, 'is_display': True, 'state': 4}
  ```
* 如果打算在界面配置独立域名。可登录蓝鲸桌面，打开 “开发者中心”应用，开始配置：
  1. 展开侧栏 “应用引擎”，点击进入 “访问入口” 界面。
  2. 切换顶部 Tab 到 “独立域名”。在 “域名管理” 下，点击 “添加域名” 按钮。
  3. 在弹框中选择 “生产环境”，输入地址： `lesscode.${BK_DOMAIN}`（请替换 `${BK_DOMAIN}` 为你的域名）。保持路径为 `/` 不变，绑定到 `default` 模块。点击 “确定” 按钮即可。
  4. 展开侧栏 “应用推广”，点击进入 “应用市场” 界面。
  5. 默认在 “发布管理” Tab 下，切换访问地址类型为 “主模块生产环境独立域名”，点击 “更改访问地址” 按钮。

# 访问运维开发平台
需要配置域名解析，将 `lesscode.$BK_DOMAIN` 指向 `apps.${BK_DOMAIN}` 所在的 IP。操作步骤已经并入 《部署步骤详解 —— 后台》 文档 的 “[配置用户侧的 DNS](manual-install-bkce.md#hosts-in-user-pc)” 章节。

配置成功后，即可在桌面打开 “运维开发平台” 应用了。

>**提示**
>
>如果出现访问白屏，且等待 1 分钟后依旧未能正常显示，请：
>1. 先确保浏览器访问地址为刚才“配置访问地址”里配置的独立域名（`lesscode.${BK_DOMAIN}`）。
>2. 然后可重新部署一次看看：
>    * 如果希望在中控机操作： `cd $INSTALL_DIR/blueking/ && scripts/setup_bkce7.sh -i lesscode -f`。
>    * 如果希望在浏览器里操作：在 “蓝鲸桌面” 打开 “开发者中心”——“运维开发平台”——“部署管理” 界面。切换为 “生产环境”，点击“default”模块右侧的“部署”按钮，在弹框里点击 “部署至生产环境” 按钮即可。


# 配置应用开发环境
在界面里开发的应用，此时已经可以预览了。如果希望部署到开发者中心，需要先完成本章节。

## 完善应用部署环境
当项目开发到一定阶段后，你需要“部署”此项目到蓝鲸 PaaS 平台，前端项目在构建时需要下载 npm 包。

### NodeJS 开发环境
请参考 《[上传 PaaS runtimes 到制品库](paas-upload-runtimes.md)》文档，完成“下载基础文件”、“下载 nodejs 环境”及“上传文件”章节，上传文件到制品库。

### 推荐：配置 npm 仓库镜像加速构建
应用部署时会在应用对应 namespace 下创建一个名为 `slug-builder` 的 pod，从 npm 仓库下载软件包开始构建。

npm 包数量繁多，选择合适的仓库镜像可以显著加速构建过程。调整 PaaS 的配置项修改 NPM 仓库地址，指向访问速度较快的镜像站（有条件的用户可以在内网搭建镜像站）。

按如下步骤修改 bk-paas release 的 helm values，设置 `apiserver.npmRegistry` 为所需的值：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
npmRegistry="https://mirrors.tencent.com/npm/"  # 请按需替换为其他 npmRegistry
# 修改 npmRegistry
case $(yq e '.apiserver.npmRegistry' environments/default/bkpaas3-custom-values.yaml.gotmpl 2>/dev/null) in
  null|"")
    tee -a environments/default/bkpaas3-custom-values.yaml.gotmpl <<< $'apiserver:\n  npmRegistry: '"$npmRegistry"
  ;;
  *)
    echo "environments/default/bkpaas3-custom-values.yaml.gotmpl 中配置了 apiserver.npmRegistry=$npmRegistry, 如有调整请自行修改."
  ;;
esac
```
修改完毕后，重启 bk-paas release 使之生效：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-paas sync
```

检查 values 是否生效：
``` bash
helm get values -n blueking bk-paas | yq e '.apiserver.npmRegistry' -
```

## API 调试环境
运维开发平台有个功能叫做 “调试 API”，会在服务端构造并发起 HTTP 请求，因此需要服务端能解析调试域名且网络通畅。

本文部署的服务端运行在 K8s 环境中，域名解析由 coredns 负责，请尽量配置 coredns 的上游 DNS 完成解析。也可参考本章节在 coredns 中添加 hosts 记录应急。

### 配置 coredns 添加蓝鲸域名
如果你使用了运维开发平台的 “数据源管理” 功能，则请求的域名为 `lesscode.$BK_DOMAIN`，请参考如下步骤进行配置。

在 **中控机** 执行：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" lesscode.$BK_DOMAIN
./scripts/control_coredns.sh list  # 检查添加的记录。
```
其他蓝鲸域名同理，此处不再赘述。

### 可选：配置 coredns 添加其他域名
如果你的其他服务端域名需要添加解析，也能添加 hosts 记录临时解决问题。正式环境请配置 coredns 的上游 DNS 服务器。

>**注意**
>
>此配置对整个 k8s 集群生效，集群中所有 pod 在解析到这些域名时，都会变为此处指定 IP。请注意及时更新。

在 **中控机** 执行：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
./scripts/control_coredns.sh update "域名解析的IP" "自定义域名"
./scripts/control_coredns.sh list  # 检查添加的记录。
```
如果有多条记录，请自行封装脚本实现批量处理。

### 网络策略

访问 `lesscode.$BK_DOMAIN`时，属于 k8s 集群内部联网，故无需网络策略。

当调试 API 位于其他网络时，且存在网络访问限制时，请自行确保网络畅通。


# 下一步
开始了解 [运维开发平台](../../LessCode/1.1/UserGuide/intro.md)。

或者回到《[部署基础套餐](install-bkce.md#next)》文档看看其他操作。
