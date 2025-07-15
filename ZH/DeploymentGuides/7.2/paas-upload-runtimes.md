开发者中心预置了一批编译环境，被称为 `runtimes`。

目前蓝鲸 V7 提供了预编译的 SaaS 包（开发者中心部署应用时，“选择部署分支” 下拉框中标题格式为 `image`），故无需 `runtimes`。

当你基于 PaaS 自行开发应用，或者安装适配 V6 的 S-Mart 源码包（格式为 `package`）时，需要进行编译操作。


# 上传 PaaS runtimes 到制品库

## 下载默认开发环境
>**提示**
>
>本章节内容已于 2024-11-13 更新了 Go SDK 相关内容，请按需更新。

### 下载基础文件
一些公共的脚本及资源文件，大约 12MB。
``` bash
bkdl-7.2-stable.sh -C ce7/paas-runtimes -ur paas3-1.5 common
```

### 下载开发框架模板
>**提示**
>
>已于 2025-6-18 更新了 Go SDK ，请重新下载并上传。
>

不同 sdk 对应的语言版本

``` bash
# 下载 python 开发框架模板(支持 3.6.12 3.10.5 3.11.10 版本，默认下载 3.6.12 版本)
bkdl-7.2-stable.sh -C ce7/paas-runtimes -ur paas3-1.5 pysdk
# 下载 node 开发框架模板(默认下载 12.16.3 版本)
bkdl-7.2-stable.sh -C ce7/paas-runtimes -ur paas3-1.5 nodesdk
# 下载 golang 开发框架模板(支持 1.22.12 1.23.8 1.24.2 版本，默认下载 1.22.12 版本)
bkdl-7.2-stable.sh -C ce7/paas-runtimes -ur paas3-1.5 gosdk
```

## 扩展下载
如果默认语言版本不满足需求，可以下载其他版本。如下示例包含了我们提供的常见版本，未收录版本可以联系蓝鲸助手添加。

### 下载 python 环境
我们推荐下载一些常用的 python 版本及 pip 版本，共约 130 MB。
``` bash
# 下载 python
for v in 2.7.18 3.6.8 3.6.12 3.10.5 3.11.10; do
  bkdl-7.2-stable.sh -C ce7/paas-runtimes -r paas3-1.5 python=$v
done
# 这些 pip 同时提供 py2 和 py3 版本。
for v in 9.0.2 19.1.1 20.0.2 20.1.1 20.2.3 20.2.4 20.3.4; do
  bkdl-7.2-stable.sh -C ce7/paas-runtimes -r paas3-1.5 pip-whl-py23=$v
done
# 这些 pip 仅提供 py3 版本。
for v in 21.3.1 22.0.4 22.1.2 22.2.2 22.3.1 23.0.1; do
  bkdl-7.2-stable.sh -C ce7/paas-runtimes -r paas3-1.5 pip-whl=$v
done
```

### 下载 nodejs 环境
常见 4 个版本，一共 100MB。
``` bash
for v in 10.10.0 12.16.3 14.16.1 16.16.0; do
  bkdl-7.2-stable.sh -C ce7/paas-runtimes -r paas3-1.5 node=$v
done
```

### 下载 golang 环境
每个版本约 130M，可以仅下载所需的版本。
``` bash
for v in 1.12.17 1.17.10 1.18.6 1.19.1 1.20.14 1.22.3 1.22.12 1.23.8 1.24.2; do
  bkdl-7.2-stable.sh -C ce7/paas-runtimes -ur paas3-1.5 go=$v
done
```

## 上传文件
在 **中控机** 执行如下命令上传文件到制品库 `bkpaas` 项目下。
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
# 从 bk-repo secret中的 BLOBSTORE_BKREPO_CONFIG 变量读取账户信息并设置变量 PROJECT ENDPOINT USERNAME PASSWORD
source <(kubectl get secret -n blueking bkpaas3-apiserver-bkrepo-envs -o json | jq -r '.data.BLOBSTORE_BKREPO_CONFIG|@base64d|gsub(", ";"\n")|gsub("[{}]";"")')
# 搜索文件列表上传
while read filepath; do
  bucket="${filepath#../paas-runtimes/}"
  bucket="${bucket%%/*}"
  remote="/${filepath#../paas-runtimes/*/}"
  remote="${remote%/*}/"
  scripts/bkrepo_tool.sh -u "$USERNAME" -p "$PASSWORD" -P "$PROJECT" -i "$ENDPOINT/generic" -n "$bucket" -X PUT -O -R "$remote" -T "$filepath"
  sleep 1
done < <(find ../paas-runtimes/ -mindepth 2 -type f)
```

>**提示**
>
>重复运行此脚本时，可能提示文件已经存在导致上传失败，为正常情况。参考输出如下：
>``` json
>upload ../paas-runtimes/bkpaas3-platform-assets/common/buildpack-stdlib/v7/stdlib.sh to /common/buildpack-stdlib/v7/ failed
>http response is: {
>  "code" : 251012,
>  "message" : "Node [/common/buildpack-stdlib/v7/stdlib.sh] existed",
>  "data" : null,
>  "traceId" : "略"
>}
>```

上传完成后，可前往 bkrepo 系统检查上传的文件：
使用 admin 账户登录蓝鲸桌面，添加应用 “制品库”，然后打开。

切换到 bkpaas 项目，在仓库列表中找到 `bkpaas3-platform-assets` 仓库。逐层展开子目录，即可看到上传的资源。


## 如何补充 runtimes
上面列举了一些常用的版本，如果你需要部署的 S-Mart 包引用了旧版本的 runtimes，请参考如下方式排查依赖的版本。

下载 runtimes 都会请求制品库，我们可以分析下制品库 `bkpaas` 项目下的 404 请求：
``` bash
kubectl logs -n blueking deploy/bk-repo-bkrepo-generic generic | awk '/ \/bkpaas\/.*HTTP\/[0-9.]+" 404/{sub(/  .*(GET|HEAD) /,"  "); sub(/".*/, "");print}' | tail
```
默认仅展示最后 10 条记录，可以检查部署时间后的文件名。例如显示的文件名为 `node-v14.16.1-linux-x64.tar.gz`，表示需要 node ，版本为 `14.16.1`。

然后使用下载脚本下载指定版本：`bkdl-7.2-stable.sh -C ce7/paas-runtimes -r paas3-1.5 node=14.16.1`。

下载完成后参考 “上传文件” 章节重新上传一次即可。如果下载脚本提示文件 404，可以联系蓝鲸助手排查原因。

# 下一步
继续完善 SaaS 运行环境：
* [可选：配置 SaaS 专用 node](saas-dedicated-node.md)

也可以直接开始部署 SaaS：
* [部署步骤详解 —— SaaS](manual-install-saas.md)

如果是从快速部署文档跳转过来，可以 [回到快速部署文档继续阅读](install-bkce.md#paas-runtimes)。
