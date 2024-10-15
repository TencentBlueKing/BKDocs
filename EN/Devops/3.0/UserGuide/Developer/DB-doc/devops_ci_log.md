# devops\_ci\_log

**The database name:** devops\_ci\_log

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_log

|                    Table name                   |      Description      |
| :-------------------------------------: | :----------: |
| [T\_LOG\_INDICES\_V2](broken-reference) | build log has link ES index table  |
|    [T\_LOG\_STATUS](broken-reference)   |   build log Print status Table   |
|   [T\_LOG\_SUBTAGS](broken-reference)   |   build log label Table     |

**Table name:** T\_LOG\_INDICES\_V2

**Description:**   build log has link ES index table 

**Data column:** 

|  No. |         name         |    Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |             Description            |
| :-: | :----------------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :-----------------------: |
|  1  |         ID         |   bigint  |  20 |  0  |   N  |  Y  |                    |             primary key ID           |
|  2  |      BUILD\_ID     |  varchar  |  64 |  0  |   N  |  N  |                    |            build ID            |
|  3  |     INDEX\_NAME    |  varchar  |  20 |  0  |   N  |  N  |                    |                           |
|  4  |   LAST\_LINE\_NUM  |   bigint  |  20 |  0  |   N  |  N  |          1         |            last Line number            |
|  5  |    CREATED\_TIME   | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |           creationTime            |
|  6  |    UPDATED\_TIME   | timestamp |  19 |  0  |   N  |  N  | 2019-11-1100:00:00 |             change the time            |
|  7  |       ENABLE       |    bit    |  1  |  0  |   N  |  N  |        b'0'        |    buildisenablev2ornot   |
|  8  | LOG\_CLUSTER\_NAME |  varchar  |  64 |  0  |   N  |  N  |                    |   multieslogclustername   |
|  9  |    USE\_CLUSTER    |    bit    |  1  |  0  |   N  |  N  |        b'0'        | usemultieslogclusterornot |

**Table name:** T\_LOG\_STATUS

**Description:**   build log Print status Table 

**Data column:** 

|  No. |       name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |          defaultValue          |          Description          |
| :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :------------------: |
|  1  |       ID       |  bigint  |  20 |  0  |   N  |  Y  |                       |          primary key ID         |
|  2  |    BUILD\_ID   |  varchar |  64 |  0  |   N  |  N  |                       |          build ID          |
|  3  |       TAG      |  varchar |  64 |  0  |   Y  |  N  |                       |           label           |
|  4  |    SUB\_TAG    |  varchar | 256 |  0  |   Y  |  N  |                       |           child label          |
|  5  |     JOB\_ID    |  varchar |  64 |  0  |   Y  |  N  |                       |         JOBID        |
|  6  |      MODE      |  varchar |  32 |  0  |   Y  |  N  |                       |    LogStorageMode    |
|  7  | EXECUTE\_COUNT |    int   |  10 |  0  |   N  |  N  |                       |          Number of execute          |
|  8  |    FINISHED    |    bit   |  1  |  0  |   N  |  N  |          b'0'         | buildisfinishedornot |
|  9  |  CREATE\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |         creationTime         |

**Table name:** T\_LOG\_SUBTAGS

**Description:**   build log label Table 

**Data column:** 

|  No. |      name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |          defaultValue          |   Description  |
| :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :-------------------: | :---: |
|  1  |      ID      |  bigint  |   20  |  0  |   N  |  Y  |                       |   primary key ID |
|  2  |   BUILD\_ID  |  varchar |   64  |  0  |   N  |  N  |                       |  build ID |
|  3  |      TAG     |  varchar |   64  |  0  |   N  |  N  |                       |   plugin label  |
|  4  |   SUB\_TAGS  |   text   | 65535 |  0  |   N  |  N  |                       | plugin child label |
|  5  | CREATE\_TIME | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   creationTime  |
