# 凭证变量

在凭证管理中设置**密码类型**的凭证后，可以在流水线中引用该密码变量，密码变量是项目级别的，同项目下不同流水线都能引用，适用于需要给整个项目定义变量的场景，如游戏平台、游戏版本、分支名称等。

引用方式：`${{凭证名称}}`

![png](../../../assets/image-variables-ticket-myvar.png)

![png](../../../assets/image-variables-ticket-var-used.png)