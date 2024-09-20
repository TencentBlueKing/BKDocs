# devops\_ci\_measure

**The database name:** devops\_ci\_measure

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_measure

|                        Table name                       |  Description |
| :---------------------------------------------: | :-: |
|  [T\_MEASURE\_BUILD\_ELEMENT](broken-reference) |     |
| [T\_MEASURE\_DASHBOARD\_VIEW](broken-reference) |     |
| [T\_MEASURE\_PIPELINE\_BUILD](broken-reference) |     |
|     [T\_MEASURE\_PROJECT](broken-reference)     |     |
|   [T\_MEASURE\_WETEST\_INFO](broken-reference)  |     |

**Table name:** T\_MEASURE\_BUILD\_ELEMENT

**Description:** 

**Data column:** 

|  No. |      name     |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |      Description     |
| :-: | :---------: | :------: | :---: | :-: | :--: | :-: | :-: | :---------: |
|  1  | elementName |  varchar |   64  |  0  |   N  |  N  |     |     Element name    | 
|  2  |  pipelineId |  varchar |   34  |  0  |   N  |  N  |     |    pipelineId    | 
|  3  |   buildId   |  varchar |   34  |  0  |   N  |  N  |     |     build ID    | 
|  4  |    status   |  varchar |   32  |  0  |   N  |  N  |     |      status     | 
|  5  |  beginTime  | datetime |   19  |  0  |   N  |  N  |     |     Starting Time    | 
|  6  |   endTime   | datetime |   19  |  0  |   N  |  N  |     |     End Time    | 
|  7  |  projectId  |  varchar |   32  |  0  |   N  |  N  |     |     Project ID    | 
|  8  |    extra    |   text   | 65535 |  0  |   Y  |  N  |     |     Additional Information    | 
|  9  |     type    |  varchar |   32  |  0  |   N  |  N  |     |      type     | 
|  10 |  elementId  |  varchar |   64  |  0  |   N  |  N  |     | Plugin elementId| 
|  11 |      id     |    int   |   10  |  0  |   N  |  Y  |     |      primary key ID    | 
|  12 |   atomCode  |  varchar |  128  |  0  |   N  |  N  |     |   Unique identification of the Plugin   | 

**Table name:** T\_MEASURE\_DASHBOARD\_VIEW

**Description:** 

**Data column:** 

|  No. |     name     |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  |   defaultValue  |  Description  |
| :-: | :--------: | :--------: | :------: | :-: | :--: | :-: | :----: | :--: |
|  1  |     id     |     int    |    10    |  0  |   N  |  Y  |        |  primary key ID | 
|  2  |  projectId |   varchar  |    36    |  0  |   N  |  N  |        | Project ID| 
|  3  |    user    |   varchar  |    32    |  0  |   N  |  N  |        |  user| 
|  4  |    NAME    |   varchar  |    64    |  0  |   N  |  N  |        |  name  | 
|  5  | viewConfig | mediumtext | 16777215 |  0  |   N  |  N  |        | view setting| 
|  6  |  viewType  |   varchar  |    32    |  0  |   N  |  N  | SINGLE |view type| 

**Table name:** T\_MEASURE\_PIPELINE\_BUILD

**Description:** 

**Data column:** 

|  No. |        name        |    Type Of Data    |    length    | decimal place | Allow Null |   primary key  | defaultValue |      Description      |
| :-: | :--------------: | :--------: | :------: | :-: | :--: | :-: | :-: | :----------: |
|  1  |    pipelineId    |   varchar  |    34    |  0  |   N  |  N  |     |     pipelineId    | 
|  2  |      buildId     |   varchar  |    34    |  0  |   N  |  N  |     |     build ID     | 
|  3  |     beginTime    |  datetime  |    19    |  0  |   N  |  N  |     |   Pipeline Start Time   | 
|  4  |      endTime     |  datetime  |    19    |  0  |   N  |  N  |     |   End Time of Pipeline   | 
|  5  |     startType    |   varchar  |    20    |  0  |   N  |  N  |     |   Pipeline Start Up mode   | 
|  6  |     buildUser    |   varchar  |    255   |  0  |   N  |  N  |     |   startUser of Pipeline   | 
|  7  |    isParallel    |     bit    |     1    |  0  |   N  |  N  |     |   Whether the Pipeline is parallel   | 
|  8  |    buildResult   |   varchar  |    20    |  0  |   N  |  N  |     |   Pipeline build result   | 
|  9  |     projectId    |   varchar  |    32    |  0  |   N  |  N  |     |     Project ID     | 
|  10 |     pipeline     | mediumtext | 16777215 |  0  |   N  |  N  |     |      Pipeline     | 
|  11 |     buildNum     |     int    |    10    |  0  |   N  |  N  |     |     build versionNum    | 
|  12 |        id        |     int    |    10    |  0  |   N  |  Y  |     |      primary key ID     | 
|  13 |     metaInfo     |    text    |   65535  |  0  |   Y  |  N  |     |      metaData     | 
|  14 | parentPipelineId |   varchar  |    34    |  0  |   Y  |  N  |     | pipelineId of the Start Up subPipeline| 
|  15 |   parentBuildId  |   varchar  |    34    |  0  |   Y  |  N  |     |  build ID of the Start Up subPipeline| 

**Table name:** T\_MEASURE\_PROJECT

**Description:** 

**Data column:** 

|  No. |        name        |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |     Description     |
| :-: | :--------------: | :------: | :---: | :-: | :--: | :-: | :-: | :--------: |
|  1  |        id        |    int   |   10  |  0  |   N  |  Y  |     |     primary key ID    | 
|  2  | approval\_status |    int   |   10  |  0  |   Y  |  N  |     |    toCheck status    | 
|  3  |      bg\_id      |    int   |   10  |  0  |   Y  |  N  |     |    Business Group ID   | 
|  4  |     bg\_name     |  varchar |  120  |  0  |   Y  |  N  |     |    Business Group name   | 
|  5  |    cc\_app\_id   |    int   |   10  |  0  |   Y  |  N  |     |    App ID    | 
|  6  |    center\_id    |    int   |   10  |  0  |   Y  |  N  |     |    Site ID    | 
|  7  |   center\_name   |  varchar |  120  |  0  |   Y  |  N  |     |    Center Name    | 
|  8  |    created\_at   | datetime |   19  |  0  |   Y  |  N  |     |    creationTime    | 
|  9  |      creator     |  varchar |   32  |  0  |   Y  |  N  |     |     projectCreator    | 
|  10 |     data\_id     |    int   |   10  |  0  |   Y  |  N  |     |    Data ID    | 
|  11 |   deploy\_type   |  varchar |  256  |  0  |   Y  |  N  |     |    Deploy type    | 
|  12 |     dept\_id     |    int   |   10  |  0  |   Y  |  N  |     | ID of secondary institution of the project| 
|  13 |    dept\_name    |  varchar |  120  |  0  |   Y  |  N  |     | Name of secondary institution of the project| 
|  14 |    description   |   text   | 65535 |  0  |   Y  |  N  |     |     description     | 
|  15 |   project\_code  |  varchar |  128  |  0  |   Y  |  N  |     |   userGroup Project| 
|  16 |   is\_offlined   |    bit   |   1   |  0  |   Y  |  N  |     |    Disable    | 
|  17 |    is\_secrecy   |    bit   |   1   |  0  |   Y  |  N  |     |    Confidentiality    | 
|  18 |       kind       |    int   |   10  |  0  |   Y  |  N  |     |    Container type    | 
|  19 |    project\_id   |  varchar |   64  |  0  |   Y  |  N  |     |    Project ID    | 
|  20 |   project\_name  |  varchar |  256  |  0  |   Y  |  N  |     |    project name    | 
|  21 |   project\_type  |    int   |   10  |  0  |   Y  |  N  |     |    Project type    | 
|  22 |    updated\_at   | datetime |   19  |  0  |   Y  |  N  |     |    updateTime    | 
|  23 |      use\_bk     |    bit   |   1   |  0  |   Y  |  N  |     |    Whether to use BlueKing   | 
|  24 |    logo\_addr    |  varchar |  1024 |  0  |   Y  |  N  |     |   Logo address   | 
|  25 |  pipeline\_count |    int   |   10  |  0  |   Y  |  N  |  0  |    Quantity of Pipeline   | 

**Table name:** T\_MEASURE\_WETEST\_INFO

**Description:** 

**Data column:** 

|  No. |         name        |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |    Description   |
| :-: | :---------------: | :------: | :---: | :-: | :--: | :-: | :-: | :-----: |
|  1  |         ID        |  bigint  |   20  |  0  |   N  |  Y  |     |    primary key ID  | 
|  2  |    elementKeyId   |    int   |   10  |  0  |   N  |  N  |     | Element Keyid| 
|  3  |       testid      |  varchar |   64  |  0  |   Y  |  N  |     |         | 
|  4  |      passrate     |    int   |   10  |  0  |   Y  |  N  |  0  |   approve rate   | 
|  5  |    failManuMap    |   text   | 65535 |  0  |   Y  |  N  |     |         | 
|  6  |   failVersionMap  |   text   | 65535 |  0  |   Y  |  N  |     | failed version map| 
|  7  | failResolutionMap |   text   | 65535 |  0  |   Y  |  N  |     | failed to parse map| 
|  8  |     errCodeMap    |   text   | 65535 |  0  |   Y  |  N  |     | Error Code map| 
|  9  |    errLevelMap    |   text   | 65535 |  0  |   Y  |  N  |     | Error grade map| 
|  10 |     createTime    | datetime |   19  |  0  |   Y  |  N  |     |   creationTime| 
