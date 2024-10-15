# devops\_ci\_sign

**The database name:** devops\_ci\_sign

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_sign

 |                    Table name                    |    Description    | 
 | :--------------------------------------: | :------: | 
 |   [T\_SIGN\_HISTORY](broken-reference)   |  Signature Last 10 history records Sheet| 
 |  [T\_SIGN\_IPA\_INFO](broken-reference)  |Signature Task information Table| 
 | [T\_SIGN\_IPA\_UPLOAD](broken-reference) |Signature Package upload Record Form| 

 **Table name:** T\_SIGN\_HISTORY 

 **Description:** Signature Last 10 history records Table 

 **Data column:** 

 |  No. |           name          |    Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |   Description   | 
 | :-: | :-------------------: | :-------: | :---: | :-: | :--: | :-: | :----------------: | :----: | 
 |  1  |       RESIGN\_ID      |  varchar  |   64  |  0  |   N  |  Y  |                    |  Signature ID| 
 |  2  |        USER\_ID       |  varchar  |   64  |  0  |   N  |  N  |       system       |  user ID| 
 |  3  |      PROJECT\_ID      |  varchar  |   64  |  0  |   Y  |  N  |                    |  Project ID| 
 |  4  |      PIPELINE\_ID     |  varchar  |   64  |  0  |   Y  |  N  |                    |  pipelineId| 
 |  5  |       BUILD\_ID       |  varchar  |   64  |  0  |   Y  |  N  |                    |  build ID| 
 |  6  |        TASK\_ID       |  varchar  |   64  |  0  |   Y  |  N  |                    |  Task ID| 
 |  7  |  TASK\_EXECUTE\_COUNT |    int    |   10  |  0  |   Y  |  N  |                    | Task execute Total| 
 |  8  |     ARCHIVE\_TYPE     |  varchar  |   32  |  0  |   Y  |  N  |                    |  Archive type| 
 |  9  |     ARCHIVE\_PATH     |    text   | 65535 |  0  |   Y  |  N  |                    |  Archive path| 
 |  10 |       FILE\_MD5       |  varchar  |   64  |  0  |   Y  |  N  |                    |  file MD5| 
 |  11 |         STATUS        |  varchar  |   32  |  0  |   Y  |  N  |                    |   status   | 
 |  12 |      CREATE\_TIME     | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  13 |       END\_TIME       | timestamp |   19  |  0  |   Y  |  N  |                    |  End Time| 
 |  14 |   RESULT\_FILE\_MD5   |  varchar  |   64  |  0  |   Y  |  N  |                    |  file MD5| 
 |  15 |   RESULT\_FILE\_NAME  |  varchar  |  512  |  0  |   Y  |  N  |                    |  file name| 
 |  16 |  UPLOAD\_FINISH\_TIME | timestamp |   19  |  0  |   Y  |  N  |                    | upload complete time| 
 |  17 |  UNZIP\_FINISH\_TIME  | timestamp |   19  |  0  |   Y  |  N  |                    | Decompression complete time| 
 |  18 |  RESIGN\_FINISH\_TIME | timestamp |   19  |  0  |   Y  |  N  |                    | Signature complete time| 
 |  19 |   ZIP\_FINISH\_TIME   | timestamp |   19  |  0  |   Y  |  N  |                    | Packing complete time| 
 |  20 | ARCHIVE\_FINISH\_TIME | timestamp |   19  |  0  |   Y  |  N  |                    | Archive complete time| 
 |  21 |     ERROR\_MESSAGE    |    text   | 65535 |  0  |   Y  |  N  |                    |  Error Message| 

 **Table name:** T\_SIGN\_IPA\_INFO 

 **Description:** Signature Task information Table 

 **Data column:** 

 |  No. |            name            |    Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |        Description        | 
 | :-: | :----------------------: | :-------: | :---: | :-: | :--: | :-: | :----------------: | :--------------: | 
 |  1  |        RESIGN\_ID        |  varchar  |   64  |  0  |   N  |  Y  |                    |       Signature ID       | 
 |  2  |         USER\_ID         |  varchar  |   64  |  0  |   N  |  N  |                    |       user ID       | 
 |  3  |         WILDCARD         |    bit    |   1   |  0  |   N  |  N  |                    |     Use wildcard to re-sign    | 
 |  4  |         CERT\_ID         |  varchar  |  128  |  0  |   Y  |  N  |                    |       Certificate ID       | 
 |  5  |        PROJECT\_ID       |  varchar  |   64  |  0  |   Y  |  N  |                    |       Project ID       | 
 |  6  |       PIPELINE\_ID       |  varchar  |   64  |  0  |   Y  |  N  |                    |       pipelineId      | 
 |  7  |         BUILD\_ID        |  varchar  |   64  |  0  |   Y  |  N  |                    |       build ID       | 
 |  8  |         TASK\_ID         |  varchar  |   64  |  0  |   Y  |  N  |                    |       Task ID       | 
 |  9  |       ARCHIVE\_TYPE      |  varchar  |   32  |  0  |   Y  |  N  |                    |       Archive type       | 
 |  10 |       ARCHIVE\_PATH      |    text   | 65535 |  0  |   Y  |  N  |                    |       Archive path       | 
 |  11 |   MOBILE\_PROVISION\_ID  |  varchar  |  128  |  0  |   Y  |  N  |                    |      Mobile Device ID      | 
 |  12 |     UNIVERSAL\_LINKS     |    text   | 65535 |  0  |   Y  |  N  |                    | UniversalLink Set| 
 |  13 | KEYCHAIN\_ACCESS\_GROUPS |    text   | 65535 |  0  |   Y  |  N  |                    |      Keychain access group      | 
 |  14 |      REPLACE\_BUNDLE     |    bit    |   1   |  0  |   Y  |  N  |                    |   Replace bundleId   | 
 |  15 |     APPEX\_SIGN\_INFO    |    text   | 65535 |  0  |   Y  |  N  |                    |  Extended Apply name and corresponding remarkFile ID| 
 |  16 |         FILENAME         |    text   | 65535 |  0  |   Y  |  N  |                    |       file name       | 
 |  17 |        FILE\_SIZE        |   bigint  |   20  |  0  |   Y  |  N  |                    |       filesize       | 
 |  18 |         FILE\_MD5        |  varchar  |   64  |  0  |   Y  |  N  |                    |       file MD5      | 
 |  19 |     REQUEST\_CONTENT     |    text   | 65535 |  0  |   N  |  N  |                    |       event content       | 
 |  20 |       CREATE\_TIME       | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |       creationTime       | 

 **Table name:** T\_SIGN\_IPA\_UPLOAD 

 **Description:** Signature Package upload Record Table 

 **Data column:** 

 |  No. |       name      |    Type Of Data   |  length | decimal place | Allow Null |   primary key  |         defaultValue        |   Description  | 
 | :-: | :-----------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :---: | 
 |  1  | UPLOAD\_TOKEN |  varchar  |  64 |  0  |   N  |  Y  |                    | token | 
 |  2  |    USER\_ID   |  varchar  |  64 |  0  |   N  |  N  |                    |  user ID| 
 |  3  |  PROJECT\_ID  |  varchar  |  64 |  0  |   N  |  N  |                    |  Project ID| 
 |  4  |  PIPELINE\_ID |  varchar  |  64 |  0  |   N  |  N  |                    | pipelineId| 
 |  5  |   BUILD\_ID   |  varchar  |  64 |  0  |   N  |  N  |                    |  build ID| 
 |  6  |  CREATE\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |creationTime| 
 |  7  |   RESIGN\_ID  |  varchar  |  64 |  0  |   Y  |  N  |                    |  Signature ID| 
