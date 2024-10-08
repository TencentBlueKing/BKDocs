# bkpaas-cli

> bkpaas-cli 是蓝鲸开发者中心提供的命令行工具，支持应用基础信息查看，部署，部署结果查询等功能。

## 使用指南

### 配置信息

bkpaas-cli 通过配置文件来存储 API 访问路径，用户认证等信息，你可以在开发者中心上获取到示例配置。

默认情况下 bkpaas-cli 会读取 ${HOME}/.blueking-paas/config.yaml 并加载为配置，你可以执行以下命令来初始化：

```shell
>>> mkdir ${HOME}/.blueking-paas && cat > ${HOME}/.blueking-paas/config.yaml << EOF
paasApigwUrl: http://bkapi.example.com/api/bkpaas3/
paasUrl: http://bkpaas.example.com
checkTokenUrl: ''
username: ''
accessToken: ''
EOF
```

如果你有特殊指定的需求，可以执行以下命令，bkpaas-cli 将优先使用你指定的文件作为配置：

```shell
export BKPAAS_CLI_CONFIG='/root/.blueking-paas/config.yaml'
```

你可以通过执行命令 bkpaas-cli config view 来查看当前加载 & 使用的配置内容：

```shell
>>> bkpaas-cli config view
configFilePath: /root/.blueking-paas/config.yaml

paasApigwUrl: http://bkapi.example.com/api/bkpaas3/
paasUrl: http://bkpaas.example.com
checkTokenUrl: ''
username: admin
accessToken: [REDACTED]
```

### 用户登录

使用本工具需要认证用户的开发者身份，如果你未认证或认证信息已过期，则需要重新登录以更新你的认证信息。

#### 交互式登录(推荐)

bkpaas-cli 提供交互式的用户登录能力，需要你执行 bkpaas-cli login 命令以进行登录。

```shell
>>> bkpaas-cli login
Now we will open your browser...
Please copy and paste the access_token from your browser.
>>> AccessToken: ********  # 从唤起的浏览器窗口中复制并粘贴你的 AccessToken
User login... success!
```

注意：如果你是在没有浏览器的环境中使用交互式登录（如 Linux 开发机），在打开浏览器环节会失败，但是你依旧可以通过链接手动访问浏览器以获取
access_token。

```shell
>>> Now we will open your browser...
Please copy and paste the access_token from your browser.
Failed to open browser, error: exec: "xdg-open,x-www-browser,www-browser": executable file not found in $PATH
Dont worry, you can still manually open the browser to get the access_token: http://bkpaas.example.com/backend/api/accounts/oauth/token/
>>> AccessToken: ********  # 从手动唤起的浏览器窗口中复制并粘贴你的 AccessToken
User login... success!
```

更多登录方式，请参考 [bkpaas-cli Readme 文档](https://github.com/TencentBlueKing/blueking-paas/blob/main/bkpaas-cli/Readme.md#%E7%94%A8%E6%88%B7%E7%99%BB%E5%BD%95)

### 蓝鲸应用管理

bkpaas-cli 可用于蓝鲸应用的信息查询，部署，部署状态查询等场景。

#### 列举应用

你可以通过执行命令 `bkpaas-cli app list` 来查看你有操作权限的蓝鲸应用：

```shell
>>> bkpaas-cli app list
Application List
+----+------------------+------------------+
| #  |      NAME        |       CODE       |
+----+------------------+------------------+
|  1 | demo-app-1       | app-code-1       |
|  2 | demo-app-2       | app-code-2       |
|  3 | demo-app-3       | app-code-3       |
+----+------------------+------------------+
```

#### 应用信息查询

```shell
>>> bkpaas-cli app get-info --code=app-code-1
+---------------------------------------------------------------------------------------------+
|                              Application Basic Information                                  |
+------+--------------------------------------------------------------------------------------+
| Name | demo-app-1    | Code | app-code-1     | Region | default       | Type | default      |
+------+--------------------------------------------------------------------------------------+
|                                           Modules                                           |
+---------------------------------------------------------------------------------------------+
|   0   | Name     | frontend                                                                 |
+       +-------------------------------------------------------------------------------------+
|       | RepoType | GitHub       | RepoUrl | https://github.com/octocat/Hello-World.git      |
+       +-------------------------------------------------------------------------------------+
|       | Env      | prod         | Cluster | default -> BCS-K8S-12345                        |
+       +-------------------------------------------------------------------------------------+
|       | Env      | stag         | Cluster | default -> BCS-K8S-12345                        |
+---------------------------------------------------------------------------------------------+
|   1   | Name     | backend                                                                  |
+       +-------------------------------------------------------------------------------------+
|       | RepoType | GitHub       | RepoUrl | https://github.com/octocat/Hello-World.git      |
+       +-------------------------------------------------------------------------------------+
|       | Env      | prod         | Cluster | default -> BCS-K8S-12345                        |
+       +-------------------------------------------------------------------------------------+
|       | Env      | stag         | Cluster | default -> BCS-K8S-12345                        |
+---------------------------------------------------------------------------------------------+
```

#### 应用部署

你可以通过执行命令 `bkpaas-cli app deploy` 来部署普通或云原生应用，以下是具体示例：

##### 云原生应用

```shell
# 首先你需要准备一份 BkApp 的 manifest，可以在 云原生应用 -> 应用编排 -> YAML 页面获取
>>> cat > ./bkapp.yaml << EOF
apiVersion: paas.bk.tencent.com/v1alpha1
kind: BkApp
metadata:
  name: cnative-demo
spec:
  processes:
    - image: strm/helloworld-http
      imagePullPolicy: IfNotPresent
      cpu: 250m
      memory: 256Mi
      name: web
      replicas: 2
      targetPort: 80
EOF

# 执行以下命令以部署云原生应用
>>> bkpaas-cli app deploy --code=cnative-demo --env=stag -f ./bkapp.yaml
Application cnative-demo deploying...

# 轮询获取部署结果，直到部署成功 / 失败
# 若不关注部署结果，可以在部署时，添加 --no-watch 参数，后续可通过其他命令，查看部署结果
Waiting for deploy finished...
Waiting for deploy finished...
Waiting for deploy finished...

# 若部署成功，则输出应用状态表，以及应用访问地址等信息
# 若部署失败，则会额外输出资源调度相关事件，便于排查问题
Deploy Conditions: (Code: cnative-demo, Module: default, Env: stag)
+-------------------+--------+--------------+---------+
|       TYPE        | STATUS |    REASON    | MESSAGE |
+-------------------+--------+--------------+---------+
| AppAvailable      | True   | AppAvailable |         |
+-------------------+--------+--------------+---------+
| AppProgressing    | True   | NewRevision  |         |
+-------------------+--------+--------------+---------+
| AddOnsProvisioned | True   | Provisioned  |         |
+-------------------+--------+--------------+---------+
| HooksFinished     | True   | Finished     |         |
+-------------------+--------+--------------+---------+
Deploy successful.

↗ SaaS Home Page: https://stag-dot-cnative-demo.bkapps.example.com/

↗ Open developer center for more details: https://bkpaas.example.com/developer-center/apps/cnative-demo/default/status
```

##### 普通应用

```shell
# 注：如果你有部署非默认模块的需求，可以在部署时添加参数 --module=${module_name}
>>> bkpaas-cli app deploy --code=demo-app --env=stag --branch master
Application demo-app deploying...
Waiting for deploy finished...
Waiting for deploy finished...
Waiting for deploy finished...
Logs:
Preparing to build bkapp-demo-app-stag
Starting build app: bkapp-demo-app-stag
...

Generated build id: ec09dff9-a8a6-a990-6648-4489dff8866
building process finished.

Deploy successful.

↗ Open developer center for more details: https://bkpaas.example.com/developer-center/apps/demo-app/default/deploy/stag
```

#### 应用部署结果查询

你可以通过执行命令 `bkpaas-cli app deploy-result` 来查询 **最近一次** 部署的结果，以下是具体示例：

##### 云原生应用

```shell
>>> bkpaas-cli app deploy-result --code=cnative-demo --env=stag
Deploy Conditions: (Code: cnative-demo, Module: default, Env: stag)
+-------------------+--------+--------------+---------+
|       TYPE        | STATUS |    REASON    | MESSAGE |
+-------------------+--------+--------------+---------+
| AppAvailable      | True   | AppAvailable |         |
+-------------------+--------+--------------+---------+
| AppProgressing    | True   | NewRevision  |         |
+-------------------+--------+--------------+---------+
| AddOnsProvisioned | True   | Provisioned  |         |
+-------------------+--------+--------------+---------+
| HooksFinished     | True   | Finished     |         |
+-------------------+--------+--------------+---------+
Deploy successful.

↗ SaaS Home Page: https://stag-dot-cnative-demo.bkapps.example.com/

↗ Open developer center for more details: https://bkpaas.example.com/developer-center/apps/cnative-demo/default/status
```

##### 普通应用

```shell
# 成功情况
>>> bkpaas-cli app deploy-result --code=demo-app --env=stag
Logs:
Preparing to build bkapp-demo-app-stag ...
Starting build app: bkapp-demo-app-stag
Using config file: /etc/pilot.yaml
-----> Starting slug builder heroku-18
-----> Step setup begin
-----> Fetching buildpack bk-buildpack-python-v213:v213.2
-----> Restoring cache...
     * Restore cache from ......
-----> Restoring source...
       Initialzing build environment
-----> Fetching buildpack bk-buildpack-apt:v2.1
       Buildpack bk-buildpack-apt:v2.1 size is 31 kB, duration: 21.819053ms
       Source size is 3.6 kB, duration: 101.689459ms
       Buildpack bk-buildpack-python-v213:v213.2 size is 389 kB, duration: 155.819695ms
       Cache size is 55 MB, duration: 1.486204998s
       Cache fingerprint is ......
       Step setup done, duration 2.008541506s
-----> Step detect begin
     * Detecting by bk-buildpack-apt:v2.1
       Detected Apt app
     * Activated bk-buildpack-apt:v2.1
     * Detecting by bk-buildpack-python-v213:v213.2
       Detected Python app
     * Activated bk-buildpack-python-v213:v213.2
       Step detect done, duration 4.941487ms
-----> Step analysis begin
       Selected 2 buildpacks: [bk-buildpack-apt:v2.1 bk-buildpack-python-v213:v213.2]
     * Checking Procfile
       Step analysis done, duration 196.09µs
-----> Step build begin
-----> Compiling Apt app by buildpack bk-buildpack-apt:v2.1
...
...
-----> Step export begin
       Buildpack bk-buildpack-apt:v2.1 releasing
       Buildpack bk-buildpack-python-v213:v213.2 releasing
       Step export done, duration 12.317789ms
-----> Step finish begin
-----> Updating slug...
     * Update slug to ......
     * Origin fingerprint is ......, current is ......
-----> Cache has changed, updating...
       Slug size is 24 MB, duration: 1.644033198s
       Step finish done, duration 3.055406364s
-----> Build success, duration: 23.171538433s
       Sleeping 1s before exit

Generated build id: ec09dff9-a8a6-a990-6648-4489dff8866
building process finished.

Deploy successful.

↗ Open developer center for more details: https://bkpaas.example.com/developer-center/apps/demo-app/default/deploy/stag


# 失败情况
>>> bkpaas-cli app deploy-result --code=demo-app --env=stag
Logs:
Procfile error: Can not read Procfile file from repository

Deploy failed, detail: Procfile error: Can not read Procfile file from repository
You can:
1: 修复 Procfile 相关报错（fix-procfile）: https://wiki.example.com?pageId=how-to-fix-procfile

↗ Open developer center for more details: https://bkpaas.example.com/developer-center/apps/demo-app/default/deploy/stag
```

#### 应用部署历史查询

你可以通过执行命令 `bkpaas-cli app deploy-histroy` 来查询 **最近 5 次** 部署的历史，以下是具体示例：

##### 云原生应用

```shell
>>> bkpaas-cli app deploy-history --code=cnative-demo --env=stag
Application Recent 5 Deploy History (AppCode: cnative-demo, Module: default, Env: stag)
+-----------------------------+----------+-----------+--------+---------------------+
|           VERSION           | OPERATOR | COST TIME | STATUS |      START AT       |
+-----------------------------+----------+-----------+--------+---------------------+
| cnative-demo-730-1682221214 | admin    | 9s        | ready  | 2023-04-23 11:40:14 |
| cnative-demo-729-1682221170 | admin    | 8s        | error  | 2023-04-23 11:39:30 |
| cnative-demo-728-1682221118 | admin    | 8s        | ready  | 2023-04-23 11:38:38 |
| cnative-demo-727-1682220845 | admin    | 8s        | ready  | 2023-04-23 11:34:05 |
| cnative-demo-726-1682220727 | admin    | 5s        | ready  | 2023-04-23 11:32:07 |
+-----------------------------+----------+-----------+--------+---------------------+
```

##### 普通应用

```shell
>>> bkpaas-cli app deploy-history --code=demo-app --env=stag
Application Recent 5 Deploy History (AppCode: demo-app, Module: default, Env: stag)
+--------------------+----------+----------+-----------+------------+---------------------+
|       BRANCH       | VERSION  | OPERATOR | COST TIME |   STATUS   |      START AT       |
+--------------------+----------+----------+-----------+------------+---------------------+
| master             | 3f89690a | admin    | 38s       | successful | 2023-04-23 11:50:03 |
| must-deploy-failed | c94d3821 | admin    | 1s        | failed     | 2023-04-23 11:49:48 |
| must-deploy-failed | c94d3821 | admin    | 1s        | failed     | 2023-04-17 21:05:18 |
| dev-1              | 3f89690a | admin    | 40s       | successful | 2023-04-17 21:03:52 |
| dev-1              | 3f89690a | admin    | 32s       | successful | 2023-04-17 20:32:53 |
+--------------------+----------+----------+-----------+------------+---------------------+
```

### 工具版本

你可以执行 `bkpaas-cli version` 来查看当前工具的版本信息。

```shell
>>> bkpaas-cli version
Version  : 1.0.0
GitCommit: 6469e0d074f027bb08dc5ce93002177c36f3ae8e
BuildTime: 2023-03-31T15:00:00+0800
GoVersion: go1.19.4
```

### 命令提示

你可以在执行任意命令时，添加 `-h` 或 `--help` 参数以获取参数 / 子命令提示

```shell
>>> bkpaas-cli app deploy-history --help
List PaaS application deploy history

Usage:
  bkpaas-cli app deploy-history [flags]

Flags:
      --code string     app code
      --env string      environment (stag/prod) (default "stag")
  -h, --help            help for deploy-history
      --module string   module name (default "default")

Global Flags:
      --debug   Enable debug mode
```

### 调试模式

如果你在使用 bkpaas-cli 时遇到问题，可以在任何命令执行时添加 `--debug` 参数，这将为您提供更多的执行信息。

如果需要联系蓝鲸助手或开发者以获取帮助，请提供调试模式下的输出结果，这将更有助于解决问题 : )

## 多系统支持

bkpaas-cli 将提供适用于 Linux，MacOS，Windows 等多种系统 / 架构的二进制可执行文件。

你可以在 [Release 页面](https://github.com/TencentBlueKing/blueking-paas/releases?q=bkpaas-cli&expanded=true) 下载适用于你的系统 / 架构的最新版本的
bkpaas-cli。

## 参考文档

- [bkpaas-cli README 文档](https://github.com/TencentBlueKing/blueking-paas/blob/main/bkpaas-cli/Readme.md)
