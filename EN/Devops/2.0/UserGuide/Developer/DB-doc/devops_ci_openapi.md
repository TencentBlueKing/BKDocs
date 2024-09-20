# devops\_ci\_openapi

**The database name:** devops\_ci\_openapi

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_openapi

|                     Table name                    |        Description        | 
| :---------------------------------------: | :--------------: | 
|  [T\_APP\_CODE\_GROUP](broken-reference)  |app\_code corresponding organization architecture| 
| [T\_APP\_CODE\_PROJECT](broken-reference) |BK-CI project corresponding to app\_code| 
|   [T\_APP\_USER\_INFO](broken-reference)  |app\_code corresponding Administrator| 

**Table name:** T\_APP\_CODE\_GROUP

**Description:**  app\_code corresponding organization architecture

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |     Description     | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--------: | 
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |     primary key ID    | 
|  2  |   APP\_CODE  |  varchar | 255 |  0  |   N  |  N  |     |    APP code   | 
|  3  |    BG\_ID    |    int   |  10 |  0  |   Y  |  N  |     |    Business Group ID   | 
|  4  |   BG\_NAME   |  varchar | 255 |  0  |   Y  |  N  |     |    Business Group name   | 
|  5  |   DEPT\_ID   |    int   |  10 |  0  |   Y  |  N  |     | ID of secondary institution of the project| 
|  6  |  DEPT\_NAME  |  varchar | 255 |  0  |   Y  |  N  |     | Name of secondary institution of the project| 
|  7  |  CENTER\_ID  |    int   |  10 |  0  |   Y  |  N  |     |    Site ID    | 
|  8  | CENTER\_NAME |  varchar | 255 |  0  |   Y  |  N  |     |    Center Name    | 
|  9  |    CREATOR   |  varchar | 255 |  0  |   Y  |  N  |     |     projectCreator    | 
|  10 | create\_time | datetime |  19 |  0  |   Y  |  N  |     |    creationTime    | 
|  11 |    UPDATER   |  varchar | 255 |  0  |   Y  |  N  |     |     With the new guy    | 
|  12 | UPDATE\_TIME | datetime |  19 |  0  |   Y  |  N  |     |    Change the time    | 

**Table name:** T\_APP\_CODE\_PROJECT

**Description:**  BK-CI project corresponding to app\_code

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |   Description  | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: | 
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |   primary key ID | 
|  2  |   APP\_CODE  |  varchar | 255 |  0  |   N  |  N  |     | APP code| 
|  3  |  PROJECT\_ID |  varchar | 255 |  0  |   N  |  N  |     |  Project ID| 
|  4  |    CREATOR   |  varchar | 255 |  0  |   Y  |  N  |     |  projectCreator| 
|  5  | create\_time | datetime |  19 |  0  |   Y  |  N  |     |  creationTime| 

**Table name:** T\_APP\_USER\_INFO

**Description:**  app\_code corresponding Administrator

**Data column:** 

|  No. |      name      |   Type Of Data   |  length | decimal place | Allow Null |   primary key  | defaultValue |    Description    | 
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :------: | 
|  1  |      ID      |    int   |  10 |  0  |   N  |  Y  |     |    primary key ID   | 
|  2  |   APP\_CODE  |  varchar |  64 |  0  |   N  |  N  |     |   APP code| 
|  3  |  MANAGER\_ID |  varchar |  64 |  0  |   N  |  N  |     | App Administrator ID| 
|  4  |  IS\_DELETE  |    bit   |  1  |  0  |   N  |  N  |     |   Delete   | 
|  5  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |   append Person   | 
|  6  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  |     |   append time   | 
