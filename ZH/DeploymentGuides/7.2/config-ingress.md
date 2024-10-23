本文档描述如何维护蓝鲸访问入口，包括：
* 默认部署使用了 HTTP 协议，调整为 HTTPS。
* 默认部署使用了 bkce7.bktencent.com，如何更换为其他域名。

# 使用 https 访问蓝鲸
在获得了 SSL 证书后，需要先提供一个 HTTPS 访问入口。然后调整蓝鲸配置，启用 https。

## 准备工作
### 商业证书准备流程
现代操作系统已经预置了商业证书供应商的 root CA，所以使用商业 SSL 证书会较为方便。一些证书提供商提供了免费证书，有效期一般为 3 个月，付费证书一般为 1~2 年。

鉴于蓝鲸服务众多，申请 多域名证书（Subject Alternative Name certificate） 可能不能满足未来增设或调整域名的需求，建议申请 **通配符证书**（Wildcard certificate）。

一般申请 **DV 证书** 即可，证书签发过程中使用 域名验证（Domain Validation）。因此需要你：
1. 持有一个公网域名。
2. 域名解析指向一个公网服务器。
3. 配置此公网服务器，配合完成证书签发认证。

不同厂商的 DV 认证流程略有差异，部分厂商支持配置 DNS `TXT` 记录完成认证，具体以证书供应商指引为准。

如果申请 OV 或者 EV 证书，流程不同，以证书供应商指引为准。

证书供应商可能交付多种格式：
* `server.pem` PEM 格式的证书（特征为：首行文本`-----BEGIN CERTIFICATE-----`）。下面的部署命令默认采用此格式。
* `server.crt` DER 格式的证书（特征为：文件开头显示数字 `0`，后面是二进制内容（乱码））。部署前需要转换为 PEM 格式。
* `fullchain.cer` 或者 `nginx/server-bundle.pem`，适配了 nginx 的证书链文件。如果没有，需要自行制作。

自己持有的文件（文件名仅供参考）：
* `server.key` 你自己生成的服务器证书私钥。注意 **保密** 存储，部署时需要此文件。
* `server.csr` 你使用私钥签名的证书申请文件。部署期间不需要此文件。

#### 获得 PEM 证书

如果你是 DER 格式，请转换：
``` bash
openssl x509 -inform der -in server.crt -out server.pem
```

命令成功返回码为 `0`，没有显示，如果出现报错：
``` plain
unable to load certificate
139926113482640:error:0D0680A8:asn1 encoding routines:ASN1_CHECK_TLEN:wrong tag:tasn_dec.c:1239:
139926113482640:error:0D07803A:asn1 encoding routines:ASN1_ITEM_EX_D2I:nested asn1 error:tasn_dec.c:405:Type=X509
```
说明此文件不是 `DER` 格式，那么尝试使用 `PEM` 格式加载：
``` bash
openssl x509 -inform pem -in server.crt -out server.pem
```
如果依旧报错，请联系证书供应商获取 PEM 格式的服务器证书。

#### 检查 fullchain 证书
如果你计划使用 ingress-nginx 或者自建 nginx 提供 SSL 服务。需要证书文件包含全部中级 CA 的证书。

如果证书供应商提供了名为 `fullchain.cer` 或者 `nginx/server-bundle.pem` 类似名字的证书，大概率是满足要求的证书。

检查方法：
``` bash
grep "BEGIN CERTIFICATE" fullchain.cer
```
如果显示 2 行（或者更多）内容，说明证书符合要求，可以直接重命名为 `fullchain.pem` 供后续脚本使用：
``` bash
cp fullchain.cer fullchain.pem
```

#### 制作 fullchain.pem
如果没有合格的 fullchain.pem 证书链文件，可以使用如下方法制作。

解析服务器 PEM 证书，提取证书里的中级 CA url 并下载：
``` bash
curl -Lo intermediate.crt $(openssl x509 -in server.pem -noout -text | grep 'Authority Information Access' -A 2 | sed -n '/CA Issuer/s/.*URI://p')
# 将服务器证书和CA证书（一般为二进制 der 格式），写入fullchain.pem
cat server.pem <(openssl x509 -in intermediate.crt -inform der) > fullchain.pem
```

### 自签证书准备流程
自行签发的证书不会产生费用，但是默认不受操作系统信任。需要自行导出 root CA 证书，然后在所有客户端上导入 root CA 证书，并设置“信任此证书”。

操作颇为复杂，不建议尝试，此处仅列出技术要点。

如下表所示，假设有个单独的证书服务器管理证书。然后在中控机发起证书申请，并将签发的证书部署到 ingress。（“--”表示无关联。）

|  | 证书服务器 | 中控机 | ingress | 客户端 |
|--|--|--|--|--|
| root-CA.key | 临时生成，注意 **保密** 存储 | -- | -- | -- |
| root-CA.pem | 临时生成。公开，方便客户端获取证书完成导入 | 从证书服务器获得；部署到 ingress | 存储并使用 | 导入到“系统根证书库”，并信任 |
| server.key | -- | 临时生成，注意 **保密** 存储；部署到 ingress | 存储并使用 | -- |
| server.csr | 读取中控机传递的文件 | 读取 key 填写信息后生成，提交给证书服务器 | -- | -- |
| server.pem | 基于 csr 签发证书；可公开 | 从证书服务器获得；部署到 ingress | 存储并使用 | 浏览器访问蓝鲸时，自动下载证书，在本地找“系统根证书库”校验 |

填写 csr 时，请注意 CN 为蓝鲸主域名（`$BK_DOMAIN`），SAN 填写 `*.$BK_DOMAIN`。

自签证书一般不存在中级 CA，此时可以直接使用 `server.pem`。

## 取得 https 入口
请根据自己的场景选择对应的选项。

### 选项 1: 使用 k8s ingress 作为 https 入口
当前部署文档中，所有的域名都集中在 k8s 集群的 ingress 上。所以由 ingress 来提供 https 入口，是自然而然的选择。

我们使用 ingress-nginx 作为示例，其他类型的 ingress 配置略有不同，见对应 ingress 的官方文档。

ingress-nginx 基于 nginx，要求证书文件提供完整的证书链。需要将所有中级 CA 证书都追加到服务器证书文件结尾。
* 商业证书一般存在中级 CA，请参考上文检查和制作 fullchain.pem。
* 自签证书如果不存在中级 CA，可直接使用 server.pem（下面脚本中的 `fullchain.pem` 可以替换为 `server.pem`）。

服务器证书 key 文件名假设为 `server.key`。

在中控机执行：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
# 从自定义配置中提取, 也可自行赋值
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)
# 创建 BK_DOMAIN 对应的 证书，为了方便维护，secret 名字保持一致
kubectl create secret tls "$BK_DOMAIN" --namespace ingress-nginx --key ./server.key --cert ./fullchain.pem
# 修改 ingress 配置，使用刚才的 证书。
yq -i '.controller.extraArgs.default-ssl-certificate|= "ingress-nginx/'"$BK_DOMAIN"'"' ./environments/default/ingress-nginx-custom-values.yaml.gotmpl
# 使配置生效
helmfile -f 00-ingress-nginx.yaml.gotmpl apply
```

此时 ingress 提供了 HTTPS 入口，可以 `curl` 验证，如果为自签证书，请自行导入根证书。

### 选项 2: 部署 nginx 作为 https 入口
TODO 待用户要求后，补充 nginx 配置项

### 选项 3: 使用腾讯云 CLB 作为 https 入口
TODO 待用户要求后，补充 clb 采购流程及配置项

## 配置蓝鲸启用 https
接下来，告知所有蓝鲸服务启用 https。

### 配置启用 https

``` bash
yq -i '.bkDomainScheme = "https"' environments/default/custom.yaml
yq -i '.config.bkHttpSchema = "https"' environments/default/bkci/bkci-custom-values.yaml.gotmpl
yq -i '.config.bkCiPublicSchema = "https" | .config.bkCodeccPublicSchema = "https"' environments/default/bkci/bkcodecc-custom-values.yaml.gotmpl
```

### 重启服务使 https 生效
#### 重启蓝鲸基础套餐

重启第一批：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=first sync
kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-repo,bk.repo.scope=backend'  # bkrepo 部分 pod 不会重启，主动删除等重建
kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-apigateway,app.kubernetes.io/component in (api-support-fe, dashboard-fe)'  # bk-apigateway 部分 pod 不会重启，主动删除等重建
```
重启第二批：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=second sync
# 持续观察等 bk-repo-repository pod 全部Ready

kubectl get pod -n blueking -l 'app.kubernetes.io/instance=bk-repo,app.kubernetes.io/component=repository' -w
```
然后重启第三批：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=third sync
kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-paas,app.kubernetes.io/name=webfe'  # bk-paas-webfe-web pod 不会重启，主动删除等重建
```
重启第四、五批：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l seq=fourth,fifth sync
 # 如果bk-job sync报错，则把bk-job的migrate job删除后再重新sync
kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-job,app.kubernetes.io/component in (job-file-worker, job-frontend, job-gateway, job-logsvr)'  # bk-job 多个 pod 不会重启，主动删除等重建
```

#### 重启蓝鲸监控日志套餐
``` bash
helmfile -f 04-bkmonitor.yaml.gotmpl sync
helmfile -f 04-bklog-search.yaml.gotmpl
```

#### 重启蓝鲸容器管理平台
``` bash
helmfile -f 03-bcs.yaml.gotmpl sync
```

#### 重启蓝鲸持续集成套餐
``` bash
helmfile -f 03-bkci.yaml.gotmpl sync
```

# 更改访问域名

## 配置域名
修改配置文件 `environments/default/custom.yaml`：
``` yaml
domain:
  bkDomain: 新域名
  bkMainSiteDomain: 新域名
```

## 刷新 coredns
更新 DNS，把旧域名改为新域名：
1. 修改 coredns：
   ``` bash
   EDITOR=vim kubectl edit -n kube-system cm coredns
   ```
2. 修改 中控机 的 DNS 解析或 hosts 文件。
3. 修改 全部 node 的 DNS 解析或 hosts 文件。
4. 修改用户侧 DNS 或者个人 PC 上的 hosts 文件。

## 变更服务
### 变更蓝鲸基础套餐
按批次重启蓝鲸基础套餐。
1. 重启第一批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=first sync
   kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-repo,bk.repo.scope=backend'  # bkrepo 部分 pod 不会重启，主动删除等重建
   kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-apigateway,app.kubernetes.io/component in (api-support-fe, dashboard-fe)'  # bk-apigateway 部分 pod 不会重启，主动删除等重建
   ```
2. 重启第二批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=second sync
   ```
3. 持续观察等 bk-repo-repository pod 全部 `Ready`：
   ``` bash
   kubectl get pod -n blueking -l 'app.kubernetes.io/instance=bk-repo,app.kubernetes.io/component=repository' -w
   ```
   然后重启第三批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=third sync
   kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-paas,app.kubernetes.io/name=webfe'  # bk-paas-webfe-web pod 不会重启，主动删除等重建
   ```
4. 重启第四批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=fourth sync
   kubectl delete pod -n blueking -l 'app.kubernetes.io/instance=bk-job,app.kubernetes.io/component in (job-file-worker, job-frontend, job-gateway, job-logsvr)'  # bk-job 多个 pod 不会重启，主动删除等重建
   ```
5. 重启第五批：
   ``` bash
   helmfile -f base-blueking.yaml.gotmpl -l seq=fifth sync
   ```


### 重新部署 SaaS
1. 完成《[调整 node 上的容器运行时](install-bkce.md#k8s-node-cri-insecure-registries)》文档。
2. 访问蓝鲸桌面，打开 “开发者中心”。如果页面提示 “服务异常”，说明未能成功重启 `bkpaas3-webfe` pod，请再重启一次试试。
3. 在首页选择 SaaS （如“标准运维”），进入 “应用概览” 界面。
4. 如果 SaaS 有配置 “环境变量” 或 “访问入口”，需检查配置项中域名进行更新。“标准运维” 默认无相关配置，可忽略本步骤。
5. 在左侧选择 “应用引擎” —— “部署管理”。切换到 “生产环境” tab，点击“部署至生产环境”。在弹窗中勾选 “总在创建进程实例前拉取镜像”，点击“确定”开始部署。如果未重新部署，则更新入口后，访问应用会报错 “404 Not Found”。
6. 部署 SaaS 的其他模块。点击顶部 “模块” 进行切换，然后重复步骤 5。“标准运维” 还有 3 个模块需要部署。如果未重新部署模块，会导致 SaaS 工作异常。
7. 如有用到“预发布环境”，可一并部署。
8. 在左上角切换应用为 “流程服务”，重复步骤 4-7。其他 SaaS 依此类推。

### 变更增强套餐

如果部署了这些平台，则执行对应的命令重启：
* 容器管理平台：`helmfile -f 03-bcs.yaml.gotmpl sync`，如果提示 `PASSWORDS ERROR`，请参考部署文档修改 helmfile 模板后重试。
* 监控平台：`helmfile -f 04-bkmonitor.yaml.gotmpl sync`。
* 日志平台：`helmfile -f 04-bklog-search.yaml.gotmpl sync`。
* 持续集成平台-蓝盾：`helmfile -f 03-bkci.yaml.gotmpl sync`。


## 配置变更
>**提示**
>
>TODO 此操作并入数据库变更。

1. 节点管理全局配置中，接入点可能配置了域名，请检查替换为新域名，或者改用 IP 端口访问。
2. PaaS 服务实例。使用 `admin` 账户登录蓝鲸桌面，打开 “开发者中心”。然后访问 `http://bkpaas.新域名/backend/admin42/platform/plans/manage`。
   * 编辑 `default-bk-repo` 服务，更新 **方案配置** 字段中 `endpoint_url` 地址中的域名。然后点“确定”保存。

## 数据库变更
历史保存的数据不会变动，需要修改数据库。

>**提示**
>
>MySQL 连接方法见 《[访问入口及账户密码汇总](access.md)》文档，操作前请 **备份数据库**。

>**提示**
>
>如下 SQL 语句中，会包含 `BK_DOMAIN`（**新域名**） 及 `BK_DOMAIN_OLD`（**当前域名**） 等变量，请自行赋值。

1. 修改权限中心的回调 url：
   ``` sql
   SET @BK_DOMAIN_OLD='bkce7.bktencent.com';  -- 当前的域名
   SET @BK_DOMAIN='new-bk7.bktencent.com';  -- 将使用的新域名
   -- 如下内容可直接复制粘贴
   USE bkiam;
   UPDATE saas_system_info SET provider_config = REPLACE(provider_config, @BK_DOMAIN_OLD, @BK_DOMAIN) WHERE provider_config LIKE CONCAT('%', @BK_DOMAIN_OLD, '%');
   ```
2. 变更桌面中的应用访问地址及图标：
   ``` sql
   -- 如果没有退出过mysql shell，可以跳过变量赋值
   SET @BK_DOMAIN_OLD='bkce7.bktencent.com';  -- 当前的域名
   SET @BK_DOMAIN='new-bk7.bktencent.com';  -- 将使用的新域名
   -- 如下内容可直接复制粘贴
   USE open_paas;
   UPDATE paas_app SET external_url = REPLACE(external_url, @BK_DOMAIN_OLD, @BK_DOMAIN) WHERE external_url LIKE CONCAT('%', @BK_DOMAIN_OLD, '%');
   UPDATE paas_app SET logo = REPLACE(logo, @BK_DOMAIN_OLD, @BK_DOMAIN) WHERE logo LIKE CONCAT('%', @BK_DOMAIN_OLD, '%');
   ```
3. 修改 API 网关中记录的 SDK 下载地址：
   ``` sql
   -- 如果没有退出过mysql shell，可以跳过变量赋值
   SET @BK_DOMAIN_OLD='bkce7.bktencent.com';  -- 当前的域名
   SET @BK_DOMAIN='new-bk7.bktencent.com';  -- 将使用的新域名
   -- 如下内容可直接复制粘贴
   USE bk_apigateway;
   UPDATE support_api_sdk SET url = REPLACE(url, @BK_DOMAIN_OLD, @BK_DOMAIN) WHERE url LIKE CONCAT('%', @BK_DOMAIN_OLD, '%');
   ```

## 最终检查
通过后则通知用户访问入口发生变更。
1. 检查 k8s ingress 注册的域名： `kubectl get ingress -A | grep -F 旧域名`，预期结果为空。
2. 使用新域名访问蓝鲸桌面，预期所有应用的图标可正常显示，点击应用也会是新域名的地址。
3. 检查 “权限中心” 能否打开。如果地址栏显示为旧域名，可能遗漏了重启 `bkpaas3-webfe` pod 操作。
4. 检查 “配置平台” 能否打开。如果地址栏显示为旧域名，可能没有变更 `open_paas` 数据库且重启 console pod。
5. 检查 “作业平台” 能否打开，以及历史任务查看有无异常。如果提示 `jobapi.新域名` 访问异常（HTTP 403），可能没有变更 `bkiam` 数据库并重启 job pod。
6. 检查“节点管理”能否正常安装 agent。
7. 检查“标准运维”及“流程服务”能否正常执行任务。
8. 检查其他平台访问是否正常。如果依旧存在旧域名，请在社区反馈。
