# devops\_ci\_plugin

**The database name:** devops\_ci\_plugin

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_plugin

|                       Table name                       |  Description |
| :--------------------------------------------: | :-: |
|      [T\_PLUGIN\_CODECC](broken-reference)     |     |
| [T\_PLUGIN\_CODECC\_ELEMENT](broken-reference) |     |
|  [T\_PLUGIN\_GITHUB\_CHECK](broken-reference)  |     |
|    [T\_PLUGIN\_GIT\_CHECK](broken-reference)   |     |

**Table name:** T\_PLUGIN\_CODECC

**Description:** 

**Data column:** 

 |  No. |          name          |   Type Of Data   |     length     | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
 | :-: | :------------------: | :------: | :--------: | :-: | :--: | :-: | :-: | :---: | 
 |  1  |          ID          |  bigint  |     20     |  0  |   N  |  Y  |     |   primary key ID | 
 |  2  |      PROJECT\_ID     |  varchar |     64     |  0  |   Y  |  N  |     |  Project ID| 
 |  3  |     PIPELINE\_ID     |  varchar |     34     |  0  |   Y  |  N  |     | pipelineId| 
 |  4  |       BUILD\_ID      |  varchar |     34     |  0  |   Y  |  N  |     |  build ID| 
 |  5  |       TASK\_ID       |  varchar |     34     |  0  |   Y  |  N  |     |  Task ID| 
 |  6  | TOOL\_SNAPSHOT\_LIST | longtext | 2147483647 |  0  |   Y  |  N  |     |       | 

**Table name:** T\_PLUGIN\_CODECC\_ELEMENT

**Description:** 

**Data column:** 

 |  No. |        name        |   Type Of Data   |     length     | decimal place | Allow Null |   primary key  | defaultValue |                    Description                   | 
 | :-: | :--------------: | :------: | :--------: | :-: | :--: | :-: | :-: | :-------------------------------------: | 
 |  1  |        ID        |  bigint  |     20     |  0  |   N  |  Y  |     |                    primary key ID                  | 
 |  2  |    PROJECT\_ID   |  varchar |     128    |  0  |   Y  |  N  |     |                   Project ID                  | 
 |  3  |   PIPELINE\_ID   |  varchar |     34     |  0  |   Y  |  N  |     |                  pipelineId                  | 
 |  4  |    TASK\_NAME    |  varchar |     256    |  0  |   Y  |  N  |     |                   Task name                  | 
 |  5  |  TASK\_CN\_NAME  |  varchar |     256    |  0  |   Y  |  N  |     |                  Task Chinese name                 | 
 |  6  |     TASK\_ID     |  varchar |     128    |  0  |   Y  |  N  |     |                   Task ID                  | 
 |  7  |     IS\_SYNC     |  varchar |      6     |  0  |   Y  |  N  |     |                  Is it synchronous                  | 
 |  8  |    SCAN\_TYPE    |  varchar |      6     |  0  |   Y  |  N  |     |             Scan type (0: All, 1: Increment)             | 
 |  9  |     LANGUAGE     |  varchar |    1024    |  0  |   Y  |  N  |     |                   engineering language                  | 
 |  10 |     PLATFORM     |  varchar |     16     |  0  |   Y  |  N  |     |   Blueking Code Check Center atomic execute environment, such for example WINDOWS, LINUX, MACOS, etc.   | 
 |  11 |       TOOLS      |  varchar |    1024    |  0  |   Y  |  N  |     |                   Scanning tool                  | 
 |  12 |    PY\_VERSION   |  varchar |     16     |  0  |   Y  |  N  |     | where "py2" means using the python2 version, and "py3" means using the python3 version| 
 |  13 |    ESLINT\_RC    |  varchar |     16     |  0  |   Y  |  N  |     |                  js project framework                 | 
 |  14 |    CODE\_PATH    | longtext | 2147483647 |  0  |   Y  |  N  |     |                  Code storage path                 | 
 |  15 |   SCRIPT\_TYPE   |  varchar |     16     |  0  |   Y  |  N  |     |                   Script type                  | 
 |  16 |      SCRIPT      | longtext | 2147483647 |  0  |   Y  |  N  |     |                   Package Script                  | 
 |  17 |   CHANNEL\_CODE  |  varchar |     16     |  0  |   Y  |  N  |     |                Channel number, default to DS                | 
 |  18 | UPDATE\_USER\_ID |  varchar |     128    |  0  |   Y  |  N  |     |                 Update user id                 | 
 |  19 |    IS\_DELETE    |  varchar |      6     |  0  |   Y  |  N  |     |                Delete 0 can be deleted by 1               | 
 |  20 |   UPDATE\_TIME   | datetime |     19     |  0  |   Y  |  N  |     |                   updateTime                  | 

**Table name:** T\_PLUGIN\_GITHUB\_CHECK

**Description:** 

**Data column:** 

 |  No. |        name        |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |        ID        |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |   PIPELINE\_ID   |  varchar |  64 |  0  |   N  |  N  |     |  pipelineId| 
 |  3  |   BUILD\_NUMBER  |    int   |  10 |  0  |   N  |  N  |     |  build Number| 
 |  4  |     REPO\_ID     |  varchar |  64 |  0  |   Y  |  N  |     |  Code Repository ID| 
 |  5  |    COMMIT\_ID    |  varchar |  64 |  0  |   N  |  N  |     | Code submit ID| 
 |  6  |  CHECK\_RUN\_ID  |  bigint  |  20 |  0  |   N  |  N  |     |        | 
 |  7  |   CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
 |  8  |   UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  |     |  updateTime| 
 |  9  |    REPO\_NAME    |  varchar | 128 |  0  |   Y  |  N  |     |  Code Repository aliasName| 
 |  10 | CHECK\_RUN\_NAME |  varchar |  64 |  0  |   Y  |  N  |     |        | 

**Table name:** T\_PLUGIN\_GIT\_CHECK

**Description:** 

**Data column:** 

 |  No. |       name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |       ID      |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |  PIPELINE\_ID |  varchar |  64 |  0  |   N  |  N  |     |  pipelineId| 
 |  3  | BUILD\_NUMBER |    int   |  10 |  0  |   N  |  N  |     |  build Number| 
 |  4  |    REPO\_ID   |  varchar |  64 |  0  |   Y  |  N  |     |  Code Repository ID| 
 |  5  |   COMMIT\_ID  |  varchar |  64 |  0  |   N  |  N  |     | Code submit ID| 
 |  6  |  CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
 |  7  |  UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  updateTime| 
 |  8  |   REPO\_NAME  |  varchar | 128 |  0  |   Y  |  N  |     |  Code Repository aliasName| 
 |  9  |    CONTEXT    |  varchar | 255 |  0  |   Y  |  N  |     |   content   | 