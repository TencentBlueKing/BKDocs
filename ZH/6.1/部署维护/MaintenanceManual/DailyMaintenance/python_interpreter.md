# 蓝鲸 Python 运行环境简介

蓝鲸的 Python 项目分为后台直接部署的服务和通过 S-mart 应用使用 Docker 部署的 SaaS。它们运行时使用的 Python 环境有所差异，本文档描述
这些 Python 运行环境安装部署和配置的细节。安装和使用遇到和解释器相关的问题，请先仔细阅读本文档作为前提。

> 说明：本文提及的 `./` 开头的文件路径均相对于脚本和安装包解压的同级目录，默认为 /data

## 后台 Python 项目运行环境

后台部署直接部署的服务使用的 Python 解释器来源于蓝鲸安装包的 `./src/python/` 目录，文件列表为：

- py27.tgz: 原生 python2 解释器，版本号为`2.7.10`
- py27_e.tgz：加密 python2 解释器，版本号为`2.7.91`
- py36.tgz: 原生 python3 解释器，版本号为`3.6.10`
- py36_e.tgz: 加密 python3 解释器，版本号为`3.6.61`
- python27_requirements.txt: python2 解释器编译安装后，通过 pip 附加安装的基础 pip 包依赖列表
- python36_requirements.txt: python3 解释器编译安装后，通过 pip 附加安装的基础 pip 包依赖列表
- MD5: 以上 6 个文件的 md5sum 值
- VERSION: python/ 目录的整体版本号

从压缩包到解压到对应机器的 `/opt/` 下，主要由 `./install/install.sh` 文件中定义的 `install_python ()` 函数完成:

- 先将 `./src/python/` 目录四个压缩包从中控机同步到指定模块对应的服务器的 `./src/python/` 目录
- 解压四个压缩包到 `/opt/` 目录
- 在 `./install/.installed_module` 文件中追加 `python` 标记该机器已经安装了蓝鲸 Python 解释器

安装 Python 后台项目时，会利用 [virtualenv](https://virtualenv.pypa.io/en/latest/) 创建不同的虚拟环境来隔离。创建虚拟环境时具体使用 /opt/ 下哪个解释器，根据项目情况，有所区别。这些在模块DetailInstall中会提及，这里主要描述通用逻辑。

一般部署 Python 工程的步骤如下：

1. 根据 Python 解释器创建虚拟环境
2. 在虚拟环境中安装依赖的 pip 包
3. 设定启动脚本使用虚拟环境中的 Python 解释器

前两步为了复用，使用一个独立的脚本 `./install/bin/install_py_venv_pkgs.sh`，它的参数如下：

```bash
$ ./bin/install_py_venv_pkgs.sh -h
用法: 
    install_py_venv_pkgs.sh [ -h --help -?  查看帮助 ]
            [ -n, --virtualenv  [必选] "指定virtualenv名字" ]
            [ -w, --workon-home [可选] "指定WORKON_HOME路径，默认为$HOME/.virtualenvs" ]
            [ -p, --python-path [可选] "指定python的路径，默认为/opt/py27/bin/python" ]
            [ -a, --project-home [可选] "指定python工程的家目录" ]
            [ -s, --pkg-path    [可选] "指定本地包路径" ]
            [ -r, --req-file    [必选] "指定requirements.txt的路径" ]
            [ -e, --encrypt     [可选] "指定的python解释器为加密解释器" ]
            [ -v, --version     [可选] 查看脚本版本号 ]
```

几个参数的默认取值为：

- `-n` 指定虚拟环境的名字，规则是 模块名-子工程名，例如 PaaS 模块下的 esb 工程，虚拟环境名为 `open_paas-esb`
- `-w` 指定 WORKON_HOME (虚拟环境安装的家目录），蓝鲸固定为 `$BK_HOME/.envs`，对于社区版，默认是 `/data/bkce/.envs`。virtualenvwrapper 系列脚本会读取的环境变量，比如 `workon open_paas-esb` 这个命令，就会加载 `/data/bkce/.envs/open_paas-esb/bin/activate` 来激活虚拟环境
- `-p, --python-path` 指定虚拟环境依据的解释器路径。
- `-a` 指定工程的家目录。便于 `workon xxxx` 后就直接切换目录到该路径。譬如 `workon open_paas-esb` 后，会自动切换当前目录到 `/data/bkce/open_paas/esb/` 下。
- `-r` 指定工程的 requirments.txt 路径，pip 会根据它来安装依赖包。
- `-s` 指定离线 pip 包的安装目录。假如安装环境没有网络，需要通过它指定离线 pip 包的目录。
- `-e` 指定 `-p` 对应的 Python 解释器是否加密解释器。加密解释器创建虚拟环境时参数略由差异

还是以 open_paas 的 esb 工程为例，安装时调用的完整参数为：

```bash
./install/bin/install_py_venv_pkgs.sh -e -p /opt/py27_e/bin/python2.7_e \
    -n open_paas-esb \
    -w /data/bkce/.envs -a /data/bkce/open_paas/esb \
    -s /data/bkce/open_paas/support-files/pkgs \
    -r /data/bkce/oppen_paas/esb/requirements.txt
```

## SaaS 使用的 Docker 运行环境

安装包中的 `./src/image/` 目录下是 SaaS 运行的 docker 镜像和依赖的解压工具二进制：

- python27e_1.0.tar: 运行 python2 的 SaaS 使用的镜像
- python36e_1.0.tar: 运行 python3 的 SaaS 使用的镜像 
- runtool: 加密 SaaS 包的解压工具
- MD5: 以上三个文件的 md5sum
- VERSION: image/ 目录的版本号

该目录在 `./install/bkcli sync appo` 和 `./install/bkcli sync appt` 时同步到对应机器上。

然后通过脚本 `./install/bin/install_docker.sh`（新版本更名为 install_docker_for_paasagent.sh）来导入。

这两个 docker 镜像构建的 Dockerfile 如下：

1. python27e_1.0.tar 对应的 Dockerfile：

    ```bash
    FROM centos:7

    ENV PYTHON_VERSION=2.7.9 \
        PATH=/cache/.bk/env/bin/:$PATH \
        PYTHONUNBUFFERED=1 \
        PYTHONIOENCODING=UTF-8 \
        LC_ALL=en_US.UTF-8 \
        LANG=en_US.UTF-8 \
        PIP_NO_CACHE_DIR=off

    RUN mkdir -p /cache/.bk/ \
    	&& yum install -y bind-utils procps-ng gcc git svn mysql iproute mailcap sysvinit-tools \
    		bzip2-devel db4-devel gdbm-devel glibc-devel libcurl-devel libevent-devel \
    		libpcap-devel libxml2-devel mysql-devel openssl-devel pcre-devel \
    		readline-devel sqlite-devel tk-devel xz-devel zlib-devel \
    	&& yum clean all 
    ADD output/python27_e.tar.gz /cache/.bk
    COPY requirements.txt /opt

    RUN pip install -r /opt/requirements.txt && \
        pip install pytest-runner==2.8  && \
        pip install django-guardian==1.4.8 && \
        pip install 'cryptography>=1.1'
    ```

2. python36e_1.0.tar 对应的 Dockerfile 如下：

    ```bash
    FROM centos:7

    ENV PYTHON_VERSION=3.6.6 \
        PATH=/cache/.bk/env/bin:$PATH \
        PYTHONUNBUFFERED=1 \
        PYTHONIOENCODING=UTF-8 \
        LC_ALL=en_US.UTF-8 \
        LANG=en_US.UTF-8 \
        PIP_NO_CACHE_DIR=off

    RUN mkdir -p /cache/.bk/ \
    	&& yum install -y bind-utils procps-ng gcc git svn mysql iproute mailcap sysvinit-tools \
    		bzip2-devel db4-devel gdbm-devel glibc-devel libcurl-devel libevent-devel \
    		libpcap-devel libxml2-devel mysql-devel openssl-devel pcre-devel \
    		readline-devel sqlite-devel tk-devel xz-devel zlib-devel \
    	&& yum clean all 
    ADD output/python36_e.tar.gz /cache/.bk/

    RUN pip install uWSGI==2.0.13.1 && \
        pip install supervisor==4.1.0
    ```

3. Dockerfile 中 ADD 命令添加的两个加密解释器的包的格式，是根据后台的加密解释器包，通过一定脚本的格式转化来兼容开发框架的习惯。比如镜像中安装目录是固定为`/cache/.bk/`。转化脚本如下：

    ```bash
    #!/bin/bash

    SELF_DIR=$(readlink -f "$(dirname "$0")")
    PKG_DIR=${SELF_DIR}/output

    tmpdir=$(mktemp -d /tmp/python.build.XXXX)
    trap 'rm -rf $tmpdir' EXIT 

    orig_tgz=$1
    [[ -r $orig_tgz ]] || { echo "Usage:$0 <tgz>"; exit 1; }

    tar -xf $orig_tgz -C $tmpdir/
    version=$(cd $tmpdir && ls)

    grep -lr /opt/py $tmpdir/$version/bin/ | xargs sed -i "s,/opt/$version/,/cache/.bk/env/,g"

    cd $tmpdir/$version/bin/
    if [[ -e ./python3.6 ]]; then
        ln -sf ./python3.6 python
    fi
    cd $tmpdir/ && mv $version env && tar -czf $PKG_DIR/$(basename $orig_tgz) env
    ```

## 加密解释器特殊说明

如果某个 Python 项目代码加密，使用的是加密解释器时，直接运行 python 脚本是会报错的。处理方式如下：

以运行 paas 的 esb 项目的脚本为例：

```bash
# 切换到esb虚拟环境
workon open_paas-esb

# 设置环境变量
export BK_FILE_PATH=/data/bkce/open_paas/cert/saas_priv.txt

# 运行脚本
python manage.py
```

Python3 项目的虚拟环境已经使用加密解释器后，如果需要安装或者更新 pip 包，需要注意：

1. 切换到虚拟环境

    ```bash
    workon <venv_name>
    ```

2. 判断 pip 命令使用的 python 解释器的版本号

    ```bash
    eval $(head -1 $(which pip) | sed 's/\#\!//') --version
    ```

3. 根据版本号输出，假设是加密解释器版本(3.6.61)，需要修改 pip 文件为原生解释器的路径。

    ```bash
    sed -i "1s,bin/python[0-9. ]*$,bin/python3.6," $(which pip)
    ```
