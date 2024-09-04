# 升级 django-celery 规避重连风险 

## 背景

首先，请检查你的应用是否满足以下条件：
- 使用了 django-celery 。注意是使用了 django-celery，如果你只是使用了 celery ，则不满足条件
- 使用了 beat 进程执行定时任务或周期任务
- django-celery 的版本小于 `3.2.1`

如果你的应用有任意一条不满足以上条件，那么恭喜你，你的应用并没有重连风险，文章后面的内容也可以跳过了。
反之，如果所有条件都满足，那么请留意以下内容。

由于较老版本的 django-celery 模块不支持重连机制，所以一旦后端 DB 有正常的服务切换，就会造成应用层的不可用，具体表现为 celery 日志中会出现类似如下内容：

```bash
OperationalError(2006, 'MySQL server has gone away')
```

## 解决方案

大部分使用 PaaS3.0 创建的应用，默认是没有重连风险的，但如果你手动切换到了老版本的 django-celery ，或者是从 PaaS2.0 迁移而来，那么你需要一些操作来规避重连风险。

首先，你需要修改 requirements.txt

```bash
django-celery>=3.2.1
celery>=3.1.15,<4.0
```

然后，由于变更版本，会有一次无用的 DB 变更，你需要在 `bin/post_compile` 中修改 migrate 脚本，以忽略这次 DB 变更：

```bash
python manage.py migrate --fake djcelery 0001_initial
```

接着提交并部署，从部署日志中确保新版本的 django-celery 已经安装成功。最后在下次部署之前，要记得把 `bin/post_compile` 中的 `migrte`后面的内容 及时删除。

