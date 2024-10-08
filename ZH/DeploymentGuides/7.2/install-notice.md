# 部署蓝鲸通知中心

TODO 规范出包

## 在中控机使用脚本部署
### 下载安装包
在 **中控机** 运行：
``` bash
bkdl-7.2-stable.sh -ur latest notice
```

### 使用脚本部署
在 **中控机** 运行：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
scripts/setup_bkce7.sh -i notice
```


# 开启消息通知功能
蓝鲸部分产品已经适配了消息通知功能，但是默认并未开启。请按需配置。

目前暂不支持开启的产品：
* 制品库
* 用户管理
* 蓝盾

<!--
* gsekit
* DBM
* BKBase
* 图表平台
* 审计中心
-->

## 基础套餐开启通知功能

### 修改全局 values

在 **中控机** 运行：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
yq -i '.bkNotice.enabled = true' environments/default/custom.yaml
```

### 重启 release
``` bash
# 基础套餐产品开启
helmfile -f base-blueking.yaml.gotmpl \
-l name=bk-apigateway \
-l name=bk-console \
-l name=bk-iam-saas \
-l name=bk-paas \
-l name=bk-job \
-l name=bk-nodeman \
apply
```

### 配置流程服务（bk_itsm）

>**注意**
>
>开启之后不能关闭。

在 中控机 执行：
``` bash
kubectl -n bkapp-bk0us0itsm-prod exec -it deploy/bkapp-bk0us0itsm-prod--web -- python manage.py register_notice
```

执行注册命令，提示 “成功注册平台” 即开启成功。


### 配置标准运维（bk_sops）

请登录蓝鲸桌面，打开 “开发者中心”应用，点击应用开发进入 “标准运维” 后，开始配置：
1. 展开侧栏 “应用引擎”，点击进入 “环境配置” 界面。
2. 新增环境变量，对应的配置项为 `ENABLE_NOTICE_CENTER`: `true` ，生效环境为所有环境，点击“添加”按钮即可。

环境变量需要部署后生效，共有 **四个模块** 需要部署，详细操作可参考 流程服务，此处仅为概述：
1. 选择部署模块，需要先部署 `default` 模块。
2. 选择 生产环境。
3. 选择版本。
4. 点击 “部署至生产环境” 按钮。
5. 等 `default`模块 **部署成功后**，开始部署 `api`、`pipeline`与`callback` 等 3 个模块（无次序要求，可同时部署）。重复步骤 1-4，每轮操作注意**切换模块**。


### 配置蓝鲸配置平台（bk_cmdb_saas）

请登录蓝鲸桌面，打开 “开发者中心”应用，点击应用开发进入 “蓝鲸配置平台” 后，开始配置：

1. 展开侧栏 “应用引擎”，点击进入 “环境配置” 界面。
2. 新增环境变量，对应的配置项为 `BK_CMDB_ENABLE_BK_NOTICE`: `true` ，生效环境为所有环境，点击“添加”按钮即可。

环境变量需要部署后生效，共有 **一个模块** 需要部署，详细操作可参考 流程服务，此处仅为概述：
1. 选择部署模块，需要先部署 `web` 模块。
2. 选择 生产环境。
3. 选择版本。
4. 点击 “部署至生产环境” 按钮。


## 容器管理平台开启通知功能

TODO


## 监控平台开启通知功能

TODO 确认：不需要 sync 生效 values 吗？

``` bash
kubectl -nblueking get pods | awk '/bk-monitor-web-[0-9]/{print $1}' | xargs -i kubectl exec {} -- bash -c 'python manage.py register_application'
```
提示 “成功注册平台” 即开启成功。

## 日志平台开启通知功能

前面调整 values 成功后，重新 apply：
``` bash
helmfile -f 04-bklog-search.yaml.gotmpl apply
```

## 运维开发平台开启通知功能

请登录蓝鲸桌面，打开 “开发者中心”应用，点击应用开发进入 “运维开发平台” 后，开始配置：

1. 展开侧栏 “应用引擎”，点击进入 “环境配置” 界面。
2. 新增环境变量，对应的配置项为 `NOTICE_CENTER_ENABLE`: `true` ，生效环境为所有环境，点击“添加”按钮即可。

环境变量需要部署后生效，共有 **一个模块** 需要部署，详细操作可参考 流程服务，此处仅为概述：
1. 选择部署模块，需要先部署 `default` 模块。
2. 选择 生产环境。
3. 选择版本。
4. 点击 “部署至生产环境” 按钮。


# 使用
* [产品简介](../../BKNotice/1.5/UserGuide/Introduction/What-is-BKNotice.md)
* [发布新公告](../../BKNotice/1.5/UserGuide/Features/new-announcement.md)

# 验证
参考上文指引发布一条新公告，然后进入蓝鲸桌面，打开刚才公告面向的平台。查看效果。

