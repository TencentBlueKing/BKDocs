# devops\_ci\_notify

**数据库名：** devops\_ci\_notify

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_notify的数据库文档

|                            表名                            |     说明    |
| :------------------------------------------------------: | :-------: |
| [T\_COMMON\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference) |   基础模板表   |
| [T\_EMAILS\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference) |  email模板表 |
|           [T\_NOTIFY\_EMAIL](broken-reference)           |           |
|            [T\_NOTIFY\_RTX](broken-reference)            |   rtx流水表  |
|            [T\_NOTIFY\_SMS](broken-reference)            |           |
|           [T\_NOTIFY\_WECHAT](broken-reference)          |   微信流水表   |
|           [T\_NOTIFY\_WEWORK](broken-reference)          |  企业微信流水表  |
|   [T\_RTX\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference)  |   rtx模板表  |
| [T\_WECHAT\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference) | wechat模板表 |
| [T\_WEWORK\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference) | wework模板表 |

**表名：** T\_COMMON\_NOTIFY\_MESSAGE\_TEMPLATE

**说明：** 基础模板表

**数据列：**

|  序号 |          名称         |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |                    说明                    |
| :-: | :-----------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--------------------------------------: |
|  1  |          ID         | varchar |  32 |  0  |   N  |  Y  |     |                   主键ID                   |
|  2  |    TEMPLATE\_CODE   | varchar |  64 |  0  |   N  |  N  |     |                   模板代码                   |
|  3  |    TEMPLATE\_NAME   | varchar | 128 |  0  |   N  |  N  |     |                   模板名称                   |
|  4  | NOTIFY\_TYPE\_SCOPE | varchar |  64 |  0  |   N  |  N  |     | 适用的通知类型（EMAIL:邮件RTX:企业微信WECHAT:微信SMS:短信） |
|  5  |       PRIORITY      | tinyint |  4  |  0  |   N  |  N  |     |                    优先级                   |
|  6  |        SOURCE       | tinyint |  4  |  0  |   N  |  N  |     |                   邮件来源                   |

**表名：** T\_EMAILS\_NOTIFY\_MESSAGE\_TEMPLATE

**说明：** email模板表

**数据列：**

|  序号 |          名称          |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |         默认值        |         说明         |
| :-: | :------------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :----------------: |
|  1  |          ID          |   varchar  |    32    |  0  |   N  |  Y  |                    |        主键ID        |
|  2  | COMMON\_TEMPLATE\_ID |   varchar  |    32    |  0  |   N  |  N  |                    |        模板ID        |
|  3  |        CREATOR       |   varchar  |    50    |  0  |   N  |  N  |                    |         创建者        |
|  4  |       MODIFIOR       |   varchar  |    50    |  0  |   N  |  N  |                    |         修改者        |
|  5  |        SENDER        |   varchar  |    128   |  0  |   N  |  N  |       DevOps       |        邮件发送者       |
|  6  |         TITLE        |   varchar  |    256   |  0  |   Y  |  N  |                    |        邮件标题        |
|  7  |         BODY         | mediumtext | 16777215 |  0  |   N  |  N  |                    |        邮件内容        |
|  8  |     BODY\_FORMAT     |   tinyint  |     4    |  0  |   N  |  N  |                    | 邮件格式（0:文本1:html网页） |
|  9  |      EMAIL\_TYPE     |   tinyint  |     4    |  0  |   N  |  N  |                    | 邮件类型（0:外部邮件1:内部邮件） |
|  10 |     CREATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |        创建时间        |
|  11 |     UPDATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |        更新时间        |

**表名：** T\_NOTIFY\_EMAIL

**说明：**

**数据列：**

|  序号 |        名称        |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 | 默认值 |               说明              |
| :-: | :--------------: | :--------: | :------: | :-: | :--: | :-: | :-: | :---------------------------: |
|  1  |        ID        |   varchar  |    32    |  0  |   N  |  Y  |     |              主键ID             |
|  2  |      SUCCESS     |     bit    |     1    |  0  |   N  |  N  |     |              是否成功             |
|  3  |      SOURCE      |   varchar  |    255   |  0  |   N  |  N  |     |              邮件来源             |
|  4  |      SENDER      |   varchar  |    255   |  0  |   N  |  N  |     |             邮件发送者             |
|  5  |        TO        |    text    |   65535  |  0  |   N  |  N  |     |             邮件接收者             |
|  6  |       TITLE      |   varchar  |    255   |  0  |   N  |  N  |     |              邮件标题             |
|  7  |       BODY       | mediumtext | 16777215 |  0  |   N  |  N  |     |              邮件内容             |
|  8  |     PRIORITY     |     int    |    10    |  0  |   N  |  N  |     |              优先级              |
|  9  |   RETRY\_COUNT   |     int    |    10    |  0  |   N  |  N  |     |              重试次数             |
|  10 |    LAST\_ERROR   |    text    |   65535  |  0  |   Y  |  N  |     |             最后错误内容            |
|  11 |   CREATED\_TIME  |  datetime  |    19    |  0  |   N  |  N  |     |              创建时间             |
|  12 |   UPDATED\_TIME  |  datetime  |    19    |  0  |   N  |  N  |     |              更新时间             |
|  13 |        CC        |    text    |   65535  |  0  |   Y  |  N  |     |            邮件抄送接收者            |
|  14 |        BCC       |    text    |   65535  |  0  |   Y  |  N  |     |            邮件密送接收者            |
|  15 |      FORMAT      |     int    |    10    |  0  |   N  |  N  |     |               格式              |
|  16 |       TYPE       |     int    |    10    |  0  |   N  |  N  |     |               类型              |
|  17 |   CONTENT\_MD5   |   varchar  |    32    |  0  |   N  |  N  |     | 内容md5值，由title和body计算得，频率限制时使用 |
|  18 | FREQUENCY\_LIMIT |     int    |    10    |  0  |   Y  |  N  |     |   频率限制时长，单位分钟，即n分钟内不重发成功的消息   |
|  19 |   TOF\_SYS\_ID   |   varchar  |    20    |  0  |   Y  |  N  |     |            tof系统id            |
|  20 |   FROM\_SYS\_ID  |   varchar  |    20    |  0  |   Y  |  N  |     |           发送消息的系统id           |
|  21 |   DelaySeconds   |     int    |    10    |  0  |   Y  |  N  |     |           延迟发送的时间，秒           |

**表名：** T\_NOTIFY\_RTX

**说明：** rtx流水表

**数据列：**

|  序号 |        名称        |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |               说明              |
| :-: | :--------------: | :------: | :---: | :-: | :--: | :-: | :-: | :---------------------------: |
|  1  |        ID        |  varchar |   32  |  0  |   N  |  Y  |     |              主键ID             |
|  2  |     BATCH\_ID    |  varchar |   32  |  0  |   N  |  N  |     |           RTX通知批次ID           |
|  3  |      SUCCESS     |    bit   |   1   |  0  |   N  |  N  |     |              是否成功             |
|  4  |      SOURCE      |  varchar |  255  |  0  |   N  |  N  |     |              邮件来源             |
|  5  |      SENDER      |  varchar |  255  |  0  |   N  |  N  |     |             邮件发送者             |
|  6  |     RECEIVERS    |   text   | 65535 |  0  |   N  |  N  |     |             通知接收者             |
|  7  |       TITLE      |  varchar |  255  |  0  |   N  |  N  |     |              邮件标题             |
|  8  |       BODY       |   text   | 65535 |  0  |   N  |  N  |     |              邮件内容             |
|  9  |     PRIORITY     |    int   |   10  |  0  |   N  |  N  |     |              优先级              |
|  10 |   RETRY\_COUNT   |    int   |   10  |  0  |   N  |  N  |     |              重试次数             |
|  11 |    LAST\_ERROR   |   text   | 65535 |  0  |   Y  |  N  |     |             最后错误内容            |
|  12 |   CREATED\_TIME  | datetime |   19  |  0  |   N  |  N  |     |              创建时间             |
|  13 |   UPDATED\_TIME  | datetime |   19  |  0  |   N  |  N  |     |              更新时间             |
|  14 |   CONTENT\_MD5   |  varchar |   32  |  0  |   N  |  N  |     | 内容md5值，由title和body计算得，频率限制时使用 |
|  15 | FREQUENCY\_LIMIT |    int   |   10  |  0  |   Y  |  N  |     |   频率限制时长，单位分钟，即n分钟内不重发成功的消息   |
|  16 |   TOF\_SYS\_id   |  varchar |   20  |  0  |   Y  |  N  |     |            tof系统id            |
|  17 |   FROM\_SYS\_ID  |  varchar |   20  |  0  |   Y  |  N  |     |           发送消息的系统id           |
|  18 |   DelaySeconds   |    int   |   10  |  0  |   Y  |  N  |     |           延迟发送的时间，秒           |

**表名：** T\_NOTIFY\_SMS

**说明：**

**数据列：**

|  序号 |         名称        |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |               说明              |
| :-: | :---------------: | :------: | :---: | :-: | :--: | :-: | :-: | :---------------------------: |
|  1  |         ID        |  varchar |   32  |  0  |   N  |  Y  |     |              主键ID             |
|  2  |      SUCCESS      |    bit   |   1   |  0  |   N  |  N  |     |              是否成功             |
|  3  |       SOURCE      |  varchar |  255  |  0  |   N  |  N  |     |              邮件来源             |
|  4  |       SENDER      |  varchar |  255  |  0  |   N  |  N  |     |             邮件发送者             |
|  5  |     RECEIVERS     |   text   | 65535 |  0  |   N  |  N  |     |             通知接收者             |
|  6  |        BODY       |   text   | 65535 |  0  |   N  |  N  |     |              邮件内容             |
|  7  |      PRIORITY     |    int   |   10  |  0  |   N  |  N  |     |              优先级              |
|  8  |    RETRY\_COUNT   |    int   |   10  |  0  |   N  |  N  |     |              重试次数             |
|  9  |    LAST\_ERROR    |   text   | 65535 |  0  |   Y  |  N  |     |             最后错误内容            |
|  10 |   CREATED\_TIME   | datetime |   19  |  0  |   N  |  N  |     |              创建时间             |
|  11 |   UPDATED\_TIME   | datetime |   19  |  0  |   N  |  N  |     |              更新时间             |
|  12 |     BATCH\_ID     |  varchar |   32  |  0  |   N  |  N  |     |             通知批次ID            |
|  13 | T\_NOTIFY\_SMScol |  varchar |   45  |  0  |   Y  |  N  |     |                               |
|  14 |    CONTENT\_MD5   |  varchar |   32  |  0  |   N  |  N  |     | 内容md5值，由title和body计算得，频率限制时使用 |
|  15 |  FREQUENCY\_LIMIT |    int   |   10  |  0  |   Y  |  N  |     |   频率限制时长，单位分钟，即n分钟内不重发成功的消息   |
|  16 |    TOF\_SYS\_ID   |  varchar |   20  |  0  |   Y  |  N  |     |            tof系统id            |
|  17 |   FROM\_SYS\_ID   |  varchar |   20  |  0  |   Y  |  N  |     |           发送消息的系统id           |
|  18 |    DelaySeconds   |    int   |   10  |  0  |   Y  |  N  |     |           延迟发送的时间，秒           |

**表名：** T\_NOTIFY\_WECHAT

**说明：** 微信流水表

**数据列：**

|  序号 |        名称        |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |               说明              |
| :-: | :--------------: | :------: | :---: | :-: | :--: | :-: | :-: | :---------------------------: |
|  1  |        ID        |  varchar |   32  |  0  |   N  |  Y  |     |              主键ID             |
|  2  |      SUCCESS     |    bit   |   1   |  0  |   N  |  N  |     |              是否成功             |
|  3  |      SOURCE      |  varchar |  255  |  0  |   N  |  N  |     |              邮件来源             |
|  4  |      SENDER      |  varchar |  255  |  0  |   N  |  N  |     |             邮件发送者             |
|  5  |     RECEIVERS    |   text   | 65535 |  0  |   N  |  N  |     |             通知接收者             |
|  6  |       BODY       |   text   | 65535 |  0  |   N  |  N  |     |              邮件内容             |
|  7  |     PRIORITY     |    int   |   10  |  0  |   N  |  N  |     |              优先级              |
|  8  |   RETRY\_COUNT   |    int   |   10  |  0  |   N  |  N  |     |              重试次数             |
|  9  |    LAST\_ERROR   |   text   | 65535 |  0  |   Y  |  N  |     |             最后错误内容            |
|  10 |   CREATED\_TIME  | datetime |   19  |  0  |   N  |  N  |     |              创建时间             |
|  11 |   UPDATED\_TIME  | datetime |   19  |  0  |   N  |  N  |     |              更新时间             |
|  12 |   CONTENT\_MD5   |  varchar |   32  |  0  |   N  |  N  |     | 内容md5值，由title和body计算得，频率限制时使用 |
|  13 | FREQUENCY\_LIMIT |    int   |   10  |  0  |   Y  |  N  |     |   频率限制时长，单位分钟，即n分钟内不重发成功的消息   |
|  14 |   TOF\_SYS\_ID   |  varchar |   20  |  0  |   Y  |  N  |     |            tof系统id            |
|  15 |   FROM\_SYS\_ID  |  varchar |   20  |  0  |   Y  |  N  |     |           发送消息的系统id           |
|  16 |   DelaySeconds   |    int   |   10  |  0  |   Y  |  N  |     |           延迟发送的时间，秒           |

**表名：** T\_NOTIFY\_WEWORK

**说明：** 企业微信流水表

**数据列：**

|  序号 |       名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |          默认值          |   说明   |
| :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :-------------------: | :----: |
|  1  |       ID      |  bigint  |   20  |  0  |   N  |  Y  |                       |  主键ID  |
|  2  |    SUCCESS    |    bit   |   1   |  0  |   N  |  N  |                       |  是否成功  |
|  3  |   RECEIVERS   |   text   | 65535 |  0  |   N  |  N  |                       |  通知接收者 |
|  4  |      BODY     |   text   | 65535 |  0  |   N  |  N  |                       |  邮件内容  |
|  5  |  LAST\_ERROR  |   text   | 65535 |  0  |   Y  |  N  |                       | 最后错误内容 |
|  6  | CREATED\_TIME | datetime |   26  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP(6) |  创建时间  |
|  7  | UPDATED\_TIME | datetime |   26  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP(6) |  更新时间  |

**表名：** T\_RTX\_NOTIFY\_MESSAGE\_TEMPLATE

**说明：** rtx模板表

**数据列：**

|  序号 |          名称          |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :------------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |          ID          |   varchar  |    32    |  0  |   N  |  Y  |                    |  主键ID |
|  2  | COMMON\_TEMPLATE\_ID |   varchar  |    32    |  0  |   N  |  N  |                    |  模板ID |
|  3  |        CREATOR       |   varchar  |    50    |  0  |   N  |  N  |                    |  创建者  |
|  4  |       MODIFIOR       |   varchar  |    50    |  0  |   N  |  N  |                    |  修改者  |
|  5  |        SENDER        |   varchar  |    128   |  0  |   N  |  N  |       DevOps       | 邮件发送者 |
|  6  |         TITLE        |   varchar  |    256   |  0  |   Y  |  N  |                    |  邮件标题 |
|  7  |         BODY         | mediumtext | 16777215 |  0  |   N  |  N  |                    |  邮件内容 |
|  8  |     CREATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间 |
|  9  |     UPDATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间 |

**表名：** T\_WECHAT\_NOTIFY\_MESSAGE\_TEMPLATE

**说明：** wechat模板表

**数据列：**

|  序号 |          名称          |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :------------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |          ID          |   varchar  |    32    |  0  |   N  |  Y  |                    |  主键ID |
|  2  | COMMON\_TEMPLATE\_ID |   varchar  |    32    |  0  |   N  |  N  |                    |  模板ID |
|  3  |        CREATOR       |   varchar  |    50    |  0  |   N  |  N  |                    |  创建者  |
|  4  |       MODIFIOR       |   varchar  |    50    |  0  |   N  |  N  |                    |  修改者  |
|  5  |        SENDER        |   varchar  |    128   |  0  |   N  |  N  |       DevOps       | 邮件发送者 |
|  6  |         TITLE        |   varchar  |    256   |  0  |   Y  |  N  |                    |  邮件标题 |
|  7  |         BODY         | mediumtext | 16777215 |  0  |   N  |  N  |                    |  邮件内容 |
|  8  |     CREATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间 |
|  9  |     UPDATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间 |

**表名：** T\_WEWORK\_NOTIFY\_MESSAGE\_TEMPLATE

**说明：** wework模板表

**数据列：**

|  序号 |          名称          |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |          默认值          |   说明  |
| :-: | :------------------: | :--------: | :------: | :-: | :--: | :-: | :-------------------: | :---: |
|  1  |          ID          |   varchar  |    32    |  0  |   N  |  Y  |                       |  主键ID |
|  2  | COMMON\_TEMPLATE\_ID |   varchar  |    32    |  0  |   N  |  N  |                       |  模板ID |
|  3  |        CREATOR       |   varchar  |    50    |  0  |   N  |  N  |                       |  创建者  |
|  4  |       MODIFIOR       |   varchar  |    50    |  0  |   N  |  N  |                       |  修改者  |
|  5  |        SENDER        |   varchar  |    128   |  0  |   N  |  N  |         DevOps        | 邮件发送者 |
|  6  |         TITLE        |   varchar  |    256   |  0  |   Y  |  N  |                       |  邮件标题 |
|  7  |         BODY         | mediumtext | 16777215 |  0  |   N  |  N  |                       |  邮件内容 |
|  8  |     CREATE\_TIME     |  datetime  |    26    |  0  |   N  |  N  | CURRENT\_TIMESTAMP(6) |  创建时间 |
|  9  |     UPDATE\_TIME     |  datetime  |    26    |  0  |   Y  |  N  |                       |  更新时间 |
