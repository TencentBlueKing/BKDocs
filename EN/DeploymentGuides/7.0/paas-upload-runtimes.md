# 上传 PaaS runtimes 到 bkrepo

当你使用 PaaS 开发应用，或者导入 S-Mart 源码包时，需要进行编译操作。

这些编译环境在 PaaS 中被称为 `runtimes`，使用 `runtimes-download.sh` 脚本从蓝鲸官网下载，并上传到你私有化部署环境中。

>**提示**
>
>要求 k8s node 能访问外网，如果因网络问题下载异常，可以重复运行此脚本。

在 **中控机** 获取需要执行的命令：
``` bash
helm status bk-paas -n blueking
```
其输出如图所示：
![](assets/2022-03-09-10-42-53.png)

在 **中控机** 执行 `helm status` 显示的命令：
``` bash
kubectl run --rm \
--env=以上述命令显示为准 \
--image=以上述命令显示为准 \
-it bkpaas3-upload-runtime --command  -- /bin/bash runtimes-download.sh \
-n blueking
```

>**提示**
>
>如果有修改 bkrepo 的账户密码，请自行修改命令行参数。

当容器退出时没有报错，则为上传完成。

可前往 bkrepo 系统检查上传的文件：
使用 admin 账户登录蓝鲸桌面，添加应用 “制品库”，然后打开。

切换到 bkpaas 项目，在仓库列表中找到 `bkpaas3-platform-assets` 仓库。进入 `runtimes` 目录，即可看到上传的资源。
