#Send WeChat component

BlueKing WeChat messages can be notified through WeChat official account or corporate WeChat.
Before configuring, please read the differences between the 2 methods and then choose one of them for configuration.

| <div style="width:80px">Notification method</div> | User binding | Server configuration where the open_paas module is located | <div style="width:120px">WeChat public platform configuration</div> |
| --- | --- | --- | --- |
| WeChat public account | The user client needs to have an external network or at least be able to access WeChat related links | (1) It must have an external network or be able to access the API provided by WeChat <br> (2) A reverse proxy is required to allow the agent to forward Go to http://{paas_domain}/console/user_center/weixin/mp/callback/| (1) Server configuration<br> (2) Message template configuration |
| Enterprise WeChat | The user client needs to have an external network or at least be able to access WeChat related links | Must have an external network or be able to access the API provided by WeChat | Authorization callback domain configuration |

### Prerequisite preparation

* The server where the BlueKing API gateway is located must be able to access the API provided by WeChat. The relevant domain names are as follows

```
# WeChat public account
https://api.weixin.qq.com

# Enterprise WeChat
https://qyapi.weixin.qq.com
```

* Ensure that the user's client browser can access WeChat related links. The relevant domain names are as follows

```
# WeChat public account
https://mp.weixin.qq.com

# Enterprise WeChat
https://open.work.weixin.qq.com
https://rescdn.qqmail.com
https://js.aq.qq.com
```

### Entry description

* WeChat public account: https://mp.weixin.qq.com/
* Enterprise WeChat: https://work.weixin.qq.com/
* BlueKing user WeChat binding entrance: http://{paas_domain}, Personal Center → WeChat Binding
* BlueKing WeChat component configuration entrance: `BlueKing API Gateway` -> Component Management -> Component send_weixin -> Component Configuration

### 1. WeChat public account

#### WeChat public account → Message template configuration

Please enter the WeChat public platform "Official Account Backstage → Template Message → Template Library"

* Search for "BlueKing News Alert". Only the industry you are in is IT technology and can be searched on the Internet. For other industries, please add templates by yourself. Click to help us improve the template and enter the template library to add (it will take a certain amount of time to review after submission)

![](../../assets/component/reference/15081375626539.jpeg)

![](../../assets/component/reference/15081379473152.jpeg)

* The mapping relationship between BlueKing default template content and BlueKing component parameters and template parameters is shown in the figure below

![](../../assets/component/reference/15081384579344.jpeg)

| Component parameters | WeChat message template parameters |
| -------- | ---------------- |
| heading | first |
| message | keyworkd1 |
| date | keyworkd2 |
| remark | remark |

* If the module library has been added or the template library of "BlueKing Message Notification" has been searched, click on the details to enter the template and add the template. After adding, you will see the added message in "Function → Template Message → My Template" Template, the template ID is what we need for subsequent configuration components

#### WeChat public account → IP whitelist and server configuration

Please first check the official account background on the WeChat public platform → Development → Basic Configuration to see if the server configuration (server address, token, message encryption and decryption key, message encryption and decryption method) has been configured.

![](../../assets/component/reference/15081252708641.jpeg)

##### 1. Basic configuration → IP whitelist

Since the API gateway needs to call WeChat to obtain the AccessToken interface to send WeChat messages, it is necessary to configure the machine IP deployed by the BlueKing API gateway in "Basic Configuration → Public Account Developer Information → IP Whitelist"

##### 2. The server configuration has been configured on the WeChat public platform

Contact the person who has configured the server configuration and ask for his or her assistance in adding the call http://{paas_domain}/console/user_center/weixin/mp/callback/ (transparent transmission of WeChat event push) to the service responded to by the server address (<font style ="color:red">If the port is not 80, paas_domain needs to bring the port. If it is ssl, you need to change http to https</font>)

##### 3. Server configuration is not configured on WeChat public platform

Fill in the server configuration (after filling in, <font style="color:red">do not click submit yet</font>)

* url fill in the URL that can be accessed from the external network (temporarily called weixin_server_url)
At the same time, a reverse proxy needs to be configured to forward weixin_server_url to the enterprise BlueKing platform http://{paas_domain}/console/user_center/weixin/mp/callback/ (<font style="color:red">If the port is not 80, paas_domain needs Bring the port. If it is ssl, you need to change http to https</font>)
* Token is in English or numbers, the length is 3-32 characters, please define it yourself and fill it in randomly
* EncodingAESKey click to generate randomly
* For message encryption and decryption methods, just select plaintext mode (any mode is not affected)

After filling in the server configuration, please <font style="color:red">do not click submit</font>. In fact, submitting is useless. "Token verification failed" will definitely appear, because when you click submit, WeChat will verify that weixin_server_url can work normally. Response verification. Since the BlueKing WeChat message notification component has not been configured yet, it must have failed. Therefore, you need to proceed to the next step "Configuring the BlueKing WeChat message notification component" first, and then return and click Submit (<font style="color: red">Remember to come back and click submit after completing the next step!!!</font>)


#### BlueKing Platform → API Gateway

Visit `BlueKing API Gateway`, under the top navigation menu **Component Management**, click the left menu **Component Management** to open the component management page. Filter out the component `send_weixin` under the system CMSI and click edit:

* wx_type select "WeChat official account"
* wx_app_id ["WeChat Official Account → Development → Basic Configuration → Official Account Development Information"] Developer ID (AppID)
* wx_secret ["WeChat Official Account → Development → Basic Configuration → Official Account Development Information"] Developer password (AppSecret)
   Since it is not displayed, you can ask the administrator who maintains the official account in the company to provide it.
* wx_token ["WeChat Official Account → Development → Basic Configuration → Server Configuration"] Token
* wx_template_id ["WeChat Official Account → Function → Template Message"] Select the template ID of the message template configured in the previous step.

At this point, the configuration of BlueKing sending messages through the official account is completed. Please go to the last step to verify whether the configuration is correct after binding the user.

### 2. Enterprise WeChat

#### Enterprise WeChat configuration

* Configure applications for BlueKing message notifications

"Enterprise WeChat → Application Management" You can select an existing self-built application or create a new one, and set the visibility range of the application to all employees in the enterprise (or at least to those who may need to receive and receive WeChat message notifications)

* Configure Web page login authorization callback domain

"Enterprise WeChat → Application Management → Select the corresponding application → Enterprise WeChat authorized login → Settings → Web page
  →Set authorization callback domain" Set {paas_domain} as the login authorization callback domain (<font style="color:red">If the port is not 80, paas_domain needs to bring the port</font>)

#### BlueKing Platform → API Gateway

Visit `BlueKing API Gateway`, under the top navigation menu **Component Management**, click the left menu **Component Management** to open the component management page. Filter out the component `send_weixin` under the system CMSI and click edit:

* wx_type select "Enterprise WeChat"
* wx_qy_corpid ["Corporate WeChat → My company → Corporate information"] CorpID
* wx_qy_corpsecret【"Enterprise WeChat → Application Management → Select the corresponding application"] Secret
* wx_qy_agentid ["Enterprise WeChat → Application Management → Select the corresponding application"] AgentId

At this point, the configuration of BlueKing sending messages through Enterprise WeChat is completed. Please go to the last step to verify whether the configuration is correct after binding the user.

### User binding

BlueKing Desktop → Personal Center → Bind WeChat

Click "Bind WeChat" and scan to bind.
requires attention:

(1) If it is Enterprise WeChat, the user needs to use the Enterprise WeChat APP to scan

### Other notes

* The reason why the user-bound QR code does not appear

(1) The user client cannot access the external network or cannot access WeChat-related URLs

(2) The server where the BlueKing API gateway is located cannot access the external network or at least cannot request WeChat related interfaces.