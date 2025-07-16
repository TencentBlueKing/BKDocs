# 部署流程引擎服务

## 在中控机使用脚本部署
### 下载安装包
在 **中控机** 运行：
``` bash
bkdl-7.2-stable.sh -ur latest bk_flow_engine
```

### 使用脚本部署
在 **中控机** 运行：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
scripts/setup_bkce7.sh -i flow_engine
```


## 在开发者中心部署
本章节演示另外一种部署方法：在浏览器完成整个部署过程。效果和上文的“脚本部署”是相同的。

### 下载安装包
当浏览器访问“开发者中心”进行部署时，需要提前在浏览器里下载安装包：
| 名字及 app_code | 版本号 | 下载链接 |
|--|--|--|
| 流程引擎服务（bk_flow_engine） | 1.9.6 | https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_flow_engine/bk_flow_engine-V1.9.6.tar.gz |


### 创建应用
在第一次部署时，需要先在 “开发者中心” 点击 “创建应用”，上传刚才的安装包。

具体步骤可以参考 [《部署步骤详解 —— SaaS》文档的“上传安装包”章节](manual-install-saas.md#upload-bkce-saas)。


<a id="deploy-bkce-saas-flow_engine" name="deploy-bkce-saas-flow_engine"></a>

### 部署流程引擎服务（bk_flow_engine）
请参考上文 上传安装包 章节完成应用创建或者安装包更新。

流程引擎服务（bk_flow_engine） **无需额外配置**，所以可以直接在 “部署管理” 界面开始部署。

共有 **两个模块** 需要部署，详细步骤如下：
1. 切换面板到 “生产环境”。
2. 需要先部署 `default` 模块，点击“部署”按钮。
3. 弹出的“选择部署分支”下拉框，会展示最新版本，请注意确认。“镜像拉取策略”选择“`IfNotPresent`”即可。
4. 点击“部署至生产环境”按钮。开始部署，期间会显示进度及日志。
5. 等 `default`模块 **部署成功后**，开始部署 `default-engine` 模块，重复步骤 2-4 即可。
6. 部署成功后，即可点击“访问”按钮了。如果访问出错或者白屏，可能是服务尚未启动完毕，稍等 1 分钟后重试。

>**提示**
>
>部署如有异常，请先查阅《[SaaS 部署问题案例](troubles/deploy-saas.md)》文档。

# 访问流程引擎服务
在蓝鲸桌面，添加应用 “蓝鲸流程引擎服务”，打开即可。

部署脚本已经自动将此应用添加到了 `admin` 用户的 “桌面 1”。

# 使用流程引擎服务

* [产品简介](../../BKFlow/1.8/UserGuide/Introduce/introduce.md)
* [快速入门](../../BKFlow/1.8/UserGuide/QuickStart/quick_start.md)
* [系统接入](../../BKFlow/1.8/UserGuide/SystemAccess/system_access.md)
