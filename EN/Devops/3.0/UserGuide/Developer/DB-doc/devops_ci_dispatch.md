 # devops\_ci\_dispatch 

 **The database name:** devops\_ci\_dispatch 

 **The document Version:** 1.0.0 

 **The document description:** The database document of the devops\_ci\_dispatch 

 |                                Table name                               |        Description       | 
 | :-------------------------------------------------------------: | :-------------: | 
 |             [T\_DISPATCH\_MACHINE](broken-reference)            |                 | 
 |         [T\_DISPATCH\_PIPELINE\_BUILD](broken-reference)        |                 | 
 |     [T\_DISPATCH\_PIPELINE\_DOCKER\_BUILD](broken-reference)    |                 | 
 |     [T\_DISPATCH\_PIPELINE\_DOCKER\_DEBUG](broken-reference)    |                 | 
 |    [T\_DISPATCH\_PIPELINE\_DOCKER\_ENABLE](broken-reference)    |                 | 
 |     [T\_DISPATCH\_PIPELINE\_DOCKER\_HOST](broken-reference)     |                 | 
 |  [T\_DISPATCH\_PIPELINE\_DOCKER\_HOST\_ZONE](broken-reference)  |                 | 
 |   [T\_DISPATCH\_PIPELINE\_DOCKER\_IP\_INFO](broken-reference)   |   DOCKER agent Load TABLE| 
 |     [T\_DISPATCH\_PIPELINE\_DOCKER\_POOL](broken-reference)     |  DOCKER Concurrent build Pool status Table| 
 |     [T\_DISPATCH\_PIPELINE\_DOCKER\_TASK](broken-reference)     |                 | 
 |  [T\_DISPATCH\_PIPELINE\_DOCKER\_TASK\_DRIFT](broken-reference) |DOCKER buildTask Drift Log Sheet| 
 | [T\_DISPATCH\_PIPELINE\_DOCKER\_TASK\_SIMPLE](broken-reference) |   DOCKER buildTask SHEET   | 
 |   [T\_DISPATCH\_PIPELINE\_DOCKER\_TEMPLATE](broken-reference)   |                 | 
 |          [T\_DISPATCH\_PIPELINE\_VM](broken-reference)          |                 | 
 |           [T\_DISPATCH\_PRIVATE\_VM](broken-reference)          |                 | 
 |       [T\_DISPATCH\_PROJECT\_RUN\_TIME](broken-reference)       |    Amount Used project month    | 
 |        [T\_DISPATCH\_PROJECT\_SNAPSHOT](broken-reference)       |                 | 
 |         [T\_DISPATCH\_QUOTA\_PROJECT](broken-reference)         |       project quota      | 
 |          [T\_DISPATCH\_QUOTA\_SYSTEM](broken-reference)         |       system quota      | 
 |          [T\_DISPATCH\_RUNNING\_JOBS](broken-reference)         |     JOB running     | 
 |    [T\_DISPATCH\_THIRDPARTY\_AGENT\_BUILD](broken-reference)    |                 | 
 |               [T\_DISPATCH\_VM](broken-reference)               |                 | 
 |            [T\_DISPATCH\_VM\_TYPE](broken-reference)            |                 | 
 |         [T\_DOCKER\_RESOURCE\_OPTIONS](broken-reference)        |   Docker Base quota table   | 
 
 **Table name:** T\_DISPATCH\_MACHINE 

 **Description:** 

 **Data column:** 

 |  No.|           name           |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|      Description      | 
 | :-: | :--------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----------: | 
 |  1  |       MACHINE\_ID      |    int   |  10 |  0  |   N  |  Y  |     |     Machine ID     | 
 |  2  |       MACHINE\_IP      |  varchar | 128 |  0  |   N  |  N  |     |    Machine IP    | 
 |  3  |      MACHINE\_NAME     |  varchar | 128 |  0  |   N  |  N  |     |     Machine name     | 
 |  4  |    MACHINE\_USERNAME   |  varchar | 128 |  0  |   N  |  N  |     |     machine username    | 
 |  5  |    MACHINE\_PASSWORD   |  varchar | 128 |  0  |   N  |  N  |     |     machine password     | 
 |  6  | MACHINE\_CREATED\_TIME | datetime |  19 |  0  |   N  |  N  |     |    Machine creationTime    | 
 |  7  | MACHINE\_UPDATED\_TIME | datetime |  19 |  0  |   N  |  N  |     |    machine Change the time    | 
 |  8  |    CURRENT\_VM\_RUN    |    int   |  10 |  0  |   N  |  N  |  0  |Number of virtual machines current Run| 
 |  9  |      MAX\_VM\_RUN      |    int   |  10 |  0  |   N  |  N  |  1  |Maximum number of virtual machines Allow| 

 **Table name:** T\_DISPATCH\_PIPELINE\_BUILD 

 **Description:** 

 **Data column:** 

 |  No.|       name      |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|   Description| 
 | :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: | 
 |  1  |       ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  Primary Key ID| 
 |  2  |  PROJECT\_ID  |  varchar |  32 |  0  |   N  |  N  |     |  Project ID| 
 |  3  |  PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |     | pipelineId| 
 |  4  |   BUILD\_ID   |  varchar |  34 |  0  |   N  |  N  |     |  build ID| 
 |  5  |  VM\_SEQ\_ID  |  varchar |  34 |  0  |   N  |  N  |     | build index Number| 
 |  6  |     VM\_ID    |  bigint  |  20 |  0  |   N  |  N  |     | Virtual Machine ID| 
 |  7  | CREATED\_TIME | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
 |  8  | UPDATED\_TIME | datetime |  19 |  0  |   N  |  N  |     |  updateTime| 
 |  9  |     STATUS    |    int   |  10 |  0  |   N  |  N  |     |   status| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_BUILD 

 **Description:** 

 **Data column:** 

 |  No.|         name        |   Type Of Data   |   length| decimal place| Allow Null| primary key| defaultValue|     Description     | 
 | :-: | :---------------: | :------: | :---: | :-: | :--: | :-: | :-: | :--------: | 
 |  1  |         ID        |  bigint  |   20  |  0  |   N  |  Y  |     |    Primary Key ID    | 
 |  2  |     BUILD\_ID     |  varchar |   64  |  0  |   N  |  N  |     |    build ID    | 
 |  3  |    VM\_SEQ\_ID    |    int   |   10  |  0  |   N  |  N  |     |    build index Number   | 
 |  4  |    SECRET\_KEY    |  varchar |   64  |  0  |   N  |  N  |     |     secretKey     | 
 |  5  |       STATUS      |    int   |   10  |  0  |   N  |  N  |     |     status     | 
 |  6  |   CREATED\_TIME   | datetime |   19  |  0  |   N  |  N  |     |    creationTime    | 
 |  7  |   UPDATED\_TIME   | datetime |   19  |  0  |   N  |  N  |     |    updateTime    | 
 |  8  |        ZONE       |  varchar |  128  |  0  |   Y  |  N  |     |    agent region   | 
 |  9  |    PROJECT\_ID    |  varchar |   34  |  0  |   Y  |  N  |     |    Project ID    | 
 |  10 |    PIPELINE\_ID   |  varchar |   34  |  0  |   Y  |  N  |     |    pipelineId   | 
 |  11 | DISPATCH\_MESSAGE |  varchar |  4096 |  0  |   Y  |  N  |     |    Send Message    | 
 |  12 |  STARTUP\_MESSAGE |   text   | 65535 |  0  |   Y  |  N  |     |    Start Up information    | 
 |  13 |     ROUTE\_KEY    |  varchar |   64  |  0  |   Y  |  N  |     | Routing Key for Message queue| 
 |  14 |  DOCKER\_INST\_ID |  bigint  |   20  |  0  |   Y  |  N  |     |            | 
 |  15 |    VERSION\_ID    |    int   |   10  |  0  |   Y  |  N  |     |    version ID    | 
 |  16 |    TEMPLATE\_ID   |    int   |   10  |  0  |   Y  |  N  |     |    Template ID    | 
 |  17 |   NAMESPACE\_ID   |  bigint  |   20  |  0  |   Y  |  N  |     |   Namespace ID   | 
 |  18 |     DOCKER\_IP    |  varchar |   64  |  0  |   Y  |  N  |     |    agent IP   | 
 |  19 |   CONTAINER\_ID   |  varchar |  128  |  0  |   Y  |  N  |     |   build Container ID   | 
 |  20 |      POOL\_NO     |    int   |   10  |  0  |   Y  |  N  |  0  |   build Container Pool No.| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_DEBUG 

 **Description:** 

 **Data column:** 

 |  No.|          name         |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|       Description       | 
 | :-: | :-----------------: | :------: | :--: | :-: | :--: | :-: | :-: | :------------: | 
 |  1  |          ID         |  bigint  |  20  |  0  |   N  |  Y  |     |      Primary Key ID      | 
 |  2  |     PROJECT\_ID     |  varchar |  64  |  0  |   N  |  N  |     |      Project ID      | 
 |  3  |     PIPELINE\_ID    |  varchar |  34  |  0  |   N  |  N  |     |      pipelineId     | 
 |  4  |     VM\_SEQ\_ID     |  varchar |  34  |  0  |   N  |  N  |     |      build index Number     | 
 |  5  |       POOL\_NO      |    int   |  10  |  0  |   N  |  N  |  0  |      build Pool No.     | 
 |  6  |        STATUS       |    int   |  10  |  0  |   N  |  N  |     |       status       | 
 |  7  |        TOKEN        |  varchar |  128 |  0  |   Y  |  N  |     |      TOKEN     | 
 |  8  |     IMAGE\_NAME     |  varchar | 1024 |  0  |   N  |  N  |     |      mirrorName      | 
 |  9  |      HOST\_TAG      |  varchar |  128 |  0  |   Y  |  N  |     |      Host label      | 
 |  10 |    CONTAINER\_ID    |  varchar |  128 |  0  |   Y  |  N  |     |     build Container ID     | 
 |  11 |    CREATED\_TIME    | datetime |  19  |  0  |   N  |  N  |     |      creationTime      | 
 |  12 |    UPDATED\_TIME    | datetime |  19  |  0  |   N  |  N  |     |      Change the time      | 
 |  13 |         ZONE        |  varchar |  128 |  0  |   Y  |  N  |     |      agent region     | 
 |  14 |      BUILD\_ENV     |  varchar | 4096 |  0  |   Y  |  N  |     |     agent Env Variables    | 
 |  15 |    REGISTRY\_USER   |  varchar |  128 |  0  |   Y  |  N  |     |      Registered username     | 
 |  16 |    REGISTRY\_PWD    |  varchar |  128 |  0  |   Y  |  N  |     |     Registered user password     | 
 |  17 |     IMAGE\_TYPE     |  varchar |  128 |  0  |   Y  |  N  |     |      Mirror type      | 
 |  18 | IMAGE\_PUBLIC\_FLAG |    bit   |   1  |  0  |   Y  |  N  |     | Whether the image is publicImage: 0 No 1 Yes| 
 |  19 |   IMAGE\_RD\_TYPE   |    bit   |   1  |  0  |   Y  |  N  |     | Image R & D source: 0 self-developed 1 third party| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_ENABLE 

 **Description:** 

 **Data column:** 

 |  No.|      name      |   Type Of Data| length| decimal place| Allow Null| primary key| defaultValue|   Description| 
 | :-: | :----------: | :-----: | :-: | :-: | :--: | :-: | :-: | :---: | 
 |  1  | PIPELINE\_ID | varchar |  64 |  0  |   N  |  Y  |     | pipelineId| 
 |  2  |    ENABLE    |   bit   |  1  |  0  |   N  |  N  |  0  |Enable| 
 |  3  |  VM\_SEQ\_ID |   int   |  10 |  0  |   N  |  Y  |  -1 |build index Number| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_HOST 

 **Description:** 

 **Data column:** 

 |  No.|       name      |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|     Description     | 
 | :-: | :-----------: | :------: | :--: | :-: | :--: | :-: | :-: | :--------: | 
 |  1  | PROJECT\_CODE |  varchar |  128 |  0  |   N  |  Y  |     |   userGroup Project| 
 |  2  |    HOST\_IP   |  varchar |  128 |  0  |   N  |  Y  |     |    Host ip    | 
 |  3  |     REMARK    |  varchar | 1024 |  0  |   Y  |  N  |     |     Commentary     | 
 |  4  | CREATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |    creationTime    | 
 |  5  | UPDATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |    updateTime    | 
 |  6  |      TYPE     |    int   |  10  |  0  |   N  |  N  |  0  |     type     | 
 |  7  |   ROUTE\_KEY  |  varchar |  45  |  0  |   Y  |  N  |     | Routing Key for Message queue| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_HOST\_ZONE 

 **Description:** 

 **Data column:** 

 |  No.|       name      |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|     Description     | 
 | :-: | :-----------: | :------: | :--: | :-: | :--: | :-: | :-: | :--------: | 
 |  1  |    HOST\_IP   |  varchar |  128 |  0  |   N  |  Y  |     |    Host ip    | 
 |  2  |      ZONE     |  varchar |  128 |  0  |   N  |  N  |     |    agent region   | 
 |  3  |     ENABLE    |    bit   |   1  |  0  |   Y  |  N  |  1  |    Enable    | 
 |  4  |     REMARK    |  varchar | 1024 |  0  |   Y  |  N  |     |     Commentary     | 
 |  5  | CREATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |    creationTime    | 
 |  6  | UPDATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |    updateTime    | 
 |  7  |      TYPE     |    int   |  10  |  0  |   N  |  N  |  0  |     type     | 
 |  8  |   ROUTE\_KEY  |  varchar |  45  |  0  |   Y  |  N  |     | Routing Key for Message queue| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_IP\_INFO 

 **Description:** DOCKER agent Load table 

 **Data column:** 

 |  No.|         name         |   Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |      Description      | 
 | :-: | :----------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----------: | 
 |  1  |         ID         |  bigint  |  20 |  0  |   N  |  Y  |                    |      primary key      | 
 |  2  |     DOCKER\_IP     |  varchar |  64 |  0  |   N  |  N  |                    |   DOCKERIP   | 
 |  3  | DOCKER\_HOST\_PORT |    int   |  10 |  0  |   N  |  N  |         80         |  DOCKERPORT  | 
 |  4  |      CAPACITY      |    int   |  10 |  0  |   N  |  N  |          0         |    Total node container Capacity   | 
 |  5  |      USED\_NUM     |    int   |  10 |  0  |   N  |  N  |          0         |   node Container Used Capacity| 
 |  6  |      CPU\_LOAD     |    int   |  10 |  0  |   N  |  N  |          0         |   node Container CPU Load| 
 |  7  |      MEM\_LOAD     |    int   |  10 |  0  |   N  |  N  |          0         |   node Container MEM Load| 
 |  8  |     DISK\_LOAD     |    int   |  10 |  0  |   N  |  N  |          0         |  node Container Disk Load| 
 |  9  |   DISK\_IO\_LOAD   |    int   |  10 |  0  |   N  |  N  |          0         | node Container DISKIO Load| 
 |  10 |       ENABLE       |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |    Whether the node is available    | 
 |  11 |     SPECIAL\_ON    |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |   Whether the node acts as a dedicated machine| 
 |  12 |      GRAY\_ENV     |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |    Whether it is a gray node   | 
 |  13 |    CLUSTER\_NAME   |  varchar |  64 |  0  |   Y  |  N  |       COMMON       |    build cluster type    | 
 |  14 |     GMT\_CREATE    | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |     creationTime     | 
 |  15 |    GMT\_MODIFIED   | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |     Change the time     | 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_POOL 

 **Description:** DOCKER concurrent build pool status table 

 **Data column:** 

 |  No.|       name      |   Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |   Description| 
 | :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---: | 
 |  1  |       ID      |  bigint  |  20 |  0  |   N  |  Y  |                    |   primary key| 
 |  2  |  PIPELINE\_ID |  varchar |  64 |  0  |   N  |  N  |                    | pipelineId| 
 |  3  |    VM\_SEQ    |  varchar |  64 |  0  |   N  |  N  |                    | agent No.| 
 |  4  |    POOL\_NO   |    int   |  10 |  0  |   N  |  N  |          0         | build Pool No.| 
 |  5  |     STATUS    |    int   |  10 |  0  |   N  |  N  |          0         | build Pool status| 
 |  6  |  GMT\_CREATE  | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  | GMT\_MODIFIED | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |Change the time| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_TASK 

 **Description:** 

 **Data column:** 

 |  No.|          name         |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|       Description       | 
 | :-: | :-----------------: | :------: | :--: | :-: | :--: | :-: | :-: | :------------: | 
 |  1  |          ID         |  bigint  |  20  |  0  |   N  |  Y  |     |      Primary Key ID      | 
 |  2  |     PROJECT\_ID     |  varchar |  64  |  0  |   N  |  N  |     |      Project ID      | 
 |  3  |      AGENT\_ID      |  varchar |  32  |  0  |   N  |  N  |     |      agent ID     | 
 |  4  |     PIPELINE\_ID    |  varchar |  34  |  0  |   N  |  N  |     |      pipelineId     | 
 |  5  |      BUILD\_ID      |  varchar |  34  |  0  |   N  |  N  |     |      build ID      | 
 |  6  |     VM\_SEQ\_ID     |    int   |  10  |  0  |   N  |  N  |     |      build index Number     | 
 |  7  |        STATUS       |    int   |  10  |  0  |   N  |  N  |     |       status       | 
 |  8  |     SECRET\_KEY     |  varchar |  128 |  0  |   N  |  N  |     |       secretKey       | 
 |  9  |     IMAGE\_NAME     |  varchar | 1024 |  0  |   N  |  N  |     |      mirrorName      | 
 |  10 |    CHANNEL\_CODE    |  varchar |  128 |  0  |   Y  |  N  |     |    Channel number, default to DS   | 
 |  11 |      HOST\_TAG      |  varchar |  128 |  0  |   Y  |  N  |     |      Host label      | 
 |  12 |    CONTAINER\_ID    |  varchar |  128 |  0  |   Y  |  N  |     |     build Container ID     | 
 |  13 |    CREATED\_TIME    | datetime |  19  |  0  |   N  |  N  |     |      creationTime      | 
 |  14 |    UPDATED\_TIME    | datetime |  19  |  0  |   N  |  N  |     |      updateTime      | 
 |  15 |         ZONE        |  varchar |  128 |  0  |   Y  |  N  |     |      agent region     | 
 |  16 |    REGISTRY\_USER   |  varchar |  128 |  0  |   Y  |  N  |     |      Registered username     | 
 |  17 |    REGISTRY\_PWD    |  varchar |  128 |  0  |   Y  |  N  |     |     Registered user password     | 
 |  18 |     IMAGE\_TYPE     |  varchar |  128 |  0  |   Y  |  N  |     |      Mirror type      | 
 |  19 | CONTAINER\_HASH\_ID |  varchar |  128 |  0  |   Y  |  N  |     |    build Job Unique ID   | 
 |  20 | IMAGE\_PUBLIC\_FLAG |    bit   |   1  |  0  |   Y  |  N  |     | Whether the image is publicImage: 0 No 1 Yes| 
 |  21 |   IMAGE\_RD\_TYPE   |    bit   |   1  |  0  |   Y  |  N  |     | Image R & D source: 0 self-developed 1 third party| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_TASK\_DRIFT 

 **Description:** DOCKER buildTask Drift Record Table 

 **Data column:** 

 |  No.|           name          |   Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |    Description   | 
 | :-: | :-------------------: | :------: | :--: | :-: | :--: | :-: | :----------------: | :-----: | 
 |  1  |           ID          |  bigint  |  20  |  0  |   N  |  Y  |                    |    primary key   | 
 |  2  |      PIPELINE\_ID     |  varchar |  64  |  0  |   N  |  N  |                    |  pipelineId| 
 |  3  |       BUILD\_ID       |  varchar |  64  |  0  |   N  |  N  |                    |   build ID| 
 |  4  |        VM\_SEQ        |  varchar |  64  |  0  |   N  |  N  |                    |  agent No.| 
 |  5  |    OLD\_DOCKER\_IP    |  varchar |  64  |  0  |   N  |  N  |                    | Old build Container IP| 
 |  6  |    NEW\_DOCKER\_IP    |  varchar |  64  |  0  |   N  |  N  |                    | New build container IP| 
 |  7  | OLD\_DOCKER\_IP\_INFO |  varchar | 1024 |  0  |   N  |  N  |                    | Old Container IP Load| 
 |  8  |      GMT\_CREATE      | datetime |  19  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |   creationTime| 
 |  9  |     GMT\_MODIFIED     | datetime |  19  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |   Change the time| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_TASK\_SIMPLE 

 **Description:** DOCKER buildTask Table 

 **Data column:** 

 |  No.|            name            |   Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |   Description   | 
 | :-: | :----------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |            ID            |  bigint  |  20 |  0  |   N  |  Y  |                    |   primary key   | 
 |  2  |       PIPELINE\_ID       |  varchar |  64 |  0  |   N  |  N  |                    |  pipelineId| 
 |  3  |          VM\_SEQ         |  varchar |  64 |  0  |   N  |  N  |                    |  agent No.| 
 |  4  |        DOCKER\_IP        |  varchar |  64 |  0  |   N  |  N  |                    | build Container IP| 
 |  5  | DOCKER\_RESOURCE\_OPTION |    int   |  10 |  0  |   N  |  N  |          0         | Resource Allocation| 
 |  6  |        GMT\_CREATE       | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  |       GMT\_MODIFIED      | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |Change the time| 

 **Table name:** T\_DISPATCH\_PIPELINE\_DOCKER\_TEMPLATE 

 **Description:** 

 **Data column:** 

 |  No.|          name         |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue| Description| 
 | :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |          ID         |    int   |  10 |  0  |   N  |  Y  |     | Primary Key ID| 
 |  2  |     VERSION\_ID     |    int   |  10 |  0  |   N  |  N  |     | version ID| 
 |  3  |  SHOW\_VERSION\_ID  |    int   |  10 |  0  |   N  |  N  |     |      | 
 |  4  | SHOW\_VERSION\_NAME |  varchar |  64 |  0  |   N  |  N  |     | version name| 
 |  5  |    DEPLOYMENT\_ID   |    int   |  10 |  0  |   N  |  N  |     | Deploy ID| 
 |  6  |   DEPLOYMENT\_NAME  |  varchar |  64 |  0  |   N  |  N  |     | Deploy name| 
 |  7  |     CC\_APP\_ID     |  bigint  |  20 |  0  |   N  |  N  |     | App ID| 
 |  8  |   BCS\_PROJECT\_ID  |  varchar |  64 |  0  |   N  |  N  |     |      | 
 |  9  |     CLUSTER\_ID     |  varchar |  64 |  0  |   N  |  N  |     | cluster ID| 
 |  10 |    CREATED\_TIME    | datetime |  19 |  0  |   N  |  N  |     | creationTime| 

 **Table name:** T\_DISPATCH\_PIPELINE\_VM 

 **Description:** 

 **Data column:** 

 |  No.|      name      |   Type Of Data|   length| decimal place| Allow Null| primary key| defaultValue|   Description| 
 | :-: | :----------: | :-----: | :---: | :-: | :--: | :-: | :-: | :---: | 
 |  1  | PIPELINE\_ID | varchar |   64  |  0  |   N  |  Y  |     | pipelineId| 
 |  2  |   VM\_NAMES  |   text  | 65535 |  0  |   N  |  N  |     |  VM name| 
 |  3  |  VM\_SEQ\_ID |   int   |   10  |  0  |   N  |  Y  |  -1 |build index Number| 

 **Table name:** T\_DISPATCH\_PRIVATE\_VM 

 **Description:** 

 **Data column:** 

 |  No.|      name     |   Type Of Data| length| decimal place| Allow Null| primary key| defaultValue| Description| 
 | :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |    VM\_ID   |   int   |  10 |  0  |   N  |  Y  |     | VMID | 
 |  2  | PROJECT\_ID | varchar |  64 |  0  |   N  |  N  |     | Project ID| 

 **Table name:** T\_DISPATCH\_PROJECT\_RUN\_TIME 

 **Description:** The quota of the project Used in the current month 

 **Data column:** 

 |  No.|      name      |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue| Description| 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |  PROJECT\_ID |  varchar | 128 |  0  |   N  |  Y  |     | Project ID| 
 |  2  |   VM\_TYPE   |  varchar | 128 |  0  |   N  |  Y  |     | VM type| 
 |  3  |   RUN\_TIME  |  bigint  |  20 |  0  |   N  |  N  |     | Run time| 
 |  4  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | updateTime| 

 **Table name:** T\_DISPATCH\_PROJECT\_SNAPSHOT 

 **Description:** 

 **Data column:** 

 |  No.|           name          |   Type Of Data| length| decimal place| Allow Null| primary key| defaultValue|   Description   | 
 | :-: | :-------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |      PROJECT\_ID      | varchar |  64 |  0  |   N  |  Y  |     |  Project ID| 
 |  2  | VM\_STARTUP\_SNAPSHOT | varchar |  64 |  0  |   N  |  N  |     | VM Start Up Snapshot| 

 **Table name:** T\_DISPATCH\_QUOTA\_PROJECT 

 **Description:** project quota 

 **Data column:** 

 |  No.|              name             |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|       Description      | 
 | :-: | :-------------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-----------: | 
 |  1  |         PROJECT\_ID         |  varchar | 128 |  0  |   N  |  Y  |     |      Project ID     | 
 |  2  |           VM\_TYPE          |  varchar | 128 |  0  |   N  |  Y  |     |      VM type     | 
 |  3  |      RUNNING\_JOBS\_MAX     |    int   |  10 |  0  |   N  |  N  |     |   Maximum number of concurrent JOBs for project| 
 |  4  |   RUNNING\_TIME\_JOB\_MAX   |    int   |  10 |  0  |   N  |  N  |     |  Maximum lastExecTime of project list JOB| 
 |  5  | RUNNING\_TIME\_PROJECT\_MAX |    int   |  10 |  0  |   N  |  N  |     | Maximum lastExecTime for all JOBs of the project| 
 |  6  |        CREATED\_TIME        | datetime |  19 |  0  |   N  |  N  |     |      creationTime     | 
 |  7  |        UPDATED\_TIME        | datetime |  19 |  0  |   N  |  N  |     |      updateTime     | 
 |  8  |           OPERATOR          |  varchar | 128 |  0  |   N  |  N  |     |      operateUser      | 

 **Table name:** T\_DISPATCH\_QUOTA\_SYSTEM 

 **Description:** system quota 

 **Data column:** 
  |  No.|                    name                   |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|         Description        | 
 | :-: | :-------------------------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :---------------: | 
 |  1  |                 VM\_TYPE                |  varchar | 128 |  0  |   N  |  Y  |     |       agent type       | 
 |  2  |        RUNNING\_JOBS\_MAX\_SYSTEM       |    int   |  10 |  0  |   N  |  N  |     |    Maximum number of concurrent JOBs in BK-CI system   | 
 |  3  |       RUNNING\_JOBS\_MAX\_PROJECT       |    int   |  10 |  0  |   N  |  N  |     |   Default maximum concurrent JOB number for single project   | 
 |  4  |         RUNNING\_TIME\_JOB\_MAX         |    int   |  10 |  0  |   N  |  N  |     | The system defaults to the maximum lastExecTime of all individual JOBs| 
 |  5  |     RUNNING\_TIME\_JOB\_MAX\_PROJECT    |    int   |  10 |  0  |   N  |  N  |     |  Default maximum lastExecTime of all JOBs for single project| 
 |  6  |    RUNNING\_JOBS\_MAX\_GITCI\_SYSTEM    |    int   |  10 |  0  |   N  |  N  |     |  Total Maximum Concurrent JOB Quantity of Worker Bee CI system| 
 |  7  |    RUNNING\_JOBS\_MAX\_GITCI\_PROJECT   |    int   |  10 |  0  |   N  |  N  |     |  Maximum concurrent JOB Quantity of worker bee CI single project| 
 |  8  |      RUNNING\_TIME\_JOB\_MAX\_GITCI     |    int   |  10 |  0  |   N  |  N  |     |   Maximum lastExecTime of worker bee CI single JOB| 
 |  9  | RUNNING\_TIME\_JOB\_MAX\_PROJECT\_GITCI |    int   |  10 |  0  |   N  |  N  |     |   Maximum lastExecTime of worker bee CI single project   | 
 |  10 |     PROJECT\_RUNNING\_JOB\_THRESHOLD    |    int   |  10 |  0  |   N  |  N  |     |   project execute Job Quantity Alert Threshold   | 
 |  11 |    PROJECT\_RUNNING\_TIME\_THRESHOLD    |    int   |  10 |  0  |   N  |  N  |     |   project execute job time Alert Threshold   | 
 |  12 |     SYSTEM\_RUNNING\_JOB\_THRESHOLD     |    int   |  10 |  0  |   N  |  N  |     |   Alert Threshold for Quantity of jobs execute by the system   | 
 |  13 |              CREATED\_TIME              | datetime |  19 |  0  |   N  |  N  |     |        creationTime       | 
 |  14 |              UPDATED\_TIME              | datetime |  19 |  0  |   N  |  N  |     |        updateTime       | 
 |  15 |                 OPERATOR                |  varchar | 128 |  0  |   N  |  N  |     |        operateUser        | 

 **Table name:** T\_DISPATCH\_RUNNING\_JOBS 

 **Description:** running JOB 

 **Data column:** 

 |  No.|         name         |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|    Description   | 
 | :-: | :----------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-----: | 
 |  1  |         ID         |    int   |  10 |  0  |   N  |  Y  |     |   Primary Key ID| 
 |  2  |     PROJECT\_ID    |  varchar | 128 |  0  |   N  |  N  |     |   Project ID| 
 |  3  |      VM\_TYPE      |  varchar | 128 |  0  |   N  |  N  |     |   VM type| 
 |  4  |      BUILD\_ID     |  varchar | 128 |  0  |   N  |  N  |     |   build ID| 
 |  5  |     VM\_SEQ\_ID    |  varchar | 128 |  0  |   N  |  N  |     |  build index Number| 
 |  6  |   EXECUTE\_COUNT   |    int   |  10 |  0  |   N  |  N  |     |   Number of execute| 
 |  7  |    CREATED\_TIME   | datetime |  19 |  0  |   N  |  N  |     |   creationTime| 
 |  8  | AGENT\_START\_TIME | datetime |  19 |  0  |   Y  |  N  |     | agent Start Time| 

 **Table name:** T\_DISPATCH\_THIRDPARTY\_AGENT\_BUILD 

 **Description:** 

 **Data column:** 

 |  No.|       name       |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|   Description| 
 | :-: | :------------: | :------: | :--: | :-: | :--: | :-: | :-: | :---: | 
 |  1  |       ID       |  bigint  |  20  |  0  |   N  |  Y  |     |  Primary Key ID| 
 |  2  |   PROJECT\_ID  |  varchar |  64  |  0  |   N  |  N  |     |  Project ID| 
 |  3  |    AGENT\_ID   |  varchar |  32  |  0  |   N  |  N  |     | agent ID| 
 |  4  |  PIPELINE\_ID  |  varchar |  34  |  0  |   N  |  N  |     | pipelineId| 
 |  5  |    BUILD\_ID   |  varchar |  34  |  0  |   N  |  N  |     |  build ID| 
 |  6  |   VM\_SEQ\_ID  |  varchar |  34  |  0  |   N  |  N  |     | build index Number| 
 |  7  |     STATUS     |    int   |  10  |  0  |   N  |  N  |     |   status| 
 |  8  |  CREATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |  creationTime| 
 |  9  |  UPDATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |  updateTime| 
 |  10 |    WORKSPACE   |  varchar | 4096 |  0  |   Y  |  N  |     |  workspace| 
 |  11 |   BUILD\_NUM   |    int   |  10  |  0  |   Y  |  N  |  0  |Number of build| 
 |  12 | PIPELINE\_NAME |  varchar |  255 |  0  |   Y  |  N  |     | pipelineName| 
 |  13 |   TASK\_NAME   |  varchar |  255 |  0  |   Y  |  N  |     |  Task Name| 

 **Table name:** T\_DISPATCH\_VM 

 **Description:** 

 **Data column:** 

 |  No.|           name          |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|     Description    | 
 | :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-------: | 
 |  1  |         VM\_ID        |  bigint  |  20 |  0  |   N  |  Y  |     |    Primary Key ID   | 
 |  2  |    VM\_MACHINE\_ID    |    int   |  10 |  0  |   N  |  N  |     |  VM corresponding master machine ID| 
 |  3  |         VM\_IP        |  varchar | 128 |  0  |   N  |  N  |     |   VMIP address| 
 |  4  |        VM\_NAME       |  varchar | 128 |  0  |   N  |  N  |     |    VM name   | 
 |  5  |         VM\_OS        |  varchar |  64 |  0  |   N  |  N  |     |   VM system Information| 
 |  6  |    VM\_OS\_VERSION    |  varchar |  64 |  0  |   N  |  N  |     |  VM system Information version| 
 |  7  |        VM\_CPU        |  varchar |  64 |  0  |   N  |  N  |     |  VMCPU Information| 
 |  8  |       VM\_MEMORY      |  varchar |  64 |  0  |   N  |  N  |     |   VM Memory Information| 
 |  9  |      VM\_TYPE\_ID     |    int   |  10 |  0  |   N  |  N  |     |   VM type ID| 
 |  10 |      VM\_MAINTAIN     |    bit   |  1  |  0  |   N  |  N  |  0  |Is the VM in maintenance status| 
 |  11 | VM\_MANAGER\_USERNAME |  varchar | 128 |  0  |   N  |  N  |     |  VM Administrator username| 
 |  12 |  VM\_MANAGER\_PASSWD  |  varchar | 128 |  0  |   N  |  N  |     |  VM Administrator password| 
 |  13 |      VM\_USERNAME     |  varchar | 128 |  0  |   N  |  N  |     | VM Administrator username| 
 |  14 |       VM\_PASSWD      |  varchar | 128 |  0  |   N  |  N  |     |  VM Administrator password| 
 |  15 |   VM\_CREATED\_TIME   | datetime |  19 |  0  |   N  |  N  |     |    creationTime   | 
 |  16 |   VM\_UPDATED\_TIME   | datetime |  19 |  0  |   N  |  N  |     |    Change the time   | 

 **Table name:** T\_DISPATCH\_VM\_TYPE 

 **Description:** 

 **Data column:** 

 |  No.|          name         |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue| Description| 
 | :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |       TYPE\_ID      |    int   |  10 |  0  |   N  |  Y  |     | Primary Key ID| 
 |  2  |      TYPE\_NAME     |  varchar |  64 |  0  |   N  |  N  |     |  name| 
 |  3  | TYPE\_CREATED\_TIME | datetime |  19 |  0  |   N  |  N  |     | creationTime| 
 |  4  | TYPE\_UPDATED\_TIME | datetime |  19 |  0  |   N  |  N  |     | updateTime| 

 **Table name:** T\_DOCKER\_RESOURCE\_OPTIONS 

 **Description:** Docker Base Quota Table 

 **Data column:** 

  |  No.|             name            |   Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |       Description      | 
 | :-: | :-----------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----------: | 
 |  1  |             ID            |  bigint  |  20 |  0  |   N  |  Y  |                    |       primary key      | 
 |  2  |        CPU\_PERIOD        |    int   |  10 |  0  |   N  |  N  |        10000       |     CPU setting     | 
 |  3  |         CPU\_QUOTA        |    int   |  10 |  0  |   N  |  N  |       160000       |     CPU setting     | 
 |  4  |    MEMORY\_LIMIT\_BYTES   |  bigint  |  20 |  0  |   N  |  N  |     34359738368    |     Memory: 32G    | 
 |  5  |            DISK           |    int   |  10 |  0  |   N  |  N  |         100        |    Disk: 100G    | 
 |  6  | BLKIO\_DEVICE\_WRITE\_BPS |  bigint  |  20 |  0  |   N  |  N  |      125829120     | Disk write rate, 120m/s| 
 |  7  |  BLKIO\_DEVICE\_READ\_BPS |  bigint  |  20 |  0  |   N  |  N  |      125829120     | Disk read rate, 120m/s| 
 |  8  |        DESCRIPTION        |  varchar | 128 |  0  |   N  |  N  |                    |       description      | 
 |  9  |        GMT\_CREATE        | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |      creationTime     | 
 |  10 |       GMT\_MODIFIED       | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |      Change the time     | 