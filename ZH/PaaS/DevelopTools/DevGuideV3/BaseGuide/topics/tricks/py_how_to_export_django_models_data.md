# 如何导出数据


## 前言

这篇技巧指引，目前只针对 Django 应用，如果其他框架没有类同的数据导出命令，请联系蓝鲸助手咨询详情。

其他需要注意的：
- 本方法只适用于**少量数据(<10MB)**导出，数据量大的请联系蓝鲸助手处理
- 如果只需要导出某些 table 而非全库，请参考 [django dumpdata 文档](https://docs.djangoproject.com/en/3.2/ref/django-admin/#dumpdata-app-label-app-label-app-label-model) 添加参数
- 由于 `post_compile` 是在部署过程中执行，数据量将会影响部署的速度。在完成数据导出操作之后，请记得恢复 `post_compile` 文件。

## 具体步骤

### Step 0: 申请 Ceph 对象存储

增强服务 -> 数据存储 -> 对象存储(Ceph) -> 启用

### Step 1: 在 post_compile 中导出

正如大家已知的，`post_compile` 本质就是 bash 脚本，所以我们可以将导出逻辑直接写在里面，示例:
```bash
# export logic start

# export via django commands
# refer to https://docs.djangoproject.com/en/3.2/ref/django-admin/#dumpdata-app-label-app-label-app-label-model
python manage.py dumpdata > dumps.json

# upload to s3
s3cmd put dumps.json --host $CEPH_RGW_HOST --secret_key $CEPH_AWS_SECRET_ACCESS_KEY --access_key $CEPH_AWS_ACCESS_KEY_ID --acl-public s3://$CEPH_BUCKET
```

### Step 2: 从对象存储下载

假设上面例子中，应用为内部版，且 CEPH_BUCKET 为 `bkapp-test-stag`。

### Step 3: 添加到版本库，并导入到其他环境 (可选)

如果你还需要将这份数据导入到其他环境，例如 stag -> prod 或者 prod -> stag，那么你需要将这份 json 文件添加到版本库**根目录**，并且在 post_compile 时添加导入逻辑

```bash
python manage.py loaddata dumps.json
```

## 注意事项

数据使用完毕之后，记得将数据使用 s3cmd 从 ceph 删除

