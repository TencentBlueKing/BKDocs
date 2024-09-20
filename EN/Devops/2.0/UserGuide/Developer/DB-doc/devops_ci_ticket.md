# devops\_ci\_ticket

**The database name:** devops\_ci\_ticket

**The document Version:** 1.0.0

**The document description:** The database document of the devops\_ci\_ticket

 |                    Table name                   |   Description   | 
 | :-------------------------------------: | :----: | 
 |       [T\_CERT](broken-reference)       |  Voucher Information Table| 
 | [T\_CERT\_ENTERPRISE](broken-reference) |Enterprise Certificate Form| 
 |     [T\_CERT\_TLS](broken-reference)    | TLS certificate table| 
 |    [T\_CREDENTIAL](broken-reference)    |   voucher table| 

 **Table name:** T\_CERT 

 **Description:** Voucher Information Table 

 **Data column:** 

 |  No. |                name                |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |     Description    | 
 | :-: | :------------------------------: | :------: | :---: | :-: | :--: | :-: | :-: | :-------: | 
 |  1  |            PROJECT\_ID           |  varchar |   64  |  0  |   N  |  Y  |     |    Project ID   | 
 |  2  |             CERT\_ID             |  varchar |  128  |  0  |   N  |  Y  |     |    Certificate ID   | 
 |  3  |          CERT\_USER\_ID          |  varchar |   64  |  0  |   N  |  N  |     |   Certificate user ID| 
 |  4  |            CERT\_TYPE            |  varchar |   32  |  0  |   N  |  N  |     |    certType   | 
 |  5  |           CERT\_REMARK           |  varchar |  128  |  0  |   N  |  N  |     |    CERTIFICATE remark   | 
 |  6  |       CERT\_P12\_FILE\_NAME      |  varchar |  128  |  0  |   N  |  N  |     | certificate p12File name| 
 |  7  |     CERT\_P12\_FILE\_CONTENT     |   blob   | 65535 |  0  |   N  |  N  |     | Certificate p12File content| 
 |  8  |       CERT\_MP\_FILE\_NAME       |  varchar |  128  |  0  |   N  |  N  |     |  certificate mp file name| 
 |  9  |      CERT\_MP\_FILE\_CONTENT     |   blob   | 65535 |  0  |   N  |  N  |     |  Certificate mp file content| 
 |  10 |       CERT\_JKS\_FILE\_NAME      |  varchar |  128  |  0  |   N  |  N  |     | certificate jksFile name| 
 |  11 |     CERT\_JKS\_FILE\_CONTENT     |   blob   | 65535 |  0  |   N  |  N  |     | Certificate jsk file content| 
 |  12 |         CERT\_JKS\_ALIAS         |  varchar |  128  |  0  |   Y  |  N  |     |  Certificate jsk aliasName| 
 |  13 | CERT\_JKS\_ALIAS\_CREDENTIAL\_ID |  varchar |   64  |  0  |   Y  |  N  |     | Certificate jks ticket ID| 
 |  14 |       CERT\_DEVELOPER\_NAME      |  varchar |  128  |  0  |   N  |  N  |     |  Certificate Develop Name| 
 |  15 |         CERT\_TEAM\_NAME         |  varchar |  128  |  0  |   N  |  N  |     |   Certificate Team Name| 
 |  16 |            CERT\_UUID            |  varchar |   64  |  0  |   N  |  N  |     |   Certificate uuid| 
 |  17 |        CERT\_EXPIRE\_DATE        | datetime |   19  |  0  |   Y  |  N  |     |   Certificate expireDate| 
 |  18 |        CERT\_CREATE\_TIME        | datetime |   19  |  0  |   Y  |  N  |     |   Certificate creationTime| 
 |  19 |        CERT\_UPDATE\_TIME        | datetime |   19  |  0  |   Y  |  N  |     |   Certificate updateTime| 
 |  20 |          CREDENTIAL\_ID          |  varchar |   64  |  0  |   Y  |  N  |     |    ticketId   | 

 **Table name:** T\_CERT\_ENTERPRISE 

 **Description:** Enterprise Certificate Form 

 **Data column:** 

 |  No. |            name           |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |    Description    | 
 | :-: | :---------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :------: | 
 |  1  |       PROJECT\_ID       |  varchar |   64  |  0  |   N  |  Y  |                    |   Project ID   | 
 |  2  |         CERT\_ID        |  varchar |   32  |  0  |   N  |  Y  |                    |   Certificate ID   | 
 |  3  |   CERT\_MP\_FILE\_NAME  |  varchar |  128  |  0  |   N  |  N  |                    | certificate mp file name| 
 |  4  | CERT\_MP\_FILE\_CONTENT |   blob   | 65535 |  0  |   N  |  N  |                    | Certificate mp file content| 
 |  5  |  CERT\_DEVELOPER\_NAME  |  varchar |  128  |  0  |   N  |  N  |                    |  Certificate Develop Name| 
 |  6  |     CERT\_TEAM\_NAME    |  varchar |  128  |  0  |   N  |  N  |                    |  Certificate Team Name| 
 |  7  |        CERT\_UUID       |  varchar |   64  |  0  |   N  |  N  |                    |  Certificate uuid| 
 |  8  |    CERT\_UPDATE\_TIME   | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   updateTime   | 
 |  9  |    CERT\_EXPIRE\_DATE   | datetime |   19  |  0  |   N  |  N  | 2019-08-0100:00:00 |Certificate expireDate| 
 |  10 |    CERT\_CREATE\_TIME   | datetime |   19  |  0  |   N  |  N  | 2019-08-0100:00:00 |Certificate creationTime| 

 **Table name:** T\_CERT\_TLS 

 **Description:** TLS certificate table 

 **Data column:** 

 |  No. |               name              |    Type Of Data   |   length  | decimal place | Allow Null |   primary key  |         defaultValue        |         Description        | 
 | :-: | :---------------------------: | :-------: | :---: | :-: | :--: | :-: | :----------------: | :---------------: | 
 |  1  |          PROJECT\_ID          |  varchar  |   64  |  0  |   N  |  Y  |                    |        Project ID       | 
 |  2  |            CERT\_ID           |  varchar  |   32  |  0  |   N  |  Y  |                    |        Certificate ID       | 
 |  3  | CERT\_SERVER\_CRT\_FILE\_NAME |  varchar  |  128  |  0  |   N  |  N  |                    |     service crt certificate name     | 
 |  4  |    CERT\_SERVER\_CRT\_FILE    |    blob   | 65535 |  0  |   N  |  N  |                    | Base64 encoded encryption certificate content| 
 |  5  | CERT\_SERVER\_KEY\_FILE\_NAME |  varchar  |  128  |  0  |   N  |  N  |                    |     service key certificate name     | 
 |  6  |    CERT\_SERVER\_KEY\_FILE    |    blob   | 65535 |  0  |   N  |  N  |                    | Base64 encoded encryption certificate content| 
 |  7  | CERT\_CLIENT\_CRT\_FILE\_NAME |  varchar  |  128  |  0  |   Y  |  N  |                    |     Client crt certificate name     | 
 |  8  |    CERT\_CLIENT\_CRT\_FILE    |    blob   | 65535 |  0  |   Y  |  N  |                    | Base64 encoded encryption certificate content| 
 |  9  | CERT\_CLIENT\_KEY\_FILE\_NAME |  varchar  |  128  |  0  |   Y  |  N  |                    |     Client key certificate name     | 
 |  10 |    CERT\_CLIENT\_KEY\_FILE    |    blob   | 65535 |  0  |   Y  |  N  |                    | Base64 encoded encryption certificate content| 
 |  11 |       CERT\_CREATE\_TIME      | timestamp |   19  |  0  |   N  |  N  | 2019-08-0100:00:00 |       Certificate creationTime      | 
 |  12 |       CERT\_UPDATE\_TIME      | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |       Certificate updateTime      | 

 **Table name:** T\_CREDENTIAL 

 **Description:** Voucher Table 

 **Data column:** 

 |  No. |          name          |   Type Of Data   |   length  | decimal place | Allow Null |   primary key  | defaultValue |   Description   | 
 | :-: | :------------------: | :------: | :---: | :-: | :--: | :-: | :-: | :----: | 
 |  1  |      PROJECT\_ID     |  varchar |   64  |  0  |   N  |  Y  |     |  Project ID| 
 |  2  |    CREDENTIAL\_ID    |  varchar |   64  |  0  |   N  |  Y  |     |  ticket ID| 
 |  3  |   CREDENTIAL\_NAME   |  varchar |   64  |  0  |   Y  |  N  |     |  ticket name| 
 |  4  | CREDENTIAL\_USER\_ID |  varchar |   64  |  0  |   N  |  N  |     | ticket user ID| 
 |  5  |   CREDENTIAL\_TYPE   |  varchar |   64  |  0  |   N  |  N  |     |  ticket type| 
 |  6  |  CREDENTIAL\_REMARK  |   text   | 65535 |  0  |   Y  |  N  |     |  ticket remark| 
 |  7  |    CREDENTIAL\_V1    |   text   | 65535 |  0  |   N  |  N  |     |  ticket content| 
 |  8  |    CREDENTIAL\_V2    |   text   | 65535 |  0  |   Y  |  N  |     |  ticket content| 
 |  9  |    CREDENTIAL\_V3    |   text   | 65535 |  0  |   Y  |  N  |     |  ticket content| 
 |  10 |    CREDENTIAL\_V4    |   text   | 65535 |  0  |   Y  |  N  |     |  ticket content| 
 |  11 |     CREATED\_TIME    | datetime |   19  |  0  |   N  |  N  |     |  creationTime| 
 |  12 |     UPDATED\_TIME    | datetime |   19  |  0  |   N  |  N  |     |  updateTime| 
 |  13 |     UPDATE\_USER     |  varchar |   64  |  0  |   Y  |  N  |     |   Revise by| 
