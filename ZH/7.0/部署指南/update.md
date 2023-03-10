# 单产品更新
我们在推出 7.0.0 版本后，对其中部分平台进行了更新。

## 更新 bk-job

|  | 7.0.0 中的版本 | 本次更新的版本 |
|--|--|--|
| charts version | 0.2.6 | 0.3.2-rc.3 |
| app version | 3.5.1 | 3.6.2-rc.3 |

登录到 **中控机**，先更新 helm 仓库：
``` bash
helm repo update
```
使用 `helm search repo bk-job -l --devel` 命令确认已经存在 `bk-job` charts 的 `0.3.2-rc.3` 版本：
``` plain
NAME           	CHART VERSION	APP VERSION 	DESCRIPTION
blueking/bk-job	0.3.2-rc.3   	3.6.2-rc.3  	略
```

接下来开始升级了。

先进入工作目录：
``` bash
cd ~/bkhelmfile/blueking  # 默认路径，按实际情况修改。
```

修改 `environments/default/version.yaml` 文件，配置 bk-job charts version 为 `0.3.2-rc.3`：
``` bash
sed -i 's/bk-job:.*/bk-job: "0.3.2-rc.3"/' environments/default/version.yaml
```
检查修改结果： `grep bk-job environments/default/version.yaml`，预期输出：
``` yaml
  bk-job: "0.3.2-rc.3"
```

更新 job：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-job apply
```

等待命令执行完毕，结尾输出如下即为更新成功：
``` plain
UPDATED RELEASES:
NAME     CHART                VERSION
bk-job   blueking/bk-job   0.3.2-rc.3
```


## 更新标准运维
下载适用于蓝鲸 7.0.0 的安装包：
* [bk_sops-V3.26.6.tar.gz](https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_sops/bk_sops-V3.26.6.tar.gz)

参考 《[部署标准运维（bk_sops）](install-saas-manually.md#deploy-bkce-saas-sops)》 文档上传安装包，并部署到生产环境。

>**注意**
>
>标准运维有 4 个模块需要部署。

全部模块部署成功后，即可在桌面访问了。
