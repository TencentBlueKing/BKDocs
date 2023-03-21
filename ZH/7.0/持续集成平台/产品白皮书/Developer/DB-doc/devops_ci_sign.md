# devops\_ci\_sign

**数据库名：** devops\_ci\_sign

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_sign的数据库文档

|                    表名                    |    说明    |
| :--------------------------------------: | :------: |
|   [T\_SIGN\_HISTORY](broken-reference)   |  签名历史记录表 |
|  [T\_SIGN\_IPA\_INFO](broken-reference)  |  签名任务信息表 |
| [T\_SIGN\_IPA\_UPLOAD](broken-reference) | 签名包上传记录表 |

**表名：** T\_SIGN\_HISTORY

**说明：** 签名历史记录表

**数据列：**

|  序号 |           名称          |    数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :-------------------: | :-------: | :---: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |       RESIGN\_ID      |  varchar  |   64  |  0  |   N  |  Y  |                    |  签名ID  |
|  2  |        USER\_ID       |  varchar  |   64  |  0  |   N  |  N  |       system       |  用户ID  |
|  3  |      PROJECT\_ID      |  varchar  |   64  |  0  |   Y  |  N  |                    |  项目ID  |
|  4  |      PIPELINE\_ID     |  varchar  |   64  |  0  |   Y  |  N  |                    |  流水线ID |
|  5  |       BUILD\_ID       |  varchar  |   64  |  0  |   Y  |  N  |                    |  构建ID  |
|  6  |        TASK\_ID       |  varchar  |   64  |  0  |   Y  |  N  |                    |  任务ID  |
|  7  |  TASK\_EXECUTE\_COUNT |    int    |   10  |  0  |   Y  |  N  |                    | 任务执行计数 |
|  8  |     ARCHIVE\_TYPE     |  varchar  |   32  |  0  |   Y  |  N  |                    |  归档类型  |
|  9  |     ARCHIVE\_PATH     |    text   | 65535 |  0  |   Y  |  N  |                    |  归档路径  |
|  10 |       FILE\_MD5       |  varchar  |   64  |  0  |   Y  |  N  |                    |  文件MD5 |
|  11 |         STATUS        |  varchar  |   32  |  0  |   Y  |  N  |                    |   状态   |
|  12 |      CREATE\_TIME     | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  13 |       END\_TIME       | timestamp |   19  |  0  |   Y  |  N  |                    |  结束时间  |
|  14 |   RESULT\_FILE\_MD5   |  varchar  |   64  |  0  |   Y  |  N  |                    |  文件MD5 |
|  15 |   RESULT\_FILE\_NAME  |  varchar  |  512  |  0  |   Y  |  N  |                    |  文件名称  |
|  16 |  UPLOAD\_FINISH\_TIME | timestamp |   19  |  0  |   Y  |  N  |                    | 上传完成时间 |
|  17 |  UNZIP\_FINISH\_TIME  | timestamp |   19  |  0  |   Y  |  N  |                    | 解压完成时间 |
|  18 |  RESIGN\_FINISH\_TIME | timestamp |   19  |  0  |   Y  |  N  |                    | 签名完成时间 |
|  19 |   ZIP\_FINISH\_TIME   | timestamp |   19  |  0  |   Y  |  N  |                    | 打包完成时间 |
|  20 | ARCHIVE\_FINISH\_TIME | timestamp |   19  |  0  |   Y  |  N  |                    | 归档完成时间 |
|  21 |     ERROR\_MESSAGE    |    text   | 65535 |  0  |   Y  |  N  |                    |  错误信息  |

**表名：** T\_SIGN\_IPA\_INFO

**说明：** 签名任务信息表

**数据列：**

|  序号 |            名称            |    数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |        说明        |
| :-: | :----------------------: | :-------: | :---: | :-: | :--: | :-: | :----------------: | :--------------: |
|  1  |        RESIGN\_ID        |  varchar  |   64  |  0  |   N  |  Y  |                    |       签名ID       |
|  2  |         USER\_ID         |  varchar  |   64  |  0  |   N  |  N  |                    |       用户ID       |
|  3  |         WILDCARD         |    bit    |   1   |  0  |   N  |  N  |                    |     是否采用通配符重签    |
|  4  |         CERT\_ID         |  varchar  |  128  |  0  |   Y  |  N  |                    |       证书ID       |
|  5  |        PROJECT\_ID       |  varchar  |   64  |  0  |   Y  |  N  |                    |       项目ID       |
|  6  |       PIPELINE\_ID       |  varchar  |   64  |  0  |   Y  |  N  |                    |       流水线ID      |
|  7  |         BUILD\_ID        |  varchar  |   64  |  0  |   Y  |  N  |                    |       构建ID       |
|  8  |         TASK\_ID         |  varchar  |   64  |  0  |   Y  |  N  |                    |       任务ID       |
|  9  |       ARCHIVE\_TYPE      |  varchar  |   32  |  0  |   Y  |  N  |                    |       归档类型       |
|  10 |       ARCHIVE\_PATH      |    text   | 65535 |  0  |   Y  |  N  |                    |       归档路径       |
|  11 |   MOBILE\_PROVISION\_ID  |  varchar  |  128  |  0  |   Y  |  N  |                    |      移动设备ID      |
|  12 |     UNIVERSAL\_LINKS     |    text   | 65535 |  0  |   Y  |  N  |                    | UniversalLink的设置 |
|  13 | KEYCHAIN\_ACCESS\_GROUPS |    text   | 65535 |  0  |   Y  |  N  |                    |      钥匙串访问组      |
|  14 |      REPLACE\_BUNDLE     |    bit    |   1   |  0  |   Y  |  N  |                    |   是否替换bundleId   |
|  15 |     APPEX\_SIGN\_INFO    |    text   | 65535 |  0  |   Y  |  N  |                    |  拓展应用名和对应的描述文件ID |
|  16 |         FILENAME         |    text   | 65535 |  0  |   Y  |  N  |                    |       文件名称       |
|  17 |        FILE\_SIZE        |   bigint  |   20  |  0  |   Y  |  N  |                    |       文件大小       |
|  18 |         FILE\_MD5        |  varchar  |   64  |  0  |   Y  |  N  |                    |       文件MD5      |
|  19 |     REQUEST\_CONTENT     |    text   | 65535 |  0  |   N  |  N  |                    |       事件内容       |
|  20 |       CREATE\_TIME       | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |       创建时间       |

**表名：** T\_SIGN\_IPA\_UPLOAD

**说明：** 签名包上传记录表

**数据列：**

|  序号 |       名称      |    数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :-----------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :---: |
|  1  | UPLOAD\_TOKEN |  varchar  |  64 |  0  |   N  |  Y  |                    | token |
|  2  |    USER\_ID   |  varchar  |  64 |  0  |   N  |  N  |                    |  用户ID |
|  3  |  PROJECT\_ID  |  varchar  |  64 |  0  |   N  |  N  |                    |  项目ID |
|  4  |  PIPELINE\_ID |  varchar  |  64 |  0  |   N  |  N  |                    | 流水线ID |
|  5  |   BUILD\_ID   |  varchar  |  64 |  0  |   N  |  N  |                    |  构建ID |
|  6  |  CREATE\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间 |
|  7  |   RESIGN\_ID  |  varchar  |  64 |  0  |   Y  |  N  |                    |  签名ID |
