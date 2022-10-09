# 上传 PaaS runtimes 到 bkrepo

在 **中控机** 获取需要执行的命令：
``` bash
helm status bk-paas -n blueking
```
其输出如图所示：
![](assets/2022-03-09-10-42-53.png)
在 **中控机** 执行所提示的命令即可运行 `runtimes-download.sh` 脚本：
``` bash
kubectl run --rm \
--env="BKREPO_USERNAME=admin" \
--env="BKREPO_PASSWORD=略" \
--env="BKREPO_ENDPOINT=http://bkrepo.略" \
--env="BKREPO_PROJECT=bkpaas" \
--image="hub.bktencent.com/blueking/paas3-buildpack-toolkit:1.1.0-beta.70" \
-it bkpaas3-upload-runtime --command  -- /bin/bash runtimes-download.sh \
-n blueking
```

>此处 `runtimes-download.sh` 脚本从蓝鲸官方资源库下载依赖 SaaS 必需的 `runtime` （运行时资源）并上传到私有化环境中的 bkrepo 仓库。
>
>要求 k8s node 能访问外网，如果因网络问题下载异常，可以重复运行此脚本。

