# 部署持续集成套餐
持续集成套餐包含“流水线”、“代码检查”及“编译加速”三个平台。

>**提示**
>
>欢迎先体验“流水线”平台，其他平台陆续接入中。


<a id="install-ci" name="install-ci"></a>

## 部署持续集成平台-蓝盾
>**提示**
>
>当前“持续集成平台”因为固定了 构建 Pod 规格为 `1 核 1G 内存 1G 磁盘`，故不建议用于生产环境。

### 配置 coredns

在 **中控机** 执行：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" devops.$BK_DOMAIN codecc.$BK_DOMAIN bktbs.$BK_DOMAIN
./scripts/control_coredns.sh list  # 检查添加的记录。
```

### 修改 custom values
* 目前 编译加速平台（turbo）暂未适配完成，需要临时禁用初始化。
* 需要更新 bkrepo 的配置项，不然上传构件会失败。
* 需要调高部分 pod 的 limit，初次启动很容易超时。（如果你的资源充足，可以调整更多 Pod）。

修改 `environments/default/bkci/bkci-custom-values.yaml.gotmpl`：
``` yaml
init:
  turbo: false
config:
  bkRepoFqdn: bkrepo.{{ .Values.domain.bkDomain }}
auth:
  resources:
    limits:
      cpu: 1500m
      memory: 1500Mi
store:
  resources:
    limits:
      cpu: 1500m
      memory: 1500Mi
openapi:
  resources:
    limits:
      cpu: 1500m
      memory: 1500Mi
```

### 部署 bk-ci
在 **中控机** 执行：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f 03-bkci.yaml.gotmpl sync  # 部署
# 在admin桌面添加应用，也可以登录后自行添加。
scripts/add_user_desktop_app.sh -u "admin" -a "bk_ci"
# 设为默认应用。
scripts/set_desktop_default_app.sh -a "bk_ci"
```
部署需 5 ~ 10 分钟。上述命令结束后，可在中控机检查所有 Pod 是否正常：
``` bash
kubectl get pod -A | grep bk-ci
```

>**提示**
>
>**如果部署期间出错，请先查阅 《[问题案例](troubles.md)》文档。**
>
>问题解决后，可重新执行 `helmfile` 命令。


### 浏览器访问

需要配置域名 `devops.$BK_DOMAIN`，操作步骤已经并入《基础套餐部署》文档的 “[配置用户侧的 DNS](install-bkce.md#hosts-in-user-pc)” 章节。

配置成功后，即可在桌面打开 “持续集成平台-蓝盾” 应用了。
