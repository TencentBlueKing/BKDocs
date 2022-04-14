# 上下文传参

上下文传参一般用于组合套餐中，将上一个节点的输出作为下一个节点的输入。

> 目前支持将作业平台套餐的输出作为任意下一个节点(作业平台、通知、标准运维等)的输入。

## 使用场景

故障自愈的默认套餐`『快捷』发送CPU使用率TOP10的进程(微信)`、`『快捷』发送内存使用率TOP10的进程(微信)` 实际上是一个使用上下文传参的组合套餐。

- 第 1 步：创建输出 CPU、内存使用率的 TOP10 的作业

- 第 2 步：创建作业平台套餐

- 第 3 步：创建`通知`套餐，引用上一步输出的结果，以微信的方式发送出来

- 第 4 步：使用组合套餐，将两个套餐串起来

## 在作业平台中定义传递的参数

在作业平台的作业中按照如下格式将传递的参数定义好

```bash
  echo "FTAARGV 变量:值"
```

以`『快捷』发送内存使用率TOP10的进程(微信)` 套餐中的第 1 步的脚本为例：

```bash
#!/bin/bash
#         USAGE: ./get_top_proc_mem.sh <cpu|mem> <number>#
#   DESCRIPTION: 输出系统当前占用资源(cpu、内存)最多的TopN进程
#===================================================================
set -o nounset                              # Treat unset variables as an error

fields="pcpu,pmem,comm"

usage() {
    cat <<EOF
    get_top_proc_in_oneline.sh <cpu|mem> <number of top proc>
EOF
    exit 1
}

join() {
    local IFS="$1"
    shift; echo "$*"
}

if (( $# < 1 )) || (( $# > 2 )) ; then
    usage
fi

case $1 in
    cpu) sort_field=pcpu ;;
    mem) sort_field=rss ;;
    *) usage ;;
esac

if [[ $# -eq 2 ]]; then
    top_n=$2
else
    top_n=6
fi

return_mem=$(ps -eo "$fields" --sort=-"$sort_field" | head -$(( top_n + 1 )) | awk 'NR==1 { gsub(/%/,"") } {printf "%s\\n", $0 }')

echo "FTAARGV return_mem:${return_mem}"
```

> 上面示例中，return_mem 为传递给下一个原子节点的变量，${return_mem}为变量的值。

![fta_give_argu](../assets/fta_give_argu.png)
<center>图 1. 创建输出传参(传递给下一个步骤的参数)的作业</center>

## 创建作业平台套餐

创建自愈套餐，套餐类型选择作业平台，选择上一步创建的作，并勾选`从作业中获取参数`
![-w757](../assets/15361165262752.jpg)
<center>图 2. 创建输出传参(传递给下一个步骤的参数)的套餐</center>

## 创建使用上一步输出参数的套餐

创建通知套餐或作业平台套餐来使用上一步输出的参数。

> 如果你没配置通知套餐，也可以通过作业平台套餐来测试。

![-w2020](../assets/15361169576206.jpg)
<center>图 3. 创建通知套餐，引用上一步输出的参数</center>

![-w2020](../assets/15361180934431.jpg)
<center>图 4. 创建作业，引用作业平台套餐传递的参数</center>

![-w754](../assets/15361168485235.jpg)
<center>图 5. 创建作业平台套餐，引用上一步输出的参数</center>

## 创建组合套餐

通过组合套餐，将输出参数 和 使用参数 的原子套餐串起来。

![-w2020](../assets/15361170784129.jpg)
<center>图 6. 创建组合套餐</center>

## 测试

如果故障自愈不是很方便获取监控的告警，可以使用 [REST API 推送](../functions/REST_API_PUSH_Alarm_processing_automation.md) 方式，来验证故障自愈的执行。

## 作业间传参效果

![-w2020](../assets/15361183999000.jpg)
<center>图 7. 模拟自愈，执行上一步创建的组合套餐(包含上下文传参特性)</center>

![-w2020](../assets/15361183753395.jpg)
<center>图 8. 该自愈的执行详情</center>

![-w2020](../assets/15361184242911.jpg)
<center>图 9. #0 步 输出参数</center>

![-w2020](../assets/15361186282518.jpg)
<center>图 9. #1 步 获取参数</center>

![-w2020](../assets/15361187273160.jpg)
<center>图 10. #2 步 作业执行时传递参数内容</center>

## 作业 + 通知 组合套餐的输出结果
![-w398](../assets/15361193219458.jpg)
<center>图 11. 作业+通知 组合套餐的输出结果</center>

> 注：如果参数仅在作业平台中传递，可以使用 [作业平台的上下文传参功能](../../../作业平台/产品白皮书/Best-Practices/How-to-pass-params-through-steps.md)。


