# 在 Shell/Batchscript 插件里使用变量

## 在 Shell 插件里使用变量

```shell
# 引用全局变量WORKSPACE
cd $WORKSPACE

# 设置自定义变量: setEnv '变量名' '变量值'
setEnv 'version' '3.2.16'
```

setEnv 设置的是当前 shell 的输出参数，在下游才会生效，当前的 shell 里打印不出来的。

```shell
# 在后续的shell插件中引用version
echo ${{version}}
```

## 在 Batchscript 插件里使用变量

```bat
REM 引用全局变量WORKSPACE
cd %WORKSPACE%

REM 您可以通过setEnv函数设置插件间传递的参数 
REM call:setEnv "FILENAME" "package.zip" 
REM 然后在后续的插件的表单中使用%FILENAME%引用这个变量
call:setEnv "FILENAME" "package.zip"

```

在后续 Batchscript 插件中引用 FILENAME
```bat
echo on
echo ${{FILENAME}}
```
