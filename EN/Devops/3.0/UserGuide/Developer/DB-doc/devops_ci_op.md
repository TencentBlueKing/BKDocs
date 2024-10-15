# devops\_ci\_op

**The database name:** devops\_ci\_op

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_op

|                        Table name                       |  Description |
| :---------------------------------------------: | :-: |
|          [dept\_info](broken-reference)         |     |
|        [project\_info](broken-reference)        |     |
|             [role](broken-reference)            |     |
|       [role\_permission](broken-reference)      |     |
|       [schema\_version](broken-reference)       |     |
|       [spring\_session](broken-reference)       |     |
| [SPRING\_SESSION\_ATTRIBUTES](broken-reference) |     |
|        [t\_user\_token](broken-reference)       |     |
|         [url\_action](broken-reference)         |     |
|             [user](broken-reference)            |     |
|       [user\_permission](broken-reference)      |     |
|          [user\_role](broken-reference)         |     |

**Table name:** dept\_info

**Description:** 

**Data column:** 

 |  No. |        name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |     Description     | 
 | :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--------: | 
 |  1  |        id        |    int   |  10 |  0  |   N  |  Y  |     |     primary key ID    | 
 |  2  |   create\_time   | datetime |  19 |  0  |   Y  |  N  |     |    creationTime    | 
 |  3  |     dept\_id     |    int   |  10 |  0  |   N  |  N  |     | ID of secondary institution of the project| 
 |  4  |    dept\_name    |  varchar | 100 |  0  |   N  |  N  |     | Name of secondary institution of the project| 
 |  5  |       level      |    int   |  10 |  0  |   N  |  N  |     |    Hierarchy ID    | 
 |  6  | parent\_dept\_id |    int   |  10 |  0  |   Y  |  N  |     |            | 
 |  7  |   UPDATE\_TIME   | datetime |  19 |  0  |   Y  |  N  |     |    updateTime    | 

**Table name:** project\_info

**Description:** 

**Data column:** 

 |  No. |           name          |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |       Description      | 
 | :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-----------: | 
 |  1  |           id          |    int   |  10 |  0  |   N  |  Y  |     |       primary key ID     | 
 |  2  |    approval\_status   |    int   |  10 |  0  |   Y  |  N  |     |      toCheck status     | 
 |  3  |     approval\_time    | datetime |  19 |  0  |   Y  |  N  |     |      Approval time     | 
 |  4  |        approver       |  varchar | 100 |  0  |   Y  |  N  |     |      Approved by      | 
 |  5  |      cc\_app\_id      |    int   |  10 |  0  |   Y  |  N  |     |      App ID     | 
 |  6  |      created\_at      | datetime |  19 |  0  |   Y  |  N  |     |      creationTime     | 
 |  7  |        creator        |  varchar | 100 |  0  |   Y  |  N  |     |      projectCreator      | 
 |  8  |   creator\_bg\_name   |  varchar | 100 |  0  |   Y  |  N  |     |    projectCreator Business Group name   | 
 |  9  | creator\_center\_name |  varchar | 100 |  0  |   Y  |  N  |     |    projectCreator Center Name    | 
 |  10 |  creator\_dept\_name  |  varchar | 100 |  0  |   Y  |  N  |     | Name of secondary organization of projectCreator project| 
 |  11 |     english\_name     |  varchar | 255 |  0  |   Y  |  N  |     |      English name     | 
 |  12 |      is\_offlined     |    bit   |  1  |  0  |   Y  |  N  |     |      Disable     | 
 |  13 |      is\_secrecy      |    bit   |  1  |  0  |   Y  |  N  |     |      Confidentiality     | 
 |  14 |    project\_bg\_id    |    int   |  10 |  0  |   Y  |  N  |     |     Business Group ID     | 
 |  15 |   project\_bg\_name   |  varchar | 100 |  0  |   Y  |  N  |     |     Business Group name     | 
 |  16 |  project\_center\_id  |  varchar |  50 |  0  |   Y  |  N  |     |      Site ID     | 
 |  17 | project\_center\_name |  varchar | 100 |  0  |   Y  |  N  |     |      Center Name     | 
 |  18 |   project\_dept\_id   |    int   |  10 |  0  |   Y  |  N  |     |      Facility ID     | 
 |  19 |  project\_dept\_name  |  varchar | 100 |  0  |   Y  |  N  |     |   Name of secondary institution of the project| 
 |  20 |      project\_id      |  varchar | 100 |  0  |   Y  |  N  |     |      Project ID     | 
 |  21 |     project\_name     |  varchar | 100 |  0  |   Y  |  N  |     |      project name     | 
 |  22 |     project\_type     |    int   |  10 |  0  |   Y  |  N  |     |      Project type     | 
 |  23 |        use\_bk        |    bit   |  1  |  0  |   Y  |  N  |     |     Whether to use BlueKing     | 

**Table name:** role

**Description:** 

**Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |      id      |    int   |  10 |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |  description |  varchar | 255 |  0  |   Y  |  N  |     |  description| 
 |  3  |     name     |  varchar | 255 |  0  |   N  |  N  |     |  name  | 
 |  4  |   ch\_name   |  varchar | 255 |  0  |   Y  |  N  |     |  Branch name| 
 |  5  | create\_time | datetime |  19 |  0  |   Y  |  N  |     | creationTime| 
 |  6  | modify\_time | datetime |  19 |  0  |   Y  |  N  |     | Change the time| 

**Table name:** role\_permission

**Description:** 

**Data column:** 

 |  No. |        name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :-------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |        id       |    int   |  10 |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |   expire\_time  | datetime |  19 |  0  |   Y  |  N  |     | expireDate| 
 |  3  |     role\_id    |    int   |  10 |  0  |   Y  |  N  |     | Role ID| 
 |  4  | url\_action\_id |    int   |  10 |  0  |   Y  |  N  |     |      | 
 |  5  |   create\_time  | datetime |  19 |  0  |   Y  |  N  |     | creationTime| 
 |  6  |   modify\_time  | datetime |  19 |  0  |   Y  |  N  |     | Change the time| 

**Table name:** schema\_version

**Description:** 

**Data column:** 

 |  No. |        name       |    Type Of Data   |  length  | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :-------------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  | installed\_rank |    int    |  10  |  0  |   N  |  Y  |                    |      | 
 |  2  |     version     |  varchar  |  50  |  0  |   Y  |  N  |                    |  versionNum| 
 |  3  |   description   |  varchar  |  200 |  0  |   N  |  N  |                    |  description| 
 |  4  |       type      |  varchar  |  20  |  0  |   N  |  N  |                    |  type| 
 |  5  |      script     |  varchar  | 1000 |  0  |   N  |  N  |                    | Package Script| 
 |  6  |     checksum    |    int    |  10  |  0  |   Y  |  N  |                    |  Check| 
 |  7  |  installed\_by  |  varchar  |  100 |  0  |   N  |  N  |                    |  installer| 
 |  8  |  installed\_on  | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |installTime| 
 |  9  | execution\_time |    int    |  10  |  0  |   N  |  N  |                    | lastExecTime| 
 |  10 |     success     |    bit    |   1  |  0  |   N  |  N  |                    | Is it Success| 

**Table name:** spring\_session

**Description:** 

**Data column:** 

|  No. |            name           |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |     Description    |
| :-: | :---------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :-------: |
|  1  |       SESSION\_ID       |   char  |  36 |  0  |   N  |  Y  |     | SESSIONID |
|  2  |      CREATION\_TIME     |  bigint |  20 |  0  |   N  |  N  |     |     creationTime    |
|  3  |    LAST\_ACCESS\_TIME   |  bigint |  20 |  0  |   N  |  N  |     |           |
|  4  | MAX\_INACTIVE\_INTERVAL |   int   |  10 |  0  |   N  |  N  |     |           |
|  5  |     PRINCIPAL\_NAME     | varchar | 100 |  0  |   Y  |  N  |     |           |

**Table name:** SPRING\_SESSION\_ATTRIBUTES

**Description:** 

**Data column:** 

|  No. |        name        |   Type Of Data  |   length  | decimal place | Allow Null |   primary key  | defaultValue |     Description    |
| :-: | :--------------: | :-----: | :---: | :-: | :--: | :-: | :-: | :-------: |
|  1  |    SESSION\_ID   |   char  |   36  |  0  |   N  |  Y  |     | SESSIONID |
|  2  |  ATTRIBUTE\_NAME | varchar |  200  |  0  |   N  |  Y  |     |     attribute name   |
|  3  | ATTRIBUTE\_BYTES |   blob  | 65535 |  0  |   Y  |  N  |     |     attribute byte    |

**Table name:** t\_user\_token

**Description:** 

**Data column:** 

 |  No. |             name            |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |    Description   | 
 | :-: | :-----------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :-----: | 
 |  1  |          user\_Id         | varchar | 255 |  0  |   N  |  Y  |     |   user ID| 
 |  2  |       access\_Token       | varchar | 255 |  0  |   Y  |  N  |     | auth Token| 
 |  3  |    expire\_Time\_Mills    |  bigint |  20 |  0  |   N  |  N  |     |   expireDate| 
 |  4  | last\_Access\_Time\_Mills |  bigint |  20 |  0  |   N  |  N  |     |  Recent authentication time| 
 |  5  |       refresh\_Token      | varchar | 255 |  0  |   Y  |  N  |     | reflash token| 
 |  6  |         user\_Type        | varchar | 255 |  0  |   Y  |  N  |     |   User Type| 

**Table name:** url\_action

**Description:** 

**Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: | 
 |  1  |      id      |    int   |  10 |  0  |   N  |  Y  |     |   primary key ID | 
 |  2  |    action    |  varchar | 255 |  0  |   N  |  N  |     |   Operation| 
 |  3  |  description |  varchar | 255 |  0  |   Y  |  N  |     |   description| 
 |  4  |      url     |  varchar | 255 |  0  |   N  |  N  |     | URL address| 
 |  5  | create\_time | datetime |  19 |  0  |   Y  |  N  |     |  creationTime| 
 |  6  | modify\_time | datetime |  19 |  0  |   Y  |  N  |     |  Change the time| 

**Table name:** user

**Description:** 

**Data column:** 

 |  No. |         name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |         id        |    int   |  10 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |       chname      |  varchar | 255 |  0  |   Y  |  N  |     |        | 
 |  3  |    create\_time   | datetime |  19 |  0  |   Y  |  N  |     |  creationTime| 
 |  4  |       email       |  varchar | 255 |  0  |   Y  |  N  |     |  email | 
 |  5  |        lang       |  varchar | 255 |  0  |   Y  |  N  |     |   Language   | 
 |  6  | last\_login\_time | datetime |  19 |  0  |   Y  |  N  |     | Recent signIn time| 
 |  7  |       phone       |  varchar | 255 |  0  |   Y  |  N  |     |   Phone   | 
 |  8  |      username     |  varchar | 255 |  0  |   N  |  N  |     |  user name| 

**Table name:** user\_permission

**Description:** 

**Data column:** 

 |  No. |        name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :-------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |        id       |    int   |  10 |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |   expire\_time  | datetime |  19 |  0  |   Y  |  N  |     | expireDate| 
 |  3  | url\_action\_id |    int   |  10 |  0  |   Y  |  N  |     |      | 
 |  4  |     user\_id    |    int   |  10 |  0  |   Y  |  N  |     | user ID| 
 |  5  |   create\_time  | datetime |  19 |  0  |   Y  |  N  |     | creationTime| 
 |  6  |   modify\_time  | datetime |  19 |  0  |   Y  |  N  |     | Change the time| 

**Table name:** user\_role

**Description:** 

**Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |      id      |    int   |  10 |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |   role\_id   |    int   |  10 |  0  |   Y  |  N  |     | Role ID| 
 |  3  |   user\_id   |    int   |  10 |  0  |   Y  |  N  |     | user ID| 
 |  4  | expire\_time | datetime |  19 |  0  |   Y  |  N  |     | expireDate| 
 |  5  | create\_time | datetime |  19 |  0  |   Y  |  N  |     | creationTime| 
 |  6  | modify\_time | datetime |  19 |  0  |   Y  |  N  |     | Change the time| 
