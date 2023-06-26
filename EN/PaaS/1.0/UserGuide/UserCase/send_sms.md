 # Setting Message Notification: SMS 

 Address setting:  Enter "Developer Center" with the role "admin"-> API Gateway-> Channel Management-> Select [CMSI] BlueKing Message Management-> Select [CMSI] Send SMS "in the role of" admin ". 

 ## Component Config 

 - dest_url: If users are not good at using Python, you can provide an API in other language and fill in dest_url. ESB can only forward the request and get through the SMS setting 
 - qcloud_app_id: SDK AppID 
 - qcloud_app_key: App key 
 - qcloud_sms_sign:Signature of Tencent Cloud SMS application, for example:Tencent Technology 

 ## Example Component

 This example is based on Tencent Cloud SMS. 

 ### 1. Create signature 

 Enter Tencent Cloud Products-> SMS 

 ![-w2021](../assets/markdown-img-paste-20200403173430929.png) 

 Domestic SMS-> Signature Manage-> Create Signature 

 ![-w2021](../assets/noticeWay06.png) 


 ### 2. create a body template 

 Domestic SMS-> Body TemplateManage-> Create Body Template 

 Template example: {1} is your login verification code, please fill in within {2} minutes.  If not operated by yourself, please ignore this SMS.  (where {1} and {2} are custom content, which must be numbered consecutively starting from 1, such as {1} and {2}) 

 > Note: SMS template content cannot contain [] symbol. 

 ![-w2021](../assets/noticeWay07.png) 

 Template example: Notification "BlueKing Job System" {1} If the information is not subscribed by me, please ignore this SMS. 

 ### 3. Create an Apply 

 Application Management -> Application List-> Create Application 

 ![-w2021](../assets/markdown-img-paste-20200403173623741.png) 

 click on Application Name-> Get SDK AppID and App Key 

 ![-w2021](../assets/markdown-img-paste-20200403173813685.png) 

 ### 4. Set the channel 

 Enter "Developer Center" role "admin"->"API Gateway"->"Channel Management"-> select system "[CMSI] BlueKing Message Management"-> select "[CMSI] Send SMS". 

 ```bash 
 qcloud_app_id：SDK AppID 
 qcloud_app_key：App Key 
 qcloud_sms_sign:Tencent BlueKing 
 ``` 

 Enabled: Yes 

 Send Revise 

 ![-w2021](../assets/markdown-img-paste-20200403172817676.png) 

 Submit Revise after filling 

 ### 5. Testing the API 

 Use the Postman tool request as an example 

 ```bash 
 http://{PaaS_URL}/api/c/compapi/cmsi/send_sms/ 
 ``` 

 ```json 
 { 
    "bk_app_code":"test",
    "bk_app_secret":"test",
    "bk_username": "admin",
    "receiver": "telephone number",
    "content": "[Tencent BlueKing]" BlueKing Job System "notifies you that the task" the_new_role "in the" Assistant "Business Name of BlueKing Operation Platform has been SUCCESSED! pleaseLogin to BlueKing Job System (http://xxxxxx) View detailed information!  If you have not subscribed to this message, please ignore this SMS.  " 
 } 
 ``` 

 ![-w2020](../assets/noticeWay04.png) 
 <center>Test Interface</center> 

 ![-w2020](../assets/noticeWay05.png) 
 <center>Mobile phone received Success</center> 

 ### 6. Troubleshooting the API 

 Log in to the PaaS machine to view relevant log information 

 ```bash 
 tail -f /data/bkce/logs/open_paas/esb.log 
 ``` 

 ### 7、FAQ 

 1、"Message":"Signature format error or signature pending approval" 

 Solution: Please Go to Tencent Cloud SMS-> Domestic SMS-> Body Template Management-> Create Body Template 

 2、"message":"The format of captcha template parameter is error" 

 Solution: Please refer to the text template to approve to send the email. Pay attention to the template parameter position and spacing. 