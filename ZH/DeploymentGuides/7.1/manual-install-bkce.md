本文包含蓝鲸各组件的部署方法，部署成功后，即可在浏览器访问蓝鲸了。

# 前置步骤
需要先完成：
* [自定义配置](custom-values.md)
* [部署或对接存储服务](storage-services.md)


# 部署蓝鲸
为了并行部署节约时间，我们提前将这些 release 分为了 5 层，依次部署。

接下来会逐层逐 release 讲述部署过程。

**如果部署期间出错，请先查阅 《[问题案例](troubles.md)》文档。**

## 部署 seq=first 的 release
第 1 层包含了 `bk-repo,bk-auth,bk-apigateway` 等 release。
>**提示**
>
>在中控机执行 `helmfile -f base-blueking.yaml.gotmpl -l seq=first sync` 即可并行部署这些 release。

### 部署 bk-apigateway
蓝鲸 API 网关是蓝鲸各组件互通的枢纽。

>**提示**
>
>bk-apigateway-1.12.1 版本支持使用 RabbitMQ 作为 celery 的 broker，推荐在生产环境使用。详细信息见 https://github.com/TencentBlueKing/blueking-apigateway/issues/275

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway sync
```

### 部署 bk-auth
认证服务。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-auth sync
```

### 部署 bk-repo
蓝鲸制品库提供了文件和镜像存储等服务。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-repo sync
```

## 部署 seq=second 的 release
第 2 层包含了 `bk-iam,bk-ssm,bk-console` 等 release。
>**提示**
>
>在中控机执行 `helmfile -f base-blueking.yaml.gotmpl -l seq=second sync` 即可并行部署这些 release。

### 部署权限中心后台
先部署权限中心后台 API。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-iam -l name=bk-ssm sync
```

### 部署 bk-console
蓝鲸桌面。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-console sync
```

## 部署 seq=third 的 release
第 3 层包含了 `bk-user,bk-iam-saas,bk-iam-search-engine,bk-gse,bk-cmdb,bk-paas,bk-applog,bk-ingress-nginx,bk-ingress-rule` 等 release。
>**提示**
>
>在中控机执行 `helmfile -f base-blueking.yaml.gotmpl -l seq=third sync` 即可并行部署这些 release。

### 部署 bk-user
蓝鲸用户管理。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-user sync
```

### 部署权限中心应用
等权限中心后台启动成功后，可以部署应用来管理权限。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-iam-saas -l name=bk-iam-search-engine sync
```

### 部署 bk-gse
蓝鲸管控平台。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-gse sync
```

### 部署 bk-cmdb
蓝鲸配置平台。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-cmdb sync
```

### 部署 PaaS 平台
在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-ingress-nginx -l name=bk-ingress-rule sync
helmfile -f base-blueking.yaml.gotmpl -l name=bk-paas -l name=bkpaas-app-operator -l name=bk-applog sync
```

## 部署 seq=fourth 的 release
第 4 层只包含了 `bk-job` 1 个 release。
>**提示**
>
>在中控机执行 `helmfile -f base-blueking.yaml.gotmpl -l seq=fourth sync` 即可并行部署这些 release。

### 部署 bk-job
作业平台。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-job sync
```

## 部署 seq=fifth 的 release
第 5 层只包含了 `bk-nodeman` 1 个 release。
>**提示**
>
>在中控机执行 `helmfile -f base-blueking.yaml.gotmpl -l seq=fifth sync` 即可并行部署这些 release。

### 部署 bk-nodeman
节点管理。

在中控机工作目录下执行：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-nodeman sync
```

# 访问蓝鲸桌面

<a id="hosts-in-user-pc" name="hosts-in-user-pc"></a>

## 配置用户侧的 DNS
蓝鲸设计为需要通过域名访问使用。所以你需先配置所在内网的 DNS 系统，或修改本机 hosts 文件。然后才能在浏览器访问。

>**注意**
>
>如 k8s 集群重启等原因重新调度，pod 所在 node 发生了变动，需更新 hosts 文件。

你如何访问蓝鲸集群呢？请根据你的场景选择对应的命令获取 IP：
* 你和蓝鲸集群在同一个内网，使用 内网 IP 访问蓝鲸。
  1.  获取 ingress-nginx pod 所在机器的内网 IP，记为 IP1。在 **中控机** 执行如下命令可获取 IP1：
      ``` bash
      IP1=$(kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx \
        -o jsonpath='{.items[0].status.hostIP}')
      ```
* 蓝鲸集群部署在公网，使用 ingress-nginx pod 所在机器的 公网 IP 访问蓝鲸。
  1.  先在 **中控机** 执行如下命令获取 内网 IP：
      ``` bash
      IP1=$(kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx \
        -o jsonpath='{.items[0].status.hostIP}')
      ```
  2.  从中控机登录到 node 上查询公网 IP：
      ``` bash
      IP1=$(ssh "$IP1" 'curl -sSf ip.sb')
      ```
* 蓝鲸集群使用了负载均衡器（包括公网负载均衡）
  1.  需要手动指定负载均衡 IP：
      ``` bash
      IP1=负载均衡IP
      ```
  2.  在负载均衡器配置后端为 ingress-nginx pod 所在机器的内网 IP，端口为 80。

在 **中控机** 执行如下命令生成 hosts 文件的内容：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
# 人工检查取值
echo "BK_DOMAIN=$BK_DOMAIN IP1=$IP1 IP2=$IP2"
if [ -z "$BK_DOMAIN" ] || [ -z "$IP1" ]; then
  echo "请先赋值 BK_DOMAIN 及 IP1."
else
  echo "# bkce7 hosts配置项，ingress-nginx pod所在的主机变动后需更新。"
  cat <<EOF | sed 's/ *#.*//' | scripts/update-hosts-file.sh /etc/hosts /etc/hosts
$IP1 $BK_DOMAIN  # 蓝鲸桌面
$IP1 bkrepo.$BK_DOMAIN  # 蓝鲸制品库
$IP1 docker.$BK_DOMAIN  # 蓝鲸制品库
$IP1 helm.$BK_DOMAIN  # 蓝鲸制品库
$IP1 bkpaas.$BK_DOMAIN  # 开发者中心
$IP1 bkuser.$BK_DOMAIN  # 用户管理
$IP1 bkuser-api.$BK_DOMAIN  # 用户管理
$IP1 bkapi.$BK_DOMAIN  # 开发者中心 API 网关
$IP1 apigw.$BK_DOMAIN  # 开发者中心 API 管理
$IP1 bkiam.$BK_DOMAIN  # 权限中心
$IP1 bkiam-api.$BK_DOMAIN  # 权限中心
$IP1 cmdb.$BK_DOMAIN  # 配置平台
$IP1 job.$BK_DOMAIN  # 作业平台
$IP1 jobapi.$BK_DOMAIN  # 作业平台
$IP1 bknodeman.$BK_DOMAIN  # 节点管理
$IP1 apps.$BK_DOMAIN  # SaaS 入口：标准运维、流程服务等
$IP1 bcs.$BK_DOMAIN  # 容器管理平台
$IP1 bcs-api.$BK_DOMAIN  # 容器管理平台
$IP1 bklog.$BK_DOMAIN  # 日志平台
$IP1 bkmonitor.$BK_DOMAIN  # 监控平台
$IP1 devops.$BK_DOMAIN  # 持续集成平台-蓝盾
$IP1 codecc.$BK_DOMAIN  # 持续集成平台-代码检查
$IP1 lesscode.$BK_DOMAIN  # 可视化开发平台
$IP1 bk-apicheck.$BK_DOMAIN  # apicheck 测试工具
EOF
fi
```

## 添加桌面应用
使用脚本在 admin 用户的桌面添加应用，也可以登录后自行在桌面添加。
``` bash
scripts/add_user_desktop_app.sh -u "admin" -a "bk_cmdb,bk_job"
scripts/add_user_desktop_app.sh -u "admin" -a "bk_usermgr"
```
如果提示 `user(admin) not exists`，说明用户尚未登录，可以忽略此报错。

将用户管理设置为默认应用，新用户登录桌面就可以看到。
``` bash
scripts/set_desktop_default_app.sh -a "bk_usermgr"
```

## 获取 PaaS 登录账户及密码
在 **中控机** 执行如下命令获取登录账户:

``` bash
kubectl get cm -n blueking bk-user-api-general-envs -o go-template='user={{.data.INITIAL_ADMIN_USERNAME}}{{"\n"}}password={{ .data.INITIAL_ADMIN_PASSWORD }}{{"\n"}}'
```
其输出如下：
``` plain
user=用户名
password=密码
```

## 浏览器访问
在 **中控机** 执行如下命令获取访问地址：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
echo "http://$BK_DOMAIN"
```
浏览器访问上述地址即可。记得提前配置本地 DNS 服务器或修改本机的 hosts 文件。


<a id="next" name="next"></a>

# 下一步
准备 SaaS 运行环境。

一共需要准备 3 项：
* [确保 node 能拉取 SaaS 镜像](saas-node-pull-images.md)
* [推荐：上传 PaaS runtimes 到制品库](paas-upload-runtimes.md)
* [可选：配置 SaaS 专用 node](saas-dedicated-node.md)
