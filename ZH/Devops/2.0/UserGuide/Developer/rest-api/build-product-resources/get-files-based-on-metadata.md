# 根据元数据获取文件

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/artifactories

### 资源描述

#### 根据元数据获取文件

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| pipelineId | string | 是 | 流水线ID |  |
| buildId | string | 是 | 构建ID |  |
| page | integer | 否 | 第几页 | 1 |
| pageSize | integer | 否 | 每页多少条\(不传默认全部返回\) | 20 |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型分页数据包装模型版本仓库-文件信息 |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?pipelineId={pipelineId}&amp;buildId={buildId}&amp;page={page}&amp;pageSize={pageSize}' \
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
    "records" : [ {
      "fullPath" : "String",
      "modifiedTime" : 0,
      "appVersion" : "String",
      "shortUrl" : "String",
      "downloadUrl" : "String",
      "fullName" : "String",
      "path" : "String",
      "folder" : true,
      "size" : 0,
      "name" : "String",
      "artifactoryType" : "ENUM",
      "properties" : [ {
        "value" : "String",
        "key" : "String"
      } ],
      "md5" : "String"
    } ],
    "count" : 0,
    "totalPages" : 0,
    "pageSize" : 0,
    "page" : 0
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型分页数据包装模型版本仓库-文件信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | 分页数据包装模型版本仓库-文件信息 | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 分页数据包装模型版本仓库-文件信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| records | List&lt;版本仓库-文件信息&gt; | 是 | 数据 |
| count | integer | 是 | 总记录行数 |
| totalPages | integer | 是 | 总共多少页 |
| pageSize | integer | 是 | 每页多少条 |
| page | integer | 是 | 第几页 |

## 版本仓库-文件信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| fullPath | string | 是 | 文件全路径 |
| modifiedTime | integer | 是 | 更新时间 |
| appVersion | string | 是 | app版本 |
| shortUrl | string | 是 | 下载短链接 |
| downloadUrl | string | 否 | 下载链接 |
| fullName | string | 是 | 文件全名 |
| path | string | 是 | 文件路径 |
| folder | boolean | 是 | 是否文件夹 |
| size | integer | 是 | 文件大小\(byte\) |
| name | string | 是 | 文件名 |
| artifactoryType | ENUM\(PIPELINE, CUSTOM\_DIR, \) | 是 | 仓库类型 |
| properties | List&lt;版本仓库-元数据&gt; | 是 | 元数据 |
| md5 | string | 否 | MD5 |

## 版本仓库-元数据

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| value | string | 是 | 元数据值 |
| key | string | 是 | 元数据键 |

