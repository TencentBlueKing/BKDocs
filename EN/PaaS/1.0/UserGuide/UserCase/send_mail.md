 # Setting Message Notification: Email 

 Address setting: Enter "Developer Center" role "admin"-> "API Gateway"-> "Channel Manage"-> select system "[CMSI] BlueKing Message Management"-> select "[CMSI] Send Email". 

 ## Component Config 

 - dest_url: If users are not good at using Python, you can provide an API in other languages and fill in dest_url. ESB can only forward the request and get through the email setting 
 - smtp_host: SMTP service address (note that this is different from company mailbox or personal mailbox) 
 - smtp_port: SMTP service port (note the difference between corporate mailbox and personal mailbox). 
 - smtp_user: SMTP service account 
 - smtp_pwd: SMTP service account password (usually a DataToken) 
 - smtp_usessl: default is false 
 - smtp_usetls:Default is false 
 - mail_sender:Default email sender (same as smtp_user) 

 ## Configuration example 

 This example uses QQ mailbox as an example 

 ### 1. Enable SMTP service 

 The SMTP service of QQ mailbox is closed by default. 

 Log in to QQ mailbox, click "Settings"-> Account->find "POP3/SMTP Service" and "IMAP/SMTP Service" in the top navigation bar, and click "Enable". 

 ![-w2020](../assets/noticeWay01.png) 
 <center>Enable Service</center>

 Once enabled, click Generate DataToken. This DataToken will be called smtp_pwd. 

 ### 2. Configure the send_mail component

 [QQ Mailbox SMTP Default Setting](https://service.mail.qq.com/cgi-bin/help?subtype=1&&id=20010&&no=1000557)：. 

 ```bash 
 smtp_host ：smtp.qq.com 
 smtp_port ：465 
 smtp_user: demo@qq.com (Personal QQ email address) 
 smtp_pwd: DataToken 
 smtp_usessl ：True 
 ``` 

 ![-w2020](../assets/noticeWay02.png) 
 <center>Fill in value</center> 

 Submit Revise After Fill 

 ### 3. Testing the API 

 Using the Postman tool request address an example 

 ```bash 
 http://{PaaS_URL}/api/c/compapi/cmsi/send_mail/ 
 ``` 

 ```json 
 { 
    "bk_app_code":"test", 
    "bk_app_secret":"test", 
    "bk_username": "admin", 
    "receiver": "demo@qq.com", 
    "sender": "demo@qq.com", 
    "title": "This is a Test", 
    "content": "<html>Welcome to Blueking</html>" 
 } 
 ``` 
 The sender must match the pipe setting smtp_user 

 ![-w2020](../assets/noticeWay03.png) 
 <center>Test Interface</center> 

 ### 4. Troubleshooting the API 

 1. login to the PaaS machine to view relevant log information 

 ```bash 
 tail -f /data/bkce/logs/open_paas/esb.log 
 ``` 

 2. Check if the port is open 