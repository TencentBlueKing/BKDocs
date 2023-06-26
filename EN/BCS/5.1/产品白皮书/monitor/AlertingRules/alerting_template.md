## 背景

在告警策略中，可以通过模板变量生成动态的告警内容，也可以自定义标签和注解，在 Webhooks 中使用。

告警规则模板基于 go template 开发，基本使用语法和一致， 如 {{ $labels }}  替换变量等。

模板规则在 Prometheus Template 基础上，新增了变量和函数，如果不满足需求，请联系[蓝鲸客服](https://bk.tencent.com/)。

## 模板变量

Prometheus 内置的变量有：

| 变量名  |  类型  |  说明 |
| ------------ | ------------ | ------------ |
| $labels     | map[string]string  | 查询告警返回的 labels, 和规则表达式有关 |
| $value      | float64  | 查询告警返回的值，和规则表达式有关 |
| $externalLabels  | map[string]string  | 全局 labels，目前是空 |

BCS 扩展的变量有：

| 变量名  |  类型  |  说明 |
| ------------ | ------------ | ------------ |
| $ruleLabels  | map[string]string  | 填写的标签 |
| $ruleAnnotations  | map[string]string  | 填写的注解 |
| $threshold  | float64  | 填写的告警阀值 |
| $for  | uint64  | 填写的持续时间，单位是秒，可以结合函数`duration`得到中文描述的持续时间 |
| $operator  | string  | 填写操作符，>=, =等 |

## 模板函数

Prometheus 内置的函数：

[Prometheus Function](https://prometheus.io/docs/prometheus/latest/configuration/template_reference/#functions)

BCS 扩展的函数有：

| 函数名  | 参数  | 返回 | 说明 |
| ------------ | ------------ | ------------ | ------------ |
| ip  | 任意 ip:port 字符串  | ip | 如果不是合法的 ip:port，会原样返回，多用于 instance 中提取 IP 变量，如`$labels.instance pipe ip` |
| duration  | uint64, 单位是秒  | 持续时间 | 计算持续时间，一般和 $for 变量结合使用 |
| queryMetric  | $labels 等 key,value 字符串  | []sample | 查询单个 metric 的值 |

## 参考文档

[Prometheus 模板规则](https://prometheus.io/docs/prometheus/latest/configuration/template_reference/)
[Prometheus 模板使用样例](https://prometheus.io/docs/prometheus/latest/configuration/template_examples/)