# 如何让自己的流水线日志显示带上不同颜色

在流水线日志组件中，我们定义了以下关键字供插件开发者使用。

| 关键字 | 作用 | 备注 |
| :--- | :--- | :--- |
| \#\#\[section\] | 一个Job或者插件的开头 | 如果是插件开头，必须包含在一个Job的Starting内 |
| \#\#\[endsection\] | 一个Job或者插件的结尾 | 如果是插件结尾，必须包含在一个Job的Finishing内 |
| \#\#\[command\] | 将后面的字符串以ShellScripts高亮 | \#0070BB |
| \#\#\[info\] | 将后面的字符串标记为info颜色 | \#48BB31 |
| \#\#\[warning\] | 将后面的字符串标记为warning颜色 | \#BBBB23 |
| \#\#\[error\] | 将后面的字符串标记为error颜色 | \#DE0A1A |
| \#\#\[debug\] | 将后面的字符串标记为debug颜色 | \#0D8F61 |
| \#\#\[group\] | 一个折叠的开始 |  |
| \#\#\[endgroup\] | 一个折叠的结束 |  |

**以Bash插件为例：**

```bash
echo "##[command]whoami"
whoami
echo "##[command]pwd"
pwd
echo "##[command]uptime"
uptime
echo "##[command]python --version"
python --version

echo "##[info] this is a info log"
echo "##[warning] this is a warning log"
echo "##[error] this is a error log"
echo "##[debug] this is a debug log"

echo "##[group] Print SYSTEM ENV"
env
echo "##[endgroup]"
```

你将看到如下图所示效果

![](../../assets/image2020-1-9_21-59-12.png)

