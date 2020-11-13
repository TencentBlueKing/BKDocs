# 企业微信审批接入流程

## 情景

在故障替换等高危场景中，微信审批功能可以把控风险。

## 前提条件

- 企业微信号一个，[点击注册](https://work.weixin.qq.com/wework_admin/register_wx?from=wxqy_register)。

- 蓝鲸故障自愈 APP 已经正常运行。

- 外网域名一个，能代理访问到故障自愈 APP weixin api(可通过 nginx，apache 等)，下面以 mycompany.com 做示例。

- 若是已有企业微信，注意需要企业微信管理员才能进入企业微信后台。

## 操作步骤

- 1. 配置企业微信

- 2. 配置故障自愈

- 3. 自愈测试

微信审批分两种，一种是回复指令审批，适合组合套装中的【通知或审批】套餐，还有一种需要在微信页面审批(通过菜单进入)，适合告警收敛的【异常防御需审批】。这些都需要一个企业微信应用为载体，下面以故障自愈应用为例，指引接入审批流程，相关参数可按照配置自行修改。

## 配置企业微信

### 新建应用

- 入口：企业微信后台管理页面 -> 应用中心 -> 自建应用-> 新建应用

- 操作步骤：
点击创建应用，选择消息型应用，上传自己 LOGO，填写应用名称，请根据人员选择可见范围，点击提交完成。
    - 名称填写：故障自愈
    - 功能介绍：一套帮助业务全自动的发现告警、分析告警、自动恢复故障的服务。

截图示例如下：
![Alt text](../assets/1494574167873.png)

注意：可见范围，请务必保证审批管理员，业务管理员可见。

### 配置回调参数

此模式适用指令回复审批

- 入口： 应用中心 -> 故障自愈 -> 模式选择|回调模式

- 操作步骤：
在对应栏填写下面的默认值即可
    - URL：http://mycompany.com/o/bk_fta_solutions/wechat/entry/
    - Token：FTAToken
    - EncodingAESKey：FTAEncodingAESKeyFTAEncodingAESKey923456781

截图示例如下：

![Alt text](../assets/1495508733324.png)

> 注意：上面 TOKEN 和 EncodingAESKey 都是默认参数，请在 APP 配置后，务必修改 Token 和 EncodingAESKey

### 配置审批菜单

此模式适合收敛审批。

- 入口：应用中心  ->  故障自愈  ->  模式选择|回调模式  ->  自定义菜单|设置

- 操作步骤：
    - 点击右边+号按钮，输入名称后，事件类型为调整到网页，输入跳转地址完成，
    - 点下右下方保存按钮后，发布即可，菜单会在 5 分钟内生效。
    - 菜单名称：审批列表
    - 跳转链接：http://mycompany.com/o/bk_fta_solutions/wechat/todo/

截图示例如下：

![Alt text](../assets/1495508805368.png)

完成后，企业微信接入就完成了， 下一步需要把生成的 token 等配置到自愈 APP 中。

## 配置故障自愈

配置完 APP 后，才能发送审批消息，对于一些特殊处理的静态资源路径，API 路径，也需要在这里配置。

- 入口：admin 页面：http://mycompany.com/o/bk_fta_solutions/doc/wechat_config/
- 也可以通过后台 admin 页面右上角->微信审批配置进入。

- 配置页面示例如下：

![Alt text](../assets/1495527861556.png)

下面对每个配置项详解。

- 微信端地址(外网可访问)：
填写外网能访问的域名，url 到 wechat/结束，如上面的域名应该填写：
> http://mycompany.com/o/bk_fta_solutions/wechat/

- 微信端静态资源地址(外网可访问)：
默认即可，如果 nginx 做了路径映射，或者使用 CDN，需要填写绝对路径，如：
> /static/wechat/ (默认)
> http://mycompany.com/o/bk_fta_solutions/static/wechat/ (绝对路径，适合 nginx 做了路径映射，或者 CDN 场景)

- TOKEN 和 EncodingAESKey：
TOKEN 对应第二步中，配置回调参数中的 Token。注意，如果这里修改，在上面配置也需要同步修改
EncodingAESKey 对应第二步中，配置回调参数中的 EncodingAESKey，注意，如果这里修改，上面配置也需要同步修改，长度固定为 43 个字符

- CorpID 和 Secret 需要在企业号中获取，入口在设置->权限管理中，如果没有，新建一个管理组即可。

![Alt text](../assets/1495527151654.png)

- 微信消息的 Agent_ID：
Agent_ID 在创建完企业号应用就可以获取到，在应用中心->故障自愈，进入即可看到

![Alt text](../assets/1495527228622.png)

- 审批管理员
审批管理员是一个组超级用户，可以接受到任意审批消息，也可以审批任意的收敛审批。填写对应的名称，以逗号分隔即可。

> 注意，名称是已经在企业微信注册的用户。

## 自愈测试

- 创建审批套餐

![Alt text](../assets/20181211121143.png)

- 在接入自愈流程中，告警类型选择 REST 默认分类，这里选择 REST 默认分类是为了方便触发告警，实际使用过程中，请根据自己实际需求选择告警类型。

![Alt text](../assets/20181211123915.png)

- 触发告警

完整流程请参照 [REST API 推送](../functions/REST_API_PUSH_Alarm_processing_automation.md)。

- 审批套餐执行详情

![Alt text](../assets/201812112115.png)

微信审批，降低高危告警处理的风险。


