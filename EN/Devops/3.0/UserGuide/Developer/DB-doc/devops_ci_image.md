# devops\_ci\_image

**The database name:** devops\_ci\_image

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_image

|                     Table name                     |  Description |
| :----------------------------------------: | :-: |
| [T\_UPLOAD\_IMAGE\_TASK](broken-reference) |     |

**Table name:** T\_UPLOAD\_IMAGE\_TASK

**Description:** 

**Data column:** 

|  No. |       name      |    Type Of Data   |     length     | decimal place | Allow Null |   primary key  | defaultValue |  Description  |
| :-: | :-----------: | :-------: | :--------: | :-: | :--: | :-: | :-: | :--: |
|  1  |    TASK\_ID   |  varchar  |     128    |  0  |   N  |  Y  |     | Task ID  |
|  2  |  PROJECT\_ID  |  varchar  |     128    |  0  |   N  |  N  |     | Project ID  |
|  3  |    OPERATOR   |  varchar  |     128    |  0  |   N  |  N  |     |  Operation |
|  4  | CREATED\_TIME | timestamp |     19     |  0  |   Y  |  N  |     | CreationTime  |
|  5  | UPDATED\_TIME | timestamp |     19     |  0  |   Y  |  N  |     | Change the time  |
|  6  |  TASK\_STATUS |  varchar  |     32     |  0  |   N  |  N  |     | Task Total  |
|  7  | TASK\_MESSAGE |  varchar  |     256    |  0  |   Y  |  N  |     | Task message  |
|  8  |  IMAGE\_DATA  |  longtext | 2147483647 |  0  |   Y  |  N  |     | Mirror List  |
