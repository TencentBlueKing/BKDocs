# stage 准入

业务可以通过流式审批来控制 Pipeline 工作流。
Pipeline 中，除了 Final Stage，其他每个阶段都可以设置准入条件。条件包括人工审核 。

# 关键字：check-in

**语法：**
由 stage 的属性  check-in 来描述 stage 准入，值为 Object，包含如下属性：

|**属性名** |**值格式** |**说明** |**备注** |
|reviews |Object |定义**人工审批流**，包括如下属性：<br>| |<br>|:--|<br>|**属性名** |**值格式** |**说明** |**备注** |<br>|flows |Array<flow> |审批流。支持定义`最多 5 个`flow。<br>多个 flow 按照顺序逐一执行。 | |<br>|variables |Object<var_name, variable > |变量<br>在下游步骤中通过 variables 上下文访问 | |<br>|description |String |审核说明。描述如何审核 | | | |
|timeout-hours |Number |准入的超时时间，单位为小时（h）。默认 24h，取值范围为1~720 之间的整数 |


示例如下：
	
 ```
check-in:
  reviews:
    flows:
      - name: 审批组1
        reviewers: [a, b, c] # a、b、c 三人中任意一人操作即可
      - name: 审批组2
        reviewers: fayewang
    variables:
      var_1: 
        default: 1
        label: 中文
        type: SELECTOR
        values: [1,2,3]
    description: |
        说明下如何审核
        参数var_1如何取值
  timeout-hours: 10
```

# 人工审核 reviews

reviews 用于定义人工审核，支持：
- 定义一个或多个审批流，多个审批流顺序执行
- 定义一个或多个入参，参数值可以通过上下文变量占位。审批时可以修改参数值。

## flows

值格式为 Array<flow>，每个 flow 包括如下属性：


| |
|:--|
|**属性名** |**值格式** |**说明** |**备注** |
|name |String |审批流名称 | |
|reviewers |String | Array<String> |审批人 |支持指定一个或多个审批人。当有多个审批人时，其中任意一位用户进行审核操作即可。 |


## variables

值格式为 Object<var_name, variable >，key 为变量名，每个 variable 包含如下属性：


| |
|:--|
|**属性名** |**值格式** |**说明** |**备注** |
|label |String |中文名 |非必填，默认为 变量名 |
|type |String |字段类型，可选值有：<br>INPUT<br>TEXTAREA<br>SELECTOR<br>SELECTOR-MULTIPLE<br>BOOL<br>`RADIO — 尚未实施`<br>`CHECKBOX — 尚未实施` | |
|default | | |非必填 |
|values |Array |可选值 |非必填 |
|description |String |字段描述 |非必填 |

## 使用限制


| |
|:--|
|**限制项** |**阈值** |**备注** |
|同一stage下的审批步骤数（flows长度） |不超过`5`个 | |