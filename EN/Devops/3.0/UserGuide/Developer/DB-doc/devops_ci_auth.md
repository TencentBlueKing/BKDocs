 # devops\_ci\_auth 

 **The database name:** devops\_ci\_Auth 

 **The document Version:** 1.0.0 

 **The document description:** The database document of the devops\_ci\_Auth 

 |                          Table name                         |         Description        | 
 | :-------------------------------------------------: | :---------------: | 
 |       [T\_AUTH\_GROUP\_INFO](broken-reference)      |       userGroup Information Table      | 
 |     [T\_AUTH\_GROUP\_PERSSION](broken-reference)    |                   | 
 |       [T\_AUTH\_GROUP\_USER](broken-reference)      |                   | 
 |      [T\_AUTH\_IAM\_CALLBACK](broken-reference)     |      IAM callback address      | 
 |         [T\_AUTH\_MANAGER](broken-reference)        |       Administrator Alert Rules Tabl      | 
 |      [T\_AUTH\_MANAGER\_USER](broken-reference)     | Administrator user table (only users within the EXP)| 
 | [T\_AUTH\_MANAGER\_USER\_HISTORY](broken-reference) |      Administrator user History Table     | 
 |   [T\_AUTH\_MANAGER\_WHITELIST](broken-reference)   |    Administrator Self-service apply Form List    | 
 |        [T\_AUTH\_STRATEGY](broken-reference)        |       auth Alert Rules table       | 

 **Table name:** T\_Auth\_GROUP\_INFO 

 **Description:** userGroup Information Table 

 **Data column:** 

 |  No.|       name      |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|       Description       | 
 | :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :--: | :------------: | 
 |  1  |       ID      |    int   |  10 |  0  |   N  |  Y  |      |      Primary Key ID      | 
 |  2  |  GROUP\_NAME  |  varchar |  32 |  0  |   N  |  N  |  ""  |      userGroup name     | 
 |  3  |  GROUP\_CODE  |  varchar |  32 |  0  |   N  |  N  |      | userGroup ID The default user group ID is the same| 
 |  4  |  GROUP\_TYPE  |    bit   |  1  |  0  |   N  |  N  |      |   userGroup type 0 Default group   | 
 |  5  | PROJECT\_CODE |  varchar |  64 |  0  |   N  |  N  |  ""  |     userGroup Project    | 
 |  6  |   IS\_DELETE  |    bit   |  1  |  0  |   N  |  N  | b'0' |   Delete 0 can be deleted by 1   | 
 |  7  |  CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |  ""  |       Added by      | 
 |  8  |  UPDATE\_USER |  varchar |  64 |  0  |   Y  |  N  |      |       Revise by      | 
 |  9  |  CREATE\_TIME | datetime |  23 |  0  |   N  |  N  |      |      creationTime      | 
 |  10 |  UPDATE\_TIME | datetime |  23 |  0  |   Y  |  N  |      |      Change the time      | 
 |  11 | DISPLAY\_NAME |  varchar |  32 |  0  |   Y  |  N  |      |      userGroup aliasName     | 
 |  12 |  RELATION\_ID |  varchar |  32 |  0  |   Y  |  N  |      |     link system ID     | 

 **Table name:** T\_Auth\_GROUP\_PERSION 
   
 **Description:** 
   
 **Data column:** 

 |  No.|      name      |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|            Description            | 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :----------------------: | 
 |  1  |      ID      |  varchar |  64 |  0  |   N  |  Y  |     |           Primary Key ID           | 
 |  2  | AUTH\_ACTION |  varchar |  64 |  0  |   N  |  N  |  "" |           auth action           | 
 |  3  |  GROUP\_CODE |  varchar |  64 |  0  |   N  |  N  |  "" |userGroup Number default 7 built-in group number fixed customize group code random| 
 |  4  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |  "" |            creator           | 
 |  5  | UPDATE\_USER |  varchar |  64 |  0  |   Y  |  N  |     |            Revise by           | 
 |  6  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  |     |           creationTime           | 
 |  7  | UPDATE\_TIME | datetime |  23 |  0  |   Y  |  N  |     |           Change the time           | 

 **Table name:** T\_Auth\_GROUP\_USER 

 **Description:** 

 **Data column:** 

 |  No.|      name      |   Type Of Data   |  length| decimal place| Allow Null| primary key| defaultValue|   Description| 
 | :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: | 
 |  1  |      ID      |  varchar |  64 |  0  |   N  |  Y  |     |  Primary Key ID| 
 |  2  |   USER\_ID   |  varchar |  64 |  0  |   N  |  N  |  "" |user ID| 
 |  3  |   GROUP\_ID  |  varchar |  64 |  0  |   N  |  N  |  "" |userGroup ID| 
 |  4  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |  "" |append user| 
 |  5  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  |     |  append time| 

 **Table name:** T\_Auth\_IAM\_CALLBACK 

 **Description:** IAM callback address 

 **Data column:** 

 |  No.|      name      |   Type Of Data| length| decimal place| Allow Null| primary key| defaultValue|         Description        | 
 | :-: | :----------: | :-----: | :--: | :-: | :--: | :-: | :--: | :---------------: | 
 |  1  |      ID      |   int   |  10  |  0  |   N  |  Y  |      |        Primary Key ID       | 
 |  2  |    GATEWAY   | varchar |  255 |  0  |   N  |  N  |  ""  |       target service Gateway      | 
 |  3  |     PATH     | varchar | 1024 |  0  |   N  |  N  |  ""  |       target Interface path      | 
 |  4  | DELETE\_FLAG |   bit   |   1  |  0  |   Y  |  N  | b'0' |Delete true-Yes false-No| 
 |  5  |   RESOURCE   | varchar |  32  |  0  |   N  |  N  |  ""  |        Resource type       | 
 |  6  |    SYSTEM    | varchar |  32  |  0  |   N  |  N  |  ""  |        access system       | 
 **Table name:** T\_Auth\_MANAGER 

 **Description:** Administrator Alert Rules Table 

 **Data column:** 

 |  No.|        name        |    Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |   Description   | 
 | :-: | :--------------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |        ID        |    int    |  10 |  0  |   N  |  Y  |                    |  Primary Key ID| 
 |  2  |       NAME       |  varchar  |  32 |  0  |   N  |  N  |                    |   name   | 
 |  3  | ORGANIZATION\_ID |    int    |  10 |  0  |   N  |  N  |                    |  Tissue ID| 
 |  4  |       LEVEL      |    int    |  10 |  0  |   N  |  N  |                    |  Hierarchy ID| 
 |  5  |    STRATEGYID    |    int    |  10 |  0  |   N  |  N  |                    | auth Alert Rules ID| 
 |  6  |    IS\_DELETE    |    bit    |  1  |  0  |   N  |  N  |          0         |  Delete| 
 |  7  |   CREATE\_USER   |  varchar  |  11 |  0  |   N  |  N  |         ""         |  create user| 
 |  8  |   UPDATE\_USER   |  varchar  |  11 |  0  |   Y  |  N  |         ""         |  Revise user| 
 |  9  |   CREATE\_TIME   | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  10 |   UPDATE\_TIME   | timestamp |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |Change the time| 

 **Table name:** T\_Auth\_MANAGER\_USER 

 **Description:** Administrator user table (only users within the EXP are saved) 

 **Data column:** 

 |  No.|      name      |    Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |    Description    | 
 | :-: | :----------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :------: | 
 |  1  |      ID      |    int    |  10 |  0  |   N  |  Y  |                    |   Primary Key ID   | 
 |  2  |   USER\_ID   |  varchar  |  64 |  0  |   N  |  N  |                    |   user ID   | 
 |  3  |  MANAGER\_ID |    int    |  10 |  0  |   N  |  N  |                    |  Administrator auth ID| 
 |  4  |  START\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |auth Take Effect Start time| 
 |  5  |   END\_TIME  | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |auth Take Effect End Time| 
 |  6  | CREATE\_USER |  varchar  |  64 |  0  |   N  |  N  |                    |   create user   | 
 |  7  | UPDATE\_USER |  varchar  |  64 |  0  |   Y  |  N  |                    |   Revise user   | 
 |  8  | CREATE\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime   | 
 |  9  | UPDATE\_TIME | timestamp |  19 |  0  |   Y  |  N  |                    |   Change the time   | 

 **Table name:** T\_Auth\_MANAGER\_USER\_HISTORY 

 **Description:** Administrator user history table 

 **Data column:** 

 |  No.|      name      |    Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |    Description    | 
 | :-: | :----------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :------: | 
 |  1  |      ID      |    int    |  10 |  0  |   N  |  Y  |                    |   Primary Key ID   | 
 |  2  |   USER\_ID   |  varchar  |  64 |  0  |   N  |  N  |                    |   user ID   | 
 |  3  |  MANAGER\_ID |    int    |  10 |  0  |   N  |  N  |                    |  Administrator auth ID| 
 |  4  |  START\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |auth Take Effect Start time| 
 |  5  |   END\_TIME  | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |auth Take Effect End Time| 
 |  6  | CREATE\_USER |  varchar  |  64 |  0  |   N  |  N  |                    |   create user   | 
 |  7  | UPDATE\_USER |  varchar  |  64 |  0  |   Y  |  N  |                    |   Revise user   | 
 |  8  | CREATE\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   creationTime   | 
 |  9  | UPDATE\_TIME | timestamp |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |   Change the time   | 

 **Table name:** T\_Auth\_MANAGER\_WHITELIST 

 **Description:** Administrator Self-service apply List 

 **Data column:** 

 |  No.|      name     |   Type Of Data| length| decimal place| Allow Null| primary key| defaultValue|   Description   | 
 | :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |      ID     |   int   |  10 |  0  |   N  |  Y  |     |  Primary Key ID| 
 |  2  | MANAGER\_ID |   int   |  10 |  0  |   N  |  N  |     | Manage Alert Rules ID| 
 |  3  |   USER\_ID  | varchar |  64 |  0  |   N  |  N  |     |  user ID| 

 **Table name:** T\_Auth\_STRATEGY 

 **Description:** auth Alert Rules Table 

 **Data column:** 

 |  No.|       name       |    Type Of Data   |  length| decimal place| Allow Null| primary key|         defaultValue        |      Description     | 
 | :-: | :------------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :---------: | 
 |  1  |       ID       |    int    |  10  |  0  |   N  |  Y  |                    |    Alert Rules PK ID   | 
 |  2  | STRATEGY\_NAME |  varchar  |  32  |  0  |   N  |  N  |                    |     Alert Rules name    | 
 |  3  | STRATEGY\_BODY |  varchar  | 2000 |  0  |   N  |  N  |                    |     Alert Rules content    | 
 |  4  |   IS\_DELETE   |    bit    |   1  |  0  |   N  |  N  |          0         | Delete 0 Not Delete 1 Delete| 
 |  5  |  CREATE\_TIME  | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |     creationTime    | 
 |  6  |  UPDATE\_TIME  | timestamp |  19  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |     Change the time    | 
 |  7  |  CREATE\_USER  |  varchar  |  32  |  0  |   N  |  N  |                    |     creator     | 
 |  8  |  UPDATE\_USER  |  varchar  |  32  |  0  |   Y  |  N  |                    |     Revise by     | 
