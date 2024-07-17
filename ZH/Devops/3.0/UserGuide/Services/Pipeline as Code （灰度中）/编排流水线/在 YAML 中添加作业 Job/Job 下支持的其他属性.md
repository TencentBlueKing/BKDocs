# job 下支持的其它属性

除了构建环境、互斥组、Matrix Job，job 下还支持如下属性：
 
## name

job名称，缺省值为 job-<jobNum>
值格式为：String
	
## if

值格式为：String
满足条件时才执行当前 job，不满足时跳过不执行
支持条件表达式，详见 [条件执行](https://iwiki.woa.com/p/4009967248)
  
## steps

定义一个或多个step
值格式为：Array<Step>
每个 step 如何设置详见 [在 YAML 中添加步骤 Task/Step ](https://iwiki.woa.com/p/4010307333)
 
 
## timeout-minutes

设置  job 的超时时间，单位为分钟
值格式为：Int
- 缺省值为 480 分钟 （8 小时）
- 取值范围为 1~ 10080 之间的整数

## env

环境变量，当前 job 下生效
值格式为：Object
命名规范：
- 由大写字母和下划线组成
- CI_ /BK_CI_为系统内置变量前缀，不建议自定义此前缀开头的环境变量


使用限制：
| |
|:--|
|**受限项** |**限制规则** |
|环境变量个数 |不超过** 20** 个 |
|单变量 key 长度 |不超过 **128** 字符 |
|单变量值长度 |不超过 **4k** 字符 |



示例：

 ```
env:
  ENV_A: 这是环境变量A
```
 
## depend-on

用于设置当前 stage 下的 job 的执行顺序。可以配置一个或多个 job id，当依赖的所有 job 执行完毕时，才执行当前 job。
值格式为：Arrayru
- 循环依赖时报错
- 依赖的 job 不支持由变量指定