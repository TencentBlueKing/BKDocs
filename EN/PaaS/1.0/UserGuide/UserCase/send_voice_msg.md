 # Set Message Notification: Voice Message 

 Address setting: Enter "Developer Center" with the role "admin"-> "API Gateway"-> "Channel Management"-> select system "[CMSI] BlueKing Message Management"-> select "[CMSI] Public Voice Notification". 

 ## Component Config 

 - dest_url: If users are not good at using Python, you can provide an API in other languages and fill in dest_url. ESB can only forward the request and get through the voice message setting 
 - qcloud_app_id: SDK AppID 
 - qcloud_app_key: App key 

 ## Components Example 

 This example is based on Tencent Cloud VMS 

 ### 1. Create an application 

 Go to Tencent Cloud Products-> Voice Messages 

 ![-w2021](../assets/markdown-img-paste-20200403173430929.png) 

 Application Management-> Application List-> Create Application 

 ![-w2021](../assets/markdown-img-paste-20200407195612299.png) 

 click on Application Name-> Get SDK AppID and App Key 

 ![-w2021](../assets/markdown-img-paste-20200407203051995.png) 

 ### 2. Apply No. 

 Application Manage-> Voice Number-> select the appropriate application-> Application Number 

 !  [-w2021](../ assets/send_voice_msg01.png) 

 ### 3. create a voice template 

 Apply Manage-> Voice Template-> select the appropriate application-> Create Voice Template 

 !  [-w2021](../ assets/send_voice_msg02.png) 

 Template example: BK Monitor Notification {1} 

 ### 4. Setting channel 

 Enter "Developer Center" with the role "admin"-> "API Gateway"-> "Channel Management"-> select system "[CMSI] BlueKing Message Management"-> select "[CMSI] Public Voice Notification". 

 ```bash 
 qcloud_app_id：SDK AppID 
 qcloud_app_key：App Key 
 ``` 

 Enabled: Yes 

 Submit Revise 

 ![-w2021](../assets/2020040720315877.png) 

 Submit Revise after filling 

 ### 5. Testing the API 

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

 ### 6. Troubleshooting API 

 Log in to the PaaS machine to view relevant log information 

 ```bash 
 tail -f /data/bkce/logs/open_paas/esb.log 
 ``` 

 ### 7, FAQ 

 1."errmsg": "Template Pending or content does not match" 

 Solution: please Go to Tencent Cloud Voice Messaging-> Application Management-> Voice Template-> select an application-> create a voice template 