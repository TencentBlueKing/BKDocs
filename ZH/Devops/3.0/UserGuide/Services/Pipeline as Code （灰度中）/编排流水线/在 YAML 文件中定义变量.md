# 在YAML文件中定义变量


流水线变量介绍详见 
 流水线变量管理和使用-灰度中 
 
Code 模式下，通过顶级关键字 variables 定义流水线变量。
 
# variables

全局变量
值格式为：Object，可以定义一个或多个变量，key 为变量唯一标识

## 变量命名规范

- 以字母、数字和下划线组成
- 若为常量，字母需为大写
- template 为保留关键字，不能作为自定义属性名称

## 支持的属性




目前支持的UI组件类型：

| |
|:--|
|组件类型 |组件说明 |
|vuex-input |单行文本输入框 |
|vuex-textarea |多行文本输入框 |
|selector |下拉框 |
|checkbox |复选框 |
|boolean |单选 true or false |
|company-staff-input |人名选择器 |
|tips |提示信息 |
 
 
### 定义入参

#### 定义一个非必填的单行文本输入框变量

简写为：

 ```
variables:
  my_val: "1"
```


完整配置为：

 ```
variables:
  my_val:                                        # 参数英文名
    value: "1"                                   # 参数默认值
    allow-modify-at-startup: true                # 是否允许在手动触发/openapi触发时变更值
    props:
      type: vuex-input                           # 组件类型
```

#### 定义一个必填的单行文本输入框变量

 ```
variables:
  my_val:                                        # 参数英文名
    value: ""                                    # 参数默认值
    allow-modify-at-startup: true                # 是否允许在手动触发/openapi触发时变更值
    props:
      type: vuex-input                           # 组件类型
      label: 单行文本框                            # 参数中文名
      required: true                             # 是否必填
```


#### 定义一个多行文本输入框变量

 ```
variables:
  my_val:                                        # 参数英文名
    value: ""                                    # 参数默认值
    allow-modify-at-startup: true                # 是否允许在手动触发/openapi触发时变更值
    props:
      type: vuex-textarea                        # 组件类型
      label: 多行文本框                            # 参数中文名
```
 
 
#### 定义一个下拉可选的变量

枚举下拉选项列表：    

 ```
variables:
  my_val:                                           # 参数英文名
    value: 1,2                                     # 参数默认值
    allow-modify-at-startup: true       # 是否允许在手动触发/openapi触发时变更值
    props:
      label: 我是预定义下拉可选值的字段   # [可选] 参数中文名
      type: selector                  # 参数类型
      options:                          # 下拉选项列表
        - id: 1
          label: 正式环境
          description: 说明什么情况下发正式
        - id: 2
          label: 灰度环境
          description: 说明什么情况下发灰度
        - id: 3
          label: test环境
          description: 说明什么情况下发test
      description: 这是个下拉选择字段    # [可选] 参数说明
```


下拉选项列表通过接口获取：   

 ```
variables:
  my_val:                                         # 参数英文名
    value: ""                                   # 参数默认值
    allow-modify-at-startup: true    # 是否允许在手动触发/openapi触发时变更值
    props:
      label: 我是通过url获取下拉可选值的字段
      type: selector      
      datasource:
        url: ""                      # [可选]获取下拉列表中可选值的接口，需要接入蓝鲸网关
        data-path: ""                # [可选]选项列表数据所在的、API返回体json中的路径，没有此字段则默认为data， 示例：data.detail.list。配合url使用
        param-id: ""                 # [可选]url返回规范中，用于下拉列表选项id的字段名，配合url使用
        param-name: ""               # [可选]url返回规范中，用于下拉列表选项label的字段名，配合url使用
        has-add-item: true           # [可选]是否有新增按钮
        item-text: ""                # [可选]新增按钮文字描述
        item-target-url: ""          # [可选]点击新增按钮的跳转地址
      description: 这是个下拉选择字段
      required: true
```


#### 定义一个复选框变量

 ```
variables:
  my_val:                                         # 参数英文名
    value: ""                                    # 参数默认值
    allow-modify-at-startup: true    # 是否允许在手动触发/openapi触发时变更值
    props:
      label: 我是 checkbox 字段
      type: checkbox
      options:
        - id: 1
          label: 正式环境
```


#### 定义一个布尔变量

 ```
variables:
  my_val:                                         # 参数英文名
    value: true                                   # 参数默认值
    allow-modify-at-startup: true    # 是否允许在手动触发/openapi触发时变更值
    props:
      label: 我是 BOOL 字段
      type: boolean
```
 
 
### 定义其他变量（非入参）

 ```
variables:
  my_val:                                        # 参数英文名
    value: "1"                                   # 参数默认值
    allow-modify-at-startup: false               # 是否允许在手动触发/openapi触发时变更值
```


### 定义常量

 ```
variables:
  CONST_1:                   # 常量英文名
    value: release           # 常量值
    const: true              # 常量时必填，值为 true
```

 
### 指定运行时只读

入参或者非入参，都可以指定运行时是否只读
如果非入参，且指定了运行时只读，和常量效果一致

 ```
var_2:
    value: "2"
    readonly: true
    allow-modify-at-startup: false
```
	
