# 根据插件代码获取插件详细信息

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/atoms/{atomCode}

### 资源描述

#### 根据插件代码获取插件详细信息

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| atomCode | string | 是 | 插件代码 |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型AtomVersion |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]' \
-H 'X-DEVOPS-UID:xxx'
```

#### HEADER样例

```javascript
accept: application/json
Content-Type: application/json
X-DEVOPS-UID:xxx
```

### 返回样例-200

```javascript
{
  "data" : {
    "versionContent" : "String",
    "flag" : true,
    "modifier" : "String",
    "description" : "String",
    "language" : "String",
    "yamlFlag" : true,
    "atomId" : "String",
    "atomStatus" : "String",
    "initProjectCode" : "String",
    "codeSrc" : "String",
    "htmlTemplateVersion" : "String",
    "projectCode" : "String",
    "releaseType" : "String",
    "pkgName" : "String",
    "jobType" : "String",
    "atomType" : "String",
    "classifyName" : "String",
    "userCommentInfo" : {
      "commentFlag" : true,
      "commentId" : "String"
    },
    "summary" : "String",
    "recommendFlag" : true,
    "editFlag" : true,
    "creator" : "String",
    "defaultFlag" : true,
    "docsLink" : "String",
    "os" : "string",
    "updateTime" : "String",
    "privateReason" : "String",
    "version" : "String",
    "logoUrl" : "String",
    "atomCode" : "String",
    "labelList" : [ {
      "createTime" : 0,
      "labelType" : "String",
      "updateTime" : 0,
      "id" : "String",
      "labelName" : "String",
      "labelCode" : "String"
    } ],
    "createTime" : "String",
    "visibilityLevel" : "String",
    "frontendType" : "ENUM",
    "name" : "String",
    "repositoryAuthorizer" : "String",
    "publisher" : "String",
    "classifyCode" : "String",
    "category" : "String",
    "dailyStatisticList" : [ {
      "dailySuccessNum" : 0,
      "statisticsTime" : "String",
      "dailyFailNum" : 0,
      "dailyFailRate" : "parse error",
      "dailyDownloads" : 0,
      "totalDownloads" : 0,
      "dailySuccessRate" : "parse error",
      "dailyFailDetail" : {
        "string" : "string"
      }
    } ]
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型AtomVersion

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | AtomVersion | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## AtomVersion

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| versionContent | string | 否 | 版本日志 |
| flag | boolean | 否 | 是否可安装标识 |
| modifier | string | 否 | 修改人 |
| description | string | 否 | 插件描述 |
| language | string | 否 | 开发语言 |
| yamlFlag | boolean | 否 | yaml可用标识 true：是，false：否 |
| atomId | string | 否 | 插件ID |
| atomStatus | string | 是 | 插件状态 |
| initProjectCode | string | 否 | 插件的初始化项目 |
| codeSrc | string | 否 | 代码库链接 |
| htmlTemplateVersion | string | 否 | 前端渲染模板版本（1.0代表历史存量插件渲染模板版本） |
| projectCode | string | 否 | 插件的调试项目 |
| releaseType | string | 否 | 发布类型 |
| pkgName | string | 否 | 插件包名 |
| jobType | string | 否 | 适用Job类型 |
| atomType | string | 否 | 插件类型 |
| classifyName | string | 否 | 插件分类名称 |
| userCommentInfo | 用户评论信息 | 否 | 用户评论信息 |
| summary | string | 否 | 插件简介 |
| recommendFlag | boolean | 否 | 是否推荐标识 true：推荐，false：不推荐 |
| editFlag | boolean | 否 | 是否可编辑 |
| creator | string | 否 | 创建人 |
| defaultFlag | boolean | 否 | 是否为默认插件（默认插件默认所有项目可见）true：默认插件 false：普通插件 |
| docsLink | string | 否 | 插件说明文档链接 |
| os | List | 否 | 操作系统 |
| updateTime | string | 否 | 修改时间 |
| privateReason | string | 否 | 插件代码库不开源原因 |
| version | string | 否 | 版本号 |
| logoUrl | string | 否 | logo地址 |
| atomCode | string | 否 | 插件标识 |
| labelList | List&lt;标签信息&gt; | 否 | 标签列表 |
| createTime | string | 否 | 创建时间 |
| visibilityLevel | string | 否 | 项目可视范围,PRIVATE:私有 LOGIN\_PUBLIC:登录用户开源 |
| frontendType | ENUM\(HISTORY, NORMAL, SPECIAL, \) | 否 | 前端UI渲染方式 |
| name | string | 否 | 插件名称 |
| repositoryAuthorizer | string | 否 | 插件代码库授权者 |
| publisher | string | 否 | 发布者 |
| classifyCode | string | 否 | 插件分类code |
| category | string | 否 | 插件范畴 |
| dailyStatisticList | List&lt;每日统计信息&gt; | 否 | 每日统计信息列表 |

## 用户评论信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| commentFlag | boolean | 是 | 是否已评论 true:是，false:否 |
| commentId | string | 否 | 评论ID |

## 标签信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| createTime | integer | 否 | 创建日期 |
| labelType | string | 是 | 类别 ATOM:插件 TEMPLATE:模板 IMAGE:镜像 IDE\_ATOM:IDE插件 |
| updateTime | integer | 否 | 更新日期 |
| id | string | 是 | 标签ID |
| labelName | string | 是 | 标签名称 |
| labelCode | string | 是 | 标签代码 |

## 每日统计信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| dailySuccessNum | integer | 否 | 每日执行成功数 |
| statisticsTime | string | 否 | 统计时间，格式yyyy-MM-dd HH:mm:ss |
| dailyFailNum | integer | 否 | 每日执行失败数 |
| dailyFailRate | number | 否 | 每日执行失败率 |
| dailyDownloads | integer | 否 | 每日下载量 |
| totalDownloads | integer | 否 | 总下载量 |
| dailySuccessRate | number | 否 | 每日执行成功率 |
| dailyFailDetail | object | 否 | 每日执行失败详情 |

