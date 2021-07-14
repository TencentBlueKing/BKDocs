# Lesscode 部署指引

## 使用范围

6.0.4 之前版本（不含 6.0.4 ）

## 说明

下述操作均在中控机操作，且所述路径均为蓝鲸默认路径，实际操作过程中，请以实际为准。

## 解压软件包

将下载好的 lesscode 放置 /data 目录

```bash
tar xf /data/lesscode-ce-0.0.11.tar.gz -C /data/src/
```

## 分布模块

将 lesscode 模块加入 install.config 文件

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

## 生成 MySQL 登陆信息

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
# 映射的 IP 为  nginx 所在机器的外网 IP
10.0.0.2 lesscode.bktencent.com
```

完成 hosts 配置后，访问蓝鲸 PaaS 工作台即可。
