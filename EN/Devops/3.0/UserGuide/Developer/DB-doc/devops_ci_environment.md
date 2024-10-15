# devops\_ci\_environment

**The database name:** devops\_ci\_environment

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_environment

 |                                Table name                                |       Description       | 
 | :--------------------------------------------------------------: | :------------: | 
 |        [T\_AGENT\_FAILURE\_NOTIFY\_USER](broken-reference)       |                | 
 |            [T\_AGENT\_PIPELINE\_REF](broken-reference)           |                | 
 |                    [T\_ENV](broken-reference)                    |      Stage Sheet     | 
 |        [T\_ENVIRONMENT\_AGENT\_PIPELINE](broken-reference)       |                | 
 |        [T\_ENVIRONMENT\_SLAVE\_GATEWAY](broken-reference)        |                | 
 |       [T\_ENVIRONMENT\_THIRDPARTY\_AGENT](broken-reference)      | Self hosted agent agent information table| 
 |   [T\_ENVIRONMENT\_THIRDPARTY\_AGENT\_ACTION](broken-reference)  |                | 
 | [T\_ENVIRONMENT\_THIRDPARTY\_ENABLE\_PROJECTS](broken-reference) |                | 
 |                 [T\_ENV\_NODE](broken-reference)                 |    environment Mapping Table    | 
 |            [T\_ENV\_SHARE\_PROJECT](broken-reference)            |                | 
 |                    [T\_NODE](broken-reference)                   |      Node information table     | 
 |              [T\_PROJECT\_CONFIG](broken-reference)              |                | 

**Table name:** T\_AGENT\_FAILURE\_NOTIFY\_USER

**Description:** 

**Data column:** 

|  No. |       name      |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  |
| :-: | :-----------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |       ID      |  bigint |  20 |  0  |   N  |  Y  |     |  primary key ID |
|  2  |    USER\_ID   | varchar |  32 |  0  |   Y  |  N  |     |  user ID  |
|  3  | NOTIFY\_TYPES | varchar |  32 |  0  |   Y  |  N  |     |  type of notification  |

**Table name:** T\_AGENT\_PIPELINE\_REF

**Description:** 

**Data column:** 

|  No. |         name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |    Description   |
| :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-----: |
|  1  |         ID        |  bigint  |  20 |  0  |   N  |  Y  |     |    primary key ID  | 
|  2  |      NODE\_ID     |  bigint  |  20 |  0  |   N  |  N  |     |   node ID| 
|  3  |     AGENT\_ID     |  bigint  |  20 |  0  |   N  |  N  |     |  agent ID| 
|  4  |    PROJECT\_ID    |  varchar |  64 |  0  |   N  |  N  |     |   Project ID| 
|  5  |    PIPELINE\_ID   |  varchar |  34 |  0  |   N  |  N  |     |  pipelineId| 
|  6  |   PIEPLINE\_NAME  |  varchar | 255 |  0  |   N  |  N  |     |  Pipeline name| 
|  7  |    VM\_SEQ\_ID    |  varchar |  34 |  0  |   Y  |  N  |     |  build index Number| 
|  8  |      JOB\_ID      |  varchar |  34 |  0  |   Y  |  N  |     |  JOBID  | 
|  9  |     JOB\_NAME     |  varchar | 255 |  0  |   N  |  N  |     | JOBNAME | 
|  10 | LAST\_BUILD\_TIME | datetime |  19 |  0  |   N  |  N  |     |  Recent build time| 

**Table name:** T\_ENV

**Description:**   Stage Sheet 

**Data column:** 

|  No. |       name      |    Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |       Description       |
| :-: | :-----------: | :-------: | :---: | :-: | :--: | :-: | :-: | :------------: |
|  1  |    ENV\_ID    |   bigint  |   20  |  0  |   N  |  Y  |     |       primary key ID      | 
|  2  |  PROJECT\_ID  |  varchar  |   64  |  0  |   N  |  N  |     |      Project ID      | 
|  3  |   ENV\_NAME   |  varchar  |  128  |  0  |   N  |  N  |     |      environment name      | 
|  4  |   ENV\_DESC   |  varchar  |  128  |  0  |   N  |  N  |     |      envRemark      | 
|  5  |   ENV\_TYPE   |  varchar  |  128  |  0  |   N  |  N  |     | envType (Develop Environment {DEV}| 
|  6  |   ENV\_VARS   |    text   | 65535 |  0  |   N  |  N  |     |      Env Variables      | 
|  7  | CREATED\_USER |  varchar  |   64  |  0  |   N  |  N  |     |       creator      | 
|  8  | UPDATED\_USER |  varchar  |   64  |  0  |   N  |  N  |     |       Revise by      | 
|  9  | CREATED\_TIME | timestamp |   19  |  0  |   Y  |  N  |     |      creationTime      | 
|  10 | UPDATED\_TIME | timestamp |   19  |  0  |   Y  |  N  |     |      Change the time      | 
|  11 |  IS\_DELETED  |    bit    |   1   |  0  |   N  |  N  |     |      Delete      | 

**Table name:** T\_ENVIRONMENT\_AGENT\_PIPELINE

**Description:** 

**Data column:** 

 |  No. |       name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |      Description      | 
 | :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :-: | :----------: | 
 |  1  |       ID      |  bigint  |   20  |  0  |   N  |  Y  |     |      primary key ID     | 
 |  2  |   AGENT\_ID   |  bigint  |   20  |  0  |   N  |  N  |     |     agent ID    | 
 |  3  |  PROJECT\_ID  |  varchar |   32  |  0  |   N  |  N  |     |     Project ID     | 
 |  4  |    USER\_ID   |  varchar |   32  |  0  |   N  |  N  |     |     user ID     | 
 |  5  | CREATED\_TIME | datetime |   19  |  0  |   N  |  N  |     |     creationTime     | 
 |  6  | UPDATED\_TIME | datetime |   19  |  0  |   N  |  N  |     |     updateTime     | 
 |  7  |     STATUS    |    int   |   10  |  0  |   N  |  N  |     |      status      | 
 |  8  |    PIPELINE   |  varchar |  1024 |  0  |   N  |  N  |     | PipelineType | 
 |  9  |    RESPONSE   |   text   | 65535 |  0  |   Y  |  N  |     |              | 

**Table name:** T\_ENVIRONMENT\_SLAVE\_GATEWAY

**Description:** 

**Data column:** 

|  No. |     name     |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  |
| :-: | :--------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |     ID     |  bigint |  20 |  0  |   N  |  Y  |     |  primary key ID |
|  2  |    NAME    | varchar |  32 |  0  |   N  |  N  |     |  name  |
|  3  | SHOW\_NAME | varchar |  32 |  0  |   N  |  N  |     |  Show Name |
|  4  |   GATEWAY  | varchar | 127 |  0  |   Y  |  N  |     |  Gateway address|

**Table name:** T\_ENVIRONMENT\_THIRDPARTY\_AGENT

**Description:**   Self hosted agent agent information table 

**Data column:** 

|  No. |           name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |    Description   |
| :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :-: | :-----: |
|  1  |           ID          |  bigint  |   20  |  0  |   N  |  Y  |     |    primary key ID  | 
|  2  |        NODE\_ID       |  bigint  |   20  |  0  |   Y  |  N  |     |   node ID| 
|  3  |      PROJECT\_ID      |  varchar |   64  |  0  |   N  |  N  |     |   Project ID| 
|  4  |        HOSTNAME       |  varchar |  128  |  0  |   Y  |  N  |     |   Host name| 
|  5  |           IP          |  varchar |   64  |  0  |   Y  |  N  |     |   IP| 
|  6  |           OS          |  varchar |   16  |  0  |   N  |  N  |     |   The operating system| 
|  7  |       DETECT\_OS      |  varchar |  128  |  0  |   Y  |  N  |     |  Test The operating system| 
|  8  |         STATUS        |    int   |   10  |  0  |   N  |  N  |     |    status   | 
|  9  |      SECRET\_KEY      |  varchar |  256  |  0  |   N  |  N  |     |    secretKey   | 
|  10 |     CREATED\_USER     |  varchar |   64  |  0  |   N  |  N  |     |   projectCreator   | 
|  11 |     CREATED\_TIME     | datetime |   19  |  0  |   N  |  N  |     |   creationTime| 
|  12 |   START\_REMOTE\_IP   |  varchar |   64  |  0  |   Y  |  N  |     |   Host IP| 
|  13 |        GATEWAY        |  varchar |  256  |  0  |   Y  |  N  |     |  target service Gateway| 
|  14 |        VERSION        |  varchar |  128  |  0  |   Y  |  N  |     |   versionNum   | 
|  15 |    MASTER\_VERSION    |  varchar |  128  |  0  |   Y  |  N  |     |   majorVersion   | 
|  16 | PARALLEL\_TASK\_COUNT |    int   |   10  |  0  |   Y  |  N  |     |  parallel Task Total| 
|  17 |  AGENT\_INSTALL\_PATH |  varchar |  512  |  0  |   Y  |  N  |     | agent installPath| 
|  18 |     STARTED\_USER     |  varchar |   64  |  0  |   Y  |  N  |     |   Start Up   | 
|  19 |      AGENT\_ENVS      |   text   | 65535 |  0  |   Y  |  N  |     |   Env Variables| 
|  20 |     FILE\_GATEWAY     |  varchar |  256  |  0  |   Y  |  N  |     |  file Gateway path| 

**Table name:** T\_ENVIRONMENT\_THIRDPARTY\_AGENT\_ACTION

**Description:** 

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID | 
|  2  |   AGENT\_ID  |  bigint  |  20 |  0  |   N  |  N  |     | agent ID| 
|  3  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     |  Project ID| 
|  4  |    ACTION    |  varchar |  64 |  0  |   N  |  N  |     |   Operation| 
|  5  | ACTION\_TIME | datetime |  19 |  0  |   N  |  N  |     |  operateTime| 

**Table name:** T\_ENVIRONMENT\_THIRDPARTY\_ENABLE\_PROJECTS

**Description:** 

**Data column:** 

|  No. |       name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  |
| :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |  PROJECT\_ID  |  varchar |  64 |  0  |   N  |  Y  |     | Project ID| 
|  2  |     ENALBE    |    bit   |  1  |  0  |   Y  |  N  |     | Enable| 
|  3  | CREATED\_TIME | datetime |  19 |  0  |   N  |  N  |     | creationTime| 
|  4  | UPDATED\_TIME | datetime |  19 |  0  |   N  |  N  |     | updateTime| 

**Table name:** T\_ENV\_NODE

**Description:**   environment Mapping Table 

**Data column:** 

|  No. |      name     |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  |
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |   ENV\_ID   |  bigint |  20 |  0  |   N  |  Y  |     | environment ID| 
|  2  |   NODE\_ID  |  bigint |  20 |  0  |   N  |  Y  |     | node ID| 
|  3  | PROJECT\_ID | varchar |  64 |  0  |   N  |  N  |     | Project ID| 

**Table name:** T\_ENV\_SHARE\_PROJECT

**Description:** 

**Data column:** 

|  No. |           name          |    Type Of Data   |  length  | decimal place | Allow Null |   primary key  | defaultValue |     Description    |
| :-: | :-------------------: | :-------: | :--: | :-: | :--: | :-: | :-: | :-------: |
|  1  |        ENV\_ID        |   bigint  |  20  |  0  |   N  |  Y  |     |    environment ID   | 
|  2  |       ENV\_NAME       |  varchar  |  128 |  0  |   N  |  N  |     |    environment name   | 
|  3  |   MAIN\_PROJECT\_ID   |  varchar  |  64  |  0  |   N  |  Y  |     |   Master Project ID   | 
|  4  |  SHARED\_PROJECT\_ID  |  varchar  |  64  |  0  |   N  |  Y  |     | Shared target Project ID| 
|  5  | SHARED\_PROJECT\_NAME |  varchar  | 1024 |  0  |   Y  |  N  |     |   target project Name| 
|  6  |          TYPE         |  varchar  |  64  |  0  |   N  |  N  |     |     type    | 
|  7  |        CREATOR        |  varchar  |  64  |  0  |   N  |  N  |     |    projectCreator    | 
|  8  |      CREATE\_TIME     | timestamp |  19  |  0  |   Y  |  N  |     |    creationTime   | 
|  9  |      UPDATE\_TIME     | timestamp |  19  |  0  |   Y  |  N  |     |    updateTime   | 

**Table name:** T\_NODE

**Description:**   Node information table 

**Data column:** 

|  No. |          name          |    Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |     Description    |
| :-: | :------------------: | :-------: | :-: | :-: | :--: | :-: | :-: | :-------: |
|  1  |       NODE\_ID       |   bigint  |  20 |  0  |   N  |  Y  |     |  node ID primary key ID| 
|  2  |   NODE\_STRING\_ID   |  varchar  |  32 |  0  |   Y  |  N  |     |  node ID string| 
|  3  |      PROJECT\_ID     |  varchar  |  64 |  0  |   N  |  N  |     |    Project ID   | 
|  4  |       NODE\_IP       |  varchar  |  64 |  0  |   N  |  N  |     |    IP   | 
|  5  |      NODE\_NAME      |  varchar  |  64 |  0  |   N  |  N  |     |    node name   | 
|  6  |     NODE\_STATUS     |  varchar  |  64 |  0  |   N  |  N  |     |    nodeStatus   | 
|  7  |      NODE\_TYPE      |  varchar  |  64 |  0  |   N  |  N  |     |    nodeType   | 
|  8  |   NODE\_CLUSTER\_ID  |  varchar  | 128 |  0  |   Y  |  N  |     |    cluster ID   | 
|  9  |    NODE\_NAMESPACE   |  varchar  | 128 |  0  |   Y  |  N  |     |   node Namespace| 
|  10 |     CREATED\_USER    |  varchar  |  64 |  0  |   N  |  N  |     |    projectCreator    | 
|  11 |     CREATED\_TIME    | timestamp |  19 |  0  |   Y  |  N  |     |    creationTime   | 
|  12 |     EXPIRE\_TIME     | timestamp |  19 |  0  |   Y  |  N  |     |    expireDate   | 
|  13 |       OS\_NAME       |  varchar  | 128 |  0  |   Y  |  N  |     |   The operating system name| 
|  14 |       OPERATOR       |  varchar  | 256 |  0  |   Y  |  N  |     |    operator    | 
|  15 |     BAK\_OPERATOR    |  varchar  | 256 |  0  |   Y  |  N  |     |   bkOperator   | 
|  16 |     AGENT\_STATUS    |    bit    |  1  |  0  |   Y  |  N  |     |   agent status   | 
|  17 |     DISPLAY\_NAME    |  varchar  | 128 |  0  |   N  |  N  |     |     aliasName    | 
|  18 |         IMAGE        |  varchar  | 512 |  0  |   Y  |  N  |     |     mirror image    | 
|  19 |       TASK\_ID       |   bigint  |  20 |  0  |   Y  |  N  |     |    Task ID   | 
|  20 |  LAST\_MODIFY\_TIME  | timestamp |  19 |  0  |   Y  |  N  |     |   Updated at| 
|  21 |  LAST\_MODIFY\_USER  |  varchar  | 512 |  0  |   Y  |  N  |     |   Updated by   | 
|  22 |        BIZ\_ID       |   bigint  |  20 |  0  |   Y  |  N  |     |    Biz   | 
|  23 | PIPELINE\_REF\_COUNT |    int    |  10 |  0  |   N  |  N  |  0  |Number of Pipeline Job references| 
|  24 |   LAST\_BUILD\_TIME  |  datetime |  19 |  0  |   Y  |  N  |     |   Recent build time| 

**Table name:** T\_PROJECT\_CONFIG

**Description:** 

**Data column:** 

|  No. |          name         |    Type Of Data   |  length | decimal place | Allow Null |   primary key  |  defaultValue |  Description  |
| :-: | :-----------------: | :-------: | :-: | :-: | :--: | :-: | :--: | :--: |
|  1  |     PROJECT\_ID     |  varchar  |  64 |  0  |   N  |  Y  |      | Project ID  |
|  2  |    UPDATED\_USER    |  varchar  |  64 |  0  |   N  |  N  |      |  Updated by  |
|  3  |    UPDATED\_TIME    | timestamp |  19 |  0  |   Y  |  N  |      | Change the time  |
|  4  |    BCSVM\_ENALBED   |    bit    |  1  |  0  |   N  |  N  | b'0' |      |
|  5  |     BCSVM\_QUOTA    |    int    |  10 |  0  |   N  |  N  |   0  |      |
|  6  |    IMPORT\_QUOTA    |    int    |  10 |  0  |   N  |  N  |  30  |      |
|  7  | DEV\_CLOUD\_ENALBED |    bit    |  1  |  0  |   N  |  N  | b'0' |      |
|  8  |  DEV\_CLOUD\_QUOTA  |    int    |  10 |  0  |   N  |  N  |   0  |      |
