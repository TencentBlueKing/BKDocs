# devops\_ci\_quality

**The database name:** devops\_ci\_quality

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_quality

 |                              Table name                             |      Description     | 
 | :---------------------------------------------------------: | :---------: | 
 |            [T\_CONTROL\_POINT](broken-reference)            |             | 
 |       [T\_CONTROL\_POINT\_METADATA](broken-reference)       |             | 
 |         [T\_CONTROL\_POINT\_TASK](broken-reference)         |             | 
 |           [T\_COUNT\_INTERCEPT](broken-reference)           |             | 
 |            [T\_COUNT\_PIPELINE](broken-reference)           |             | 
 |              [T\_COUNT\_RULE](broken-reference)             |             | 
 |                 [T\_GROUP](broken-reference)                |             | 
 |                [T\_HISTORY](broken-reference)               |             | 
 |        [T\_QUALITY\_CONTROL\_POINT](broken-reference)       |   Gate Control Point Table| 
 |    [T\_QUALITY\_HIS\_DETAIL\_METADATA](broken-reference)    | Detailed Base data Table of execute result| 
 |    [T\_QUALITY\_HIS\_ORIGIN\_METADATA](broken-reference)    |  Base data Table of execute result| 
 |          [T\_QUALITY\_INDICATOR](broken-reference)          |   Gate Indicator Table   | 
 |           [T\_QUALITY\_METADATA](broken-reference)          |  Gate Base data Sheet| 
 |             [T\_QUALITY\_RULE](broken-reference)            |             | 
 |       [T\_QUALITY\_RULE\_BUILD\_HIS](broken-reference)      |             | 
 | [T\_QUALITY\_RULE\_BUILD\_HIS\_OPERATION](broken-reference) |             | 
 |          [T\_QUALITY\_RULE\_MAP](broken-reference)          |             | 
 |       [T\_QUALITY\_RULE\_OPERATION](broken-reference)       |             | 
 |        [T\_QUALITY\_RULE\_TEMPLATE](broken-reference)       |   Gate Template Table   | 
 |   [T\_QUALITY\_TEMPLATE\_INDICATOR\_MAP](broken-reference)  |   Template-Indicator Relationship Table| 
 |                 [T\_RULE](broken-reference)                 |             | 
 |                 [T\_TASK](broken-reference)                 |             | 

**Table name:** T\_CONTROL\_POINT

**Description:** 

**Data column:** 

 |  No. |      name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |      ID      |    int   |   10  |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |     NAME     |  varchar |   64  |  0  |   N  |  N  |     |   name   | 
 |  3  |  TASK\_LIST  |   text   | 65535 |  0  |   N  |  N  |     | Task information List| 
 |  4  |    ONLINE    |    bit   |   1   |  0  |   N  |  N  |     |  Online or not| 
 |  5  | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  |     |  creationTime| 
 |  6  | UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  |     |  updateTime| 

**Table name:** T\_CONTROL\_POINT\_METADATA 

**Description:** 

**Data column:** 

 |  No. |       name       |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
 | :-: | :------------: | :------: | :---: | :-: | :--: | :-: | :-: | :---: | 
 |  1  |  METADATA\_ID  |  varchar |  128  |  0  |   N  |  Y  |     | Data ID| 
 |  2  | METADATA\_TYPE |  varchar |   32  |  0  |   N  |  N  |     | Meta Type Of Data| 
 |  3  | METADATA\_NAME |   text   | 65535 |  0  |   N  |  N  |     | metaData name| 
 |  4  |    TASK\_ID    |  varchar |   64  |  0  |   N  |  N  |     |  Task ID| 
 |  5  |     ONLINE     |    bit   |   1   |  0  |   N  |  N  |     |  Online or not| 
 |  6  |  CREATE\_TIME  | datetime |   19  |  0  |   N  |  N  |     |  creationTime| 
 |  7  |  UPDATE\_TIME  | datetime |   19  |  0  |   N  |  N  |     |  updateTime| 

**Table name:** T\_CONTROL\_POINT\_TASK

**Description:** 

**Data column:** 

 |  No. |       name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |       ID       |  varchar |  64 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  | CONTROL\_STAGE |  varchar |  32 |  0  |   N  |  N  |     | atomic control Stage| 
 |  3  |  CREATE\_TIME  | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
 |  4  |  UPDATE\_TIME  | datetime |  19 |  0  |   N  |  N  |     |  updateTime| 

**Table name:** T\_COUNT\_INTERCEPT 

**Description:** 

**Data column:** 

 |  No. |           name           |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |               Description              | 
 | :-: | :--------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :---------------------------: | 
 |  1  |           ID           |  bigint  |  20 |  0  |   N  |  Y  |     |               primary key ID             | 
 |  2  |       PROJECT\_ID      |  varchar |  32 |  0  |   N  |  N  |     |              Project ID             | 
 |  3  |          DATE          |   date   |  10 |  0  |   N  |  N  |     |               date              | 
 |  4  |          COUNT         |    int   |  10 |  0  |   N  |  N  |     |               Total              | 
 |  5  |      CREATE\_TIME      | datetime |  19 |  0  |   N  |  N  |     |              creationTime             | 
 |  6  |      UPDATE\_TIME      | datetime |  19 |  0  |   N  |  N  |     |              updateTime             | 
 |  7  |    INTERCEPT\_COUNT    |    int   |  10 |  0  |   N  |  N  |  0  |              interception number              | 
 |  8  | RULE\_INTERCEPT\_COUNT |    int   |  10 |  0  |   N  |  N  |  0  | RULE\_INTERCEPT\_COUNT+count) | 

**Table name:** T\_COUNT\_PIPELINE

**Description:** 

**Data column:** 

 |  No. |           name          |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |           ID          |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |      PROJECT\_ID      |  varchar |  32 |  0  |   N  |  N  |     |  Project ID| 
 |  3  |      PIPELINE\_ID     |  varchar |  34 |  0  |   N  |  N  |     |  pipelineId| 
 |  4  |          DATE         |   date   |  10 |  0  |   N  |  N  |     |   date   | 
 |  5  |         COUNT         |    int   |  10 |  0  |   N  |  N  |     |   Total   | 
 |  6  | LAST\_INTERCEPT\_TIME | datetime |  19 |  0  |   N  |  N  |     | Last intercept time| 
 |  7  |      CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
 |  8  |      UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  |     |  updateTime| 
 |  9  |    INTERCEPT\_COUNT   |    int   |  10 |  0  |   N  |  N  |  0  |   interception number| 

**Table name:** T\_COUNT\_RULE 

**Description:** 

**Data column:** 

 |  No. |           name          |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |           ID          |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |      PROJECT\_ID      |  varchar |  32 |  0  |   N  |  N  |     |  Project ID| 
 |  3  |        RULE\_ID       |  bigint  |  20 |  0  |   N  |  N  |     |  Rule ID| 
 |  4  |          DATE         |   date   |  10 |  0  |   N  |  N  |     |   date   | 
 |  5  |         COUNT         |    int   |  10 |  0  |   N  |  N  |     |   Total   | 
 |  6  |    INTERCEPT\_COUNT   |    int   |  10 |  0  |   N  |  N  |  0  |   interception number| 
 |  7  | LAST\_INTERCEPT\_TIME | datetime |  19 |  0  |   N  |  N  |     | Last intercept time| 
 |  8  |      CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  |     |  creationTime| 
 |  9  |      UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  |     |  updateTime| 

**Table name:** T\_GROUP 

**Description:** 

**Data column:** 

 |  No. |          name         |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :-----------------: | :------: | :---: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |          ID         |  bigint  |   20  |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |     PROJECT\_ID     |  varchar |   64  |  0  |   N  |  N  |     |  Project ID| 
 |  3  |         NAME        |  varchar |   64  |  0  |   N  |  N  |     |   name   | 
 |  4  |     INNER\_USERS    |   text   | 65535 |  0  |   N  |  N  |     |  internal personnel| 
 |  5  | INNER\_USERS\_COUNT |    int   |   10  |  0  |   N  |  N  |     | Internal personnel Total| 
 |  6  |     OUTER\_USERS    |   text   | 65535 |  0  |   N  |  N  |     |  External personnel| 
 |  7  | OUTER\_USERS\_COUNT |    int   |   10  |  0  |   N  |  N  |     | External Personnel Total| 
 |  8  |        REMARK       |   text   | 65535 |  0  |   Y  |  N  |     |   Commentary   | 
 |  9  |       CREATOR       |  varchar |   64  |  0  |   N  |  N  |     |   projectCreator| 
 |  10 |       UPDATOR       |  varchar |   64  |  0  |   N  |  N  |     |   Updater| 
 |  11 |     CREATE\_TIME    | datetime |   19  |  0  |   N  |  N  |     |  creationTime| 
 |  12 |     UPDATE\_TIME    | datetime |   19  |  0  |   N  |  N  |     |  updateTime| 

**Table name:** T\_HISTORY

**Description:** 

**Data column:** 

 |  No. |        name       |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  | 
 | :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :---: | 
 |  1  |        ID       |  bigint  |   20  |  0  |   N  |  Y  |                    |   primary key ID | 
 |  2  |   PROJECT\_ID   |  varchar |   32  |  0  |   N  |  N  |                    |  Project ID| 
 |  3  |     RULE\_ID    |  bigint  |   20  |  0  |   N  |  N  |                    |  Rule ID| 
 |  4  |   PIPELINE\_ID  |  varchar |   34  |  0  |   N  |  N  |                    | pipelineId| 
 |  5  |    BUILD\_ID    |  varchar |   34  |  0  |   N  |  N  |                    |  build ID| 
 |  6  |      RESULT     |  varchar |   34  |  0  |   N  |  N  |                    |       | 
 |  7  | INTERCEPT\_LIST |   text   | 65535 |  0  |   N  |  N  |                    |  block list| 
 |  8  |   CREATE\_TIME  | datetime |   19  |  0  |   N  |  N  |                    |  creationTime| 
 |  9  |   UPDATE\_TIME  | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 
 |  10 |   PROJECT\_NUM  |  bigint  |   20  |  0  |   N  |  N  |          0         |  Quantity of project| 
 |  11 |   CHECK\_TIMES  |    int   |   10  |  0  |   Y  |  N  |          1         | Number of inspection| 

**Table name:** T\_QUALITY\_CONTROL\_POINT 

**Description:** Gate Control Point Table 

**Data column:** 

 |  No. |          name         |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |  defaultValue  |             Description             | 
 | :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :---: | :------------------------: | 
 |  1  |          ID         |  bigint  |  20 |  0  |   N  |  Y  |       |             primary key ID            | 
 |  2  |    ELEMENT\_TYPE    |  varchar |  64 |  0  |   Y  |  N  |       |        Atomic ClassType        | 
 |  3  |         NAME        |  varchar |  64 |  0  |   Y  |  N  |       |         control point name(atom name)        | 
 |  4  |        STAGE        |  varchar |  64 |  0  |   Y  |  N  |       |            R & D Stage            | 
 |  5  | AVAILABLE\_POSITION |  varchar |  64 |  0  |   Y  |  N  |       | Support redline location (allowEnter, allowLeave)| 
 |  6  |  DEFAULT\_POSITION  |  varchar |  64 |  0  |   Y  |  N  |       |           Default Red Line Location           | 
 |  7  |        ENABLE       |    bit   |  1  |  0  |   Y  |  N  |       |            Enable            | 
 |  8  |     CREATE\_USER    |  varchar |  64 |  0  |   Y  |  N  |       |            create user            | 
 |  9  |     UPDATE\_USER    |  varchar |  64 |  0  |   Y  |  N  |       |            Update user            | 
 |  10 |     CREATE\_TIME    | datetime |  19 |  0  |   Y  |  N  |       |            creationTime            | 
 |  11 |     UPDATE\_TIME    | datetime |  19 |  0  |   Y  |  N  |       |            updateTime            | 
 |  12 |    ATOM\_VERSION    |  varchar |  16 |  0  |   Y  |  N  | 1.0.0 |            Plugin version            | 
 |  13 |    TEST\_PROJECT    |  varchar |  64 |  0  |   N  |  N  |       |            project Test           | 
 |  14 |         TAG         |  varchar |  64 |  0  |   Y  |  N  |       |                            | 

**Table name:** T\_QUALITY\_HIS\_DETAIL\_METADATA 

**Description:** Detailed Base data table of execute result 

**Data column:** 

 |  No. |        name       |   Type Of Data  |   length  | decimal place | Allow Null |   primary key  | defaultValue |      Description      | 
 | :-: | :-------------: | :-----: | :---: | :-: | :--: | :-: | :-: | :----------: | 
 |  1  |        ID       |  bigint |   20  |  0  |   N  |  Y  |     |      primary key ID     | 
 |  2  |     DATA\_ID    | varchar |  128  |  0  |   Y  |  N  |     |     Data ID     | 
 |  3  |    DATA\_NAME   | varchar |  128  |  0  |   Y  |  N  |     |     data name     | 
 |  4  |    DATA\_TYPE   | varchar |   32  |  0  |   Y  |  N  |     |     Type Of Data     | 
 |  5  |    DATA\_DESC   | varchar |  128  |  0  |   Y  |  N  |     |     Data Description     | 
 |  6  |   DATA\_VALUE   | varchar |  256  |  0  |   Y  |  N  |     |      data value     | 
 |  7  |  ELEMENT\_TYPE  | varchar |   64  |  0  |   Y  |  N  |     | Atomic ClassType| 
 |  8  | ELEMENT\_DETAIL | varchar |   64  |  0  |   Y  |  N  |     |    Tools/Atom Subclasses   | 
 |  9  |   PROJECT\_ID   | varchar |   64  |  0  |   Y  |  N  |     |     Project ID     | 
 |  10 |   PIPELINE\_ID  | varchar |   64  |  0  |   Y  |  N  |     |     pipelineId    | 
 |  11 |    BUILD\_ID    | varchar |   64  |  0  |   Y  |  N  |     |     build ID     | 
 |  12 |    BUILD\_NO    | varchar |   64  |  0  |   Y  |  N  |     |      buildNo     | 
 |  13 |   CREATE\_TIME  |  bigint |   20  |  0  |   Y  |  N  |     |     creationTime     | 
 |  14 |      EXTRA      |   text  | 65535 |  0  |   Y  |  N  |     |     Additional Information     | 

**Table name:** T\_QUALITY\_HIS\_ORIGIN\_METADATA

**Description:** Base data table of execute result 

**Data column:** 

 |  No. |      name      |   Type Of Data  |   length  | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
 | :-: | :----------: | :-----: | :---: | :-: | :--: | :-: | :-: | :---: | 
 |  1  |      ID      |  bigint |   20  |  0  |   N  |  Y  |     |   primary key ID | 
 |  2  |  PROJECT\_ID | varchar |   64  |  0  |   Y  |  N  |     |  Project ID| 
 |  3  | PIPELINE\_ID | varchar |   64  |  0  |   Y  |  N  |     | pipelineId| 
 |  4  |   BUILD\_ID  | varchar |   64  |  0  |   Y  |  N  |     |  build ID| 
 |  5  |   BUILD\_NO  | varchar |   64  |  0  |   Y  |  N  |     |  buildNo| 
 |  6  | RESULT\_DATA |   text  | 65535 |  0  |   Y  |  N  |     |  Return data| 
 |  7  | CREATE\_TIME |  bigint |   20  |  0  |   Y  |  N  |     |  creationTime| 

**Table name:** T\_QUALITY\_INDICATOR 

**Description:** Gate Indicator Table 

**Data column:** 

 |  No. |           name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |   defaultValue  |       Description      | 
 | :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----: | :-----------: | 
 |  1  |           ID          |  bigint  |   20  |  0  |   N  |  Y  |        |       primary key ID     | 
 |  2  |     ELEMENT\_TYPE     |  varchar |   32  |  0  |   Y  |  N  |        |  Atomic ClassType| 
 |  3  |     ELEMENT\_NAME     |  varchar |   64  |  0  |   Y  |  N  |        |      produced atom     | 
 |  4  |    ELEMENT\_DETAIL    |  varchar |   64  |  0  |   Y  |  N  |        |    Tools/Atom Subclasses    | 
 |  5  |        EN\_NAME       |  varchar |   64  |  0  |   Y  |  N  |        |     English name of indicator     | 
 |  6  |        CN\_NAME       |  varchar |   64  |  0  |   Y  |  N  |        |     alias of indicator     | 
 |  7  |     METADATA\_IDS     |   text   | 65535 |  0  |   Y  |  N  |        |   Base data included in indicator   | 
 |  8  |   DEFAULT\_OPERATION  |  varchar |   32  |  0  |   Y  |  N  |        |      Default Operation     | 
 |  9  |  OPERATION\_AVAILABLE |   text   | 65535 |  0  |   Y  |  N  |        |      Available Operation     | 
 |  10 |       THRESHOLD       |  varchar |   64  |  0  |   Y  |  N  |        |      Default Threshold     | 
 |  11 |    THRESHOLD\_TYPE    |  varchar |   32  |  0  |   Y  |  N  |        |      Threshold type     | 
 |  12 |          DESC         |  varchar |  256  |  0  |   Y  |  N  |        |       description      | 
 |  13 | INDICATOR\_READ\_ONLY |    bit   |   1   |  0  |   Y  |  N  |        |      Read Only     | 
 |  14 |         STAGE         |  varchar |   32  |  0  |   Y  |  N  |        |       Stage      | 
 |  15 |    INDICATOR\_RANGE   |   text   | 65535 |  0  |   Y  |  N  |        |      Scope of indicators     | 
 |  16 |         ENABLE        |    bit   |   1   |  0  |   Y  |  N  |        |      Enable     | 
 |  17 |          TYPE         |  varchar |   32  |  0  |   Y  |  N  | SYSTEM |      Indicator type     | 
 |  18 |          TAG          |  varchar |   32  |  0  |   Y  |  N  |        | Indicator label for front-end differentiation control| 
 |  19 |      CREATE\_USER     |  varchar |   64  |  0  |   Y  |  N  |        |      create user     | 
 |  20 |      UPDATE\_USER     |  varchar |   64  |  0  |   Y  |  N  |        |      Update user     | 
 |  21 |      CREATE\_TIME     | datetime |   19  |  0  |   Y  |  N  |        |      creationTime     | 
 |  22 |      UPDATE\_TIME     | datetime |   19  |  0  |   Y  |  N  |        |      updateTime     | 
 |  23 |     ATOM\_VERSION     |  varchar |   16  |  0  |   N  |  N  |  1.0.0 |     Plugin versionNum     | 
 |  24 |      LOG\_PROMPT      |  varchar |  1024 |  0  |   N  |  N  |        |      log Prompt     | 

**Table name:** T\_QUALITY\_METADATA 

**Description:** Base data Sheet of Gate 

**Data column:** 

 |  No. |        name       |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |      Description      | 
 | :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :-: | :----------: | 
 |  1  |        ID       |  bigint  |   20  |  0  |   N  |  Y  |     |      primary key ID     | 
 |  2  |     DATA\_ID    |  varchar |   64  |  0  |   Y  |  N  |     |     Data ID     | 
 |  3  |    DATA\_NAME   |  varchar |   64  |  0  |   Y  |  N  |     |     data name     | 
 |  4  |  ELEMENT\_TYPE  |  varchar |   64  |  0  |   Y  |  N  |     | Atomic ClassType| 
 |  5  |  ELEMENT\_NAME  |  varchar |   64  |  0  |   Y  |  N  |     |     produced atom     | 
 |  6  | ELEMENT\_DETAIL |  varchar |   64  |  0  |   Y  |  N  |     |    Tools/Atom Subclasses   | 
 |  7  |   VALUE\_TYPE   |  varchar |   32  |  0  |   Y  |  N  |     | value value front-end Components type| 
 |  8  |       DESC      |  varchar |  256  |  0  |   Y  |  N  |     |      description      | 
 |  9  |      EXTRA      |   text   | 65535 |  0  |   Y  |  N  |     |     Additional Information     | 
 |  10 |   CREATE\_USER  |  varchar |   64  |  0  |   Y  |  N  |     |      projectCreator     | 
 |  11 |   UPDATE\_USER  |  varchar |   64  |  0  |   Y  |  N  |     |      Revise by     | 
 |  12 |   create\_time  | datetime |   19  |  0  |   Y  |  N  |     |     creationTime     | 
 |  13 |   UPDATE\_TIME  | datetime |   19  |  0  |   Y  |  N  |     |     updateTime     | 

**Table name:** T\_QUALITY\_RULE

**Description:** 

**Data column:** 

 |  No. |             name            |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |  defaultValue |     Description    | 
 | :-: | :-----------------------: | :------: | :---: | :-: | :--: | :-: | :--: | :-------: | 
 |  1  |             ID            |  bigint  |   20  |  0  |   N  |  Y  |      |     primary key ID   | 
 |  2  |            NAME           |  varchar |  128  |  0  |   Y  |  N  |      |    Rule name   | 
 |  3  |            DESC           |  varchar |  256  |  0  |   Y  |  N  |      |    rule description   | 
 |  4  |      INDICATOR\_RANGE     |   text   | 65535 |  0  |   Y  |  N  |      |    Scope of indicators   | 
 |  5  |       CONTROL\_POINT      |  varchar |   64  |  0  |   Y  |  N  |      |  Control Point Atom type| 
 |  6  |  CONTROL\_POINT\_POSITION |  varchar |   64  |  0  |   Y  |  N  |      |  Control Point Red Line Location| 
 |  7  |        CREATE\_USER       |  varchar |   64  |  0  |   Y  |  N  |      |    create user   | 
 |  8  |        UPDATE\_USER       |  varchar |   64  |  0  |   Y  |  N  |      |    Update user   | 
 |  9  |        CREATE\_TIME       | datetime |   19  |  0  |   Y  |  N  |      |    creationTime   | 
 |  10 |        UPDATE\_TIME       | datetime |   19  |  0  |   Y  |  N  |      |    updateTime   | 
 |  11 |           ENABLE          |    bit   |   1   |  0  |   Y  |  N  | b'1' |    Enable   | 
 |  12 |        PROJECT\_ID        |  varchar |   64  |  0  |   Y  |  N  |      |    Project ID   | 
 |  13 |      INTERCEPT\_TIMES     |    int   |   10  |  0  |   Y  |  N  |   0  |    Intercepted   | 
 |  14 |       EXECUTE\_COUNT      |    int   |   10  |  0  |   Y  |  N  |   0  |Take Effect Pipeline runs number| 
 |  15 | PIPELINE\_TEMPLATE\_RANGE |   text   | 65535 |  0  |   Y  |  N  |      | Effective Range of Pipeline Template| 
 |  16 |        GATEWAY\_ID        |  varchar |  128  |  0  |   N  |  N  |      |  Red line match id| 

**Table name:** T\_QUALITY\_RULE\_BUILD\_HIS 

**Description:** 

**Data column:** 

 |  No. |           name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |      Description      | 
 | :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :-: | :----------: | 
 |  1  |           ID          |  bigint  |   20  |  0  |   N  |  Y  |     |      primary key ID     | 
 |  2  |      PROJECT\_ID      |  varchar |   64  |  0  |   Y  |  N  |     |     Project ID     | 
 |  3  |      PIPELINE\_ID     |  varchar |   40  |  0  |   Y  |  N  |     |     pipelineId    | 
 |  4  |       BUILD\_ID       |  varchar |   40  |  0  |   Y  |  N  |     |     build ID     | 
 |  5  |       RULE\_POS       |  varchar |   8   |  0  |   Y  |  N  |     |     control point position    | 
 |  6  |       RULE\_NAME      |  varchar |  123  |  0  |   Y  |  N  |     |     Rule name     | 
 |  7  |       RULE\_DESC      |  varchar |  256  |  0  |   Y  |  N  |     |     rule description     | 
 |  8  |      GATEWAY\_ID      |  varchar |  128  |  0  |   Y  |  N  |     |    Red line match id   | 
 |  9  |    PIPELINE\_RANGE    |   text   | 65535 |  0  |   Y  |  N  |     |  Take Effect pipelineId Collection| 
 |  10 |    TEMPLATE\_RANGE    |   text   | 65535 |  0  |   Y  |  N  |     | Take Effect Pipeline template id Collection| 
 |  11 |     INDICATOR\_IDS    |   text   | 65535 |  0  |   Y  |  N  |     |     Indicator type     | 
 |  12 | INDICATOR\_OPERATIONS |   text   | 65535 |  0  |   Y  |  N  |     |     index Operation     | 
 |  13 | INDICATOR\_THRESHOLDS |   text   | 65535 |  0  |   Y  |  N  |     |     index Threshold     | 
 |  14 |    OPERATION\_LIST    |   text   | 65535 |  0  |   Y  |  N  |     |     Operation list     | 
 |  15 |      CREATE\_TIME     | datetime |   19  |  0  |   Y  |  N  |     |     creationTime     | 
 |  16 |      CREATE\_USER     |  varchar |   32  |  0  |   Y  |  N  |     |      creator     | 
 |  17 |       STAGE\_ID       |  varchar |   40  |  0  |   N  |  N  |  1  |   stage\_id  | 
 |  18 |         STATUS        |  varchar |   20  |  0  |   Y  |  N  |     |     Redline status     | 
 |  19 |     GATE\_KEEPERS     |  varchar |  1024 |  0  |   Y  |  N  |     |     Red line gatekeeper    | 

**Table name:** T\_QUALITY\_RULE\_BUILD\_HIS\_OPERATION

**Description:** 

**Data column:** 

 |  No. |        name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :-------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |        ID       |  bigint  |  20 |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |     RULE\_ID    |  bigint  |  20 |  0  |   N  |  N  |     | Rule ID| 
 |  3  |    STAGE\_ID    |  varchar |  40 |  0  |   N  |  N  |     |      | 
 |  4  | GATE\_OPT\_USER |  varchar |  32 |  0  |   Y  |  N  |     |      | 
 |  5  | GATE\_OPT\_TIME | datetime |  19 |  0  |   Y  |  N  |     |      | 

**Table name:** T\_QUALITY\_RULE\_MAP 

**Description:** 

**Data column:** 

 |  No. |           name          |  Type Of Data  |   length  | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :-------------------: | :----: | :---: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |           ID          | bigint |   20  |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |        RULE\_ID       | bigint |   20  |  0  |   Y  |  N  |     | Rule ID| 
 |  3  |     INDICATOR\_IDS    |  text  | 65535 |  0  |   Y  |  N  |     | Indicator type| 
 |  4  | INDICATOR\_OPERATIONS |  text  | 65535 |  0  |   Y  |  N  |     | index Operation| 
 |  5  | INDICATOR\_THRESHOLDS |  text  | 65535 |  0  |   Y  |  N  |     | index Threshold| 

**Table name:** T\_QUALITY\_RULE\_OPERATION 

**Description:** 

**Data column:** 

 |  No. |         name        |   Type Of Data  |   length  | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :---------------: | :-----: | :---: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |         ID        |  bigint |   20  |  0  |   N  |  Y  |     |   primary key ID  | 
 |  2  |      RULE\_ID     |  bigint |   20  |  0  |   Y  |  N  |     |  Rule ID| 
 |  3  |        TYPE       | varchar |   16  |  0  |   Y  |  N  |     |   type   | 
 |  4  |    NOTIFY\_USER   |   text  | 65535 |  0  |   Y  |  N  |     |  Notify personnel| 
 |  5  | NOTIFY\_GROUP\_ID |   text  | 65535 |  0  |   Y  |  N  |     |  userGroup ID| 
 |  6  |   NOTIFY\_TYPES   | varchar |   64  |  0  |   Y  |  N  |     |  type of notification| 
 |  7  |    AUDIT\_USER    |   text  | 65535 |  0  |   Y  |  N  |     |  toCheck| 
 |  8  |   AUDIT\_TIMEOUT  |   int   |   10  |  0  |   Y  |  N  |     | toCheck Timeout| 

**Table name:** T\_QUALITY\_RULE\_TEMPLATE 

**Description:** Gate Template Table 

**Data column:** 

 |  No. |            name            |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |  defaultValue |    Description   | 
 | :-: | :----------------------: | :------: | :-: | :-: | :--: | :-: | :--: | :-----: | 
 |  1  |            ID            |  bigint  |  20 |  0  |   N  |  Y  |      |    primary key ID  | 
 |  2  |           NAME           |  varchar |  64 |  0  |   Y  |  N  |      |    name   | 
 |  3  |           TYPE           |  varchar |  16 |  0  |   Y  |  N  |      |    type   | 
 |  4  |           DESC           |  varchar | 256 |  0  |   Y  |  N  |      |    description   | 
 |  5  |           STAGE          |  varchar |  64 |  0  |   Y  |  N  |      |    Stage   | 
 |  6  |      CONTROL\_POINT      |  varchar |  64 |  0  |   Y  |  N  |      | Control Point Atom type| 
 |  7  | CONTROL\_POINT\_POSITION |  varchar |  64 |  0  |   Y  |  N  |      | Control Point Red Line Location| 
 |  8  |       CREATE\_USER       |  varchar |  64 |  0  |   Y  |  N  |      |   projectCreator   | 
 |  9  |       UPDATE\_USER       |  varchar |  64 |  0  |   Y  |  N  |      |   Revise by   | 
 |  10 |       create\_time       | datetime |  19 |  0  |   Y  |  N  |      |   creationTime| 
 |  11 |       UPDATE\_TIME       | datetime |  19 |  0  |   Y  |  N  |      |   updateTime| 
 |  12 |          ENABLE          |    bit   |  1  |  0  |   Y  |  N  | b'1' |   Enable| 
 
**Table name:** T\_QUALITY\_TEMPLATE\_INDICATOR\_MAP

**Description:** Template-Indicator Relationship Table 

**Data column:** 

 |  No. |       name      |   Type Of Data  |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :-----------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |       ID      |  bigint |  20 |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |  TEMPLATE\_ID |  bigint |  20 |  0  |   Y  |  N  |     | Template ID| 
 |  3  | INDICATOR\_ID |  bigint |  20 |  0  |   Y  |  N  |     | Indicator ID| 
 |  4  |   OPERATION   | varchar |  32 |  0  |   Y  |  N  |     | optional Operation| 
 |  5  |   THRESHOLD   | varchar |  64 |  0  |   Y  |  N  |     | Default Threshold| 

**Table name:** T\_RULE 

**Description:** 

**Data column:** 

 |  No. |                 name                 |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |               Description              | 
 | :-: | :--------------------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :---------------------------: | 
 |  1  |                 ID                 |  bigint  |   20  |  0  |   N  |  Y  |                    |               primary key ID             | 
 |  2  |             PROJECT\_ID            |  varchar |   32  |  0  |   N  |  N  |                    |              Project ID             | 
 |  3  |                NAME                |  varchar |  128  |  0  |   N  |  N  |                    |               name              | 
 |  4  |               REMARK               |   text   | 65535 |  0  |   Y  |  N  |                    |               Commentary              | 
 |  5  |                TYPE                |  varchar |   32  |  0  |   N  |  N  |                    |               type              | 
 |  6  |           CONTROL\_POINT           |  varchar |   32  |  0  |   N  |  N  |                    |            Control Point Atom type            | 
 |  7  |              TASK\_ID              |  varchar |   64  |  0  |   N  |  N  |                    |              Task ID             | 
 |  8  |              THRESHOLD             |   text   | 65535 |  0  |   N  |  N  |                    |              Default Threshold             | 
 |  9  |          INDICATOR\_RANGE          |   text   | 65535 |  0  |   Y  |  N  |                    |              Scope of indicators             | 
 |  10 |        RANGE\_IDENTIFICATION       |   text   | 65535 |  0  |   N  |  N  |                    | ANY-Project ID Collection,PART\_BY\_NAME-Empty collection| 
 |  11 |              OPERATION             |  varchar |   32  |  0  |   N  |  N  |                    |              optional Operation             | 
 |  12 |    OPERATION\_END\_NOTIFY\_TYPE    |  varchar |  128  |  0  |   Y  |  N  |                    |            Operation End Notification type           | 
 |  13 |    OPERATION\_END\_NOTIFY\_GROUP   |   text   | 65535 |  0  |   Y  |  N  |                    |           Notify userGroup of Operation completion           | 
 |  14 |    OPERATION\_END\_NOTIFY\_USER    |   text   | 65535 |  0  |   Y  |  N  |                    |            Notify user of end of Operation           | 
 |  15 |   OPERATION\_AUDIT\_NOTIFY\_USER   |   text   | 65535 |  0  |   Y  |  N  |                    |            Operation stageReviewInputNotice user           | 
 |  16 |          INTERCEPT\_TIMES          |    int   |   10  |  0  |   N  |  N  |          0         |              Intercepted             | 
 |  17 |               ENABLE               |    bit   |   1   |  0  |   N  |  N  |                    |              Enable             | 
 |  18 |               CREATOR              |  varchar |   32  |  0  |   N  |  N  |                    |              projectCreator              | 
 |  19 |               UPDATOR              |  varchar |   32  |  0  |   N  |  N  |                    |              Updater              | 
 |  20 |            CREATE\_TIME            | datetime |   19  |  0  |   N  |  N  |                    |              creationTime             | 
 |  21 |            UPDATE\_TIME            | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |              updateTime             | 
 |  22 |             IS\_DELETED            |    bit   |   1   |  0  |   N  |  N  |                    |           Delete 0 can be deleted by 1          | 
 |  23 | OPERATION\_AUDIT\_TIMEOUT\_MINUTES |    int   |   10  |  0  |   Y  |  N  |                    |             toCheck Timeout            | 

**Table name:** T\_TASK 

**Description:** 

**Data column:** 

 |  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |  Description  | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: | 
 |  1  |      ID      |  varchar |  64 |  0  |   N  |  Y  |     |  primary key ID | 
 |  2  |     NAME     |  varchar | 255 |  0  |   N  |  N  |     |  name  | 
 |  3  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | creationTime| 
 |  4  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | updateTime| 
