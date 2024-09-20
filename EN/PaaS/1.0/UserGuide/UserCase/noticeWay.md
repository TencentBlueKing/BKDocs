 # How to set up notification channels such as Email, WeChat, SMS, etc.? 

 BlueKing has built-in notification channels for email and WeChat. You can enter "Developer Center"->"API Gateway"->"Guide"->"WeChat Message Components" as "admin". You can refer to the detailed tutorial for the setting.  The setting belongs to the general configuration of the whole BlueKing system. 

 ![-w2020](../assets/17401.png) 
 <center>Notification Channel Setting Entry</center> 

 Tips: 

 The software is privately deployed for internal use within the company. The company need to provide existing notification channels such as email, WeChat and SMS. 

 1. Email: You can use an existing email account. 

 2. WeChat: You can apply for an account on the official WeChat website. BlueKing does not provide public account. Please make sure you can visit [weixin.qq.com](https://weixin.qq.com/). 

 3. SMS: Tencent Cloud's SMS channel is provided by default, and you need to purchase Tencent Cloud's SMS service. 

 The three notification channels all provided a page setting mode, without Secondary development; If you want to revise, you can make coding adjustments in the background. 

 ![-w2020](../assets/17402.png) 
 <center>Notification Channel API</center> 

 Click on the parameter information display at the bottom of "Send Email". 

 ![-w2020](../assets/17403.png) 
 <center>Email Channel Setting Parameters Chart</center>

 - dest_url: If users are not good at using Python, you can provide an API in other languages and fill in dest_url. ESB can only forward the request and get through the email setting 

 - smtp_host: SMTP service address (note that this is different from company mailbox or personal mailbox) 

 - smtp_port: SMTP service port (note the difference between corporate mailbox and personal mailbox). 

 - smtp_user: SMTP service account (same as mail_sender) 

 - smtp_pwd: SMTP service account password (usually a DataToken) 

 - smtp_usessl:(default is 1) 

 - mail_sender: default email sender (same as smtp_user) 

 Click the parameter information display at the bottom of "Send WeChat message". 

 ![-w2020](../assets/17404.png) 
 <center>WeChat channel setting parameter diagram</center>