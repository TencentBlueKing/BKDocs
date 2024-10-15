# devops\_ci\_notify

**The database name:** devops\_ci\_notify

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_notify

|                            Table name                            |     Description    |
| :------------------------------------------------------: | :-------: |
| [T\_COMMON\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference) |   Base Template Table   | 
| [T\_EMAILS\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference) |Email template table| 
|           [T\_NOTIFY\_EMAIL](broken-reference)           |           | 
|            [T\_NOTIFY\_RTX](broken-reference)            |   Rtx Fact Table| 
|            [T\_NOTIFY\_SMS](broken-reference)            |           | 
|           [T\_NOTIFY\_WECHAT](broken-reference)          |   WeChat Fact Table   | 
|           [T\_NOTIFY\_WEWORK](broken-reference)          |  WeCom Fact Table| 
|   [T\_RTX\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference)  |   Rtx template table| 
| [T\_WECHAT\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference) |Wechat template table| 
| [T\_WEWORK\_NOTIFY\_MESSAGE\_TEMPLATE](broken-reference) |Wework template table| 

**Table name:** T\_COMMON\_NOTIFY\_MESSAGE\_TEMPLATE

**Description:**   Base Template Table 

**Data column:** 

|  No. |          name         |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |                    Description                    |
| :-: | :-----------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--------------------------------------: | 
|  1  |          ID         | varchar |  32 |  0  |   N  |  Y  |     |                    primary key ID                   | 
|  2  |    TEMPLATE\_CODE   | varchar |  64 |  0  |   N  |  N  |     |                   template code                   | 
|  3  |    TEMPLATE\_NAME   | varchar | 128 |  0  |   N  |  N  |     |                   Template name                   | 
|  4  | NOTIFY\_TYPE\_SCOPE | varchar |  64 |  0  |   N  |  N  |     | Applicable notification types (EMAIL: Email RTX: Wechat: Wechat SMS: SMS)| 
|  5  |       PRIORITY      | tinyint |  4  |  0  |   N  |  N  |     |                    优先级                   | 
|  6  |        SOURCE       | tinyint |  4  |  0  |   N  |  N  |     |                   Mail Source                   | 

**Table name:** T\_EMAILS\_NOTIFY\_MESSAGE\_TEMPLATE

**Description:**   Email template table 

**Data column:** 

|  No. |          name          |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |         defaultValue        |         Description         |
| :-: | :------------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :----------------: | 
|  1  |          ID          |   varchar  |    32    |  0  |   N  |  Y  |                    |         primary key ID        | 
|  2  | COMMON\_TEMPLATE\_ID |   varchar  |    32    |  0  |   N  |  N  |                    |        Template ID        | 
|  3  |        CREATOR       |   varchar  |    50    |  0  |   N  |  N  |                    |         projectCreator        | 
|  4  |       MODIFIOR       |   varchar  |    50    |  0  |   N  |  N  |                    |         Updated by        | 
|  5  |        SENDER        |   varchar  |    128   |  0  |   N  |  N  |       DevOps       |        Email sender       | 
|  6  |         TITLE        |   varchar  |    256   |  0  |   Y  |  N  |                    |        Email Header        | 
|  7  |         BODY         | mediumtext | 16777215 |  0  |   N  |  N  |                    |        Email content        | 
|  8  |     BODY\_FORMAT     |   tinyint  |     4    |  0  |   N  |  N  |                    | Email format (0: Text 1:html web page)| 
|  9  |      EMAIL\_TYPE     |   tinyint  |     4    |  0  |   N  |  N  |                    | Email type (0: External 1: Internal)| 
|  10 |     CREATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |        creationTime        | 
|  11 |     UPDATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |        updateTime        | 

**Table name:** T\_NOTIFY\_EMAIL

**Description:** 

**Data column:** 

|  No. |        name        |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  | defaultValue |               Description              |
| :-: | :--------------: | :--------: | :------: | :-: | :--: | :-: | :-: | :---------------------------: | 
|  1  |        ID        |   varchar  |    32    |  0  |   N  |  Y  |     |               primary key ID             | 
|  2  |      SUCCESS     |     bit    |     1    |  0  |   N  |  N  |     |              Is it Success             | 
|  3  |      SOURCE      |   varchar  |    255   |  0  |   N  |  N  |     |              Email source             | 
|  4  |      SENDER      |   varchar  |    255   |  0  |   N  |  N  |     |             Email sender             | 
|  5  |        TO        |    text    |   65535  |  0  |   N  |  N  |     |             Email recipient             | 
|  6  |       TITLE      |   varchar  |    255   |  0  |   N  |  N  |     |              Email Header             | 
|  7  |       BODY       | mediumtext | 16777215 |  0  |   N  |  N  |     |              Email content             | 
|  8  |     PRIORITY     |     int    |    10    |  0  |   N  |  N  |     |              Priority              | 
|  9  |   RETRY\_COUNT   |     int    |    10    |  0  |   N  |  N  |     |              execTime             | 
|  10 |    LAST\_ERROR   |    text    |   65535  |  0  |   Y  |  N  |     |             last Error content            | 
|  11 |   CREATED\_TIME  |  datetime  |    19    |  0  |   N  |  N  |     |              creationTime             | 
|  12 |   UPDATED\_TIME  |  datetime  |    19    |  0  |   N  |  N  |     |              updateTime             | 
|  13 |        CC        |    text    |   65535  |  0  |   Y  |  N  |     |            Email CC recipient            | 
|  14 |        BCC       |    text    |   65535  |  0  |   Y  |  N  |     |            Email recipient            | 
|  15 |      FORMAT      |     int    |    10    |  0  |   N  |  N  |     |               Format              | 
|  16 |       TYPE       |     int    |    10    |  0  |   N  |  N  |     |               type              | 
|  17 |   CONTENT\_MD5   |   varchar  |    32    |  0  |   N  |  N  |     | content md5 value, Processing by title and Body, used for frequency Limit| 
|  18 | FREQUENCY\_LIMIT |     int    |    10    |  0  |   Y  |  N  |     |   Frequency Limit duration (unit minutes), i.e., messages that are not successfully retransmitted within n minutes   | 
|  19 |   TOF\_SYS\_ID   |   varchar  |    20    |  0  |   Y  |  N  |     |            Tof system id            | 
|  20 |   FROM\_SYS\_ID  |   varchar  |    20    |  0  |   Y  |  N  |     |           The system id that sent the message           | 
|  21 |   DelaySeconds   |     int    |    10    |  0  |   Y  |  N  |     |           time to Delay sending, Second           | 

**Table name:** T\_NOTIFY\_RTX

**Description:**   Rtx Fact Table 

**Data column:** 

|  No. |        name        |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |               Description              |
| :-: | :--------------: | :------: | :---: | :-: | :--: | :-: | :-: | :---------------------------: |
|  1  |        ID        |  varchar |   32  |  0  |   N  |  Y  |     |               primary key ID             | 
|  2  |     BATCH\_ID    |  varchar |   32  |  0  |   N  |  N  |     |           RTX Notification Lot ID           | 
|  3  |      SUCCESS     |    bit   |   1   |  0  |   N  |  N  |     |              Is it Success             | 
|  4  |      SOURCE      |  varchar |  255  |  0  |   N  |  N  |     |              Email source             | 
|  5  |      SENDER      |  varchar |  255  |  0  |   N  |  N  |     |             Email sender             | 
|  6  |     RECEIVERS    |   text   | 65535 |  0  |   N  |  N  |     |             Notification Recipient             | 
|  7  |       TITLE      |  varchar |  255  |  0  |   N  |  N  |     |              Email Header             | 
|  8  |       BODY       |   text   | 65535 |  0  |   N  |  N  |     |              Email content             | 
|  9  |     PRIORITY     |    int   |   10  |  0  |   N  |  N  |     |              Priority              | 
|  10 |   RETRY\_COUNT   |    int   |   10  |  0  |   N  |  N  |     |              execTime             | 
|  11 |    LAST\_ERROR   |   text   | 65535 |  0  |   Y  |  N  |     |             last Error content            | 
|  12 |   CREATED\_TIME  | datetime |   19  |  0  |   N  |  N  |     |              creationTime             | 
|  13 |   UPDATED\_TIME  | datetime |   19  |  0  |   N  |  N  |     |              updateTime             | 
|  14 |   CONTENT\_MD5   |  varchar |   32  |  0  |   N  |  N  |     | content md5 value, Processing by title and Body, used for frequency Limit| 
|  15 | FREQUENCY\_LIMIT |    int   |   10  |  0  |   Y  |  N  |     |   Frequency Limit duration (unit minutes), i.e., messages that are not successfully retransmitted within n minutes   | 
|  16 |   TOF\_SYS\_id   |  varchar |   20  |  0  |   Y  |  N  |     |            Tof system id            | 
|  17 |   FROM\_SYS\_ID  |  varchar |   20  |  0  |   Y  |  N  |     |           The system id that sent the message           | 
|  18 |   DelaySeconds   |    int   |   10  |  0  |   Y  |  N  |     |           time to Delay sending, Second           | 

**Table name:** T\_NOTIFY\_SMS

**Description:** 

**Data column:** 

|  No. |         name        |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |               Description              |
| :-: | :---------------: | :------: | :---: | :-: | :--: | :-: | :-: | :---------------------------: | 
|  1  |         ID        |  varchar |   32  |  0  |   N  |  Y  |     |               primary key ID             | 
|  2  |      SUCCESS      |    bit   |   1   |  0  |   N  |  N  |     |              Is it Success             | 
|  3  |       SOURCE      |  varchar |  255  |  0  |   N  |  N  |     |              Email source             | 
|  4  |       SENDER      |  varchar |  255  |  0  |   N  |  N  |     |             Email sender             | 
|  5  |     RECEIVERS     |   text   | 65535 |  0  |   N  |  N  |     |             Notification Recipient             | 
|  6  |        BODY       |   text   | 65535 |  0  |   N  |  N  |     |              Email content             | 
|  7  |      PRIORITY     |    int   |   10  |  0  |   N  |  N  |     |              Priority              | 
|  8  |    RETRY\_COUNT   |    int   |   10  |  0  |   N  |  N  |     |              execTime             | 
|  9  |    LAST\_ERROR    |   text   | 65535 |  0  |   Y  |  N  |     |             last Error content            | 
|  10 |   CREATED\_TIME   | datetime |   19  |  0  |   N  |  N  |     |              creationTime             | 
|  11 |   UPDATED\_TIME   | datetime |   19  |  0  |   N  |  N  |     |              updateTime             | 
|  12 |     BATCH\_ID     |  varchar |   32  |  0  |   N  |  N  |     |             Notification Batch ID            | 
|  13 | T\_NOTIFY\_SMScol |  varchar |   45  |  0  |   Y  |  N  |     |                               | 
|  14 |    CONTENT\_MD5   |  varchar |   32  |  0  |   N  |  N  |     | content md5 value, Processing by title and Body, used for frequency Limit| 
|  15 |  FREQUENCY\_LIMIT |    int   |   10  |  0  |   Y  |  N  |     |   Frequency Limit duration (unit minutes), i.e., messages that are not successfully retransmitted within n minutes   | 
|  16 |    TOF\_SYS\_ID   |  varchar |   20  |  0  |   Y  |  N  |     |            Tof system id            | 
|  17 |   FROM\_SYS\_ID   |  varchar |   20  |  0  |   Y  |  N  |     |           The system id that sent the message           | 
|  18 |    DelaySeconds   |    int   |   10  |  0  |   Y  |  N  |     |           time to Delay sending, Second           | 

**Table name:** T\_NOTIFY\_WECHAT

**Description:**   WeChat Fact Table 

**Data column:** 

|  No. |        name        |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |               Description              |
| :-: | :--------------: | :------: | :---: | :-: | :--: | :-: | :-: | :---------------------------: | 
|  1  |        ID        |  varchar |   32  |  0  |   N  |  Y  |     |               primary key ID             | 
|  2  |      SUCCESS     |    bit   |   1   |  0  |   N  |  N  |     |              Is it Success             | 
|  3  |      SOURCE      |  varchar |  255  |  0  |   N  |  N  |     |              Email source             | 
|  4  |      SENDER      |  varchar |  255  |  0  |   N  |  N  |     |             Email sender             | 
|  5  |     RECEIVERS    |   text   | 65535 |  0  |   N  |  N  |     |             Notification Recipient             | 
|  6  |       BODY       |   text   | 65535 |  0  |   N  |  N  |     |              Email content             | 
|  7  |     PRIORITY     |    int   |   10  |  0  |   N  |  N  |     |              Priority              | 
|  8  |   RETRY\_COUNT   |    int   |   10  |  0  |   N  |  N  |     |              execTime             | 
|  9  |    LAST\_ERROR   |   text   | 65535 |  0  |   Y  |  N  |     |             last Error content            | 
|  10 |   CREATED\_TIME  | datetime |   19  |  0  |   N  |  N  |     |              creationTime             | 
|  11 |   UPDATED\_TIME  | datetime |   19  |  0  |   N  |  N  |     |              updateTime             | 
|  12 |   CONTENT\_MD5   |  varchar |   32  |  0  |   N  |  N  |     | content md5 value, Processing by title and Body, used for frequency Limit| 
|  13 | FREQUENCY\_LIMIT |    int   |   10  |  0  |   Y  |  N  |     |   Frequency Limit duration (unit minutes), i.e., messages that are not successfully retransmitted within n minutes   | 
|  14 |   TOF\_SYS\_ID   |  varchar |   20  |  0  |   Y  |  N  |     |            Tof system id            | 
|  15 |   FROM\_SYS\_ID  |  varchar |   20  |  0  |   Y  |  N  |     |           The system id that sent the message           | 
|  16 |   DelaySeconds   |    int   |   10  |  0  |   Y  |  N  |     |           time to Delay sending, Second           | 

**Table name:** T\_NOTIFY\_WEWORK

**Description:**   WeCom Fact Table 

**Data column:** 

|  No. |       name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |          defaultValue          |   Description   |
| :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :-------------------: | :----: |
|  1  |       ID      |  bigint  |   20  |  0  |   N  |  Y  |                       |   primary key ID  | 
|  2  |    SUCCESS    |    bit   |   1   |  0  |   N  |  N  |                       |  Is it Success| 
|  3  |   RECEIVERS   |   text   | 65535 |  0  |   N  |  N  |                       |  Notification Recipient| 
|  4  |      BODY     |   text   | 65535 |  0  |   N  |  N  |                       |  Email content| 
|  5  |  LAST\_ERROR  |   text   | 65535 |  0  |   Y  |  N  |                       | last Error content| 
|  6  | CREATED\_TIME | datetime |   26  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP(6) |creationTime| 
|  7  | UPDATED\_TIME | datetime |   26  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP(6) |updateTime| 

**Table name:** T\_RTX\_NOTIFY\_MESSAGE\_TEMPLATE

**Description:**  rtx模板表

**Data column:** 

|  No. |          name          |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  |
| :-: | :------------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |          ID          |   varchar  |    32    |  0  |   N  |  Y  |                    |   primary key ID | 
|  2  | COMMON\_TEMPLATE\_ID |   varchar  |    32    |  0  |   N  |  N  |                    |  Template ID| 
|  3  |        CREATOR       |   varchar  |    50    |  0  |   N  |  N  |                    |  projectCreator| 
|  4  |       MODIFIOR       |   varchar  |    50    |  0  |   N  |  N  |                    |  Updated by| 
|  5  |        SENDER        |   varchar  |    128   |  0  |   N  |  N  |       DevOps       | Email sender| 
|  6  |         TITLE        |   varchar  |    256   |  0  |   Y  |  N  |                    |  Email Header| 
|  7  |         BODY         | mediumtext | 16777215 |  0  |   N  |  N  |                    |  Email content| 
|  8  |     CREATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
|  9  |     UPDATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

**Table name:** T\_WECHAT\_NOTIFY\_MESSAGE\_TEMPLATE

**Description:**  wechat模板表

**Data column:** 

|  No. |          name          |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  |
| :-: | :------------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: | 
|  1  |          ID          |   varchar  |    32    |  0  |   N  |  Y  |                    |   primary key ID | 
|  2  | COMMON\_TEMPLATE\_ID |   varchar  |    32    |  0  |   N  |  N  |                    |  Template ID| 
|  3  |        CREATOR       |   varchar  |    50    |  0  |   N  |  N  |                    |  projectCreator| 
|  4  |       MODIFIOR       |   varchar  |    50    |  0  |   N  |  N  |                    |  Updated by| 
|  5  |        SENDER        |   varchar  |    128   |  0  |   N  |  N  |       DevOps       | Email sender| 
|  6  |         TITLE        |   varchar  |    256   |  0  |   Y  |  N  |                    |  Email Header| 
|  7  |         BODY         | mediumtext | 16777215 |  0  |   N  |  N  |                    |  Email content| 
|  8  |     CREATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
|  9  |     UPDATE\_TIME     |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

**Table name:** T\_WEWORK\_NOTIFY\_MESSAGE\_TEMPLATE

**Description:**  wework模板表

**Data column:** 

|  No. |          name          |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |          defaultValue          |   Description  |
| :-: | :------------------: | :--------: | :------: | :-: | :--: | :-: | :-------------------: | :---: | 
|  1  |          ID          |   varchar  |    32    |  0  |   N  |  Y  |                       |   primary key ID | 
|  2  | COMMON\_TEMPLATE\_ID |   varchar  |    32    |  0  |   N  |  N  |                       |  Template ID| 
|  3  |        CREATOR       |   varchar  |    50    |  0  |   N  |  N  |                       |  projectCreator| 
|  4  |       MODIFIOR       |   varchar  |    50    |  0  |   N  |  N  |                       |  Updated by| 
|  5  |        SENDER        |   varchar  |    128   |  0  |   N  |  N  |         DevOps        | Email sender| 
|  6  |         TITLE        |   varchar  |    256   |  0  |   Y  |  N  |                       |  Email Header| 
|  7  |         BODY         | mediumtext | 16777215 |  0  |   N  |  N  |                       |  Email content| 
|  8  |     CREATE\_TIME     |  datetime  |    26    |  0  |   N  |  N  | CURRENT\_TIMESTAMP(6) |creationTime| 
|  9  |     UPDATE\_TIME     |  datetime  |    26    |  0  |   Y  |  N  |                       |  updateTime| 
