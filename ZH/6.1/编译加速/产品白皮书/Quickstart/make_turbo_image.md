# 制作加速环境镜像
[TOC]

在拥有[基础系统镜像](make_base_image.md)的前提下，我们可以根据 turbo 包中给到的二进制的脚本，来制作加速镜像。

## 1 制作 linux 下的加速镜像

### 1.1 获取二进制和配置文件

在 turbo 的包中，获取加速服务二进制文件和其配置文件

得到目录`bk-dist-worker`(bk_dist/handler/cc/tools/docker)，其中包含文件如下
* config_file.json 配置文件
* start.sh 启动脚本
* bk-dist-worker 二进制文件

config_file.json
```json
{
  "address": "0.0.0.0",
  "port": 30811,
  "debug": true,
  "v": 3,
  "default_work_dir":"./default_work_dir"
}
```

start.sh
```bash
#! /bin/bash

echo "---env---"
env
echo "---------"

cd /data/bcss/bk-dist-worker

# make log-dir if not exists.
if [[ ! -d "./logs" ]];then
    mkdir ./logs
fi

# make module executable.
chmod +x bk-dist-worker

if [[ ! -z $RAND_PORT_SERVICE_PORT ]]; then
   PORT_SERVICE_PORT=$RAND_PORT_SERVICE_PORT
fi

port=$PORT_SERVICE_PORT
if [[ -z $port ]]; then
   echo "PORT_SERVICE_PORT should not be empty"
   exit 102
else
   echo "PORT_SERVICE_PORT is ${port}"
   export BK_DIST_PORT_4_WORKER=${port}
fi

echo "BK_DIST_MAX_PROCESS_4_WORKER=${BK_DIST_MAX_PROCESS_4_WORKER}"
echo "BK_DIST_WHITE_IP=${BK_DIST_WHITE_IP}"

source ~/.bashrc
./bk-dist-worker -f config_file.json > ./logs/bk-dist-worker.log 2>&1 &

sleep 10s

while true; do
   worker_num=$(ps -ef | grep -F "bk-dist-worker" | grep -v grep | wc -l)
   if [[ $worker_num == "1" ]]; then
      echo "There is no worker process running"
      exit 201
   fi
   sleep 1s
done
```

bk-dist-worker 二进制从 turbo 包中获取

### 1.2 制作加速镜像

Dockerfile
```dockerfile
FROM __BASE_IMAGE__

COPY ./bk-dist-worker/* /data/bcss/bk-dist-worker/

RUN chmod a+x /data/bcss/bk-dist-worker/start.sh

CMD ["sh", "-c", "/data/bcss/bk-dist-worker/start.sh"]
```

其中`__BASE_IMAGE__`替换为基础系统镜像

执行制作镜像

```bash
docker build . -t target:tag
```

然后上传结果镜像到镜像 hub 中，并将镜像添加到 turbo 配置中。

## 2 制作 windows 下的镜像
在 turbo 的包中，获取加速服务二进制文件和其配置文件

得到目录`bk-dist-worker`(bk_dist/handler/ue4/tools/docker)

将 bk-dist-worker.exe 放入 bk-dist-worker 文件夹中

执行制作镜像

```bash
docker build -f Dockerfile_pure_drived -t target:tag
```