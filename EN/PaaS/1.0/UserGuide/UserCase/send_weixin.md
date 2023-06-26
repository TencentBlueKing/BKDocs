 # Set message notification: WeChat Message 

 Address setting: Enter "Developer Center" with the role "admin"-> "API Gateway"-> "Channel Management"-> select system "[CMSI] BlueKing Message Management"-> select "[CMSI] Send WeChat Message" 


 ## WeCom 


 ### Component Config 

 - dest_url: If users are not good at using Python, you can provide an API in other languages and fill in dest_url. ESB can only forward the request and get through the voice message setting. 
 - qcloud_app_id: SDK AppID 
 - qcloud_app_key: App key 

 ### Components Example 


 #### 1. creating an application 

 #### 4. set up the channel 

 Enter "Developer Center" with the role "admin" -> "API Gateway" -> "Channel Management" -> select system "[CMSI] BlueKing Message Management" -> select "[CMSI] Public Voice Notification". 

 ```bash 
 qcloud_app_id：SDK AppID 
 qcloud_app_key：App Key 
 ``` 

 Enabled: Yes 

 Submit Revise 

 ![-w2021](../assets/2020040720315877.png) 

 Submit Revise after filling in 

 #### 5. Testing the API 

 Use the Postman tool request as an example 

 ```bash 
 http://{PaaS_URL}/api/c/compapi/cmsi/send_voice_msg/ 
 ``` 

 ```json 
 { 
    "bk_app_code":"test", 
    "bk_app_secret":"test", 
    "bk_username": "admin", 
    "auto_read_message":"BK Monitor Notification, xxxx Task fail", 
    "user_list_information": [{ 
        "username": "admin", 
        "mobile_phone": "telephone number" 
    }] 
 } 
 ``` 

 ![-w2021](../assets/send_voice_msg03.png) 


 ## Weixin Official Account








 ### 6. Troubleshooting API 

 Login to the PaaS machine to view relevant log information 

 ```bash 
 tail -f /data/bkce/logs/open_paas/esb.log 
 ``` 

 ### 7, FAQ 

 1."errmsg": "Template Pending or content does not match" 

 Solution: Please go to Tencent Cloud Voice Messaging-> Apply Management-> Voice Template->select the corresponding application-> create a voice template 