## 蓝盾使用问题

### 流水线上传构件失败
#### 表现

流水线插件 “upload artifact”报错：
``` plain
1 file match:
  /data/devops/workspace/文件名
prepare to upload 大小 B
Error: Process completed with exit code 2189503: com.tencent.devops.common.api.exception.RemoteServiceException: 上传流水线文件失败.
2189503
Please contact platform.
```

#### 排查处理

根据文件名确认 `ci-artifactory` Pod 日志，为相同报错，无法直观看到原因。

故启动 `ci-gateway` Pod 的交互 shell：
``` bash
kubectl exec -it -n blueking deploy/bk-ci-bk-ci-gateway -- bash
```

进入 shell 后，检查 nginx 日志目录 `/data/logs/nginx/` 下的 `站点名.access.时间.log` 和 `站点名.error.log`，发现为 `devops.error.log` 中记录了请求 `repo.bk.com` 域名返回了 413，从时间上能和 `ci-artifactory` 日志中的异常对应，因此判断为异常原因。

进一步联系开发确认为 charts 默认值有误所致，需要调整 custom values 文件：`environments/default/bkci/bkci-custom-values.yaml.gotmpl`：
``` yaml
config:
  bkRepoFqdn: bkrepo.{{ .Values.domain.bkDomain }}
```
随后重启 ci 解决：
``` bash
helmfile -f 03-bkci.yaml.gotmpl destroy
helmfile -f 03-bkci.yaml.gotmpl sync
```

#### 总结

蓝鲸出包问题。

`bk-ci` 默认配置项有误，请参考 《[部署持续集成平台-蓝盾](../install-ci-suite.md#install-ci)》文档重新部署。


### 流水线配置 GitLab 触发后项目设置里没有 webhook 配置项
#### 表现

流水线触发器添加了 GitLab，并正确配置了触发事件，但是 git commit 时无法触发。检查 GitLab 项目的配置（settings），也没有设置 webhook url。

#### 排查处理

添加触发器后，流水线保存时会异步触发 webhook 注册逻辑。

检查 ci-process 日志发现报错：`com.tencent.devops.common.api.exception.RemoteServiceException: Webhook添加失败，请确保该代码库的凭据关联的用户对代码库有master权限`。

添加 master 权限后，重新保存流水线，发现 GitLab 项目中已经出现 webhook url，点击 Test 可以成功触发流水线运行。

#### 总结

环境问题。

用户没有仓库的 master 权限，添加权限后重新保存流水线，即可正常触发。
