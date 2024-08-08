	
# step 下支持的其他属性

除了 run、checkout、uses， step 下还支持如下属性：

## name

step 的名称
值格式为：String
缺省值为插件名称

## id

当前 pipeline 下 step 的唯一标识
值格式为：String
用户可以自定义，当前 pipeline 下不能重复。
缺省时系统自动生成 16 位随机ID

## if

值格式为：String
满足条件时才执行当前 step，不满足时跳过不执行
支持条件表达式，详见[条件执行](../09-conditional-execution/01-control-point.md)
 
## with

当前插件的入参
值格式为：Object

## timeout-minutes

设置 step 的超时时间，单位为分钟
值格式为：Int
- 缺省值为 480 分钟 （8 小时）
- 取值范围为 1~ 10080 之间的整数

## continue-on-error

失败时是否继续执行
值格式为：Boolean，缺省值为 false

## retry-times

失败时自动重试次数
值格式为：Int
- 缺省值为 0，表示不需要重试
- 取值范围为 1~10 之间的整数
- 重试间隔算法：round(1~重试次数)

## env

环境变量，当前 step 下生效，优先级高于 job 级别的同名变量
值格式为：Object
命名规范：
- 由大写字母和下划线组成
- CI_/BK_CI_ 为系统内置变量前缀，不允许自定义此前缀开头的环境变量

使用限制：

| |
|:--|
|**受限项** |**限制规则** |
|环境变量个数 |不超过**20** 个 |
|单变量 key 长度 |不超过 **128** 字符 |
|单变量值长度 |不超过 **4k** 字符 |

示例：

```yml
env:
  ENV_A: 这是环境变量A
```

	