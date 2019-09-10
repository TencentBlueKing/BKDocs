## MySQL组件监控不出图

1. 检查mysql监听的IP是否与填写的目标IP一致
2. 检查创建用户所属的IP是否与填写的目标IP一致
3. 如果mysql监听的是本地IP，创建用户时请使用127.0.0.1，避免使用loccalhost。即`bk@127.0.0.1`而不是`bk@localhost`


