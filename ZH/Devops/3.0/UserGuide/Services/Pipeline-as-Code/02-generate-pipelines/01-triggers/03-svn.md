# 监听 SVN 代码库事件


 ```
on:
  # 关联到BK-CI代码库服务下的代码库别名
  repo-name: isd/isd_autotest_rep/att_proj
  type: svn
  push:
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
  manual: enabled
```

repo-name：关联到BK-CI代码库服务下的代码库别名