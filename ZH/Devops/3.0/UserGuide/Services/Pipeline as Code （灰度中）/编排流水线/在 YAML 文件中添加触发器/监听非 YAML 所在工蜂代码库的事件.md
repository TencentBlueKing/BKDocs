# 监听非YAML所在工蜂代码库的事件

```
摘要：本文介绍了如何在YAML文件中监听非YAML文件所在代码库的事件。首先，需要在YAML中指定目标代码库的别名并关联代码库。接下来，通过添加不同事件的属性字段（如push、mr、review等），可以分别设置触发器名称、监听分支、排除分支、监听路径、排除路径、包含人员和排除人员等参数。示例中关联的代码库别名为mingshewhe/webhook_test3，类型为内网工蜂的git代码库。 
```

监听非YAML文件所在代码库的事件需在YAML中指定目标代码库的别名以及代码库类型，关联代码库的操作请参考[【OAUTH/SSH/用户名+密码 关联Git代码库】](https://iwiki.woa.com/p/40633240)，关联完成后即可在代码库界面选中代码库别名添加至YAML中，属性字段为**on.repo-name**，同时指定代码库类型**type=git**，代码库类型对应关系如下


| |
|:--|
|**类型** |**域名** |**备注** |
|git |- [git.woa.com](http://git.woa.com/)<br>- [git.code.oa.com](http://git.code.oa.com/) (已废弃) |内网工蜂代码库 |
|tgit |- [git.tencent.com](http://git.tencent.com/)<br>- [git.code.tencent.com](http://git.code.tencent.com/) |合作版/社区版工蜂代码库 |
|github |- github.com |需提前安装 [github app](https://github.com/apps/tencent-blueking-devops)，否则流水线可能无法正常触发 |
|p4 |- 域名不固定，以项目实际地址为准 |perforce代码库 |
|svn |- [svn.woa.com](http://svn.woa.com/)<br>- [sh.svn.woa.com](http://sh.svn.woa.com/)<br>- [cd.svn.woa.com](http://cd.svn.woa.com/)<br>- [tc-svn.tencent.com](http://tc-svn.tencent.com/)<br>- [bj-svn.tencent.com](http://bj-svn.tencent.com/)<br>- [bj-scm.tencent.com](http://bj-scm.tencent.com/)<br>- [sh-svn.tencent.com](http://sh-svn.tencent.com/)<br>- [gz-svn.tencent.com](http://gz-svn.tencent.com/)<br>- [cd-svn.tencent.com](http://cd-svn.tencent.com/)<br>- [svn-cd1.tencent.com](http://svn-cd1.tencent.com/) |仅支持内网工蜂svn代码库，暂不支持合作版svn（svn.tencent.com） |



以下分别以push、mr、cr、tag、Issue、note事件进行举例说明，YAML中各字段介绍及规则可参考[【在YAML文件中添加触发器 】](https://iwiki.woa.com/p/4009967228)


# PUSH 事件

 ```
on:
- manual: enabled
  # 关联到蓝盾代码库服务下的代码库别名
- repo-name: mingshewhe/webhook_test3
  # 内网工蜂
  type: git
  # push事件
  push:
  	# 触发器名称
    name: Git事件触发
  	# 监听以下目标分支
    branches:
    - ""
  	# 排除以下目标分支
    branches-ignore:
    - ""
  	# 监听以下路径
    paths:
    - ""
  	# 排除以下路径
    paths-ignore:
    - ""
  	# 包含以下人员
    users:
    - ""
    # 排除以下人员
    users-ignore: 
    - ""
```
 
# MR 事件

 ```
on:
  # 关联到蓝盾代码库服务下的代码库别名
  repo-name: mingshewhe/webhook_test3
  # 内网工蜂
  type: git
  mr:
  	# 触发插件名
    name: Git事件触发
  	# 监听以下源分支
    source-branches:
    - "feat_*"
  	# 排除以下源分支
    source-branches-ignore:
    - "master"
    # 监听以下目标分支
    target-branches:
    - "master"
    # 排除以下目标分支
    target-branches-ignore:
    - ""
    # 监听以下路径
    paths:
    - "src/main"
    # 排除以下路径
    paths-ignore:
    - ""
  	# 包含以下人员
    users:
    - ""
    # 排除以下人员
    users-ignore: 
    - ""
    # 锁定提交
    block-mr: false
```

# CR 事件

 ```
on:
  # 关联到蓝盾代码库服务下的代码库别名
  repo-name: mingshewhe/webhook_test3
  # 内网工蜂
  type: git
  review:
  	# 触发插件名
    name: Git事件触发
  	# 监听以下CR状态
    states:
    - approved
    - approving
    - change_denied
    - change_required
```

# Tag 事件

 ```
on:
  # 关联到蓝盾代码库服务下的代码库别名
  repo-name: mingshewhe/webhook_test3
  # 内网工蜂
  type: git
  tag:
  	# 触发插件名
    name: Git事件触发
  	# 监听以下tag
    tags:
    - v2.*
  	# 排除以下tag
    tags-ignore:
    - v3.*
    # 来源分支(git客户端创建的tag不会含带创建分支的信息，这种情况下创建的tag无法监听目标分支)
    from-branches:
    - master
  	# 包含以下人员
    users:
    - ""
    # 排除以下人员
    users-ignore: 
    - ""
```

# Issue 事件

 ```
on:
  # 关联到蓝盾代码库服务下的代码库别名
  repo-name: mingshewhe/webhook_test3
  # 内网工蜂
  type: git
  issue:
  	# 触发插件名
    name: Git事件触发
    # 监听一下Issue动作
    action:
    - close
    - reopen
    - open
    - update
```
# Note 事件

 ```
on:
  # 关联到蓝盾代码库服务下的代码库别名
  repo-name: mingshewhe/webhook_test3
  # 内网工蜂
  type: git
  note:
  	# 触发插件名
    name: Git事件触发
  	# 监听以下评论类型
    types:
    - commit
    - merge_request
    - issue
  	# 监听以下评论内容
    comment:
    - note.*
    - test.*
```