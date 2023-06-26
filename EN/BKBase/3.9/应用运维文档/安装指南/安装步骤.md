# 安装步骤

## 快速体验部署

部署所有服务(含容器化存储[仅用于体验环境])

可以先使用自动脚本生成配置，并检查是否正确：
```
./scripts/auto_deploy.sh -g
```
​
一键部署体验环境:
```
./scripts/auto_deploy.sh -i all
```

## 分步部署

### 生成配置

使用脚本生成当前环境的自定义配置(`values.yaml`，`keys.yaml`)，并按需进行修改。

```
./scripts/auto_deploy.sh -g
```

如要更换加解密的key，可以使用`./scripts/generate_keys.py`生成，替换到keys.yaml中。

### 定义服务的自定义环境变量(`xxx-values.yaml.gotmpl`)

如定义metadata的资源：
```
cat >> custom/metadata-values.yaml.gotmpl << EOF
resources:
limits:
 cpu: 1
 memory: 2Gi
requests:
 cpu: 1
 memory: 2Gi
EOF
```


### 创建namespace(values.yaml中指定)

flink streaming和dask stream任务提交的namespace需要提前进行创建。
flink streaming namespace变量为 {{ .Values.dataflow.flinkStreaming.namespace }}
dask stream namespace变量为 {{ .Values.dataflow.daskStream.namespace }}
aiops namespace变量为 {{ .Values.aiops.namespace }}

参考命令:
```
kubectl create serviceaccount bkbase
kubectl create clusterrolebinding bkbase --clusterrole=cluster-admin --serviceaccount=default:bkbase
```
​
### 获取token
```
secrets_name=`kubectl get serviceaccounts bkbase -o jsonpath={".secrets[0].name"}`
kubectl get secrets $secrets_name -o jsonpath={".data.token"}|base64 -d
```


### 平台部署

```
helm repo update
​
# 部署bk-base-lite
helmfile -f helmfile_lite.yaml sync
​
# 部署bk-base-runner
helmfile -f helmfile_runner.yaml sync
​
# 部署bk-base-lake
helmfile -f helmfile_lake.yaml sync
​
# --debug可以查看调试日志
# helmfile -f xx destroy 可以卸载
```

## 基础计算平台SaaS部署

使用 "S-mart应用" 方式进行基础计算平台的SaaS(如bk_dataweb-xxx)部署，上传包，进行部署。

### 配置计算平台运行环境
因为前端模块默认只会运行最小后台套件的版本(Lite版本)，需要在SaaS中配置环境变量，指定当前后台运行的版本，前端模块才能正确渲染相关功能。

(如后台部署了Runner套件，将需要设置SaaS环境变量值为：bk-base-runner，如后台部署了Lake套件，将需要设置SaaS环境变量值为：bk-base-lake)

配置当前环境运行版本：
SaaS部署计算平台完毕，进入“开发者中心”->“计算平台”->“应用引擎”->“环境配置”->“环境变量配置”
添加环境变量`BKAPP_PLATFORM`, 值为当前后台运行版本，支持 “bk-base-{lite|runner|lake|aiops}”，点击`保存`
配置完毕，回到当前页面最顶部，发现`重新发布使改动生效`，选择`发布到当前所有环境`，点击完成。

## 部署后置操作

域名解析
以下服务需要进行域名解析，将域名(其值为values.yaml内配置的值)解析到ingress controller对应的地址。

如：
```
jupyter.${BK_DOMAIN}
queryengine.${BK_DOMAIN}
```