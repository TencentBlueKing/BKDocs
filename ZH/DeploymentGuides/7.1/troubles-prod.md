# 产品使用问题
这里收录着产品使用过程中遇到的问题。

## 用户管理
### 新装环境组织架构默认目录不显示
#### 表现
用户管理 “组织架构” 界面，左侧目录不显示。此时点击一次左下角的 “不可用目录” 按钮，则临时显示出 “默认目录” 及其下内容。刷新页面后，问题依旧。

#### 结论
仅在全新安装环境且只有默认目录时出现。

前端 bug，已于 2.5.4-beta.10 版本修复。请参考 《单产品更新》 文档更新 chart 为 bk-user-1.4.14-beta.10 。

#### 问题分析
无

## 配置平台
### 字段组合模板新建侧栏空白
#### 表现
配置平台 “模型” —— “字段组合模板” 界面，点击 “新建” 按钮，右侧弹出的侧栏一片空白。

#### 结论
cmdb 3.11.1 版本前端 bug，已于 3.11.2 版本修复。请参考 《单产品更新》 文档更新 chart 为 cmdb-3.12.2 。

#### 问题分析
无

## 作业平台
### 查看作业或任务中主机信息时页面报错
#### 表现
从旧版本升级到 3.7 后，界面出现报错：
1. 查看存量的作业模板、执行方案、定时任务及 IP 白名单中的主机时页面报错；
2. 生效范围为全业务的 IP 白名单不生效。

#### 结论
需要进行数据迁移。如果未进行，会导致查询 hostid 失败而报错。

#### 问题分析
无

## 流程服务
### 新建服务时通知方式为空
#### 表现
全新部署的环境，在新建服务时，“通知设置” 里的 “通知方式” 没有正确展示复选框。

#### 结论
apigateway 初始化数据有误，请参考问题分析进行修复。

#### 问题分析

1. 确认问题。在中控机执行：
    ```bash
    cd ~/bkce7.1-install/blueking/  # 进入工作目录
    bkpaas_app_secret=$(yq '.appSecret.bk_paas' environments/default/app_secret.yaml)
    BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)
    curl -vs "http://bkapi.$BK_DOMAIN/api/c/compapi/cmsi/get_msg_type/?bk_app_code=bk_paas&bk_app_secret=$bkpaas_app_secret&bk_username=admin" | jq '.data[].icon="略"'
    ```
    如果显示 `is_active` 为 false，即为此问题。
2. 修改 apigateway。
    访问开发者中心--组件管理--组件管理，找到 CMSI 进入 ，如果没有自定义蓝鲸基础域名，则地址为 `http://apigw.bkce7.bktencent.com/components/access`

    找到名为 “get_msg_type” 的组件，点击编辑，重新保存一次，即可看到组件名称列中，显示 get_msg_type“有更新”。

    稍等 5 分钟左右，等缓存刷新，重新执行步骤 1 的检查，可以看到 `is_active` 显示为 `true`。即可继续操作。
3. 重新部署流程服务。步骤可参考 [部署文档](manual-install-saas.md#部署流程服务bk_itsm)（此时无需重新上传包）。

## 节点管理
### 安装 proxy 时报错 data access endpoint IP:28625 is not reachable
#### 表现
新部署的 7.1.3 版本，在节点管理中 安装 Proxy 时，在 “安装” 步骤失败：“[时间 ERROR] [script] [healthz_check] gse healthz check failed”。

此行报错上方日志为：
`"data": "data access endpoint(IP:28625) is not reachable"`。

#### 结论
需要升级节点管理到 2.4.4 版本。

1.  更新节点管理，请参考 [更新 bk-nodeman-2.4.4](updates/202403.md#bk-nodeman-2.4.4) 章节操作。
2.  在 **中控机** 重新上传 Agent 和 Proxy：
    ``` bash
    # 下载7.1.3的agent及proxy包
    bkdl-7.1-stable.sh -ur 7.1.3 gse_agent gse_proxy
    # 重新上传一次，触发新的解析策略。
    ./scripts/setup_bkce7.sh -u agent
    ./scripts/setup_bkce7.sh -u proxy
    ```
3.  在节点管理中勾选 Proxy 主机，批量重新安装即可。（或在历史任务详情里点击“失败重试”按钮。）

#### 问题分析
gse proxy 在 2.1.5-beta.7 版本的配置发生变动，依赖节点管理 `>=2.4.1` 版本。7.1.3 发版时仅升级了 gse 版本，未升级节点管理。属于发版失误，特此表示歉意。
