# 部署(Release)阶段钩子

## 什么是部署(Release)阶段钩子?

平台提供了 3 个 "hooks" 让用户可以在部署新版本应用时执行自定义脚本, 其中在部署(Release)阶段前执行的 "hooks", 我们称之为部署前置命令。

要像了解部署(Release)阶段钩子, 我们先来看看部署的过程。
基于源码构建的蓝鲸应用的部署过程分为两个阶段：
- build 阶段，从源码包构建可运行实体（简称 `slug.tgz`）
- release 阶段，由 `slug.tgz` 部署成应用实例

以 Django 应用为例, Django 使用 migrations 声明了数据库的变更历史, 如果在某一时刻有多个进程同时执行 `migrate` 操作时, 此时数据库的状态则是不可预料的, 因此平台提供了「部署(Release)阶段钩子」用于执行具有以下特征的任务:
- 需要在 release 阶段之前完成，例如数据库变更
- 不可并发执行

## 如何使用部署(Release)阶段钩子？

在平台的「部署管理」-「部署配置」页面中可配置「部署前置命令」。

注意:
- 「部署前置命令」不能以 `start ` 开头
- 「部署前置命令」只能是一条可执行的命令
- 「部署前置命令」将使用 exec 进行进程切换, 需要保证第一个参数存在并且具有可执行权限

## 示例
```bash
python manage.py migrate --no-input
```

当在平台中配置上述「部署前置命令」, 那么将在 release 阶段前执行 migrate 操作，从而保证了数据库是最新的结构。   

## FAQ

### 与构建后置命令的区别？
1. 执行的环境不同
「构建后置命令」运行于构建容器, 该命令在应用构建成功后立刻执行，可操作 `slug.tgz` 以外的文件, 例如构建过程中生成的临时文件等。
「部署前置命令」运行于独立的容器, 与 release 阶段的容器环境一致。

2. 定义规则不同
「构建后置命令」定义于用户代码的 `bin/post-compile` 文件。
「部署前置命令」与用户代码无关, 开发者可于平台的「部署配置」中配置。

> 基于镜像部署的蓝鲸应用的部署过程只有 release 阶段。

### 如何执行多条命令？

一般而言, 「部署前置命令」只能是一条可执行的命令, 但是并未意味着只能执行一条命令。

#### 简单的命令
对于多条简单命令而言, 可以使用 bash -c 作为引导, 绕过该限制, 例如:
```bash
bash -c "cd backend && python manage.py migrate --no-input"
```

上述命令将切换工作目录到 backend, 随后执行 migrate 操作。

#### 复杂的命令
对于复杂的命令, 为了避免字符转义和环境变量渲染带来的问题, 建议在用户代码中创建脚本(如 `bin/pre-release`)封装相应的命令, 例如:

1. 配置「部署前置命令」为 `./bin/pre-release`

2. 用户代码中创建 `bin/pre-release` 文件, 并授予可执行权限(可参考: chmod +x bin/pre-release)   

```bash
#!/bin/bash
set -e
pip install s3cmd==2.0.0


cat >> ~/.s3cfg <<EOF
# Setup endpoint

host_base = ${CEPH_RGW_HOST}
host_bucket = ${CEPH_RGW_HOST}
bucket_location = us-east-1
use_https = False

# Setup access keys
access_key = ${CEPH_AWS_ACCESS_KEY_ID}
secret_key = ${CEPH_AWS_SECRET_ACCESS_KEY}

# Enable S3 v4 signature APIs
signature_v2 = False
EOF

s3cmd put ...
```

上述命令可利用 s3cmd 命令上传静态文件到对象存储服务, 实现静态资源托管。
