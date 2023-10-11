# 蓝鲸文档中心部署及维护

## 文档包组成简介

文档中心包分为两部分，分别为SaaS包和文档内容包。

- SaaS包是承载文档内容的主体，也就是应用，通常由开发编写逻辑去读取文档内容包的内容进行渲染。

- 文档内容包通常就是文档内容存放的地方，由各产品或在里面撰写文档，并由运营对文档内容包配置文件进行控制来渲染文档官网页面所展示的内容。

## 部署指引

### 部署前置准备

- 私有化环境: 部署前需要拥有一套私有化环境,来承载和部署saas，本文档部署条件如下：
    - 版本
        - 蓝鲸版本号：7.1
        - 开发者中心版本号：v1.3.0-beta.1
        - SaaS文档包：v1.1.7
        - 文档包： 无版本

    - 部署权限
    本文档是按admin权限进行实践的，如普通用户遇到权限不足请联系环境负责人或者参考文档[](../7.0/../../IAM/1.12/UserGuide/Feature/PermissionsApply.md)申请权限

- saas包： 该包有文档的发行版,可用在github进行下载最新的稳定版本进行操作: https://github.com/TencentBlueKing/blueking-docs/releases

- 文档包： 仓库为 https://github.com/TencentBlueKing/support-docs/tree/prod-sg, 该文档包随时下载可用

### SaaS部署指引

文档SaaS部署大致部署可以分为以下三个步骤：

1.进入开发者中心，创建应用
2.创建S-mart应用
3.上传saas包

具体细节操作步骤如下：
附上截图

最后我们在哪里点击访问，能看到正常访问就是完成了。
附截图

### 文档包部署指引

#### 能通外网
- github部署

    准备好gitlabxxx


#### 不能通外网

- gitlab 

-  离线方案(暂时未开放)

## 维护指引

### saas应用配置指引


**环境变量**: xxxx，跟据实际情况去配置其环境变量xxx

| 环境变量Key                        | 含义                                                         | 默认值                                                      | 示例                                                       |
|--------------------------------|------------------------------------------------------------|----------------------------------------------------------|----------------------------------------------------------|
| SUMMARY_LAYER                  | summary目录层级的最大限制数                                          | 4                                                        | 4                                                        |
| DOCS_SPLIT                     | 文档默认分割符                                                    | ""                                                       | ""                                                       |
| RUN_VER                        | 官网版本配置，例如社区版、Tencent版、本地开发                                 | open                                                     | tencent                                                  |
| RESOURCE_URL                   | 资源地址使用cos资源地址，资源通过流水线上传                                    | your_resource_url                                        | static/                                                  |
| BK_URL                         | 蓝鲸平台url                                                    | your_bk_url                                              | bk.tencent.com                                           |
| BK_PAAS_HOST                   | 蓝鲸PaaS平台url                                                | your_bk_paas_host                                        | bk.tencent.com                                           |
| BK_PAAS_INNER_HOST             | 蓝鲸内部版PaaS平台url                                             | your_paas_inner_host                                     | bk.tencent.com                                           |
| BK_SUB_PATH                    | 蓝鲸平台提供的访问子路径，当 SaaS 部署在 v3 平台以子路径形式提供访问时会默认添加              | "/"                                                      | "/some-sub-path"                                         |
| BKPAAS_DEFAULT_SUBPATH_ADDRESS | 用于 用户认证、用户信息获取 的蓝鲸主机                                       | https://bk.tencent.com/docs/                             | https://bk.tencent.com/docs/                             |
| BK_ONLINE_DEMO_URL             | 在线体验url地址                                                  | https://bk.tencent.com/s-mart/online-env                 | https://bk.tencent.com/s-mart/online-env                 |
| DOCS_EDIT_URL                  | 编辑文档url地址                                                  | https://github.com/TencentBlueKing/BKDocs/tree/main/     | https://github.com/TencentBlueKing/BKDocs/tree/main/     |
| BK_CONTRIBUTION_DOC_PATH       | 共建文档跳转路径                                                   | ZH/DocumentationContributorGuide/7.0/collaborateguide.md | ZH/DocumentationContributorGuide/7.0/collaborateguide.md |
| APP_CODE                       | 兼容component的APP_ID                                         | your_app_code                                            | bkdoc                                                    |
| SECRET_KEY                     | 兼容component的APP_TOKEN                                      | your_secret_key                                          | token信息                                                  |
| BK_DOMAIN                      | 启动访问的蓝鲸根域，影响国际化页面 Cookie 取值                                | bk.tencent.com                                           | bk.tencent.com                                           |
| BK_LOGIN_URL                   | 蓝鲸登录页面                                                     | bk.tencent.com                                           | bk.tencent.com                                           |
| BK_LOGIN_INNER_URL             | 蓝鲸内部版登录页面                                                  | bk.tencent.com                                           | bk.tencent.com                                           |
| BK_COMPONENT_API_URL           | 容器化V3 ESB地址                                                | your_bk_component_api_url                                | bk.tencent.com                                           |
| IS_HIDDEN_SEARCH               | 是否隐藏搜索                                                     | 否                                                        | 0                                                        |
| IS_HIDDEN_HEADER               | 是否隐藏header                                                 | 否                                                        | 0                                                        |
| IS_HIDDEN_SYNC                 | 是否隐藏异步                                                     | 是                                                        | 1                                                        |
| IS_HIDDEN_FEEDBACK             | 是否隐藏反馈                                                     | 是                                                        | 1                                                        |
| IS_HIDDEN_EDIT                 | 是否隐藏文档编辑按钮                                                 | 否                                                        | 0                                                        |
| IS_HIDDEN_PDF_EXPORT           | 是否隐藏 PDF 导出按钮                                              | 否                                                        | 0                                                        |
| IS_HIDDEN_I18N                 | 是否隐藏 i18n 切换按钮                                             | 是                                                        | 1                                                        |
| IS_ENABLE_GIT_SYNC             | 当启用 Git 同步时，每次文档更新将从提供的 Git 信息里更新文档包，并支持当文档包缺省时从远端实时拉取文档内容 | 否                                                        | 0                                                        |
| GIT_REPO_PATH                  | Git 仓库路径                                                   |                                                          | TencentBlueking/support-docs                             |
| GIT_REPO_BRANCH                | git同步分支                                                    | master                                                   | master                                                   |
| GIT_ACCESS_TOKEN               | git认证token                                                 | your_git_access_token                                    | token信息                                                  |
| GIT_USER                       | git用户                                                      | your_git_user                                            | root                                                     |
| GIT_PROVIDER_SCHEMA            | Git 服务协议头                                                  | https                                                    | https                                                    |
| GIT_PROVIDER_ADDR              | Git 服务地址                                                   | github.com                                               | github.com                                               |
| GIT_RAW_FILE_ADDR              | git原始文件地址                                                  | raw.githubusercontent.com                                | raw.githubusercontent.com                                |
| GIT_FILE_URL_TMPL              | Git 服务读取文件内容 URL 模版格式，用于从不同 Git 服务商实时读取文档内容                | your_git_store_url                                       | bk.tencent.com                                           |
| MAX_PAGE_LEN                   | 控制whoosh一次性查询的总条数                                          | 10000                                                    | 10000                                                         |   
| OLD_BKDOCS_CENTER_URL          | 旧版本文档中心URL                                                   |                            |                                                            |

- 前置命令配置：

- 其他配置

### 文档包配置维护指引

- **文档结构**

- **配置文件详解**
   
   xx
   xx
   xx





## 写作指引

- 如何新建一套产品文档

- 协作模式

- 成员修改文档指引

