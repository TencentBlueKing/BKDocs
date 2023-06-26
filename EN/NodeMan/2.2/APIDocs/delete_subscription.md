 ### 功能描述

 删除订阅

 ### 请求参数

 {{ common_args_desc }}

 #### 接口参数

 | 字段              | 类型  | <div style="width: 50pt">必选</div> | 描述   |
 | --------------- | --- | --------------------------------- | ---- |
 | subscription_id | int | 是                                 | 订阅ID |

 ### 请求参数示例

 ```json
 {
     "bk_app_code": "esb_test",
     "bk_app_secret": "xxx",
     "bk_username": "admin",
     "bk_token": "xxx",
     "subscription_id": 1,
 }
 ```

 ### 返回结果示例

 ```json
 {
     "result": true,
     "code": 0,
     "message": "success",
     "data": null
 }
 ```

 ### 返回结果参数说明

 #### response

 | 字段      | 类型     | 描述                         |
 | ------- | ------ | -------------------------- |
 | result  | bool   | 请求成功与否。true:请求成功；false请求失败 |
 | code    | int    | 错误编码。 0表示success，>0表示失败错误  |
 | message | string | 请求失败返回的错误信息                |
 | data    | object | 请求返回的数据                    |
