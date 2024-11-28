# Configure Voice Message Notifications

Configuration Address: Enter "Developer Center" with the role of "admin" -> "API Gateway" -> "Channel Management" -> Select the system "[CMSI] BlueKing Message Management" -> Select "[CMSI] Public Voice Notification"

## Component Configuration

- dest_url: If the user is not proficient in Python, you can provide an interface in another language and fill it into dest_url. The ESB will only forward the request to complete the voice message configuration.
- qcloud_app_id: SDK AppID
- qcloud_app_key: App Key

## Component Example

This example uses Tencent Cloud VMS as an example.

### 1. Create an Application

First, go to Tencent Cloud Cloud Products -> Voice Messages

![-w2021](../assets/markdown-img-paste-20200403173430929.png)

Application Management -> Application List -> Create Application

![-w2021](../assets/markdown-img-paste-20200407195612299.png)

Click on the application name -> Obtain SDK AppID, App Key

![-w2021](../assets/markdown-img-paste-20200407203051995.png)

### 2. Apply for a Number

Application Management -> Voice Numbers -> Select the corresponding application -> Apply for a number

![-w2021](../assets/send_voice_msg01.png)

### 3. Create a Voice Template

Application Management -> Voice Templates -> Select the corresponding application -> Create a voice template

![-w2021](../assets/send_voice_msg02.png)

Template Example: BlueKing Monitoring Notification {1}

### 4. Configure Channel

Enter "Developer Center" with the role of "admin" -> "API Gateway" -> "Channel Management" -> Select the system "[CMSI] BlueKing Message Management" -> Select "[CMSI] Public Voice Notification"

```bash
qcloud_app_id: SDK AppID
qcloud_app_key: App Key
```

Enable: Yes

Submit changes

![-w2021](../assets/2020040720315877.png)

Submit changes after filling in the information

### 5. Test Interface

Using Postman tool to make a request as an example

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

### 6. Troubleshoot Interface Issues

Check related log information by logging into the PaaS machine

```bash
tail -f /data/bkce/logs/open_paas/esb.log
```

### 7. FAQ

1. "errmsg": "Template not approved or content mismatch"

Solution: Please go to Tencent Cloud Voice Messages -> Application Management -> Voice Templates -> Select the corresponding application -> Create a voice template