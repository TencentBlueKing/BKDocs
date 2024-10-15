# devops\_ci\_process

**The database name:** devops\_ci\_process

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_process

|                              Table name                              |      Description      |
| :----------------------------------------------------------: | :----------: |
|            [T\_AUDIT\_RESOURCE](broken-reference)            |              |
|         [T\_BUILD\_STARTUP\_PARAM](broken-reference)         |   Pipeline Start Up var table   |
|                [T\_METADATA](broken-reference)               |              |
|     [T\_PIPELINE\_ATOM\_REPLACE\_BASE](broken-reference)     | Pipeline Plugin Replace Basic Information Table |
|    [T\_PIPELINE\_ATOM\_REPLACE\_HISTORY](broken-reference)   | Pipeline Plugin Replace history information table |
|     [T\_PIPELINE\_ATOM\_REPLACE\_ITEM](broken-reference)     |  Pipeline Plugin Replace Information Table |
|       [T\_PIPELINE\_BUILD\_CONTAINER](broken-reference)      |  Pipeline build Container environment Table  |
|        [T\_PIPELINE\_BUILD\_DETAIL](broken-reference)        |   Pipeline buildDetail Sheet   |
|        [T\_PIPELINE\_BUILD\_HISTORY](broken-reference)       |   Pipeline build History Table   |
|   [T\_PIPELINE\_BUILD\_HIS\_DATA\_CLEAR](broken-reference)   | Pipeline build data Cleanup Statistics |
|         [T\_PIPELINE\_BUILD\_STAGE](broken-reference)        |   Pipeline Build Phase table   |
|        [T\_PIPELINE\_BUILD\_SUMMARY](broken-reference)       |   Pipeline build Summary Table    |
|         [T\_PIPELINE\_BUILD\_TASK](broken-reference)         |   Pipeline buildTask Table   |
|          [T\_PIPELINE\_BUILD\_VAR](broken-reference)         |    pipelineVar table    |
|      [T\_PIPELINE\_CONTAINER\_MONITOR](broken-reference)     |              |
|         [T\_PIPELINE\_DATA\_CLEAR](broken-reference)         |  Pipeline data Cleaning Statistics  |
|    [T\_PIPELINE\_FAILURE\_NOTIFY\_USER](broken-reference)    |              |
|            [T\_PIPELINE\_FAVOR](broken-reference)            |    Pipeline toCollect table    |
|            [T\_PIPELINE\_GROUP](broken-reference)            |    Pipeline group table    |
|             [T\_PIPELINE\_INFO](broken-reference)            |    Pipeline information table    |
|      [T\_PIPELINE\_JOB\_MUTEX\_GROUP](broken-reference)      |              |
|            [T\_PIPELINE\_LABEL](broken-reference)            |    Pipeline Lable Table    |
|       [T\_PIPELINE\_LABEL\_PIPELINE](broken-reference)       |   Pipeline mapping table  |
|         [T\_PIPELINE\_MODEL\_TASK](broken-reference)         | Pipeline model task Task table |
|         [T\_PIPELINE\_MUTEX\_GROUP](broken-reference)        |    Pipeline exclusive list    |
|         [T\_PIPELINE\_PAUSE\_VALUE](broken-reference)        |   Pipeline PAUSE var table   |
|         [T\_PIPELINE\_REMOTE\_AUTH](broken-reference)        | Pipeline Remote triggers Auth table |
|           [T\_PIPELINE\_RESOURCE](broken-reference)          |    Pipeline resources table    |
|      [T\_PIPELINE\_RESOURCE\_VERSION](broken-reference)      |   Pipeline Resource Version table   |
|             [T\_PIPELINE\_RULE](broken-reference)            |   Pipeline Rule Information Table   |
|           [T\_PIPELINE\_SETTING](broken-reference)           |   Pipeline Basic Config table   |
|       [T\_PIPELINE\_SETTING\_VERSION](broken-reference)      |  Pipeline Basic Config version Table  |
|          [T\_PIPELINE\_STAGE\_TAG](broken-reference)         |              |
|           [T\_PIPELINE\_TEMPLATE](broken-reference)          |    Pipeline Template Tabl    |
|            [T\_PIPELINE\_TIMER](broken-reference)            |              |
|             [T\_PIPELINE\_USER](broken-reference)            |              |
|             [T\_PIPELINE\_VIEW](broken-reference)            |              |
|         [T\_PIPELINE\_VIEW\_LABEL](broken-reference)         |              |
|        [T\_PIPELINE\_VIEW\_PROJECT](broken-reference)        |              |
|    [T\_PIPELINE\_VIEW\_USER\_LAST\_VIEW](broken-reference)   |              |
|     [T\_PIPELINE\_VIEW\_USER\_SETTINGS](broken-reference)    |              |
|           [T\_PIPELINE\_WEBHOOK](broken-reference)           |              |
|     [T\_PIPELINE\_WEBHOOK\_BUILD\_LOG](broken-reference)     |              |
| [T\_PIPELINE\_WEBHOOK\_BUILD\_LOG\_DETAIL](broken-reference) |              |
|        [T\_PIPELINE\_WEBHOOK\_QUEUE](broken-reference)       |              |
|      [T\_PROJECT\_PIPELINE\_CALLBACK](broken-reference)      |              |
|  [T\_PROJECT\_PIPELINE\_CALLBACK\_HISTORY](broken-reference) |              |
|                 [T\_REPORT](broken-reference)                |    Pipeline List    |
|                [T\_TEMPLATE](broken-reference)               |   Pipeline Template Information Table   |
|        [T\_TEMPLATE\_INSTANCE\_BASE](broken-reference)       |  Basic Information Table of Template Implementation  |
|        [T\_TEMPLATE\_INSTANCE\_ITEM](broken-reference)       |   Template Implementation Item Info Table  |
|           [T\_TEMPLATE\_PIPELINE](broken-reference)          |  Pipeline Template-Instance Mapping Table |

**Table name:** T\_AUDIT\_RESOURCE

**Description:** 

**Data column:** 

|  No. |        name       |    Type Of Data   |  length  | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
| :-: | :-------------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :--: | 
|  1  |        ID       |   bigint  |  20  |  0  |   N  |  Y  |                    |  primary key ID | 
|  2  |  RESOURCE\_TYPE |  varchar  |  32  |  0  |   N  |  N  |                    | Resource type| 
|  3  |   RESOURCE\_ID  |  varchar  |  128 |  0  |   N  |  N  |                    | Resource ID| 
|  4  |  RESOURCE\_NAME |  varchar  |  128 |  0  |   N  |  N  |                    | resources name| 
|  5  |     USER\_ID    |  varchar  |  64  |  0  |   N  |  N  |                    | user ID| 
|  6  |      ACTION     |  varchar  |  64  |  0  |   N  |  N  |                    |  Operation| 
|  7  | ACTION\_CONTENT |  varchar  | 1024 |  0  |   N  |  N  |                    | Operation content| 
|  8  |  CREATED\_TIME  | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
|  9  |      STATUS     |  varchar  |  32  |  0  |   Y  |  N  |                    |  status| 
|  10 |   PROJECT\_ID   |  varchar  |  128 |  0  |   N  |  N  |                    | Project ID| 

**Table name:** T\_BUILD\_STARTUP\_PARAM

**Description:**  Pipeline Start Up var table

**Data column:** 

|  No. |      name      |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :-: | :---: | 
|  1  |      ID      |   bigint   |    20    |  0  |   N  |  Y  |     |   primary key ID | 
|  2  |   BUILD\_ID  |   varchar  |    64    |  0  |   N  |  N  |     |  build ID| 
|  3  |     PARAM    | mediumtext | 16777215 |  0  |   N  |  N  |     |   Parameter| 
|  4  |  PROJECT\_ID |   varchar  |    64    |  0  |   Y  |  N  |     |  Project ID| 
|  5  | PIPELINE\_ID |   varchar  |    64    |  0  |   Y  |  N  |     | pipelineId| 

**Table name:** T\_METADATA

**Description:** 

**Data column:** 

|  No. |         name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  | 
| :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---: | 
|  1  |         ID        |  bigint  |  20 |  0  |   N  |  Y  |                    |   primary key ID | 
|  2  |    PROJECT\_ID    |  varchar |  32 |  0  |   N  |  N  |                    |  Project ID| 
|  3  |    PIPELINE\_ID   |  varchar |  34 |  0  |   N  |  N  |                    | pipelineId| 
|  4  |     BUILD\_ID     |  varchar |  34 |  0  |   N  |  N  |                    |  build ID| 
|  5  |   META\_DATA\_ID  |  varchar | 128 |  0  |   N  |  N  |                    | Data ID| 
|  6  | META\_DATA\_VALUE |  varchar | 255 |  0  |   N  |  N  |                    |  metaData value| 
|  7  |    CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 

**Table name:** T\_PIPELINE\_ATOM\_REPLACE\_BASE

**Description:**  Pipeline Plugin Replace Basic Information Table

**Data column:** 

|  No. |         name         |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |          defaultValue          |    Description   | 
| :-: | :----------------: | :------: | :---: | :-: | :--: | :-: | :-------------------: | :-----: | 
|  1  |         ID         |  varchar |   32  |  0  |   N  |  Y  |                       |    primary key ID  | 
|  2  |     PROJECT\_ID    |  varchar |   64  |  0  |   Y  |  N  |                       |   Project ID| 
|  3  | PIPELINE\_ID\_INFO |   text   | 65535 |  0  |   Y  |  N  |                       | pipelineId Information| 
|  4  |  FROM\_ATOM\_CODE  |  varchar |   64  |  0  |   N  |  N  |                       | Replace Plugin Code| 
|  5  |   TO\_ATOM\_CODE   |  varchar |   64  |  0  |   N  |  N  |                       | Replace Plugin Code| 
|  6  |       STATUS       |  varchar |   32  |  0  |   N  |  N  |          INIT         |    status   | 
|  7  |       CREATOR      |  varchar |   50  |  0  |   N  |  N  |         system        |   projectCreator   | 
|  8  |      MODIFIER      |  varchar |   50  |  0  |   N  |  N  |         system        |   Updated by   | 
|  9  |    UPDATE\_TIME    | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   Change the time| 
|  10 |    CREATE\_TIME    | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   creationTime| 

**Table name:** T\_PIPELINE\_ATOM\_REPLACE\_HISTORY

**Description:**  Pipeline Plugin Replace history information table

**Data column:** 

|  No. |        name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |          defaultValue          |     Description     | 
| :-: | :-------------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :--------: | 
|  1  |        ID       |  varchar |  32 |  0  |   N  |  Y  |                       |     primary key ID    | 
|  2  |   PROJECT\_ID   |  varchar |  64 |  0  |   Y  |  N  |                       |    Project ID    | 
|  3  |     BUS\_ID     |  varchar |  34 |  0  |   N  |  N  |                       |    serviceId    | 
|  4  |    BUS\_TYPE    |  varchar |  32 |  0  |   N  |  N  |        PIPELINE       |    Biz type    | 
|  5  | SOURCE\_VERSION |    int   |  10 |  0  |   N  |  N  |                       |    Source versionNum    | 
|  6  | TARGET\_VERSION |    int   |  10 |  0  |   Y  |  N  |                       |    Target versionNum   | 
|  7  |      STATUS     |  varchar |  32 |  0  |   N  |  N  |                       |     status     | 
|  8  |       LOG       |  varchar | 128 |  0  |   Y  |  N  |                       |     log     | 
|  9  |     BASE\_ID    |  varchar |  32 |  0  |   N  |  N  |                       | Plugin Replace Basic Information ID| 
|  10 |     ITEM\_ID    |  varchar |  32 |  0  |   N  |  N  |                       |  Plugin Replace Info ID| 
|  11 |     CREATOR     |  varchar |  50 |  0  |   N  |  N  |         system        |     projectCreator    | 
|  12 |     MODIFIER    |  varchar |  50 |  0  |   N  |  N  |         system        |     Updated by    | 
|  13 |   UPDATE\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    Change the time    | 
|  14 |   CREATE\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    creationTime    | 

**Table name:** T\_PIPELINE\_ATOM\_REPLACE\_ITEM

**Description:**  Pipeline Plugin Replace Information Table

**Data column:** 

|  No. |          name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |          defaultValue          |     Description     | 
| :-: | :------------------: | :------: | :---: | :-: | :--: | :-: | :-------------------: | :--------: | 
|  1  |          ID          |  varchar |   32  |  0  |   N  |  Y  |                       |     primary key ID    | 
|  2  |   FROM\_ATOM\_CODE   |  varchar |   64  |  0  |   N  |  N  |                       |   Replace Plugin Code| 
|  3  |  FROM\_ATOM\_VERSION |  varchar |   20  |  0  |   N  |  N  |                       |  Replace Plugin versionNum| 
|  4  |    TO\_ATOM\_CODE    |  varchar |   64  |  0  |   N  |  N  |                       |   Replace Plugin Code   | 
|  5  |   TO\_ATOM\_VERSION  |  varchar |   20  |  0  |   N  |  N  |                       |   Replace Plugin versionNum| 
|  6  |        STATUS        |  varchar |   32  |  0  |   N  |  N  |          INIT         |     status     | 
|  7  | PARAM\_REPLACE\_INFO |   text   | 65535 |  0  |   Y  |  N  |                       |  Plugin Parameter Replace information| 
|  8  |       BASE\_ID       |  varchar |   32  |  0  |   N  |  N  |                       | Plugin Replace Basic Information ID| 
|  9  |        CREATOR       |  varchar |   50  |  0  |   N  |  N  |         system        |     projectCreator    | 
|  10 |       MODIFIER       |  varchar |   50  |  0  |   N  |  N  |         system        |     Updated by    | 
|  11 |     UPDATE\_TIME     | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    Change the time    | 
|  12 |     CREATE\_TIME     | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    creationTime    | 

**Table name:** T\_PIPELINE\_BUILD\_CONTAINER

**Description:**  Pipeline build Container environment Table

**Data column:** 

|  No. |        name       |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
| :-: | :-------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :-------: | 
|  1  |   PROJECT\_ID   |   varchar  |    64    |  0  |   N  |  N  |                    |    Project ID   | 
|  2  |   PIPELINE\_ID  |   varchar  |    64    |  0  |   N  |  N  |                    |   pipelineId   | 
|  3  |    BUILD\_ID    |   varchar  |    64    |  0  |   N  |  Y  |                    |    build ID   | 
|  4  |    STAGE\_ID    |   varchar  |    64    |  0  |   N  |  Y  |                    | current stageId| 
|  5  |  CONTAINER\_ID  |   varchar  |    64    |  0  |   N  |  Y  |                    |   build Container ID| 
|  6  | CONTAINER\_TYPE |   varchar  |    45    |  0  |   Y  |  N  |                    |    Container type   | 
|  7  |       SEQ       |     int    |    10    |  0  |   N  |  N  |                    |           | 
|  8  |      STATUS     |     int    |    10    |  0  |   Y  |  N  |                    |     status    | 
|  9  |   START\_TIME   |  timestamp |    19    |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |    Starting Time   | 
|  10 |    END\_TIME    |  timestamp |    19    |  0  |   Y  |  N  |                    |    End Time   | 
|  11 |       COST      |     int    |    10    |  0  |   Y  |  N  |          0         |     cost    | 
|  12 |  EXECUTE\_COUNT |     int    |    10    |  0  |   Y  |  N  |          1         |    Number of execute   | 
|  13 |    CONDITIONS   | mediumtext | 16777215 |  0  |   Y  |  N  |                    |     Status    | 

**Table name:** T\_PIPELINE\_BUILD\_DETAIL

**Description:**  Pipeline buildDetail Sheet

**Data column:** 

|  No. |      name      |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :-: | :---: | 
|  1  |  PROJECT\_ID |   varchar  |    64    |  0  |   N  |  N  |     |       | 
|  2  |   BUILD\_ID  |   varchar  |    34    |  0  |   N  |  Y  |     |  build ID| 
|  3  |  BUILD\_NUM  |     int    |    10    |  0  |   Y  |  N  |     |  Number of build| 
|  4  |     MODEL    | mediumtext | 16777215 |  0  |   Y  |  N  |     | Pipeline model| 
|  5  |  START\_USER |   varchar  |    32    |  0  |   Y  |  N  |     |  Start Up| 
|  6  |    TRIGGER   |   varchar  |    32    |  0  |   Y  |  N  |     |  Triggers| 
|  7  |  START\_TIME |  datetime  |    19    |  0  |   Y  |  N  |     |  Starting Time| 
|  8  |   END\_TIME  |  datetime  |    19    |  0  |   Y  |  N  |     |  End Time| 
|  9  |    STATUS    |   varchar  |    32    |  0  |   Y  |  N  |     |   status| 
|  10 | CANCEL\_USER |   varchar  |    32    |  0  |   Y  |  N  |     |  cancel| 

**Table name:** T\_PIPELINE\_BUILD\_HISTORY

**Description:**  Pipeline build History Table

**Data column:** 

|  No. |         name         |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |  defaultValue |     Description    | 
| :-: | :----------------: | :--------: | :------: | :-: | :--: | :-: | :--: | :-------: | 
|  1  |      BUILD\_ID     |   varchar  |    34    |  0  |   N  |  Y  |      |    build ID   | 
|  2  |  PARENT\_BUILD\_ID |   varchar  |    34    |  0  |   Y  |  N  |      |   Parent build ID| 
|  3  |  PARENT\_TASK\_ID  |   varchar  |    34    |  0  |   Y  |  N  |      |   Parent Task ID| 
|  4  |     BUILD\_NUM     |     int    |    10    |  0  |   Y  |  N  |   0  |    Number of build   | 
|  5  |     PROJECT\_ID    |   varchar  |    64    |  0  |   N  |  N  |      |    Project ID   | 
|  6  |    PIPELINE\_ID    |   varchar  |    34    |  0  |   N  |  N  |      |   pipelineId   | 
|  7  |       VERSION      |     int    |    10    |  0  |   Y  |  N  |      |    versionNum    | 
|  8  |     START\_USER    |   varchar  |    64    |  0  |   Y  |  N  |      |    Start Up    | 
|  9  |       TRIGGER      |   varchar  |    32    |  0  |   N  |  N  |      |    Triggers    | 
|  10 |     START\_TIME    |  timestamp |    19    |  0  |   Y  |  N  |      |    Starting Time   | 
|  11 |      END\_TIME     |  timestamp |    19    |  0  |   Y  |  N  |      |    End Time   | 
|  12 |       STATUS       |     int    |    10    |  0  |   Y  |  N  |      |     status    | 
|  13 |    STAGE\_STATUS   |    text    |   65535  |  0  |   Y  |  N  |      |  status of each Stage of Pipeline| 
|  14 |     TASK\_COUNT    |     int    |    10    |  0  |   Y  |  N  |      |  Quantity of Pipeline Task| 
|  15 |   FIRST\_TASK\_ID  |   varchar  |    34    |  0  |   Y  |  N  |      |   First Task ID| 
|  16 |       CHANNEL      |   varchar  |    32    |  0  |   Y  |  N  |      |    project channel   | 
|  17 |    TRIGGER\_USER   |   varchar  |    64    |  0  |   Y  |  N  |      |    trigger    | 
|  18 |      MATERIAL      | mediumtext | 16777215 |  0  |   Y  |  N  |      |    raw material    | 
|  19 |     QUEUE\_TIME    |  timestamp |    19    |  0  |   Y  |  N  |      |   QUEUE Starting Time| 
|  20 |   ARTIFACT\_INFO   | mediumtext | 16777215 |  0  |   Y  |  N  |      |   artifactList Information| 
|  21 |       REMARK       |   varchar  |   4096   |  0  |   Y  |  N  |      |     Commentary    | 
|  22 |    EXECUTE\_TIME   |   bigint   |    20    |  0  |   Y  |  N  |      |    lastExecTime   | 
|  23 |  BUILD\_PARAMETERS | mediumtext | 16777215 |  0  |   Y  |  N  |      |   buildEnvType Parameter| 
|  24 |    WEBHOOK\_TYPE   |   varchar  |    64    |  0  |   Y  |  N  |      | WEBHOOK type| 
|  25 | RECOMMEND\_VERSION |   varchar  |    64    |  0  |   Y  |  N  |      |   recommendVersion   | 
|  26 |     ERROR\_TYPE    |     int    |    10    |  0  |   Y  |  N  |      |    Error Type   | 
|  27 |     ERROR\_CODE    |     int    |    10    |  0  |   Y  |  N  |      |    Error Code    | 
|  28 |     ERROR\_MSG     |    text    |   65535  |  0  |   Y  |  N  |      |    Error description   | 
|  29 |    WEBHOOK\_INFO   |    text    |   65535  |  0  |   Y  |  N  |      | Webhook information| 
|  30 |      IS\_RETRY     |     bit    |     1    |  0  |   Y  |  N  | b'0' |    retry or not   | 
|  31 |     ERROR\_INFO    |    text    |   65535  |  0  |   Y  |  N  |      |    Error Message   | 
|  32 |     BUILD\_MSG     |   varchar  |    255   |  0  |   Y  |  N  |      |    build Information   | 
|  33 |  BUILD\_NUM\_ALIAS |   varchar  |    256   |  0  |   Y  |  N  |      |   customize buildNo| 

**Table name:** T\_PIPELINE\_BUILD\_HIS\_DATA\_CLEAR

**Description:**  Pipeline build data Cleanup Statistics

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |          defaultValue          |   Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :---: | 
|  1  |   BUILD\_ID  |  varchar |  34 |  0  |   N  |  Y  |                       |  build ID| 
|  2  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                       | pipelineId| 
|  3  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |                       |  Project ID| 
|  4  |   DEL\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |       | 

**Table name:** T\_PIPELINE\_BUILD\_STAGE 

**Description:**  Pipeline Build Phase table 

**Data column:** 

|  No. |       name       |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
| :-: | :------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :-------: | 
|  1  |   PROJECT\_ID  |   varchar  |    64    |  0  |   N  |  N  |                    |    Project ID   | 
|  2  |  PIPELINE\_ID  |   varchar  |    64    |  0  |   N  |  N  |                    |   pipelineId   | 
|  3  |    BUILD\_ID   |   varchar  |    64    |  0  |   N  |  Y  |                    |    build ID   | 
|  4  |    STAGE\_ID   |   varchar  |    64    |  0  |   N  |  Y  |                    | current stageId| 
|  5  |       SEQ      |     int    |    10    |  0  |   N  |  N  |                    |           | 
|  6  |     STATUS     |     int    |    10    |  0  |   Y  |  N  |                    |     status    | 
|  7  |   START\_TIME  |  timestamp |    19    |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |    Starting Time   | 
|  8  |    END\_TIME   |  timestamp |    19    |  0  |   Y  |  N  |                    |    End Time   | 
|  9  |      COST      |     int    |    10    |  0  |   Y  |  N  |          0         |     cost    | 
|  10 | EXECUTE\_COUNT |     int    |    10    |  0  |   Y  |  N  |          1         |    Number of execute   | 
|  11 |   CONDITIONS   | mediumtext | 16777215 |  0  |   Y  |  N  |                    |     Status    | 
|  12 |    CHECK\_IN   | mediumtext | 16777215 |  0  |   Y  |  N  |                    |   allowEnter Check setting| 
|  13 |   CHECK\_OUT   | mediumtext | 16777215 |  0  |   Y  |  N  |                    |   allowLeave setting| 

**Table name:** T\_PIPELINE\_BUILD\_SUMMARY

**Description:**  Pipeline build Summary Table 

**Data column:** 

|  No. |          name         |    Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
| :-: | :-----------------: | :-------: | :-: | :-: | :--: | :-: | :-: | :----: | 
|  1  |     PIPELINE\_ID    |  varchar  |  34 |  0  |   N  |  Y  |     |  pipelineId| 
|  2  |     PROJECT\_ID     |  varchar  |  64 |  0  |   N  |  N  |     |  Project ID| 
|  3  |      BUILD\_NUM     |    int    |  10 |  0  |   Y  |  N  |  0  |Number of build| 
|  4  |      BUILD\_NO      |    int    |  10 |  0  |   Y  |  N  |  0  |   buildNo| 
|  5  |    FINISH\_COUNT    |    int    |  10 |  0  |   Y  |  N  |  0  |Number of complete| 
|  6  |    RUNNING\_COUNT   |    int    |  10 |  0  |   Y  |  N  |  0  |Run times| 
|  7  |     QUEUE\_COUNT    |    int    |  10 |  0  |   Y  |  N  |  0  |QUEUE times| 
|  8  |  LATEST\_BUILD\_ID  |  varchar  |  34 |  0  |   Y  |  N  |     | Recent build ID| 
|  9  |   LATEST\_TASK\_ID  |  varchar  |  34 |  0  |   Y  |  N  |     | Recent Task ID| 
|  10 | LATEST\_START\_USER |  varchar  |  64 |  0  |   Y  |  N  |     |  Recent Start Up| 
|  11 | LATEST\_START\_TIME | timestamp |  19 |  0  |   Y  |  N  |     | Recent Start Time| 
|  12 |  LATEST\_END\_TIME  | timestamp |  19 |  0  |   Y  |  N  |     | Recent End Time| 
|  13 | LATEST\_TASK\_COUNT |    int    |  10 |  0  |   Y  |  N  |     | Recent Task Total| 
|  14 |  LATEST\_TASK\_NAME |  varchar  | 128 |  0  |   Y  |  N  |     | Recent Task Name| 
|  15 |    LATEST\_STATUS   |    int    |  10 |  0  |   Y  |  N  |     |  Recent status| 
|  16 |  BUILD\_NUM\_ALIAS  |  varchar  | 256 |  0  |   Y  |  N  |     | customize buildNo| 

**Table name:** T\_PIPELINE\_BUILD\_TASK 

**Description:**  Pipeline buildTask Table 

**Data column:** 

|  No. |          name         |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  | defaultValue |     Description    | 
| :-: | :-----------------: | :--------: | :------: | :-: | :--: | :-: | :-: | :-------: | 
|  1  |     PIPELINE\_ID    |   varchar  |    34    |  0  |   N  |  N  |     |   pipelineId   | 
|  2  |     PROJECT\_ID     |   varchar  |    64    |  0  |   N  |  N  |     |    Project ID   | 
|  3  |      BUILD\_ID      |   varchar  |    34    |  0  |   N  |  Y  |     |    build ID   | 
|  4  |      STAGE\_ID      |   varchar  |    34    |  0  |   N  |  N  |     | current stageId| 
|  5  |    CONTAINER\_ID    |   varchar  |    34    |  0  |   N  |  N  |     |   build Container ID| 
|  6  |      TASK\_NAME     |   varchar  |    128   |  0  |   Y  |  N  |     |    Task name   | 
|  7  |       TASK\_ID      |   varchar  |    34    |  0  |   N  |  Y  |     |    Task ID   | 
|  8  |     TASK\_PARAMS    | mediumtext | 16777215 |  0  |   Y  |  N  |     |   Task Parameter Collection| 
|  9  |      TASK\_TYPE     |   varchar  |    64    |  0  |   N  |  N  |     |    Task type   | 
|  10 |      TASK\_ATOM     |   varchar  |    128   |  0  |   Y  |  N  |     |  Task atom Code| 
|  11 |      ATOM\_CODE     |   varchar  |    128   |  0  |   Y  |  N  |     |  Unique identification of the Plugin| 
|  12 |     START\_TIME     |  timestamp |    19    |  0  |   Y  |  N  |     |    Starting Time   | 
|  13 |      END\_TIME      |  timestamp |    19    |  0  |   Y  |  N  |     |    End Time   | 
|  14 |       STARTER       |   varchar  |    64    |  0  |   N  |  N  |     |    executor    | 
|  15 |       APPROVER      |   varchar  |    64    |  0  |   Y  |  N  |     |    Approved by    | 
|  16 |        STATUS       |     int    |    10    |  0  |   Y  |  N  |     |     status    | 
|  17 |    EXECUTE\_COUNT   |     int    |    10    |  0  |   Y  |  N  |  0  |    Number of execute   | 
|  18 |      TASK\_SEQ      |     int    |    10    |  0  |   Y  |  N  |  1  |    Task index   | 
|  19 |   SUB\_PROJECT\_ID  |   varchar  |    64    |  0  |   Y  |  N  |     |   Project ID   | 
|  20 |    SUB\_BUILD\_ID   |   varchar  |    34    |  0  |   Y  |  N  |     |   build id   | 
|  21 |   CONTAINER\_TYPE   |   varchar  |    45    |  0  |   Y  |  N  |     |    Container type   | 
|  22 | ADDITIONAL\_OPTIONS | mediumtext | 16777215 |  0  |   Y  |  N  |     |    otherChoice   | 
|  23 |     TOTAL\_TIME     |   bigint   |    20    |  0  |   Y  |  N  |     |    total time   | 
|  24 |     ERROR\_TYPE     |     int    |    10    |  0  |   Y  |  N  |     |    Error Type   | 
|  25 |     ERROR\_CODE     |     int    |    10    |  0  |   Y  |  N  |     |    Error Code    | 
|  26 |      ERROR\_MSG     |    text    |   65535  |  0  |   Y  |  N  |     |    Error description   | 
|  27 | CONTAINER\_HASH\_ID |   varchar  |    64    |  0  |   Y  |  N  |     | build Job Unique ID| 

**Table name:** T\_PIPELINE\_BUILD\_VAR

**Description:**  pipelineVar table

**Data column:** 

|  No. |      name      |   Type Of Data  |  length  | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :----------: | :-----: | :--: | :-: | :--: | :-: | :-: | :---: | 
|  1  |   BUILD\_ID  | varchar |  34  |  0  |   N  |  Y  |     |  build ID| 
|  2  |      KEY     | varchar |  255 |  0  |   N  |  Y  |     |   key   | 
|  3  |     VALUE    | varchar | 4000 |  0  |   Y  |  N  |     |   Value   | 
|  4  |  PROJECT\_ID | varchar |  64  |  0  |   Y  |  N  |     |  Project ID| 
|  5  | PIPELINE\_ID | varchar |  64  |  0  |   Y  |  N  |     | pipelineId| 
|  6  |   VAR\_TYPE  | varchar |  64  |  0  |   Y  |  N  |     |  paramsType| 
|  7  |  READ\_ONLY  |   bit   |   1  |  0  |   Y  |  N  |     |  Read Only| 

**Table name:** T\_PIPELINE\_CONTAINER\_MONITOR 

**Description:** 

**Data column:** 

|  No. |         name         |   Type Of Data  |  length  | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
| :-: | :----------------: | :-----: | :--: | :-: | :--: | :-: | :-: | :----: | 
|  1  |         ID         |  bigint |  20  |  0  |   N  |  Y  |     |   primary key ID  | 
|  2  |      OS\_TYPE      | varchar |  32  |  0  |   N  |  N  |     |  type of system| 
|  3  |     BUILD\_TYPE    | varchar |  32  |  0  |   N  |  N  |     |  build type| 
|  4  | MAX\_STARTUP\_TIME |  bigint |  20  |  0  |   N  |  N  |     | Maximum Start Time| 
|  5  | MAX\_EXECUTE\_TIME |  bigint |  20  |  0  |   N  |  N  |     | Maximum lastExecTime| 
|  6  |        USERS       | varchar | 1024 |  0  |   N  |  N  |     |  user List| 

**Table name:** T\_PIPELINE\_DATA\_CLEAR 

**Description:**  Pipeline data Cleaning Statistics 

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |          defaultValue          |   Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :---: | 
|  1  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  Y  |                       | pipelineId| 
|  2  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |                       |  Project ID| 
|  3  |   DEL\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |       | 

**Table name:** T\_PIPELINE\_FAILURE\_NOTIFY\_USER 

**Description:** 

**Data column:** 

|  No. |       name      |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
| :-: | :-----------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: | 
|  1  |       ID      |  bigint |  20 |  0  |   N  |  Y  |     |  primary key ID | 
|  2  |    USER\_ID   | varchar |  32 |  0  |   Y  |  N  |     | user ID| 
|  3  | NOTIFY\_TYPES | varchar |  32 |  0  |   Y  |  N  |     | type of notification| 

**Table name:** T\_PIPELINE\_FAVOR 

**Description:**  Pipeline toCollect table 

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: | 
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID | 
|  2  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     |  Project ID| 
|  3  | PIPELINE\_ID |  varchar |  64 |  0  |   N  |  N  |     | pipelineId| 
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
|  5  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  projectCreator| 

**Table name:** T\_PIPELINE\_GROUP

**Description:**  Pipeline group table

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  primary key ID | 
|  2  |  PROJECT\_ID |  varchar |  32 |  0  |   N  |  N  |     | Project ID| 
|  3  |     NAME     |  varchar |  64 |  0  |   N  |  N  |     |  name  | 
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | creationTime| 
|  5  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | updateTime| 
|  6  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  projectCreator| 
|  7  | UPDATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  Revise by| 

**Table name:** T\_PIPELINE\_INFO 

**Description:**  Pipeline information table 

**Data column:** 

|  No. |           name           |    Type Of Data   |  length  | decimal place | Allow Null |   primary key  |         defaultValue        |    Description   | 
| :-: | :--------------------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :-----: | 
|  1  |      PIPELINE\_ID      |  varchar  |  34  |  0  |   N  |  Y  |                    |  pipelineId| 
|  2  |       PROJECT\_ID      |  varchar  |  64  |  0  |   N  |  N  |                    |   Project ID| 
|  3  |     PIPELINE\_NAME     |  varchar  |  255 |  0  |   N  |  N  |                    |  Pipeline name| 
|  4  |     PIPELINE\_DESC     |  varchar  |  255 |  0  |   Y  |  N  |                    |  Pipeline description| 
|  5  |         VERSION        |    int    |  10  |  0  |   Y  |  N  |          1         |   versionNum   | 
|  6  |      CREATE\_TIME      | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime| 
|  7  |         CREATOR        |  varchar  |  64  |  0  |   N  |  N  |                    |   projectCreator   | 
|  8  |      UPDATE\_TIME      | timestamp |  19  |  0  |   Y  |  N  |                    |   updateTime| 
|  9  |   LAST\_MODIFY\_USER   |  varchar  |  64  |  0  |   N  |  N  |                    |  Updated by| 
|  10 |         CHANNEL        |  varchar  |  32  |  0  |   Y  |  N  |                    |   project channel| 
|  11 |     MANUAL\_STARTUP    |    int    |  10  |  0  |   Y  |  N  |          1         |  Start Up manually| 
|  12 |      ELEMENT\_SKIP     |    int    |  10  |  0  |   Y  |  N  |          0         |  SKIP Plugin| 
|  13 |       TASK\_COUNT      |    int    |  10  |  0  |   Y  |  N  |          0         | Quantity of Pipeline Task| 
|  14 |         DELETE         |    bit    |   1  |  0  |   Y  |  N  |        b'0'        |   Delete| 
|  15 |           ID           |   bigint  |  20  |  0  |   N  |  N  |                    |    primary key ID  | 
|  16 | PIPELINE\_NAME\_PINYIN |  varchar  | 1300 |  0  |   Y  |  N  |                    | Pipeline name pinyin| 

**Table name:** T\_PIPELINE\_JOB\_MUTEX\_GROUP 

**Description:** 

**Data column:** 

|  No. |            name           |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |    Description    | 
| :-: | :---------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :------: | 
|  1  |       PROJECT\_ID       | varchar |  64 |  0  |   N  |  Y  |     |   Project ID   | 
|  2  | JOB\_MUTEX\_GROUP\_NAME | varchar | 127 |  0  |   N  |  Y  |     | Job Mutex Group Name| 

**Table name:** T\_PIPELINE\_LABEL

**Description:**  Pipeline Lable Table

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: | 
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID | 
|  2  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     |  Project ID| 
|  3  |   GROUP\_ID  |  bigint  |  20 |  0  |   N  |  N  |     | userGroup ID| 
|  4  |     NAME     |  varchar |  64 |  0  |   N  |  N  |     |   name  | 
|  5  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
|  6  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  updateTime| 
|  7  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  projectCreator| 
|  8  | UPDATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  Revise by| 

**Table name:** T\_PIPELINE\_LABEL\_PIPELINE 

**Description:**  Pipeline mapping table 

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: | 
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID | 
|  2  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     |  Project ID| 
|  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |     | pipelineId| 
|  4  |   LABEL\_ID  |  bigint  |  20 |  0  |   N  |  N  |     |  label ID| 
|  5  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
|  6  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  projectCreator| 

**Table name:** T\_PIPELINE\_MODEL\_TASK 

**Description:**  Pipeline model task Task table 

**Data column:** 

|  No. |          name         |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  | defaultValue |     Description    | 
| :-: | :-----------------: | :--------: | :------: | :-: | :--: | :-: | :-: | :-------: | 
|  1  |     PIPELINE\_ID    |   varchar  |    64    |  0  |   N  |  Y  |     |   pipelineId   | 
|  2  |     PROJECT\_ID     |   varchar  |    64    |  0  |   N  |  Y  |     |    Project ID   | 
|  3  |      STAGE\_ID      |   varchar  |    64    |  0  |   N  |  Y  |     | current stageId| 
|  4  |    CONTAINER\_ID    |   varchar  |    64    |  0  |   N  |  Y  |     |   build Container ID| 
|  5  |       TASK\_ID      |   varchar  |    64    |  0  |   N  |  Y  |     |    Task ID   | 
|  6  |      TASK\_NAME     |   varchar  |    128   |  0  |   Y  |  N  |     |    Task name   | 
|  7  |     CLASS\_TYPE     |   varchar  |    64    |  0  |   N  |  N  |     |    Plugin category   | 
|  8  |      TASK\_ATOM     |   varchar  |    128   |  0  |   Y  |  N  |     |  Task atom Code| 
|  9  |      TASK\_SEQ      |     int    |    10    |  0  |   Y  |  N  |  1  |    Task index   | 
|  10 |     TASK\_PARAMS    | mediumtext | 16777215 |  0  |   Y  |  N  |     |   Task Parameter Collection| 
|  11 |          OS         |   varchar  |    45    |  0  |   Y  |  N  |     |    The operating system   | 
|  12 | ADDITIONAL\_OPTIONS | mediumtext | 16777215 |  0  |   Y  |  N  |     |    otherChoice   | 
|  13 |      ATOM\_CODE     |   varchar  |    32    |  0  |   N  |  N  |     |  Unique identification of the Plugin| 
|  14 |    ATOM\_VERSION    |   varchar  |    20    |  0  |   Y  |  N  |     |   Plugin versionNum   | 
|  15 |     CREATE\_TIME    |  datetime  |    23    |  0  |   Y  |  N  |     |    creationTime   | 
|  16 |     UPDATE\_TIME    |  datetime  |    23    |  0  |   Y  |  N  |     |    updateTime   | 

**Table name:** T\_PIPELINE\_MUTEX\_GROUP 

**Description:**  Pipeline exclusive list 

**Data column:** 

|  No. |      name     |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :---: | 
|  1  | PROJECT\_ID | varchar |  64 |  0  |   N  |  Y  |     |  Project ID| 
|  2  | GROUP\_NAME | varchar | 127 |  0  |   N  |  Y  |     | userGroup name| 

**Table name:** T\_PIPELINE\_PAUSE\_VALUE 

**Description:**  Pipeline PAUSE var table 

**Data column:** 

|  No. |       name       |    Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |     Description     | 
| :-: | :------------: | :-------: | :---: | :-: | :--: | :-: | :-: | :--------: | 
|  1  |   PROJECT\_ID  |  varchar  |   64  |  0  |   N  |  N  |     |            | 
|  2  |    BUILD\_ID   |  varchar  |   34  |  0  |   N  |  Y  |     |    build ID    | 
|  3  |    TASK\_ID    |  varchar  |   34  |  0  |   N  |  Y  |     |    Task ID    | 
|  4  | DEFAULT\_VALUE |    text   | 65535 |  0  |   Y  |  N  |     |    default var    | 
|  5  |   NEW\_VALUE   |    text   | 65535 |  0  |   Y  |  N  |     | user var after PAUSE| 
|  6  |  CREATE\_TIME  | timestamp |   19  |  0  |   Y  |  N  |     |    append time    | 

**Table name:** T\_PIPELINE\_REMOTE\_AUTH

**Description:**  Pipeline Remote triggers Auth table

**Data column:** 

|  No. |       name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: | 
|  1  |  PIPELINE\_ID  |  varchar |  34 |  0  |   N  |  Y  |     | pipelineId| 
|  2  | PIPELINE\_AUTH |  varchar |  32 |  0  |   N  |  N  |     | Pipeline auth| 
|  3  |   PROJECT\_ID  |  varchar |  32 |  0  |   N  |  N  |     |  Project ID| 
|  4  |  CREATE\_TIME  | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
|  5  |  CREATE\_USER  |  varchar |  64 |  0  |   N  |  N  |     |  projectCreator| 

**Table name:** T\_PIPELINE\_RESOURCE 

**Description:**  Pipeline resources table 

**Data column:** 

|  No. |      name      |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  | 
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: | 
|  1  |  PROJECT\_ID |   varchar  |    64    |  0  |   N  |  N  |                    |  Project ID| 
|  2  | PIPELINE\_ID |   varchar  |    34    |  0  |   N  |  Y  |                    | pipelineId| 
|  3  |    VERSION   |     int    |    10    |  0  |   N  |  Y  |          1         |  versionNum| 
|  4  |     MODEL    | mediumtext | 16777215 |  0  |   Y  |  N  |                    | Pipeline model| 
|  5  |    CREATOR   |   varchar  |    64    |  0  |   Y  |  N  |                    |  projectCreator| 
|  6  | CREATE\_TIME |  timestamp |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 

**Table name:** T\_PIPELINE\_RESOURCE\_VERSION 

**Description:**  Pipeline Resource Version table 

**Data column:** 

|  No. |       name      |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  | 
| :-: | :-----------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: | 
|  1  |  PROJECT\_ID  |   varchar  |    64    |  0  |   N  |  N  |                    |  Project ID| 
|  2  |  PIPELINE\_ID |   varchar  |    34    |  0  |   N  |  Y  |                    | pipelineId| 
|  3  |    VERSION    |     int    |    10    |  0  |   N  |  Y  |          1         |  versionNum| 
|  4  | VERSION\_NAME |   varchar  |    64    |  0  |   N  |  N  |                    |  version Name| 
|  5  |     MODEL     | mediumtext | 16777215 |  0  |   Y  |  N  |                    | Pipeline model| 
|  6  |    CREATOR    |   varchar  |    64    |  0  |   Y  |  N  |                    |  projectCreator| 
|  7  |  CREATE\_TIME |  timestamp |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 

**Table name:** T\_PIPELINE\_RULE 

**Description:**  Pipeline Rule Information Table 

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |          defaultValue          |  Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :--: | 
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                       |  primary key ID | 
|  2  |  RULE\_NAME  |  varchar | 256 |  0  |   N  |  N  |                       | Rule name| 
|  3  |   BUS\_CODE  |  varchar | 128 |  0  |   N  |  N  |                       | Business Name identification| 
|  4  |   PROCESSOR  |  varchar | 128 |  0  |   N  |  N  |                       |  processor| 
|  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |         system        |  projectCreator| 
|  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |         system        |  Updated by| 
|  7  | UPDATE\_TIME | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |Change the time| 
|  8  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |creationTime| 

**Table name:** T\_PIPELINE\_SETTING

**Description:**  Pipeline Basic Config table

**Data column:** 

|  No. |                   name                   |    Type Of Data    |     length     | decimal place | Allow Null |   primary key  |  defaultValue |            Description            | 
| :-: | :------------------------------------: | :--------: | :--------: | :-: | :--: | :-: | :--: | :----------------------: | 
|  1  |              PIPELINE\_ID              |   varchar  |     34     |  0  |   N  |  Y  |      |           pipelineId          | 
|  2  |                  DESC                  |   varchar  |    1024    |  0  |   Y  |  N  |      |            description            | 
|  3  |                RUN\_TYPE               |     int    |     10     |  0  |   Y  |  N  |      |                          | 
|  4  |                  NAME                  |   varchar  |     255    |  0  |   Y  |  N  |      |            name            | 
|  5  |            SUCCESS\_RECEIVER           | mediumtext |  16777215  |  0  |   Y  |  N  |      |           Success recipient          | 
|  6  |             FAIL\_RECEIVER             | mediumtext |  16777215  |  0  |   Y  |  N  |      |           failed recipient          | 
|  7  |             SUCCESS\_GROUP             | mediumtext |  16777215  |  0  |   Y  |  N  |      |            Success Group           | 
|  8  |               FAIL\_GROUP              | mediumtext |  16777215  |  0  |   Y  |  N  |      |            failed group           | 
|  9  |              SUCCESS\_TYPE             |   varchar  |     32     |  0  |   Y  |  N  |      |          Success noticeType         | 
|  10 |               FAIL\_TYPE               |   varchar  |     32     |  0  |   Y  |  N  |      |          noticeType of failed         | 
|  11 |               PROJECT\_ID              |   varchar  |     64     |  0  |   Y  |  N  |      |           Project ID           | 
|  12 |      SUCCESS\_WECHAT\_GROUP\_FLAG      |     bit    |      1     |  0  |   N  |  N  | b'0' |       Success WeCom group notification switch       | 
|  13 |         SUCCESS\_WECHAT\_GROUP         |   varchar  |    1024    |  0  |   N  |  N  |      |       Success WeCom group notification group ID      | 
|  14 |        FAIL\_WECHAT\_GROUP\_FLAG       |     bit    |      1     |  0  |   N  |  N  | b'0' |       failed WeCom group notification switch       | 
|  15 |           FAIL\_WECHAT\_GROUP          |   varchar  |    1024    |  0  |   N  |  N  |      |       failed WeCom group notification group ID      | 
|  16 |             RUN\_LOCK\_TYPE            |     int    |     10     |  0  |   Y  |  N  |   1  |          type of Lock          | 
|  17 |          SUCCESS\_DETAIL\_FLAG         |     bit    |      1     |  0  |   Y  |  N  | b'0' |      Success notification of Pipeline detail connection switch     | 
|  18 |           FAIL\_DETAIL\_FLAG           |     bit    |      1     |  0  |   Y  |  N  | b'0' |      Pipeline detail connection switch for failed notification     | 
|  19 |            SUCCESS\_CONTENT            |  longtext  | 2147483647 |  0  |   Y  |  N  |      |        Success customize noticeContent        | 
|  20 |              FAIL\_CONTENT             |  longtext  | 2147483647 |  0  |   Y  |  N  |      |        failed customize noticeContent        | 
|  21 |        WAIT\_QUEUE\_TIME\_SECOND       |     int    |     10     |  0  |   Y  |  N  | 7200 |          lagestTime          | 
|  22 |            MAX\_QUEUE\_SIZE            |     int    |     10     |  0  |   Y  |  N  |  10  |          largestNum          | 
|  23 |              IS\_TEMPLATE              |     bit    |      1     |  0  |   Y  |  N  | b'0' |           Template           | 
|  24 | SUCCESS\_WECHAT\_GROUP\_MARKDOWN\_FLAG |     bit    |      1     |  0  |   N  |  N  | b'0' |Success WeCom group notification to Markdown format switch| 
|  25 |   FAIL\_WECHAT\_GROUP\_MARKDOWN\_FLAG  |     bit    |      1     |  0  |   N  |  N  | b'0' |failed WeCom group notification to Markdown format switch| 
|  26 |         MAX\_PIPELINE\_RES\_NUM        |     int    |     10     |  0  |   Y  |  N  |  500 |       save the maximum Count of Pipeline orchestrations       | 
|  27 |     MAX\_CON\_RUNNING\_QUEUE\_SIZE     |     int    |     10     |  0  |   Y  |  N  |  50  |         Concurrent build Limit         | 
|  28 |            BUILD\_NUM\_RULE            |   varchar  |     512    |  0  |   Y  |  N  |      |          buildNo Generate Rules         | 

**Table name:** T\_PIPELINE\_SETTING\_VERSION

**Description:**  Pipeline Basic Config version Table

**Data column:** 

|  No. |                   name                   |    Type Of Data    |     length     | decimal place | Allow Null |   primary key  |  defaultValue |            Description            | 
| :-: | :------------------------------------: | :--------: | :--------: | :-: | :--: | :-: | :--: | :----------------------: | 
|  1  |                   ID                   |   bigint   |     20     |  0  |   N  |  Y  |      |            primary key ID           | 
|  2  |              PIPELINE\_ID              |   varchar  |     34     |  0  |   N  |  N  |      |           pipelineId          | 
|  3  |            SUCCESS\_RECEIVER           | mediumtext |  16777215  |  0  |   Y  |  N  |      |           Success recipient          | 
|  4  |             FAIL\_RECEIVER             | mediumtext |  16777215  |  0  |   Y  |  N  |      |           failed recipient          | 
|  5  |             SUCCESS\_GROUP             | mediumtext |  16777215  |  0  |   Y  |  N  |      |            Success Group           | 
|  6  |               FAIL\_GROUP              | mediumtext |  16777215  |  0  |   Y  |  N  |      |            failed group           | 
|  7  |              SUCCESS\_TYPE             |   varchar  |     32     |  0  |   Y  |  N  |      |          Success noticeType         | 
|  8  |               FAIL\_TYPE               |   varchar  |     32     |  0  |   Y  |  N  |      |          noticeType of failed         | 
|  9  |               PROJECT\_ID              |   varchar  |     64     |  0  |   Y  |  N  |      |           Project ID           | 
|  10 |      SUCCESS\_WECHAT\_GROUP\_FLAG      |     bit    |      1     |  0  |   N  |  N  | b'0' |       Success WeCom group notification switch       | 
|  11 |         SUCCESS\_WECHAT\_GROUP         |   varchar  |    1024    |  0  |   N  |  N  |      |       Success WeCom group notification group ID      | 
|  12 |        FAIL\_WECHAT\_GROUP\_FLAG       |     bit    |      1     |  0  |   N  |  N  | b'0' |       failed WeCom group notification switch       | 
|  13 |           FAIL\_WECHAT\_GROUP          |   varchar  |    1024    |  0  |   N  |  N  |      |       failed WeCom group notification group ID      | 
|  14 |          SUCCESS\_DETAIL\_FLAG         |     bit    |      1     |  0  |   Y  |  N  | b'0' |      Success notification of Pipeline detail connection switch     | 
|  15 |           FAIL\_DETAIL\_FLAG           |     bit    |      1     |  0  |   Y  |  N  | b'0' |      Pipeline detail connection switch for failed notification     | 
|  16 |            SUCCESS\_CONTENT            |  longtext  | 2147483647 |  0  |   Y  |  N  |      |        Success customize noticeContent        | 
|  17 |              FAIL\_CONTENT             |  longtext  | 2147483647 |  0  |   Y  |  N  |      |        failed customize noticeContent        | 
|  18 |              IS\_TEMPLATE              |     bit    |      1     |  0  |   Y  |  N  | b'0' |           Template           | 
|  19 |                 VERSION                |     int    |     10     |  0  |   N  |  N  |   1  |            versionNum           | 
|  20 | SUCCESS\_WECHAT\_GROUP\_MARKDOWN\_FLAG |     bit    |      1     |  0  |   N  |  N  | b'0' |Success WeCom group notification to Markdown format switch| 
|  21 |   FAIL\_WECHAT\_GROUP\_MARKDOWN\_FLAG  |     bit    |      1     |  0  |   N  |  N  | b'0' |failed WeCom group notification to Markdown format switch| 

**Table name:** T\_PIPELINE\_STAGE\_TAG

**Description:** 

**Data column:** 

|  No. |        name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
| :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
|  1  |        ID        |  varchar |  32 |  0  |   N  |  Y  |                    |    primary key    | 
|  2  | STAGE\_TAG\_NAME |  varchar |  45 |  0  |   N  |  N  |                    | Stage label name| 
|  3  |      WEIGHT      |    int   |  10 |  0  |   N  |  N  |          0         | Stage label weight| 
|  4  |      CREATOR     |  varchar |  50 |  0  |   N  |  N  |       system       |   creator| 
|  5  |     MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |  Updated by| 
|  6  |   CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
|  7  |   UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |Change the time| 

**Table name:** T\_PIPELINE\_TEMPLATE 

**Description:**  Pipeline Template Tabl 

**Data column:** 

|  No. |         name        |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |         defaultValue        |     Description    | 
| :-: | :---------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :-------: | 
|  1  |         ID        |   bigint   |    20    |  0  |   N  |  Y  |                    |     primary key ID   | 
|  2  |        TYPE       |   varchar  |    32    |  0  |   N  |  N  |       FREEDOM      |     type    | 
|  3  |      CATEGORY     |   varchar  |    128   |  0  |   Y  |  N  |                    |    Apply category   | 
|  4  |   TEMPLATE\_NAME  |   varchar  |    64    |  0  |   N  |  N  |                    |    Template name   | 
|  5  |        ICON       |   varchar  |    32    |  0  |   N  |  N  |                    |    Template icon   | 
|  6  |     LOGO\_URL     |   varchar  |    512   |  0  |   Y  |  N  |                    | LOGOURL address| 
|  7  |   PROJECT\_CODE   |   varchar  |    32    |  0  |   Y  |  N  |                    |  userGroup Project| 
|  8  | SRC\_TEMPLATE\_ID |   varchar  |    32    |  0  |   Y  |  N  |                    |   Source Template ID   | 
|  9  |       AUTHOR      |   varchar  |    64    |  0  |   N  |  N  |                    |     Authors    | 
|  10 |      ATOMNUM      |     int    |    10    |  0  |   N  |  N  |                    |    Quantity of Plugin   | 
|  11 |    PUBLIC\_FLAG   |     bit    |     1    |  0  |   N  |  N  |        b'0'        |  Is it a publicImage| 
|  12 |      TEMPLATE     | mediumtext | 16777215 |  0  |   Y  |  N  |                    |     template    | 
|  13 |      CREATOR      |   varchar  |    32    |  0  |   N  |  N  |                    |    projectCreator    | 
|  14 |    CREATE\_TIME   |  datetime  |    19    |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 

**Table name:** T\_PIPELINE\_TIMER 

**Description:** 

**Data column:** 

|  No. |      name      |    Type Of Data   |  length  | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  | 
| :-: | :----------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :---: | 
|  1  |  PROJECT\_ID |  varchar  |  32  |  0  |   N  |  Y  |                    |  Project ID| 
|  2  | PIPELINE\_ID |  varchar  |  34  |  0  |   N  |  Y  |                    | pipelineId| 
|  3  |    CRONTAB   |  varchar  | 2048 |  0  |   N  |  N  |                    |  Task ID| 
|  4  |    CREATOR   |  varchar  |  64  |  0  |   N  |  N  |                    |  projectCreator| 
|  5  | CREATE\_TIME | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
|  6  |    CHANNEL   |  varchar  |  32  |  0  |   N  |  N  |         BS         |  project channel| 

**Table name:** T\_PIPELINE\_USER 

**Description:** 

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: | 
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID | 
|  2  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |     | pipelineId| 
|  3  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
|  4  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  updateTime| 
|  5  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  projectCreator| 
|  6  | UPDATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  Revise by| 
**Table name:** T\_PIPELINE\_VIEW

**Description:** 

**Data column:** 

|  No. |             name            |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |  defaultValue |    Description    | 
| :-: | :-----------------------: | :--------: | :------: | :-: | :--: | :-: | :--: | :------: | 
|  1  |             ID            |   bigint   |    20    |  0  |   N  |  Y  |      |    primary key ID   | 
|  2  |        PROJECT\_ID        |   varchar  |    32    |  0  |   N  |  N  |      |   Project ID   | 
|  3  |            NAME           |   varchar  |    64    |  0  |   N  |  N  |      |    name    | 
|  4  | FILTER\_BY\_PIPEINE\_NAME |   varchar  |    128   |  0  |   Y  |  N  |      | Pipeline name filter| 
|  5  |    FILTER\_BY\_CREATOR    |   varchar  |    64    |  0  |   Y  |  N  |      |  projectCreator filter| 
|  6  |        CREATE\_TIME       |  datetime  |    19    |  0  |   N  |  N  |      |   creationTime   | 
|  7  |        UPDATE\_TIME       |  datetime  |    19    |  0  |   N  |  N  |      |   updateTime   | 
|  8  |        CREATE\_USER       |   varchar  |    64    |  0  |   N  |  N  |      |    projectCreator   | 
|  9  |        IS\_PROJECT        |     bit    |     1    |  0  |   Y  |  N  | b'0' |   project   | 
|  10 |           LOGIC           |   varchar  |    32    |  0  |   Y  |  N  |  AND |    logical symbol   | 
|  11 |          FILTERS          | mediumtext | 16777215 |  0  |   Y  |  N  |      |    filter   | 

**Table name:** T\_PIPELINE\_VIEW\_LABEL 

**Description:** 

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
|  1  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     | Project ID| 
|  2  |   VIEW\_ID   |  bigint  |  20 |  0  |   N  |  Y  |     | view ID| 
|  3  |   LABEL\_ID  |  bigint  |  20 |  0  |   N  |  Y  |     | label ID| 
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | creationTime| 

**Table name:** T\_PIPELINE\_VIEW\_PROJECT 

**Description:** 

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  primary key ID | 
|  2  |   VIEW\_ID   |  bigint  |  20 |  0  |   N  |  N  |     | view ID| 
|  3  |  PROJECT\_ID |  varchar |  32 |  0  |   N  |  N  |     | Project ID| 
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | creationTime| 
|  5  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | updateTime| 
|  6  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  projectCreator| 

**Table name:** T\_PIPELINE\_VIEW\_USER\_LAST\_VIEW 

**Description:** 

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
|  1  |   USER\_ID   |  varchar |  32 |  0  |   N  |  Y  |                    | user ID| 
|  2  |  PROJECT\_ID |  varchar |  32 |  0  |   N  |  Y  |                    | Project ID| 
|  3  |   VIEW\_ID   |  varchar |  64 |  0  |   N  |  N  |                    | view ID| 
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |                    | creationTime| 
|  5  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

**Table name:** T\_PIPELINE\_VIEW\_USER\_SETTINGS 

**Description:** 

**Data column:** 

|  No. |      name      |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  | 
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: | 
|  1  |   USER\_ID   |   varchar  |    255   |  0  |   N  |  Y  |                    |  user ID| 
|  2  |  PROJECT\_ID |   varchar  |    32    |  0  |   N  |  Y  |                    |  Project ID| 
|  3  |   SETTINGS   | mediumtext | 16777215 |  0  |   N  |  N  |                    | attribute setting table| 
|  4  | CREATE\_TIME |  datetime  |    19    |  0  |   N  |  N  |                    |  creationTime| 
|  5  | UPDATE\_TIME |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 

**Table name:** T\_PIPELINE\_WEBHOOK

**Description:** 

**Data column:** 

|  No. |        name        |   Type Of Data  |  length | decimal place | Allow Null |   primary key  |  defaultValue |      Description     | 
| :-: | :--------------: | :-----: | :-: | :-: | :--: | :-: | :--: | :---------: | 
|  1  | REPOSITORY\_TYPE | varchar |  64 |  0  |   N  |  N  |      | type of new git Plugin| 
|  2  |    PROJECT\_ID   | varchar |  32 |  0  |   N  |  N  |      |     Project ID    | 
|  3  |   PIPELINE\_ID   | varchar |  34 |  0  |   N  |  N  |      |    pipelineId    | 
|  4  |  REPO\_HASH\_ID  | varchar |  45 |  0  |   Y  |  N  |      |  Storage HASHID| 
|  5  |        ID        |  bigint |  20 |  0  |   N  |  Y  |      |      primary key ID    | 
|  6  |    REPO\_NAME    | varchar | 128 |  0  |   Y  |  N  |      |    Code Repository aliasName    | 
|  7  |    REPO\_TYPE    | varchar |  32 |  0  |   Y  |  N  |      |    Code Repository type    | 
|  8  |   PROJECT\_NAME  | varchar | 128 |  0  |   Y  |  N  |      |     project name    | 
|  9  |     TASK\_ID     | varchar |  34 |  0  |   Y  |  N  |      |     Task ID    | 
|  10 |      DELETE      |   bit   |  1  |  0  |   Y  |  N  | b'0' |     Delete    | 

**Table name:** T\_PIPELINE\_WEBHOOK\_BUILD\_LOG 

**Description:** 

**Data column:** 

|  No. |        name        |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
| :-: | :--------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----: | 
|  1  |        ID        |  bigint  |   20  |  0  |   N  |  Y  |                    |   primary key ID  | 
|  2  |    CODE\_TYPE    |  varchar |   32  |  0  |   N  |  N  |                    |  Code Repository type| 
|  3  |    REPO\_NAME    |  varchar |  128  |  0  |   N  |  N  |                    |  Code Repository aliasName| 
|  4  |    COMMIT\_ID    |  varchar |   64  |  0  |   N  |  N  |                    | Code submit ID| 
|  5  | REQUEST\_CONTENT |   text   | 65535 |  0  |   Y  |  N  |                    |  event content| 
|  6  |   CREATED\_TIME  | datetime |   19  |  0  |   N  |  Y  | CURRENT\_TIMESTAMP |creationTime| 
|  7  |  RECEIVED\_TIME  | datetime |   19  |  0  |   N  |  N  |                    |  receiving time| 
|  8  |  FINISHED\_TIME  | datetime |   19  |  0  |   N  |  N  |                    |  complete time| 

**Table name:** T\_PIPELINE\_WEBHOOK\_BUILD\_LOG\_DETAIL

**Description:** 

**Data column:** 

|  No. |        name       |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
| :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----: | 
|  1  |        ID       |  bigint  |   20  |  0  |   N  |  Y  |                    |   primary key ID  | 
|  2  |     LOG\_ID     |  bigint  |   20  |  0  |   N  |  N  |                    |        | 
|  3  |    CODE\_TYPE   |  varchar |   32  |  0  |   N  |  N  |                    |  Code Repository type| 
|  4  |    REPO\_NAME   |  varchar |  128  |  0  |   N  |  N  |                    |  Code Repository aliasName| 
|  5  |    COMMIT\_ID   |  varchar |   64  |  0  |   N  |  N  |                    | Code submit ID| 
|  6  |   PROJECT\_ID   |  varchar |   32  |  0  |   N  |  N  |                    |  Project ID| 
|  7  |   PIPELINE\_ID  |  varchar |   34  |  0  |   N  |  N  |                    |  pipelineId| 
|  8  |     TASK\_ID    |  varchar |   34  |  0  |   N  |  N  |                    |  Task ID| 
|  9  |    TASK\_NAME   |  varchar |  128  |  0  |   Y  |  N  |                    |  Task name| 
|  10 |     SUCCESS     |    bit   |   1   |  0  |   Y  |  N  |        b'0'        |  Is it Success| 
|  11 | TRIGGER\_RESULT |   text   | 65535 |  0  |   Y  |  N  |                    |  Trigger result| 
|  12 |  CREATED\_TIME  | datetime |   19  |  0  |   N  |  Y  | CURRENT\_TIMESTAMP |creationTime| 

**Table name:** T\_PIPELINE\_WEBHOOK\_QUEUE 

**Description:** 

**Data column:** 

|  No. |          name         |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |    Description   | 
| :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: | 
|  1  |          ID         |  bigint  |  20 |  0  |   N  |  Y  |                    |    primary key ID  | 
|  2  |     PROJECT\_ID     |  varchar |  64 |  0  |   N  |  N  |                    |   Project ID| 
|  3  |     PIPELINE\_ID    |  varchar |  64 |  0  |   N  |  N  |                    |  pipelineId| 
|  4  | SOURCE\_PROJECT\_ID |  bigint  |  20 |  0  |   N  |  N  |                    |  Source Project ID| 
|  5  |  SOURCE\_REPO\_NAME |  varchar | 255 |  0  |   N  |  N  |                    |  Source Code Repository name| 
|  6  |    SOURCE\_BRANCH   |  varchar | 255 |  0  |   N  |  N  |                    |   source Branch   | 
|  7  | TARGET\_PROJECT\_ID |  bigint  |  20 |  0  |   Y  |  N  |                    |  target Project ID| 
|  8  |  TARGET\_REPO\_NAME |  varchar | 255 |  0  |   Y  |  N  |                    | target Code Repository name| 
|  9  |    TARGET\_BRANCH   |  varchar | 255 |  0  |   Y  |  N  |                    |   target Branch| 
|  10 |      BUILD\_ID      |  varchar |  34 |  0  |   N  |  N  |                    |   build ID| 
|  11 |     CREATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime| 

**Table name:** T\_PROJECT\_PIPELINE\_CALLBACK

**Description:** 

**Data column:** 

|  No. |       name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |  defaultValue |                        Description                       | 
| :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :--: | :---------------------------------------------: | 
|  1  |       ID      |  bigint  |   20  |  0  |   N  |  Y  |      |                        primary key ID                      | 
|  2  |  PROJECT\_ID  |  varchar |   64  |  0  |   N  |  N  |      |                       Project ID                      | 
|  3  |     EVENTS    |  varchar |  255  |  0  |   Y  |  N  |      |                        event                       | 
|  4  | CALLBACK\_URL |  varchar |  255  |  0  |   N  |  N  |      |                     Callback url address                     | 
|  5  |    CREATOR    |  varchar |   64  |  0  |   N  |  N  |      |                       projectCreator                       | 
|  6  |    UPDATOR    |  varchar |   64  |  0  |   N  |  N  |      |                       Updater                       | 
|  7  | CREATED\_TIME | datetime |   19  |  0  |   N  |  N  |      |                       creationTime                      | 
|  8  | UPDATED\_TIME | datetime |   19  |  0  |   N  |  N  |      |                       updateTime                      | 
|  9  | SECRET\_TOKEN |   text   | 65535 |  0  |   Y  |  N  |      | Sendtoyourwithhttpheader:X-DEVOPS-WEBHOOK-TOKEN | 
|  10 |     ENABLE    |    bit   |   1   |  0  |   N  |  N  | b'1' |                        Enable                       | 

**Table name:** T\_PROJECT\_PIPELINE\_CALLBACK\_HISTORY 

**Description:** 

**Data column:** 

|  No. |        name       |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |    Description   | 
| :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :-: | :-----: | 
|  1  |        ID       |  bigint  |   20  |  0  |   N  |  Y  |     |    primary key ID  | 
|  2  |   PROJECT\_ID   |  varchar |   64  |  0  |   N  |  N  |     |   Project ID| 
|  3  |      EVENTS     |  varchar |  255  |  0  |   Y  |  N  |     |    event   | 
|  4  |  CALLBACK\_URL  |  varchar |  255  |  0  |   N  |  N  |     | Callback url address| 
|  5  |      STATUS     |  varchar |   20  |  0  |   N  |  N  |     |    status   | 
|  6  |    ERROR\_MSG   |   text   | 65535 |  0  |   Y  |  N  |     |   Error description| 
|  7  | REQUEST\_HEADER |   text   | 65535 |  0  |   Y  |  N  |     |   Request header   | 
|  8  |  REQUEST\_BODY  |   text   | 65535 |  0  |   N  |  N  |     |  Request Body| 
|  9  |  RESPONSE\_CODE |    int   |   10  |  0  |   Y  |  N  |     |  Response code| 
|  10 |  RESPONSE\_BODY |   text   | 65535 |  0  |   Y  |  N  |     |  Response Body| 
|  11 |   START\_TIME   | datetime |   19  |  0  |   N  |  N  |     |   Starting Time| 
|  12 |    END\_TIME    | datetime |   19  |  0  |   N  |  N  |     |   End Time| 
|  13 |  CREATED\_TIME  | datetime |   19  |  0  |   N  |  Y  |     |   creationTime| 

**Table name:** T\_REPORT 

**Description:**  Pipeline List 

**Data column:** 

|  No. |      name      |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |    defaultValue   |   Description  | 
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :------: | :---: | 
|  1  |      ID      |   bigint   |    20    |  0  |   N  |  Y  |          |   primary key ID | 
|  2  |  PROJECT\_ID |   varchar  |    32    |  0  |   N  |  N  |          |  Project ID| 
|  3  | PIPELINE\_ID |   varchar  |    34    |  0  |   N  |  N  |          | pipelineId| 
|  4  |   BUILD\_ID  |   varchar  |    34    |  0  |   N  |  N  |          |  build ID| 
|  5  |  ELEMENT\_ID |   varchar  |    34    |  0  |   N  |  N  |          |  Atom ID| 
|  6  |     TYPE     |   varchar  |    32    |  0  |   N  |  N  | INTERNAL |   type| 
|  7  |  INDEX\_FILE | mediumtext | 16777215 |  0  |   N  |  N  |          |  entry file| 
|  8  |     NAME     |    text    |   65535  |  0  |   N  |  N  |          |   name  | 
|  9  | CREATE\_TIME |  datetime  |    19    |  0  |   N  |  N  |          |  creationTime| 
|  10 | UPDATE\_TIME |  datetime  |    19    |  0  |   N  |  N  |          |  updateTime| 

**Table name:** T\_TEMPLATE

**Description:**  Pipeline Template Information Table

**Data column:** 

|  No. |         name        |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |    defaultValue    |      Description     | 
| :-: | :---------------: | :--------: | :------: | :-: | :--: | :-: | :-------: | :---------: | 
|  1  |      VERSION      |   bigint   |    20    |  0  |   N  |  Y  |           |      primary key ID    | 
|  2  |         ID        |   varchar  |    32    |  0  |   N  |  N  |           |      primary key ID    | 
|  3  |   TEMPLATE\_NAME  |   varchar  |    64    |  0  |   N  |  N  |           |     Template name    | 
|  4  |    PROJECT\_ID    |   varchar  |    34    |  0  |   N  |  N  |           |     Project ID    | 
|  5  |   VERSION\_NAME   |   varchar  |    64    |  0  |   N  |  N  |           |     version Name    | 
|  6  |      CREATOR      |   varchar  |    64    |  0  |   N  |  N  |           |     projectCreator     | 
|  7  |   CREATED\_TIME   |  datetime  |    19    |  0  |   Y  |  N  |           |     creationTime    | 
|  8  |      TEMPLATE     | mediumtext | 16777215 |  0  |   Y  |  N  |           |      template     | 
|  9  |        TYPE       |   varchar  |    32    |  0  |   N  |  N  | CUSTOMIZE |      type     | 
|  10 |      CATEGORY     |   varchar  |    128   |  0  |   Y  |  N  |           |     Apply category    | 
|  11 |     LOGO\_URL     |   varchar  |    512   |  0  |   Y  |  N  |           |  LOGOURL address| 
|  12 | SRC\_TEMPLATE\_ID |   varchar  |    32    |  0  |   Y  |  N  |           |    Source Template ID    | 
|  13 |    STORE\_FLAG    |     bit    |     1    |  0  |   Y  |  N  |    b'0'   | Is it link with the store| 
|  14 |       WEIGHT      |     int    |    10    |  0  |   Y  |  N  |     0     |      weight value     | 

**Table name:** T\_TEMPLATE\_INSTANCE\_BASE 

**Description:**  Basic Information Table of Template Implementation 

**Data column:** 

|  No. |               name              |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |          defaultValue          |    Description    | 
| :-: | :---------------------------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :------: | 
|  1  |               ID              |  varchar |  32 |  0  |   N  |  Y  |                       |    primary key ID   | 
|  2  |          TEMPLATE\_ID         |  varchar |  32 |  0  |   Y  |  N  |                       |   Template ID   | 
|  3  |       TEMPLATE\_VERSION       |  varchar |  32 |  0  |   N  |  N  |                       |   templateVersion   | 
|  4  | USE\_TEMPLATE\_SETTINGS\_FLAG |    bit   |  1  |  0  |   N  |  N  |                       | Use template setting| 
|  5  |          PROJECT\_ID          |  varchar |  64 |  0  |   N  |  N  |                       |   Project ID   | 
|  6  |        TOTAL\_ITEM\_NUM       |    int   |  10 |  0  |   N  |  N  |           0           |  Total instantiate Quantity| 
|  7  |       SUCCESS\_ITEM\_NUM      |    int   |  10 |  0  |   N  |  N  |           0           |  Quantity of Success instantiations| 
|  8  |        FAIL\_ITEM\_NUM        |    int   |  10 |  0  |   N  |  N  |           0           |  Quantity of instantiate failed| 
|  9  |             STATUS            |  varchar |  32 |  0  |   N  |  N  |                       |    status    | 
|  10 |            CREATOR            |  varchar |  50 |  0  |   N  |  N  |         system        |    projectCreator   | 
|  11 |            MODIFIER           |  varchar |  50 |  0  |   N  |  N  |         system        |    Updated by   | 
|  12 |          UPDATE\_TIME         | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   Change the time   | 
|  13 |          CREATE\_TIME         | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   creationTime   | 

**Table name:** T\_TEMPLATE\_INSTANCE\_ITEM

**Description:**  Template Implementation Item Info Table

**Data column:** 

 |  No. |        name       |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |          defaultValue          |     Description    | 
 | :-: | :-------------: | :--------: | :------: | :-: | :--: | :-: | :-------------------: | :-------: | 
 |  1  |        ID       |   varchar  |    32    |  0  |   N  |  Y  |                       |     primary key ID   | 
 |  2  |   PROJECT\_ID   |   varchar  |    64    |  0  |   N  |  N  |                       |    Project ID   | 
 |  3  |   PIPELINE\_ID  |   varchar  |    34    |  0  |   N  |  N  |                       |   pipelineId   | 
 |  4  |  PIPELINE\_NAME |   varchar  |    255   |  0  |   N  |  N  |                       |   Pipeline name   | 
 |  5  | BUILD\_NO\_INFO |   varchar  |    512   |  0  |   Y  |  N  |                       |   buildNo Information   | 
 |  6  |      STATUS     |   varchar  |    32    |  0  |   N  |  N  |                       |     status    | 
 |  7  |     BASE\_ID    |   varchar  |    32    |  0  |   N  |  N  |                       | materialized Basic Information ID| 
 |  8  |      PARAM      | mediumtext | 16777215 |  0  |   Y  |  N  |                       |     Parameter    | 
 |  9  |     CREATOR     |   varchar  |    50    |  0  |   N  |  N  |         system        |    projectCreator    | 
 |  10 |     MODIFIER    |   varchar  |    50    |  0  |   N  |  N  |         system        |    Updated by    | 
 |  11 |   UPDATE\_TIME  |  datetime  |    23    |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    Change the time   | 
 |  12 |   CREATE\_TIME  |  datetime  |    23    |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    creationTime   | 

 **Table name:** T\_TEMPLATE\_PIPELINE 

 **Description:**  Pipeline Template-Instance Mapping Table 

 **Data column:** 

 |  No. |         name         |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |     defaultValue    |                Description               | 
 | :-: | :----------------: | :--------: | :------: | :-: | :--: | :-: | :--------: | :-----------------------------: | 
 |  1  |     PROJECT\_ID    |   varchar  |    64    |  0  |   N  |  N  |            |               Project ID              | 
 |  2  |    PIPELINE\_ID    |   varchar  |    34    |  0  |   N  |  Y  |            |              pipelineId              | 
 |  3  |   INSTANCE\_TYPE   |   varchar  |    32    |  0  |   N  |  N  | CONSTRAINT |instantiate Type: FREEDOM freedomMode CONSTRAINT constraintMode| 
 |  4  | ROOT\_TEMPLATE\_ID |   varchar  |    32    |  0  |   Y  |  N  |            |              Source Template ID              | 
 |  5  |       VERSION      |   bigint   |    20    |  0  |   N  |  N  |            |               versionNum               | 
 |  6  |    VERSION\_NAME   |   varchar  |    64    |  0  |   N  |  N  |            |               version Name              | 
 |  7  |    TEMPLATE\_ID    |   varchar  |    32    |  0  |   N  |  N  |            |               Template ID              | 
 |  8  |       CREATOR      |   varchar  |    64    |  0  |   N  |  N  |            |               projectCreator               | 
 |  9  |       UPDATOR      |   varchar  |    64    |  0  |   N  |  N  |            |               Updater               | 
 |  10 |    CREATED\_TIME   |  datetime  |    19    |  0  |   N  |  N  |            |               creationTime              | 
 |  11 |    UPDATED\_TIME   |  datetime  |    19    |  0  |   N  |  N  |            |               updateTime              | 
 |  12 |      BUILD\_NO     |    text    |   65535  |  0  |   Y  |  N  |            |               buildNo               | 
 |  13 |        PARAM       | mediumtext | 16777215 |  0  |   Y  |  N  |            |                Parameter               | 
 |  14 |       DELETED      |     bit    |     1    |  0  |   Y  |  N  |    b'0'    |             Pipeline has been soft delete            | 
