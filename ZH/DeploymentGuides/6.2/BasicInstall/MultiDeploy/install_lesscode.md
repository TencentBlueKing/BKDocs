# 可视化开发平台（lesscode）安装指引

## 使用范围

6.0.4 之前版本（不含 6.0.4 ，6.0.4 基础套餐默认包含）

## 说明

- 下述操作均在中控机操作，且所述路径均为蓝鲸默认路径，实际操作过程中，请以实际为准。
- 如果使用的是新机器进行部署可视化开发平台，请先根据 [新机器初始化](../../MaintenanceManual/DailyMaintenance/scale_node.md) 进行操作。

## 下载软件包

### 下载 lesscode 软件包

前往 [蓝鲸 S-mart 市场](https://bk.tencent.com/s-mart/market) 下载 Lesscode 软件包。并将下载好的 lesscode 放置 /data 目录

```bash
tar xf /data/lesscode-ce-0.0.11.tar.gz -C /data/src/
```

### 下载 lesscode 依赖包

```bash
cd /data/src
wget https://nodejs.org/download/release/v14.17.0/node-v14.17.0-linux-x64.tar.gz
```

## 分布模块

将 lesscode 模块加入 install.config 文件

如基础环境主机资源有富余（lesscode 占用内存 150M 左右），可复用基础环境的机器，反之请按下述操作新增机器分布模块。

```bash
# 请以实际分布的 IP 为准
{
echo ""
echo "10.0.0.6 lesscode" 
} >> /data/install/install.config
```

## 定义 lesscode 域名

**注意：** lesscode 的域名需要定义成与 PaaS 一致的根域名。

例如：PaaS 的域名为 `paas.bk.bktencent.com`，那么 lesscode 就需要为：`lesscode.bk.bktencent.com`。

```bash
# 以蓝鲸默认域名为例
{
echo "BK_LESSCODE_PUBLIC_ADDR=lesscode.bktencent.com:80"
echo "BK_LESSCODE_PUBLIC_URL=http://lesscode.bktencent.com:80"
} >> /data/install/bin/03-userdef/lesscode.env

```

## 生成环境变量

生成 lesscode 所需的环境变量

```bash
cd /data/install
./bkcli install bkenv

./bkcli sync common
```

**说明：** 如果是全新的机器需要做如下操作

```bash
source /data/install/utils.fc
pcmd -m lesscode "bash /data/install/bin/init_new_node.sh"
```

## 生成 MySQL 登录信息

```bash
./bkcli install mysql
```

## 部署 lesscode

```bash
./bk_install lesscode
```

## 访问 lesscode

- 绑定本地 hosts

```bash
# 映射的 IP 为 nginx 所在机器的外网 IP
10.0.0.2 lesscode.bktencent.com
```

完成 hosts 配置后，访问蓝鲸 PaaS 工作台即可看到【可视化开发平台】。
