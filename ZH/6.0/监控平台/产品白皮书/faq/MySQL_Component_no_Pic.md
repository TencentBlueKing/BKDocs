# MySQL 组件监控不出图

1. 检查 MySQL 监听的 IP 是否与填写的目标 IP 一致
2. 检查创建用户所属的 IP 是否与填写的目标 IP 一致
3. 如果 MySQL 监听的是本地 IP，创建用户时请使用 127.0.0.1，避免使用 loccalhost。即`bk@127.0.0.1`而不是`bk@localhost`
