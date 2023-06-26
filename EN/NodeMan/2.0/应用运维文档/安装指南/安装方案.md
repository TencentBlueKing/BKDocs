# 安装方案

## SaaS
蓝鲸智云 -\> 开发者中心 -\> S-mart 应用 -\> 上传部署新应用


## 后台
### 初次部署
```bash
# 解压安装包到 /data/src/bknodeman
cd /data/src
tar zxf bknodeman_ee-${version}.tgz

# 执行升级命令
source /data/install/utils.fc
./bkeec sync bknodeman
./bkeec install bknodeman
./bkeec start bknodeman
./bkeec status bknodeman
```


### 升级
```bash
# 替换中控机下面的 /data/src/bknodeman
cd /data/src
rm -rf /data/src/bknodeman
tar zxf bknodeman_ee-${version}.tgz

# 执行升级命令
source /data/install/utils.fc
./bkeec stop bknodeman
./bkeec sync bknodeman
./bkeec install bknodeman
./bkeec start bknodeman
./bkeec status bknodeman
```

