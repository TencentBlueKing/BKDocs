# 如何将蓝鲸可视化开发平台部署起来
蓝鲸可视化开发平台通 S-mart 应用的方式部署在 PaaS3.0 开发者中心上，应用ID为：bk_lesscode。

### 创建应用

通过上传 S-Mart 包的方式创建应用

![上传源码包](../../assets/paas3/bk_lesscoe_upload.png)


上传源码包后，会解析出应用信息如下:

![解析源码包结果](../../assets/paas3/bk_lesscode_info.png)

点击「确认并创建应用」即可创建应用

### 配置环境变量

在部署应用之前, 需要先配置 bk_lesscode 应用运行必须的环境变量

|环境变量名称|描述|
|---|---|
| `PRIVATE_NPM_REGISTRY` | npm镜像源地址, 值按以下模板填写: `${bkrepoConfig.endpoint}/npm/bkpaas/npm/`, 其中 bkrepoConfig.endpoint 为 bkrepo 服务的网关地址 |
| `PRIVATE_NPM_USERNAME` | npm账号用户名, 填写部署 PaaS3.0 时配置的 `bkrepoConfig.lesscodeUsername` |
| `PRIVATE_NPM_PASSWORD` | npm账号密码, 填写部署 PaaS3.0 时配置的 `bkrepoConfig.lesscodePassword ` |
| `BKAPIGW_DOC_URL` | 云 API 文档地址，填写部署 API 网关时，生成的环境变量 APISUPPORT_FE_URL 的值 |

在 bk_lesscode 应用页中, 点击 「应用引擎」-「环境配置」中配置npm相关环境变量，生效环境选择`所有环境`, 配置后的效果如图：

![配置环境变量](../../assets/paas3/bk_lesscode_vars.png)


### 配置独立域名

在「应用引擎」-「部署管理」页面部署应用。

在部署完 bk_lesscode 应用预发布环境和正式环境后，还需要给应配置独立域名。目前 bk_lesscode 只支持通过独立域名来访问。

在 bk_lesscode 应用页中, 点击 「应用引擎」-「访问入口」中配置独立域名。

注意: 需要保证配置的域名在企业内网中内正确解析至 「IP信息」 中的 `域名解析目标IP`
