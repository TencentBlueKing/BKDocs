# devops\_ci\_repository

**The database name:** devops\_ci\_repository

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_repository

 |                        Table name                        |         Description        | 
 | :----------------------------------------------: | :---------------: | 
 |         [T\_REPOSITORY](broken-reference)        |        Code Repository table       | 
 |   [T\_REPOSITORY\_CODE\_GIT](broken-reference)   |      Worker Bee Code Repository Schedule     | 
 |  [T\_REPOSITORY\_CODE\_GITLAB](broken-reference) |    gitlab Code Repository details   | 
 |   [T\_REPOSITORY\_CODE\_SVN](broken-reference)   |     svn Code Repository schedule     | 
 |     [T\_REPOSITORY\_COMMIT](broken-reference)    |      Code Repository Change log      | 
 |     [T\_REPOSITORY\_GITHUB](broken-reference)    |    Github Code Repository list   | 
 | [T\_REPOSITORY\_GITHUB\_TOKEN](broken-reference) |githuboauthtoken table| 
 |   [T\_REPOSITORY\_GIT\_CHECK](broken-reference)  |   Worker bee oauthtoken table   | 
 |   [T\_REPOSITORY\_GIT\_TOKEN](broken-reference)  |Worker bee commitchecker table| 

 **Table name:** T\_REPOSITORY 

 **Description:** Code Repository Table 

 **Data column:** 

 |  No. |       name       |    Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description     | 
 | :-: | :------------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :--------: | 
 |  1  | REPOSITORY\_ID |   bigint  |  20 |  0  |   N  |  Y  |                    |     primary key ID    | 
 |  2  |   PROJECT\_ID  |  varchar  |  32 |  0  |   N  |  N  |                    |    Project ID    | 
 |  3  |    USER\_ID    |  varchar  |  64 |  0  |   N  |  N  |                    |    user ID    | 
 |  4  |   ALIAS\_NAME  |  varchar  | 255 |  0  |   N  |  N  |                    |     aliasName     | 
 |  5  |       URL      |  varchar  | 255 |  0  |   N  |  N  |                    |    URL address   | 
 |  6  |      TYPE      |  varchar  |  20 |  0  |   N  |  N  |                    |     type     | 
 |  7  |  CREATED\_TIME | timestamp |  19 |  0  |   N  |  N  | 2019-08-0100:00:00 |    creationTime    | 
 |  8  |  UPDATED\_TIME | timestamp |  19 |  0  |   N  |  N  | 2019-08-0100:00:00 |    Change the time    | 
 |  9  |   IS\_DELETED  |    bit    |  1  |  0  |   N  |  N  |                    | Delete 0 can be deleted by 1| 

 **Table name:** T\_REPOSITORY\_CODE\_GIT 

 **Description:** Worker Bee Code Repository Details 

 **Data column:** 

 |  No. |       name       |    Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :------------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  | REPOSITORY\_ID |   bigint  |  20 |  0  |   N  |  Y  |                    | Warehouse ID| 
 |  2  |  PROJECT\_NAME |  varchar  | 255 |  0  |   N  |  N  |                    | project name| 
 |  3  |   USER\_NAME   |  varchar  |  64 |  0  |   N  |  N  |                    | user name| 
 |  4  |  CREATED\_TIME | timestamp |  19 |  0  |   N  |  N  | 2019-08-0100:00:00 |creationTime| 
 |  5  |  UPDATED\_TIME | timestamp |  19 |  0  |   N  |  N  | 2019-08-0100:00:00 |Change the time| 
 |  6  | CREDENTIAL\_ID |  varchar  |  64 |  0  |   N  |  N  |                    | ticket ID| 
 |  7  |   AUTH\_TYPE   |  varchar  |  8  |  0  |   Y  |  N  |                    | authentication mode| 

**Table name:** T\_REPOSITORY\_CODE\_GITLAB

 **Description:** gitlab Code Repository Details 

 **Data column:** 

 |  No. |       name       |    Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :------------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  | REPOSITORY\_ID |   bigint  |  20 |  0  |   N  |  Y  |                    | Warehouse ID| 
 |  2  |  PROJECT\_NAME |  varchar  | 255 |  0  |   N  |  N  |                    | project name| 
 |  3  | CREDENTIAL\_ID |  varchar  |  64 |  0  |   N  |  N  |                    | ticket ID| 
 |  4  |  CREATED\_TIME | timestamp |  19 |  0  |   N  |  N  | 2019-08-0100:00:00 |creationTime| 
 |  5  |  UPDATED\_TIME | timestamp |  19 |  0  |   N  |  N  | 2019-08-0100:00:00 |Change the time| 
 |  6  |   USER\_NAME   |  varchar  |  64 |  0  |   N  |  N  |                    | user name| 

 **Table name:** T\_REPOSITORY\_CODE\_SVN 

 **Description:** svn Code Repository details 

 **Data column:** 

 |  No. |       name       |    Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :------------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  | REPOSITORY\_ID |   bigint  |  20 |  0  |   N  |  Y  |                    | Warehouse ID| 
 |  2  |     REGION     |  varchar  | 255 |  0  |   N  |  N  |                    |  Region| 
 |  3  |  PROJECT\_NAME |  varchar  | 255 |  0  |   N  |  N  |                    | project name| 
 |  4  |   USER\_NAME   |  varchar  |  64 |  0  |   N  |  N  |                    | user name| 
 |  5  |  CREATED\_TIME | timestamp |  19 |  0  |   N  |  N  | 2019-08-0100:00:00 |creationTime| 
 |  6  |  UPDATED\_TIME | timestamp |  19 |  0  |   N  |  N  | 2019-08-0100:00:00 |Change the time| 
 |  7  | CREDENTIAL\_ID |  varchar  |  64 |  0  |   N  |  N  |                    | ticket ID| 
 |  8  |    SVN\_TYPE   |  varchar  |  32 |  0  |   Y  |  N  |                    | repoType| 

 **Table name:** T\_REPOSITORY\_COMMIT 

 **Description:** Code Repository Change log 

 **Data column:** 

 |  No. |      name      |   Type Of Data   |     length     | decimal place | Allow Null |   primary key  | defaultValue |          Description          | 
 | :-: | :----------: | :------: | :--------: | :-: | :--: | :-: | :-: | :------------------: | 
 |  1  |      ID      |  bigint  |     20     |  0  |   N  |  Y  |     |          primary key ID         | 
 |  2  |   BUILD\_ID  |  varchar |     34     |  0  |   Y  |  N  |     |         build ID         | 
 |  3  | PIPELINE\_ID |  varchar |     34     |  0  |   Y  |  N  |     |         pipelineId        | 
 |  4  |   REPO\_ID   |  bigint  |     20     |  0  |   Y  |  N  |     |         Code Repository ID        | 
 |  5  |     TYPE     | smallint |      6     |  0  |   Y  |  N  |     | 1-svn,2-git,3-gitlab | 
 |  6  |    COMMIT    |  varchar |     64     |  0  |   Y  |  N  |     |          submit          | 
 |  7  |   COMMITTER  |  varchar |     32     |  0  |   Y  |  N  |     |          submit         | 
 |  8  | COMMIT\_TIME | datetime |     19     |  0  |   Y  |  N  |     |         commitTime         | 
 |  9  |    COMMENT   | longtext | 2147483647 |  0  |   Y  |  N  |     |          Commentary          | 
 |  10 |  ELEMENT\_ID |  varchar |     34     |  0  |   Y  |  N  |     |         Atom ID         | 
 |  11 |  REPO\_NAME  |  varchar |     128    |  0  |   Y  |  N  |     |         Code Repository aliasName        | 

**Table name:** T\_REPOSITORY\_GITHUB

 **Description:** Github Code Repository list 

 **Data column:** 

 |  No. |       name       |    Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |  Description  | 
 | :-: | :------------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :--: | 
 |  1  | REPOSITORY\_ID |   bigint  |  20 |  0  |   N  |  Y  |                    | Warehouse ID| 
 |  2  | CREDENTIAL\_ID |  varchar  | 128 |  0  |   Y  |  N  |                    | ticket ID| 
 |  3  |  PROJECT\_NAME |  varchar  | 255 |  0  |   N  |  N  |                    | project name| 
 |  4  |   USER\_NAME   |  varchar  |  64 |  0  |   N  |  N  |                    | user name| 
 |  5  |  CREATED\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  6  |  UPDATED\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |Change the time| 

 **Table name:** T\_REPOSITORY\_GITHUB\_TOKEN 

 **Description:** githuboauthtoken table 

 **Data column:** 

 |  No. |       name      |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |    Description   | 
 | :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :-: | :-----: | 
 |  1  |       ID      |  bigint  |   20  |  0  |   N  |  Y  |     |    primary key ID  | 
 |  2  |    USER\_ID   |  varchar |   64  |  0  |   N  |  N  |     |   user ID| 
 |  3  | ACCESS\_TOKEN |  varchar |   96  |  0  |   N  |  N  |     | auth Token| 
 |  4  |  TOKEN\_TYPE  |  varchar |   64  |  0  |   N  |  N  |     | type of token| 
 |  5  |     SCOPE     |   text   | 65535 |  0  |   N  |  N  |     |   Effective Range| 
 |  6  |  CREATE\_TIME | datetime |   19  |  0  |   N  |  N  |     |   creationTime| 
 |  7  |  UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  |     |   updateTime| 

 **Table name:** T\_REPOSITORY\_GIT\_CHECK 

 **Description:** Worker bee oauthtoken table 

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
 |  10 |     SOURCE    |  varchar |  64 |  0  |   N  |  N  |     |  event source| 

**Table name:** T\_REPOSITORY\_GIT\_TOKEN

 **Description:** Worker commitchecker table 

 **Data column:** 

 |  No. |       name       |   Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |     Description     | 
 | :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------: | 
 |  1  |       ID       |  bigint  |  20 |  0  |   N  |  Y  |                    |     primary key ID    | 
 |  2  |    USER\_ID    |  varchar |  64 |  0  |   Y  |  N  |                    |    user ID    | 
 |  3  |  ACCESS\_TOKEN |  varchar |  96 |  0  |   Y  |  N  |                    |   auth Token| 
 |  4  | REFRESH\_TOKEN |  varchar |  96 |  0  |   Y  |  N  |                    |   reflash token| 
 |  5  |   TOKEN\_TYPE  |  varchar |  64 |  0  |   Y  |  N  |                    |   type of token| 
 |  6  |   EXPIRES\_IN  |  bigint  |  20 |  0  |   Y  |  N  |                    |    expireDate    | 
 |  7  |  CREATE\_TIME  | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |token creationTime| 