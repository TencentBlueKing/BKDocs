# traffic-label 插件

## 网关版本

bk-apigateway >= 1.21.x

## 背景

在灰度发布/全链路灰度等场景中，需要根据请求特征通过添加请求头的方式对流量进行染色。

## 支持的匹配规则

- arg_name=jack 表示 GET 请求 query string 参数 name=jack

- post_arg_name=jack 表示 POST 请求中 form data name=jack

- http_user-id=123 表示 请求 header 头 user-id=123

- cookie_bk_username=tom 表示请求 cookie 中的 bk_username=tom

- 支持 nginx/apisix 内置变量 [Alphabetical index of variables](https://nginx.org/en/docs/varindex.html) / [Built-In Variables | API7 Docs](https://docs.api7.ai/apisix/reference/built-in-variables)
  - scheme==http
  - uri~~^/[a-z]+$

## actions 处理规则

- 目前仅支持 set_headers 操作

- 权重 weight 如果没有配置，默认值为 1

- 会汇总所有 action 的 weight 后进行规范化
  - 只有一个 action， action.weight=100
  - 多个 action，其 weight 分别为 3/2/5， 那么规范化后 weight 为 30/20/50
  - 如果规范化后总值非 100，会将差值放最后一个操作的权重， 例如 weight 为 1/1/1， 规范化后为 33/33/34

- 如果只指定 weight，不指定 set_headers，那么分布在这个 weight 下的请求什么都不做；（匹配进入这个分支但是什么都不做）

## 配置示例

一个 match 条件

```json
 "bk-traffic-label": {
       "rules": [
         {
           "match": [
             ["uri", "==", "/headers"]
           ],
           "actions": [
             {
               "set_headers": {
                 "X-Server-Id": 100
               }
             }
           ]
         }
       ]
     }
```

一个 match 多个条件，有逻辑关系

```json
"bk-traffic-label": {
       "rules": [
         {
           "match": [
             "OR",
             ["arg_version", "==", "v1"],
             ["arg_env", "==", "dev"]
           ],
           "actions": [
             {
               "set_headers": {
                 "X-Server-Id": 100
               }
             }
           ]
         }
       ]
     }
```

 一个 match 多个 action，有权重的

30% of the requests should have the `X-Server-Id: 100` request header.

20% of the requests should have the `X-API-Version: v2` request header.

50% of the requests should not have any action performed on them.

```bash
"bk-traffic-label": {
       "rules": [
         {
           "match": [
             ["uri", "==", "/headers"]
           ],
           "actions": [
             {
               "set_headers": {
                 "X-Server-Id": 100
               },
               "weight": 3
             },
             {
               "set_headers": {
                 "X-API-Version": "v2"
               },
               "weight": 2
             },
             {
               "weight": 5
             }
           ]
         }
       ]
     }
```

多个 match   => 顺序执行

```json
"bk-traffic-label": {
       "rules": [
         {
           "match": [
             ["arg_version", "==", "v1"]
           ],
           "actions": [
             {
               "set_headers": {
                 "X-Server-Id": 100
               }
             }
           ]
         },
         {
           "match": [
             ["arg_version", "==", "v2"]
           ],
           "actions": [
             {
               "set_headers": {
                 "X-Server-Id": 200
               }
             }
           ]
         }
       ]
     }
```
