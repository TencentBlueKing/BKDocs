开发者中心预置了一批编译环境，被称为 `runtimes`。

目前蓝鲸 V7 提供了预编译的 SaaS 包（开发者中心部署应用时，“选择部署分支” 下拉框中标题格式为 `image`），故无需 `runtimes`。

当你基于 PaaS 自行开发应用，或者安装适配 V6 的 S-Mart 源码包（格式为 `package`）时，需要进行编译操作。


# 上传 PaaS runtimes 到制品库
## 安装下载脚本
CentOS 支持在当前用户的 `bin` 目录下安装命令：
``` bash
mkdir -p ~/bin/
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.0-stable/bkdl-7.0-stable.sh -o ~/bin/bkdl-7.0-stable.sh
chmod +x ~/bin/bkdl-7.0-stable.sh
```

### 下载基础文件
一些公共的脚本及资源文件，大约 12MB。
``` bash
bkdl-7.0-stable.sh -C ce7/paas-runtimes -ur paas3-1.0 common
```

### 下载 python 环境
我们推荐下载一些常用的 python 版本及 pip 版本，共约 130 MB。
``` bash
# 下载python
for v in 2.7.18 3.6.8 3.6.12 3.10.5; do
  bkdl-7.0-stable.sh -C ce7/paas-runtimes -r paas3-1.0 python=$v
done
# 这些pip同时提供py2和py3版本。
for v in 9.0.2 19.1.1 20.0.2 20.1.1 20.2.3 20.2.4 20.3.4; do
  bkdl-7.0-stable.sh -C ce7/paas-runtimes -r paas3-1.0 pip-whl-py23=$v
done
# 这些pip仅提供py3版本。
for v in 21.3.1 22.0.4 22.1.2 22.2.2 22.3.1 23.0.1; do
  bkdl-7.0-stable.sh -C ce7/paas-runtimes -r paas3-1.0 pip-whl=$v
done
```

### 下载 nodejs 环境
常见 3 个版本，一共 80MB。
``` bash
for v in 12.16.3 14.16.1 10.10.0; do
  bkdl-7.0-stable.sh -C ce7/paas-runtimes -r paas3-1.0 node=$v
done
```

### 下载 golang 环境
每个版本约 130M，可以下载所需的版本。
``` bash
for v in 1.19.1 1.18.6 1.17.10 1.12.17; do
  bkdl-7.0-stable.sh -C ce7/paas-runtimes -ur paas3-1.0 go=$v
done
```

## 上传文件
在 **中控机** 执行如下命令上传文件到制品库 `bkpaas` 项目下。
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
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

然后使用下载脚本下载指定版本：`bkdl-7.0-stable.sh -C ce7/paas-runtimes -r paas3-1.0 node=14.16.1`。

下载完成后参考 “上传文件” 章节重新上传一次即可。如果下载脚本提示文件 404，可以联系蓝鲸助手排查原因。

# 下一步
回到《[部署基础套餐](install-bkce.md#paas-runtimes)》文档继续阅读。
