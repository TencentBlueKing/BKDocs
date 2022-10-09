# 社区版 6.x PaaS 替换 开源 PaaS

社区版 6.x 替换开源 PaaS 指引

## 备份 open_paas 目录
```bash
mv /data/src/open_paas /data/src/open_paas_bak
```
## 替换蓝鲸社区版 open_paas

由于社区版 6.0 以及 6.1 使用的 python 版本存在差异，所以在替换时需要根据自身环境的版本来决定替换的分支。

### 社区版 6.0.x

6.0.x 使用 [develop](https://github.com/Tencent/bk-PaaS/tree/develop) 分支 代码进行替换
```bash
cp -a /opt/bk-PaaS-develop/paas2 /data/src/open_paas/

# 修改 default.py 的标识，将 BK_PAAS_EDITION 的默认值修改为 ce
vim /data/src/open_paas/paas/conf/default.py +32

# 修改后的内容如下
EDITION = os.environ.get("BK_PAAS_EDITION", "ce")
```

### 社区版 6.1

6.1 版本使用 [ft_upgrade_py3](https://github.com/Tencent/bk-PaaS/tree/ft_upgrade_py3) 分支 代码进行替换

```bash
cp -a /opt/bk-PaaS-ft_upgrade_py3/paas2 /data/src/open_paas/
```

## 下载离线包

```bash
source /data/install/utils.fc

PKGS_DIR=$BK_PKG_SRC_PATH/open_paas/support-files/pkgs/
cd "$BK_PKG_SRC_PATH"/open_paas ||exit 1

if ! [[ -d "${BK_PKG_SRC_PATH}" ]]; then
    mkdir -p "$PKGS_DIR"
fi

find ./ -type f -name "requirements.txt" -print0 | xargs -n1 -I {} /opt/py36_e/bin/pip download -r {} -d $PKGS_DIR
```

## 还原 open_paas 相关文件

```bash
rsync -a --exclude="pkgs" /data/src/open_paas_bak/support-files/  /data/src/open_paas/support-files/
rsync -a /data/src/open_paas_bak/esb/components/*  /data/src/open_paas/esb/components/
cp -a /data/src/open_paas_bak/esb/lib/gse /data/src/open_paas/esb/lib/
cp -a /data/src/open_paas_bak/cert /data/src/open_paas/
cp -a /data/src/open_paas_bak/projects.yaml /data/src/open_paas/
cp -a /data/src/open_paas_bak/apigw /data/src/open_paas/
```

## 开始部署开源版 PaaS

```bash
./bkcli sync paas
./bkcli install paas
./bkcli restart paas
```