# 在YAML文件中添加通知

通过顶级关键字 notices 配置流水线执行完成通知

# notices

流水线执行完成通知
值格式为： Array<Notice>
属性如下:

| |
|:--|
|**属性** |**值格式** |**说明** |**备注** |
|type |String |通知类型，目前支持如下三种通知：<br>email：邮件<br>wework-message：企业微信TIPS消息通知，由【Stream消息通知】统一通知<br>wework-chat：企业微信群消息 | 
|content |String |消息内容<br>非必填，缺省时使用系统内置消息模板<br>可以使用 ci、variables等上下文 |当发送企业微信消息时，可以使用 markdown 语法（非完整MD支持：[在企业微信消息中使用MD语法](https://developer.work.weixin.qq.com/document/path/90236#%E6%94%AF%E6%8C%81%E7%9A%84markdown%E8%AF%AD%E6%B3%95)） |	
|title |String |消息标题，当 type=email 时可以指定。<br>非必填，缺省为 <repo>(<分支名>) - <流水线> #<构建号> run failed/success/canceled<br>可以使用 ci、variables等上下文 | 
|receivers |Array<String> |消息接收人，当 type=email   wework-message 时可以指定<br>非必填，缺省为流水线触发人<br>可以使用 ci、variables等上下文 | 
|ccs |Array<String> |邮件抄送人，当 type=email 时可以指定<br>非必填<br>可以使用 ci、variables等上下文 | |
|chat-id |Array<String> |企业微信会话ID，当 type=wework-chat 时可以指定 |将服务号“Stream消息通知”加到群里，@Stream消息通知 会话ID，即可获得 |
|if |String |条件执行当前步骤，非必填，支持如下条件：<br>- FAILURE，当失败时执行<br>- SUCCESS，当成功时执行<br>- CANCELED，当取消时执行<br>- 缺省等同于 ALWAYS，总是执行 |不支持自定义变量 |	 


## 示例1，使用系统默认模板发送邮件、企业微信通知

 ```
version: v3.0

steps:
- run: echo "hello world"

notices:
- type: email
- type: wework-message
```

 
## 示例2，自定义通知内容、收件人、标题等信息

 ```
version: v3.0

on:
  push: [ master ] 

steps:
- run: echo "hello world"
    
notices:
- type: email
  title: this is a email notice
  content: this is a email notice,content is hello.
  receivers:
    - user1
    - user2
  ccs:
    - user3
  if: FAILURE
- type: wework-message
  title: this is a wework-message notice
  content: this is a wework-message notice,content is hello.
  receivers:
    - user1
    - user2
```

