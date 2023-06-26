# 性能调优

## 服务端性能
### 调整内存限额
在安装时限制每个微服务的内存为 `256mb~512mb`。如果您的机器装备了更大的内存，可以调整限额。

方法：
1. 进入微服务的安装目录。此处以 `dispatch-docker` 服务为例：
   ``` bash
   cd $BK_HOME/ci/dispatch-docker/
   ```
2. 修改微服务目录下的 `start.env` 文件，添加或更新 `MEM_OPTS` 配置项。模板文件为 `service.env`文件，随 CI 版本更新而更新，请勿修改。 例如
    ```bash
    # grep MEM_OPTS service.env
    MEM_OPTS="-Xms256m -Xmx512m"
    # grep MEM_OPTS start.env
    MEM_OPTS="-Xms384m -Xmx768m"
    ```
3. 重启微服务。
   ```bash
   systemctl restart bk-ci-dispatch-docker
   ```
4. 使用 `ps` 命令检查内存限额是否生效：
   ```bash
   # ps aux | grep dispatch-docker
   blueking  7238  309  1.6 6801664 530212 ?      Sl   12:45   0:34 java -server -Dfatjar=/dispatch-docker/boot-dispatch-docker.jar -Ddevops_gateway=bk-ci.service.consul -Dserver.port=21938 -Dbksvc=bk-ci-dispatch-docker -Xms384m -Xmx768m com.tencent.devops.dispatch.docker.DispatchDockerApplicationKt
   ```

## 构建机启动
目前构建机（公共构建机及无编译环境）启动时默认连接到 Docker Hub 拉取构建镜像。

### registry mirror
Docker Hub 官方自 2020 年 11 月起对镜像拉取频率进行了限制（[官方公告点此](https://www.docker.com/increase-rate-limits)）。
如果遇到了 `ERROR: toomanyrequests: Too Many Requests.` 报错，请自备 Docker Hub 账户。

推荐在内网部署 Docker Hub 镜像站缓存。请参考官方文档：[https://docs.docker.com/registry/recipes/mirror/](https://docs.docker.com/registry/recipes/mirror/)

### 私有 docker registry
推荐使用 Harbor 建设私有 docker registry: [https://github.com/goharbor/harbor](https://github.com/goharbor/harbor)

并转存蓝盾官方构建镜像到私有 Registry。以便提升加载速度。

## 构建提速
### 内网代码库
从公网拉取代码的速度较慢，请建设内网代码库。

进阶方案为部署 Git Cache Proxy Server，请自行研究。

### 内网软件源镜像
在内网提供软件源可以大幅缩减构建时的公网带宽开销及下载时间。

推荐使用清华大学开源的镜像同步系统: [https://github.com/tuna/tunasync](https://github.com/tuna/tunasync)
