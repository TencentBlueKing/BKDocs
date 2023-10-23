>当流程有多个步骤时，经常需要把前面某个个步骤处理的结果传递给下一个或后面的步骤使用（输出作为输入），这就是跨步骤传参的场景，标准运维通过特有的标记符号"<SOPS_VAR>key:value</SOPS_VAR> "来实现。

# 理解标记符号"<SOPS_VAR>key:value</SOPS_VAR>"

使用场景就是在脚本里使用标准运维的标记符号"<SOPS_VAR></SOPS_VAR>"，将要传递的数据以key/value对的形式包含在标记符号中，并使用echo/print等打印到作业平台的日志中，shell和Python都可以。

shell：
```
echo "<SOPS_VAR>key:val</SOPS_VAR>"
```

Python：
```
print("<SOPS_VAR>key:val</SOPS_VAR>")
```

例：
```
message="hello blueking"
echo "<SOPS_VAR>message:$message</SOPS_VAR>"
key "message"对应的value是"hello blueking"
```

# 实操演示

例：标准运维流程有两个步骤，第一个步骤使用作业平台插件执行脚本输出的"hello blueking"内容想要给第二个步骤使用

## 1、步骤一使用脚本执行模拟输出"hello blueking"
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506112437/20044/20230506112437/--ef78dd3a4f939ca6d2779e8b96ec4adb.png)

```
message="hello blueking"
echo "<SOPS_VAR>message:$message</SOPS_VAR>
```
（示例代码）

输出日志中提取的全局变量，日志中形如 <SOPS_VAR>key:val</SOPS_VAR> 的变量会被提取到 log_outputs['key'] 中，值为 val。

## 2、步骤二通过变量的方式引用第一步的输出
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506112516/20044/20230506112516/--fff18f4f03b77e07c3348515ab80a298.png)
```
echo ${log_outputs["message"]}
```
（示例代码）

## 3、执行效果
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506112538/20044/20230506112538/--03ed4d0c6956b24b4d18fc1c2f957ee2.png)

（步骤一)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506112552/20044/20230506112552/--5fcf6b13ba18e81cc0cddedd854410d4.png)

（步骤二)

也可以点击作业平台执行任务详情链接查看执行结果
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506112602/20044/20230506112602/--260010e6630f55dbaa3a6c00e1d4687b.png)

不同步骤传参的实现核心要素就是标准运维特有的标记符号“<SOPS_VAR>key:val</SOPS_VAR>”，以及要把log_outputs勾选为变量。

## 扩展高级使用

- 多个步骤需要跨步骤传参

如果多个步骤都需要使用到步骤传参（如步骤一的输出要给步骤二作为输入，步骤二的输出又需要给步骤三作为输入），那么输出参数里的KEY可以命名为log_outputs_xxx，避免重名。

如：

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506112626/20044/20230506112626/--03f94ac7acfdc5c191746bb1e04746fa.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506112631/20044/20230506112631/--77cdf3c8765fd7c078c5c4e66fe0c9dd.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506112636/20044/20230506112636/--542100799e58185d687d4d2da62c94c2.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506112641/20044/20230506112641/--cfdbe08d91088ddac6c7df95ca16e815.png)

- 一个步骤有多个变量需要被其他步骤引用

多个变量，只要key不同，只需要使用<SOPS_VAR>key:val</SOPS_VAR>的语法，就可以定义多个。

如：
```
echo "<SOPS_VAR>message1:123</SOPS_VAR>"
echo "<SOPS_VAR>message2:456</SOPS_VAR>"
那么使用
${log_outputs['message1']}获取到123
${log_outputs['message2']}获取到456
```

- 使用Python语法处理value，比如指定换行分隔符

```
举例1：
原始变量为： <SOPS_VAR>message:123|456|789</SOPS_VAR>

引用时用换行替换竖线：
${'\n'.join(log_outputs_xxxx['message'].split('|'))}

变量执行时，值为：
123
456
789

举例2：
原始变量为：<SOPS_VAR>message:1.1.1.1@name1|2.2.2.2@name2|3.3.3.3@name3</SOPS_VAR>

引用时，先用空格替换@，再用换行替换竖线：${'\n'.join(' '.join(log_outputs_xxxx['message'].split('@')).split('|'))}

变量执行时，值为：
1.1.1.1 name1
2.2.2.2 name2
3.3.3.3 name3
```

  