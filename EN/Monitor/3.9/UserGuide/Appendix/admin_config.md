# Global configuration

Global configuration affects the behavior of the entire monitoring system and does not differentiate between services.
![](media/16618557290241.jpg)

## Global configuration page

![](media/16618557771155.jpg)


#### Data saving cycle

After the data saving period is set, it will take effect on the 4th day of the morning every day. The longer the storage time, the higher the storage resource requirements. Pay attention to resource usage.

#### Chart watermark

The chart watermark is turned on by default. The icons on the page will be watermarked with the current user name. After turning it off, the watermark on the entire site will be turned off.

#### Alarm notification channel

The notification channel comes from the notification method in ESB, [ESB notification method added](../ProductFeatures/alarm-configurations/notify_setting.md)

The notification methods allowed to be selected on the alarm group configuration page do not affect the configured alarm groups. ["\__all__"] represents all, sms text message, weixin WeChat, voice phone number, and mail email.

#### Global disk type shielding configuration

If the disk read-only and disk full policies are configured, you can use this configuration item to block alarms for specified types of disks.

Configuration method `["iso9660", "tmpfs", "udf"]`

#### Additional notification method-message queue settings

After setting up the message queue, you can choose whether the alarm information triggered by which policies should enter the message queue during policy configuration, which facilitates secondary development needs based on alarm events.

Configuration method: `"redis://:${password}@${host}:${port}/${db}"`

For example: `"redis://:ycm%2C2rRn4A@10.0.0.1:6379/15/bk_monitor_queue"`

### More admin configuration methods

1. Visit `${BK_PAAS_HOST}/o/bk_monitor/admin/bkmonitor/globalconfig/` and enter the admin page
Click to see the original image

![-w2021](media/15746678905653.jpg)

2. Click on the configuration that needs to be modified to enter the configuration page.

3. Fill in the configuration information according to actual needs. The filled in text must strictly conform to the JSON format, and the data type must match the filled in text.
Supported data types:
     - Integer. For example: 1234
     - String (must be enclosed in double quotes). For example: "xxxxx"
     - Boolean value. For example: true
     - JSON. Any text that conforms to JSON format
     - List. For example: ["test", 321]
     - dictionary. For example: {"key": "value"}

4. After modifying the configuration, click Save in the lower right corner. If a verification failure error is returned, you need to check whether the configuration conforms to the JSON format. Then re-enter the page to fill in and submit. Do not modify and save directly on the original page

> **WARNING**: Due to the caching mechanism, the configuration will take effect within 5 minutes of modification.