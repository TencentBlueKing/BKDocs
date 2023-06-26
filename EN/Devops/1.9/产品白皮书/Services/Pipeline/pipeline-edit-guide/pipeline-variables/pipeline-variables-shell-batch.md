# 在 Shell/Batchscript/RunScript 插件里使用变量

## 在 Shell/RunScript 插件里使用变量

```shell
# cd 到工作空间 WORKSPACE 下
cd $WORKSPACE

# echo "::set-variable name=<var_name>::<value>"
# eg:
echo "::set-variable name=version:1.0.0"
```

set-variable 在当前 task 运行结束才会生效，当前的 shell 里打印不出来的。

```shell
# 在后续的shell插件中引用version
echo ${{ variables.version }}
```

## 在 Batchscript 插件里使用变量

```bat
REM 引用全局变量WORKSPACE
cd %WORKSPACE%

echo "::set-variable name=FILENAME:a.zip"

```

在后续 Batchscript 插件中引用 FILENAME
```bat
echo on
echo ${{ variables.FILENAME }}
```
