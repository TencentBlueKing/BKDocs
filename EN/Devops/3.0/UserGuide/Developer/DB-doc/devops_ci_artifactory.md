# devops\_ci\_artifactory 

**The database name:** devops\_ci\_artifact factory 

**The document version:** 1.0.0 

**The document description:** The database document of the devops\_ci\_artifact factory 

| Table name | Description | 
| :--------------------------------------: | :------: | 
| [T\_FILE\_INFO](broken-reference) | file information table| 
| [T\_FILE\_PROPS\_INFO](broken-reference) | File Information Table| 
| [T\_FILE\_TASK](broken-reference) | file hosting task table| 
| [T\_TOKEN](broken-reference) | | 

**Table name:** T\_FILE\_INFO 

**Description:** file information table 

**Data Column:**


|  No.|       name      |   Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |    Description   | 
| :-: | :-----------: | :------: | :--: | :-: | :--: | :-: | :----------------: | :-----: | 
|  1  |       ID      |  varchar |  32  |  0  |   N  |  Y  |                    |   Primary Key ID| 
|  2  | PROJECT\_CODE |  varchar |  64  |  0  |   Y  |  N  |                    | userGroup Project| 
|  3  |   FILE\_TYPE  |  varchar |  32  |  0  |   N  |  N  |                    |   file type| 
|  4  |   FILE\_PATH  |  varchar | 1024 |  0  |   Y  |  N  |                    |   file path| 
|  5  |   FILE\_NAME  |  varchar |  128 |  0  |   N  |  N  |                    |   file name| 
|  6  |   FILE\_SIZE  |  bigint  |  20  |  0  |   N  |  N  |                    |   filesize| 
|  7  |    CREATOR    |  varchar |  50  |  0  |   N  |  N  |       system       |   projectCreator   | 
|  8  |    MODIFIER   |  varchar |  50  |  0  |   N  |  N  |       system       |   Updated by   | 
|  9  |  CREATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime| 
|  10 |  UPDATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   updateTime| 

**Table name:** T\_FILE\_PROPS\_INFO 

**Description:** file Information table 

**data column:** 


|  No.|      name      |   Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |     Description    | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: | 
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    Primary Key ID   | 
|  2  |  PROPS\_KEY  |  varchar |  64 |  0  |   Y  |  N  |                    |  Attribute Field key| 
|  3  | PROPS\_VALUE |  varchar | 256 |  0  |   Y  |  N  |                    | attribute Field value| 
|  4  |   FILE\_ID   |  varchar |  32 |  0  |   N  |  N  |                    |    file ID   | 
|  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |    projectCreator    | 
|  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |    Updated by    | 
|  7  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    creationTime   | 
|  8  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    updateTime   | 

**Table name:** T\_FILE\_TASK 

**Description:** file hosting Task table 

**data column:** 

|  No.|      name      |   Type Of Data   |   length| decimal place| Allow Null| primary key| defaultValue|   Description   | 
| :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :-: | :----: | 
|  1  |   TASK\_ID   |  varchar |   64  |  0  |   N  |  Y  |     |  Task ID| 
|  2  |  FILE\_TYPE  |  varchar |   32  |  0  |   Y  |  N  |     |  file type| 
|  3  |  FILE\_PATH  |   text   | 65535 |  0  |   Y  |  N  |     |  file path| 
|  4  |  MACHINE\_IP |  varchar |   32  |  0  |   Y  |  N  |     | Machine IP| 
|  5  |  LOCAL\_PATH |   text   | 65535 |  0  |   Y  |  N  |     |  local path| 
|  6  |    STATUS    | smallint |   6   |  0  |   Y  |  N  |     |   status   | 
|  7  |   USER\_ID   |  varchar |   32  |  0  |   Y  |  N  |     |  user ID| 
|  8  |  PROJECT\_ID |  varchar |   64  |  0  |   Y  |  N  |     |  Project ID| 
|  9  | PIPELINE\_ID |  varchar |   34  |  0  |   Y  |  N  |     |  pipelineId| 
|  10 |   BUILD\_ID  |  varchar |   34  |  0  |   Y  |  N  |     |  build ID| 
|  11 | CREATE\_TIME | datetime |   19  |  0  |   Y  |  N  |     |  creationTime| 
|  12 | UPDATE\_TIME | datetime |   19  |  0  |   Y  |  N  |     |  Change the time| 

**Table name:** T\_TOKEN 

**Description:** 

**data column:** 

|  No.|         name        |   Type Of Data   |   length| decimal place| Allow Null| primary key|         defaultValue        |   Description   | 
| :-: | :---------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----: | 
|  1  |         ID        |  bigint  |   20  |  0  |   N  |  Y  |                    |  Primary Key ID| 
|  2  |      USER\_ID     |  varchar |   64  |  0  |   N  |  N  |                    |  user ID| 
|  3  |    PROJECT\_ID    |  varchar |   32  |  0  |   N  |  N  |                    |  Project ID| 
|  4  | ARTIFACTORY\_TYPE |  varchar |   32  |  0  |   N  |  N  |                    | Archive repoType| 
|  5  |        PATH       |   text   | 65535 |  0  |   N  |  N  |                    |   path   | 
|  6  |       TOKEN       |  varchar |   64  |  0  |   N  |  N  |                    |  TOKEN | 
|  7  |    EXPIRE\_TIME   | datetime |   19  |  0  |   N  |  N  |                    |  expireDate| 
|  8  |    CREATE\_TIME   | datetime |   19  |  0  |   N  |  N  |                    |  creationTime| 
|  9  |    UPDATE\_TIME   | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |updateTime| 
