# devops\_ci\_project

**The database name:** devops\_ci\_project

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_project

 |                              Table name                             |    Description    | 
 | :---------------------------------------------------------: | :------: | 
 |               [T\_ACTIVITY](broken-reference)               |          | 
 |               [T\_FAVORITE](broken-reference)               |   Follow the toCollect list| 
 |              [T\_GRAY\_TEST](broken-reference)              |          | 
 |         [T\_MESSAGE\_CODE\_DETAIL](broken-reference)        | code code detail table| 
 |                [T\_NOTICE](broken-reference)                |          | 
 |                [T\_PROJECT](broken-reference)               |   Project information Sheet| 
 |            [T\_PROJECT\_LABEL](broken-reference)            |          | 
 |          [T\_PROJECT\_LABEL\_REL](broken-reference)         |          | 
 |                [T\_SERVICE](broken-reference)               |   service Information Table| 
 |             [T\_SERVICE\_TYPE](broken-reference)            |   service type table| 
 |                 [T\_USER](broken-reference)                 |    user table   | 
 | [T\_USER\_DAILY\_FIRST\_AND\_LAST\_LOGIN](broken-reference) |          | 
 |          [T\_USER\_DAILY\_LOGIN](broken-reference)          |          | 

**Table name:** T\_ACTIVITY

**Description:** 

**Data column:** 

 |  No. |       name      |   Type Of Data   |  length  | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :-----------: | :------: | :--: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |       ID      |  bigint  |  20  |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |      TYPE     |  varchar |  32  |  0  |   N  |  N  |     |  type| 
 |  3  |      NAME     |  varchar |  128 |  0  |   N  |  N  |     |  name  | 
 |  4  | ENGLISH\_NAME |  varchar |  128 |  0  |   Y  |  N  |     | English name| 
 |  5  |      LINK     |  varchar | 1024 |  0  |   N  |  N  |     | location link| 
 |  6  |  CREATE\_TIME | datetime |  19  |  0  |   N  |  N  |     | creationTime| 
 |  7  |     STATUS    |  varchar |  32  |  0  |   N  |  N  |     |  status| 
 |  8  |    CREATOR    |  varchar |  32  |  0  |   N  |  N  |     |  projectCreator| 

**Table name:** T\_FAVORITE

**Description:**  Follow the toCollect list

**Data column:** 

 |  No. |      name     |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |      id     |  bigint |  20 |  0  |   N  |  Y  |     |  primary key id | 
 |  2  | service\_id |  bigint |  20 |  0  |   Y  |  N  |     | service ID| 
 |  3  |   username  | varchar |  64 |  0  |   Y  |  N  |     |  user| 

 **Table name:** T\_GRAY\_TEST 

 **Description:** 

 **Data column:** 

 |  No. |      name     |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |      id     |  bigint |  20 |  0  |   N  |  Y  |     |  primary key id | 
 |  2  | service\_id |  bigint |  20 |  0  |   Y  |  N  |     | service ID| 
 |  3  |   username  | varchar |  64 |  0  |   Y  |  N  |     |  user| 
 |  4  |    status   | varchar |  64 |  0  |   Y  |  N  |     | service status| 

 **Table name:** T\_MESSAGE\_CODE\_DETAIL 

 **Description:** Code Code detail 

 **Data column:** 

 |  No. |            name           |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |    Description    | 
 | :-: | :---------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :------: | 
 |  1  |            ID           | varchar |  32 |  0  |   N  |  Y  |     |     primary key     | 
 |  2  |      MESSAGE\_CODE      | varchar | 128 |  0  |   N  |  N  |     |   code code| 
 |  3  |       MODULE\_CODE      |   char  |  2  |  0  |   N  |  N  |     |   module Code   | 
 |  4  | MESSAGE\_DETAIL\_ZH\_CN | varchar | 500 |  0  |   N  |  N  |     | Simplified Chinese description| 
 |  5  | MESSAGE\_DETAIL\_ZH\_TW | varchar | 500 |  0  |   Y  |  N  |     | description information in traditional Chinese| 
 |  6  |   MESSAGE\_DETAIL\_EN   | varchar | 500 |  0  |   Y  |  N  |     |  English description information| 
**Table name:** T\_NOTICE

**Description:** 

**Data column:** 

 |  No. |        name       |    Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |       Description       | 
 | :-: | :-------------: | :-------: | :---: | :-: | :--: | :-: | :----------------: | :------------: | 
 |  1  |        ID       |   bigint  |   20  |  0  |   N  |  Y  |                    |       primary key ID      | 
 |  2  |  NOTICE\_TITLE  |  varchar  |  100  |  0  |   N  |  N  |                    |      Announcement Title      | 
 |  3  |   EFFECT\_DATE  | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      Take Effect date      | 
 |  4  |  INVALID\_DATE  | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      Expiry date      | 
 |  5  |   CREATE\_DATE  | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      Created at      | 
 |  6  |   UPDATE\_DATE  | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      Update date      | 
 |  7  | NOTICE\_CONTENT |    text   | 65535 |  0  |   N  |  N  |                    |      content      | 
 |  8  |  REDIRECT\_URL  |  varchar  |  200  |  0  |   Y  |  N  |                    |      location address      | 
 |  9  |   NOTICE\_TYPE  |  tinyint  |   4   |  0  |   N  |  N  |          0         | Message type:0. Pop-up box 1. Marquee| 

**Table name:** T\_PROJECT

**Description:**   Project information Sheet 

**Data column:** 

 |  No. |            name            |    Type Of Data   |   length  | decimal place | Allow Null |   primary key  |  defaultValue |       Description      | 
 | :-: | :----------------------: | :-------: | :---: | :-: | :--: | :-: | :--: | :-----------: | 
 |  1  |            ID            |   bigint  |   20  |  0  |   N  |  Y  |      |       primary key ID     | 
 |  2  |        created\_at       | timestamp |   19  |  0  |   Y  |  N  |      |      creationTime     | 
 |  3  |        updated\_at       | timestamp |   19  |  0  |   Y  |  N  |      |      updateTime     | 
 |  4  |        deleted\_at       | timestamp |   19  |  0  |   Y  |  N  |      |      deleteTime     | 
 |  5  |           extra          |    text   | 65535 |  0  |   Y  |  N  |      |      Additional Information     | 
 |  6  |          creator         |  varchar  |   32  |  0  |   Y  |  N  |      |      projectCreator      | 
 |  7  |        description       |    text   | 65535 |  0  |   Y  |  N  |      |       description      | 
 |  8  |           kind           |    int    |   10  |  0  |   Y  |  N  |      |      Container type     | 
 |  9  |        cc\_app\_id       |   bigint  |   20  |  0  |   Y  |  N  |      |      App ID     | 
 |  10 |       cc\_app\_name      |  varchar  |   64  |  0  |   Y  |  N  |      |      Apply name     | 
 |  11 |       is\_offlined       |    bit    |   1   |  0  |   Y  |  N  | b'0' |      Disable     | 
 |  12 |        PROJECT\_ID       |  varchar  |   32  |  0  |   N  |  N  |      |      Project ID     | 
 |  13 |       project\_name      |  varchar  |   64  |  0  |   N  |  N  |      |      project name     | 
 |  14 |       english\_name      |  varchar  |   64  |  0  |   N  |  N  |      |      English name     | 
 |  15 |          updator         |  varchar  |   32  |  0  |   Y  |  N  |      |      Updater      | 
 |  16 |       project\_type      |    int    |   10  |  0  |   Y  |  N  |      |      Project type     | 
 |  17 |          use\_bk         |    bit    |   1   |  0  |   Y  |  N  | b'1' |     Whether to use BlueKing     | 
 |  18 |       deploy\_type       |    text   | 65535 |  0  |   Y  |  N  |      |      Deploy type     | 
 |  19 |          bg\_id          |   bigint  |   20  |  0  |   Y  |  N  |      |     Business Group ID     | 
 |  20 |         bg\_name         |  varchar  |  255  |  0  |   Y  |  N  |      |     Business Group name     | 
 |  21 |         dept\_id         |   bigint  |   20  |  0  |   Y  |  N  |      |   ID of secondary institution of the project| 
 |  22 |        dept\_name        |  varchar  |  255  |  0  |   Y  |  N  |      |   Name of secondary institution of the project| 
 |  23 |        center\_id        |   bigint  |   20  |  0  |   Y  |  N  |      |      Site ID     | 
 |  24 |       center\_name       |  varchar  |  255  |  0  |   Y  |  N  |      |      Center Name     | 
 |  25 |         data\_id         |   bigint  |   20  |  0  |   Y  |  N  |      |      Data ID     | 
 |  26 |        is\_secrecy       |    bit    |   1   |  0  |   Y  |  N  | b'0' |      Confidentiality     | 
 |  27 | is\_helm\_chart\_enabled |    bit    |   1   |  0  |   Y  |  N  | b'0' |    Enable Chart Activation   | 
 |  28 |     approval\_status     |    int    |   10  |  0  |   Y  |  N  |   1  |      toCheck status     | 
 |  29 |        logo\_addr        |    text   | 65535 |  0  |   Y  |  N  |      |     Logo address    | 
 |  30 |         approver         |  varchar  |   32  |  0  |   Y  |  N  |      |      Approved by      | 
 |  31 |          remark          |    text   | 65535 |  0  |   Y  |  N  |      |       Commentary      | 
 |  32 |      approval\_time      | timestamp |   19  |  0  |   Y  |  N  |      |      Approval time     | 
 |  33 |     creator\_bg\_name    |  varchar  |  128  |  0  |   Y  |  N  |      |    projectCreator Business Group name   | 
 |  34 |    creator\_dept\_name   |  varchar  |  128  |  0  |   Y  |  N  |      | Name of secondary organization of projectCreator project| 
 |  35 |   creator\_center\_name  |  varchar  |  128  |  0  |   Y  |  N  |      |    projectCreator Center Name    | 
 |  36 |    hybrid\_cc\_app\_id   |   bigint  |   20  |  0  |   Y  |  N  |      |      App ID     | 
 |  37 |     enable\_external     |    bit    |   1   |  0  |   Y  |  N  |      |  Whether to support the agent to access the public network| 
 |  38 |        enable\_idc       |    bit    |   1   |  0  |   Y  |  N  |      |   Is the IDC agent supported| 
 |  39 |          enabled         |    bit    |   1   |  0  |   Y  |  N  |      |      Enable     | 
 |  40 |          CHANNEL         |  varchar  |   32  |  0  |   N  |  N  |  BS  |      project channel     | 
 |  41 |      pipeline\_limit     |    int    |   10  |  0  |   Y  |  N  |  500 |    Upper limit of Pipeline    | 
 |  42 |        router\_tag       |  varchar  |   32  |  0  |   Y  |  N  |      |    Gateway routing tags   | 
 |  43 |       relation\_id       |  varchar  |   32  |  0  |   Y  |  N  |      |    Extended system link ID   | 

**Table name:** T\_PROJECT\_LABEL

**Description:** 

**Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |  primary key ID | 
 |  2  |  LABEL\_NAME |  varchar |  45 |  0  |   N  |  N  |                    | label name| 
 |  3  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  4  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |Change the time| 

 **Table name:** T\_PROJECT\_LABEL\_REL 

 **Description:** 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |  primary key ID | 
 |  2  |   LABEL\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | label ID| 
 |  3  |  PROJECT\_ID |  varchar |  32 |  0  |   N  |  N  |                    | Project ID| 
 |  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  5  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |Change the time| 

 **Table name:** T\_SERVICE 

 **Description:** service Information Table 

 **Data column:** 

 |  No. |          name         |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |  defaultValue |       Description       | 
 | :-: | :-----------------: | :------: | :---: | :-: | :--: | :-: | :--: | :------------: | 
 |  1  |          id         |  bigint  |   20  |  0  |   N  |  Y  |      |       id       | 
 |  2  |         name        |  varchar |   64  |  0  |   Y  |  N  |      |       name       | 
 |  3  |    english\_name    |  varchar |   64  |  0  |   Y  |  N  |      |      English name      | 
 |  4  |  service\_type\_id  |  bigint  |   20  |  0  |   Y  |  N  |      |     service type ID     | 
 |  5  |         link        |  varchar |  255  |  0  |   Y  |  N  |      |      location link      | 
 |  6  |      link\_new      |  varchar |  255  |  0  |   Y  |  N  |      |      New location link     | 
 |  7  |     inject\_type    |  varchar |   64  |  0  |   Y  |  N  |      |      Injection type      | 
 |  8  |     iframe\_url     |  varchar |  255  |  0  |   Y  |  N  |      |   iframeUrl address| 
 |  9  |       css\_url      |  varchar |  255  |  0  |   Y  |  N  |      |    cssUrl address    | 
 |  10 |       js\_url       |  varchar |  255  |  0  |   Y  |  N  |      |     jsUrl address    | 
 |  11 | show\_project\_list |    bit   |   1   |  0  |   Y  |  N  |      |     Display on page    | 
 |  12 |      show\_nav      |    bit   |   1   |  0  |   Y  |  N  |      |     showNav    | 
 |  13 |  project\_id\_type  |  varchar |   64  |  0  |   Y  |  N  |      |     Project ID type     | 
 |  14 |        status       |  varchar |   64  |  0  |   Y  |  N  |      |       status       | 
 |  15 |    created\_user    |  varchar |   64  |  0  |   Y  |  N  |      |       projectCreator      | 
 |  16 |    created\_time    | datetime |   19  |  0  |   Y  |  N  |      |      creationTime      | 
 |  17 |    updated\_user    |  varchar |   64  |  0  |   Y  |  N  |      |       Updated by      | 
 |  18 |    updated\_time    | datetime |   19  |  0  |   Y  |  N  |      |      Change the time      | 
 |  19 |       deleted       |    bit   |   1   |  0  |   Y  |  N  |      |      Delete      | 
 |  20 |    gray\_css\_url   |  varchar |  255  |  0  |   Y  |  N  |      |   Grayscale cssUrl address   | 
 |  21 |    gray\_js\_url    |  varchar |  255  |  0  |   Y  |  N  |      |    Grayscale jsUrl address   | 
 |  22 |      logo\_url      |  varchar |  256  |  0  |   Y  |  N  |      |     Logo address     | 
 |  23 |     web\_socket     |   text   | 65535 |  0  |   Y  |  N  |      | WebSocket-enabled page| 
 |  24 |        weight       |    int   |   10  |  0  |   Y  |  N  |      |       weight value       | 
 |  25 |  gray\_iframe\_url  |  varchar |  255  |  0  |   Y  |  N  |      |  Grayscale iframeUrl address| 
 |  26 |     new\_window     |    bit   |   1   |  0  |   Y  |  N  | b'0' |    Open a new label    | 
 |  27 |    new\_windowUrl   |  varchar |  200  |  0  |   Y  |  N  |      |     New label address     | 

**Table name:** T\_SERVICE\_TYPE

 **Description:** service type Table 

 **Data column:** 

 |  No. |       name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |       ID       |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |      title     |  varchar |  64 |  0  |   Y  |  N  |     |  Email Header| 
 |  3  | english\_title |  varchar |  64 |  0  |   Y  |  N  |     | English Email Header| 
 |  4  |  created\_user |  varchar |  64 |  0  |   Y  |  N  |     |   projectCreator| 
 |  5  |  created\_time | datetime |  19 |  0  |   Y  |  N  |     |  creationTime| 
 |  6  |  updated\_user |  varchar |  64 |  0  |   Y  |  N  |     |   Updated by| 
 |  7  |  updated\_time | datetime |  19 |  0  |   Y  |  N  |     |  Change the time| 
 |  8  |     deleted    |    bit   |  1  |  0  |   Y  |  N  |     |  Delete| 
 |  9  |     weight     |    int   |  10 |  0  |   Y  |  N  |     |   weight value   | 

 **Table name:** T\_USER 

 **Description:** user Table 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description     | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------: | 
 |  1  |   USER\_ID   |  varchar |  64 |  0  |   N  |  Y  |                    |    user ID    | 
 |  2  |     NAME     |  varchar |  64 |  0  |   N  |  N  |                    |     name     | 
 |  3  |    BG\_ID    |    int   |  10 |  0  |   N  |  N  |                    |    Business Group ID   | 
 |  4  |   BG\_NAME   |  varchar | 256 |  0  |   N  |  N  |                    |    Business Group name   | 
 |  5  |   DEPT\_ID   |    int   |  10 |  0  |   Y  |  N  |                    | ID of secondary institution of the project| 
 |  6  |  DEPT\_NAME  |  varchar | 256 |  0  |   Y  |  N  |                    | Name of secondary institution of the project| 
 |  7  |  CENTER\_ID  |    int   |  10 |  0  |   Y  |  N  |                    |    Site ID    | 
 |  8  | CENTER\_NAME |  varchar | 256 |  0  |   Y  |  N  |                    |    Center Name    | 
 |  9  |   GROYP\_ID  |    int   |  10 |  0  |   Y  |  N  |                    |    userGroup ID   | 
 |  10 |  GROUP\_NAME |  varchar | 256 |  0  |   Y  |  N  |                    |    userGroup name   | 
 |  11 | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |                    |    creationTime    | 
 |  12 | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime    | 

 **Table name:** T\_USER\_DAILY\_FIRST\_AND\_LAST\_LOGIN 

 **Description:** 

 **Data column:** 

 |  No. |         name         |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :----------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |         ID         |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |      USER\_ID      |  varchar |  64 |  0  |   N  |  N  |     |  user ID| 
 |  3  |        DATE        |   date   |  10 |  0  |   N  |  N  |     |   date   | 
 |  4  | FIRST\_LOGIN\_TIME | datetime |  19 |  0  |   N  |  N  |     | First signIn time| 
 |  5  |  LAST\_LOGIN\_TIME | datetime |  19 |  0  |   N  |  N  |     | Recent signIn time| 

 **Table name:** T\_USER\_DAILY\_LOGIN 

 **Description:** 

 **Data column:** 

 |  No. |      name     |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :---------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |      ID     |  bigint  |  20 |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |   USER\_ID  |  varchar |  64 |  0  |   N  |  N  |     | user ID| 
 |  3  |     DATE    |   date   |  10 |  0  |   N  |  N  |     |  date| 
 |  4  | LOGIN\_TIME | datetime |  19 |  0  |   N  |  N  |     | signIn time| 
 |  5  |      OS     |  varchar |  32 |  0  |   N  |  N  |     | The operating system| 
 |  6  |      IP     |  varchar |  32 |  0  |   N  |  N  |     | IP| 
