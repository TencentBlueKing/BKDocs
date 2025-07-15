传统产品界面定制需逐个修改，维护成本高。全局配置方案通过统一管理 `base.js` 配置文件，实现：
- 集中维护所有产品界面配置
- 一键部署更新
- 标准化配置格式

配置流程可以分为以下几个阶段：

1. 下载配置文件包
2. 修改配置信息
3. 上传配置文件（这里可选



# 支持产品列表

这是一个新的方案，部分产品还在陆续接入中。目前支持全局配置的产品如下：
* 基础套餐
  * 作业平台
  * 桌面
  * 权限中心
  * 节点管理
  * API 网关
  * 开发者中心
* 容器管理套餐
  * 容器管理平台
* 监控日志套餐
  * 监控平台
  * 日志平台
* 持续集成套餐
  * 持续集成平台（蓝盾）

# 下载配置文件包
启用全局配置功能后，浏览器界面的默认资源均从指定的 url 下载。故需要将默认配置文件放在指定路径。

中控机下载，放入 `$INSTALL_DIR/bk-config` 目录：
``` bash
bkdl-7.2-stable.sh -ur latest bk-config
```

蓝鲸 7.2.3 及以上的版本 也提供了一个便捷的工具脚本 `bk-config-tool.sh`，用于批量编辑和上传 `base.js` 配置文件。

# 上传配置文件模板

你可以将配置文件放在任意 Web 服务器上，维持原始目录结构即可。

## 上传到蓝鲸制品库
蓝鲸制品库可以提供 Web 服务。在上传配置文件包到制品库前，需要提前修改 base.js 里的 url。

### 修改 base.js 里的 url

```bash
# 进入目录
cd $INSTALL_DIR/blueking/
# 设置全量 base.js 文件对应的图片 URL 前缀，默认为制品库域名 `bkrepo.$BK_DOMAIN/generic/blueking/bk-config`
./scripts/bk-config-tool.sh prefix bkrepo all
```

配置成功后参考输出如下：
```
Updated $INSTALL_DIR/bk-config/bk_apigateway/base.js
Updated $INSTALL_DIR/bk-config/bk_bcs/base.js
Updated $INSTALL_DIR/bk-config/bk_ci/base.js
Updated $INSTALL_DIR/bk-config/bk_cmdb/base.js
...
```

### 上传至制品库

将全局配置文件上传至制品库

> 默认上传路径： `"http://bkrepo.$BK_DOMAIN/generic/blueking/bk-config/`

``` bash
./scripts/bk-config-tool.sh bkrepo all
```

上传成功后参考输出如下：
```
upload $INSTALL_DIR/bk-config/bk_apigateway/base.js to /bk_apigateway/ succeed
upload $INSTALL_DIR/bk-config/bk_apigateway/logo.png to /bk_apigateway/ succeed
upload $INSTALL_DIR/bk-config/bk_apigateway/favicon.png to /bk_apigateway/ succeed
...
```

### 查看上传结果

脚本提供命令用于收集 base.js 中的图片URL并生成curl测试命令，也可手动进入制品库页面 `bkrepo.$BK_DOMAIN/generic/blueking/bk-config/` 查看

```bash
./scripts/bk-config-tool.sh remote all
```

## 上传至个人 web 服务器

使用自建 Web 服务器而非蓝鲸制品库托管配置文件时，可参考此方案进行上传。

### 前置准备
1. 确保已安装 Web 服务器
2. 服务器已配置域名解析（可选）
3. 已获取配置文件包（位于`$INSTALL_DIR/bk-config`）

下面提供一个 k8s 启动 web 服务并上传全局配置文件的案例

```yaml
# Kubernetes 临时测试用 Nginx 文件服务器部署方案

# nginx-temp-server.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: temp-file-server
  namespace: blueking
spec:
  replicas: 1
  selector:
    matchLabels:
      app: temp-file-server
  template:
    metadata:
      labels:
        app: temp-file-server
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        ports:
        - containerPort: 80
        volumeMounts:
        - mountPath: /etc/nginx/conf.d
          name: nginx-config
        - mountPath: /var/www/uploads
          name: upload-dir
      volumes:
      - name: nginx-config
        configMap:
          name: nginx-config
      - name: upload-dir
        emptyDir: {}
      - name: auth-file
        secret:
          secretName: basic-auth

---
apiVersion: v1
kind: Service
metadata:
  name: temp-file-server
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
  selector:
    app: temp-file-server

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  bk-config.conf: |
    server {
        listen 80;
        server_name _;
        
        location /upload {
            limit_except GET POST PUT DELETE {
                deny all;
            }
            dav_methods PUT DELETE;
            create_full_put_path on;
            client_max_body_size 100M;
            alias /var/www/uploads;
        }
    }

---
```

### 启动 web 服务
```bash
kubectl apply -f nginx.yaml 
```

### 修改 basejs 里的 url

```bash
./scripts/bk-config-tools.sh prefix http://${node_ip}:30080/upload all
```

配置成功后参考输出如下：
```
Updated $INSTALL_DIR/bk-config/bk_apigateway/base.js
Updated $INSTALL_DIR/bk-config/bk_bcs/base.js
Updated $INSTALL_DIR/bk-config/bk_ci/base.js
Updated $INSTALL_DIR/bk-config/bk_cmdb/base.js
...
```

### 上传至 web 服务器

将全局配置文件上传至个人 web 服务器

```bash
./scripts/bk-config-tools.sh upload http://${node_ip}:30080/upload all
```

上传成功后参考输出如下：
```
upload $INSTALL_DIR/bk-config/bk_apigateway/base.js to /bk_apigateway/ succeed
upload $INSTALL_DIR/bk-config/bk_apigateway/logo.png to /bk_apigateway/ succeed
upload $INSTALL_DIR/bk-config/bk_apigateway/favicon.png to /bk_apigateway/ succeed
...
```

### 查看上传结果

脚本提供命令用于收集 base.js 中的图片URL并生成curl测试命令，也可手动进入制品库页面 `bkrepo.$BK_DOMAIN/generic/blueking/bk-config/` 查看

```bash
./scripts/bk-config-tool.sh remote all
```

# 启用全局配置功能
## 修改配置文件

```bash
# 进入部署目录
cd $INSTALL_DIR/blueking/
# 修改全局 values 配置，自行替换制品库域名
yq -i '.domain.bkSharedResUrl="http://bkrepo.bkce7.bktencent.com/generic/blueking/bk-config"' environments/default/custom.yaml
```


## 重新部署对应产品
```bash
helmfile -f base-blueking.yaml.gotmpl \       # 更新基础套餐
  -l name=bk-apigateway \
  -l name=bk-console \
  -l name=bk-paas \
  -l name=bk-iam-saas \
  -l name=bk-job apply

helmfile -f 03-bcs.yaml.gotmpl apply          # 更新容器管理平台
helmfile -f 04-bkmonitor.yaml.gotmpl apply    # 更新监控平台
helmfile -f 04-bklog-search.yaml.gotmpl apply # 更新日志平台
```

## 登录页面验证

在各个产品页面检查浏览器是否访问 `base.js?callback` 开头的接口则正常完成配置

# 常见问题

TODO
