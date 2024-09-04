# 蓝鲸应用如何安装 apt 包

>有时候应用依赖一些需要 apt 安装的软件，比如 mysql-dev 之类。应该如何处理呢？


在蓝鲸应用部署的机制限制下，这个是个颇有难度的需求。简单来说，蓝鲸应用只需要进行一次构建，然后将运行环境迁移到多个容器来完成部署。

有些应用尝试在 `pre-compile` 或 `post-compile` 进行装包：

```bash
apt-get install -y some-package
```

构建的核心要求是环境可迁移部署，apt 包的安装也需要满足这个要求，这样是不能应用到最终运行的容器的。

为了解决这个问题，蓝鲸 PaaS 平台提供了一个定制镜像和提供 apt 装包能力的构建工具。



### Aptfile

用户需要**在代码根目录使用 *Aptfile* 来描述所需安装的包**，每个依赖占一行：

```
libssl-dev
```

相当于：

```bash
apt-get install -y libssl-dev
```

也可以指定 url 来下载安装，因为无法甄别安全性，请勿随便安装不可信的包，同样也是一个依赖单独一行：

```
http://radosgw.example.com/paas-assets/buildpacks/apt/deb-packages/z-libc-bp-fix.deb
```

相当于：

```bash
wget http://radosgw.example.com/paas-assets/buildpacks/apt/deb-packages/z-libc-bp-fix.deb
dpkg -i z-libc-bp-fix.deb
```

上面的依赖写进一个 *Aptfile* 应该是这样的：

```
libssl-dev
http://radosgw.example.com/paas-assets/buildpacks/apt/deb-packages/z-libc-bp-fix.deb
```

#### 安装 libmysqlclient-dev 方式
添加以下内容到 Aptfile：
```
http://radosgw.example.com/paas-assets/buildpacks/apt/deb-packages/z-libc-bp-fix.deb
libssl-dev
libc6-dev
default-libmysqlclient-dev
```


### 使用 Apt 构建工具

进入应用引擎绑定支持多个构建工具基础镜像 *Ubuntu18（蓝鲸版）* 和对应的构建工具 *安装系统包*。

**构建工具会逐个进行构建，因此需要注意构建工具选择的顺序**，比如为了在 python 构建时能够使用 apt 安装的一些系统依赖，安装系统包必须要位于 python 环境之前：

另外，构建时和部署后路径可能会有差异，不要使用绝对路径使用 apt 安装的命令，Apt 构建工具会保证系统变量 `PATH` 的准确性。


### 如何调试 Aptfile
有很多时候，我们并不能一下子确定要安装哪些依赖，反复推送代码部署会耗费大量的精力和时间，这里给出一个本地模拟线上环境的方法。
1. 使用 docker 拉取镜像：`heroku/heroku:18` ;
2. 启动调试容器：
```shell
docker run --rm -ti heroku/heroku:18 bash
```
3. 在容器中安装需要的依赖，确定环境正确性：
```shell
apt-get update
apt-get install my-requirement
```
4. 把依赖写入到 Aptfile：
```
my-requirement
```

#### 如何确定缺少的依赖
一般来说，我们可以通过依赖的文档或者网上搜索来提前确定需要的依赖，但是因为依赖的复杂性，我们往往捕获到报错才知道缺少了依赖，比如以下报错：
> libcrypto.so.10: cannot open shared object file: No such file or directory

那么，我们怎么确定哪个依赖提供了这个文件呢？
1. 使用 docker 拉取镜像：`heroku/heroku:18` ;
2. 启动调试容器：
```shell
docker run --rm -ti heroku/heroku:18 bash
```
3. 安装依赖文件搜索命令 `apt-file`：
```shell
apt-get update
apt-get install -y apt-file
```
4. 查找需要的文件：
```shell
$ apt-file find libcrypto.so
android-libboringssl: /usr/lib/x86_64-linux-gnu/android/libcrypto.so.0
android-libboringssl-dev: /usr/lib/x86_64-linux-gnu/android/libcrypto.so
libssl-dev: /usr/lib/x86_64-linux-gnu/libcrypto.so
libssl1.0-dev: /usr/lib/x86_64-linux-gnu/libcrypto.so
libssl1.0.0: /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0
libssl1.1: /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1
```

注意，`apt-file` 会列出所有含有指定文件的依赖，但并不代表所有依赖都可用，因此最好逐个进行安装确认最终需要的依赖。