## 安装脚本及配置文件 {#script_config}

**安装脚本**

使用 sample 文件 **(install.config.new.sample)** 在已部署环境的 `install.config` 新增如下示例模块：

```bash
[bcs-web]
10.0.0.4 bcs(web_console),bcs(cc),bcs(monitor),mysql01(bcs),thanos(query),devops(navigator)
10.0.0.5 bcs(grafana),devops(pm),harbor(api),harbor(server),thanos(rule)
```

> 注意：
> 1. zk(config), zk01(bcs)  属于两个不同的集群实例，用01，02等数字区域，生成的环境变量则统一通过标签区分
> 2. bkdata 有三个工程，可以如上图所示填在一行，也可以填写到不同的行，根据主机数量自行分配。monitor 和 databus 比较占资源
> 3. devops(navigator)  和  harbor(server) 不能配置到相同的主机上
> 4. bcs-server 部分的 etcd， zk，mongodb 都需要加上 bcs 标签识别。写法为：服务名(标识名)，如： etcd(bcs)
