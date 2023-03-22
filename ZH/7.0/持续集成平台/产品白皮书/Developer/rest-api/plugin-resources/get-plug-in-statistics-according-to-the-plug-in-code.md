# 根据插件代码获取插件统计信息

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/atoms/{atomCode}/statistic

### 资源描述

#### 根据插件代码获取插件统计信息

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| atomCode | string | 是 | 插件代码 |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型统计信息 |

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
    "score" : "parse error",
    "downloads" : 0,
    "successRate" : "parse error",
    "recentExecuteNum" : 0,
    "pipelineCnt" : 0,
    "commentCnt" : 0
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型统计信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | 统计信息 | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 统计信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| score | number | 否 | 星级评分 |
| downloads | integer | 否 | 下载量 |
| successRate | number | 否 | 成功率 |
| recentExecuteNum | integer | 否 | 最近执行次数 |
| pipelineCnt | integer | 否 | 流水线个数 |
| commentCnt | integer | 否 | 评论量 |

