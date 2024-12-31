# Configure Message Notifications: WeChat Messages

Configuration Address: Enter "Developer Center" as the "admin" role -> "API Gateway" -> "Channel Management" -> Select the system "[CMSI] BlueKing Message Management" -> Select "[CMSI] Send WeChat Messages"


## Enterprise WeChat


### Component Configuration

- dest_url: If the user is not proficient in Python, you can provide an interface in another language and fill it into dest_url. The ESB will only forward the request to establish the voice message configuration.
- qcloud_app_id: SDK AppID
- qcloud_app_key: App Key

### Component Example


#### 1. Create Application

#### 4. Configure Channel

Enter "Developer Center" as the "admin" role -> "API Gateway" -> "Channel Management" -> Select the system "[CMSI] BlueKing Message Management" -> Select "[CMSI] Public Voice Notification"

```bash
qcloud_app_id: SDK AppID
qcloud_app_key: App Key
```

Enable: Yes

Submit Changes


Submit changes after filling in the information

#### 5. Test Interface

Using Postman tool as an example

```bash
http://{PaaS_URL}/api/c/compapi/cmsi/send_voice_msg/
```

```json
{
    "bk_app_code":"test",
    "bk_app_secret":"test",
    "bk_username": "admin",
    "auto_read_message": "BlueKing Monitoring Notification, xxxx task execution failed",
    "user_list_information": [{
        "username": "admin",
        "mobile_phone": "telephone number"
    }]
}
```

![-w2021](../assets/send_voice_msg03.png)


## WeChat Official Account








### 6. Troubleshoot Interface Issues

Check related log information by logging into the PaaS machine

```bash
tail -f /data/bkce/logs/open_paas/esb.log
```

### 7. FAQ

1. "errmsg": "Template not approved or content mismatch"

Solution: Please go to Tencent Cloud Voice Messages -> Application Management -> Voice Templates -> Select the corresponding application -> Create a voice template