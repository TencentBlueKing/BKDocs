# devops\_ci\_ticket

**数据库名：** devops\_ci\_ticket

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_ticket的数据库文档

|                    表名                   |   说明   |
| :-------------------------------------: | :----: |
|       [T\_CERT](broken-reference)       |  凭证信息表 |
| [T\_CERT\_ENTERPRISE](broken-reference) |  企业证书表 |
|     [T\_CERT\_TLS](broken-reference)    | TLS证书表 |
|    [T\_CREDENTIAL](broken-reference)    |   凭证表  |

**表名：** T\_CERT

**说明：** 凭证信息表

**数据列：**

|  序号 |                名称                |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |     说明    |
| :-: | :------------------------------: | :------: | :---: | :-: | :--: | :-: | :-: | :-------: |
|  1  |            PROJECT\_ID           |  varchar |   64  |  0  |   N  |  Y  |     |    项目ID   |
|  2  |             CERT\_ID             |  varchar |  128  |  0  |   N  |  Y  |     |    证书ID   |
|  3  |          CERT\_USER\_ID          |  varchar |   64  |  0  |   N  |  N  |     |   证书用户ID  |
|  4  |            CERT\_TYPE            |  varchar |   32  |  0  |   N  |  N  |     |    证书类型   |
|  5  |           CERT\_REMARK           |  varchar |  128  |  0  |   N  |  N  |     |    证书备注   |
|  6  |       CERT\_P12\_FILE\_NAME      |  varchar |  128  |  0  |   N  |  N  |     | 证书p12文件名称 |
|  7  |     CERT\_P12\_FILE\_CONTENT     |   blob   | 65535 |  0  |   N  |  N  |     | 证书p12文件内容 |
|  8  |       CERT\_MP\_FILE\_NAME       |  varchar |  128  |  0  |   N  |  N  |     |  证书mp文件名称 |
|  9  |      CERT\_MP\_FILE\_CONTENT     |   blob   | 65535 |  0  |   N  |  N  |     |  证书mp文件内容 |
|  10 |       CERT\_JKS\_FILE\_NAME      |  varchar |  128  |  0  |   N  |  N  |     | 证书jks文件名称 |
|  11 |     CERT\_JKS\_FILE\_CONTENT     |   blob   | 65535 |  0  |   N  |  N  |     | 证书jsk文件内容 |
|  12 |         CERT\_JKS\_ALIAS         |  varchar |  128  |  0  |   Y  |  N  |     |  证书jsk别名  |
|  13 | CERT\_JKS\_ALIAS\_CREDENTIAL\_ID |  varchar |   64  |  0  |   Y  |  N  |     | 证书jks凭据ID |
|  14 |       CERT\_DEVELOPER\_NAME      |  varchar |  128  |  0  |   N  |  N  |     |  证书开发者名称  |
|  15 |         CERT\_TEAM\_NAME         |  varchar |  128  |  0  |   N  |  N  |     |   证书团队名称  |
|  16 |            CERT\_UUID            |  varchar |   64  |  0  |   N  |  N  |     |   证书uuid  |
|  17 |        CERT\_EXPIRE\_DATE        | datetime |   19  |  0  |   Y  |  N  |     |   证书过期时间  |
|  18 |        CERT\_CREATE\_TIME        | datetime |   19  |  0  |   Y  |  N  |     |   证书创建时间  |
|  19 |        CERT\_UPDATE\_TIME        | datetime |   19  |  0  |   Y  |  N  |     |   证书更新时间  |
|  20 |          CREDENTIAL\_ID          |  varchar |   64  |  0  |   Y  |  N  |     |    凭证ID   |

**表名：** T\_CERT\_ENTERPRISE

**说明：** 企业证书表

**数据列：**

|  序号 |            名称           |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |    说明    |
| :-: | :---------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :------: |
|  1  |       PROJECT\_ID       |  varchar |   64  |  0  |   N  |  Y  |                    |   项目ID   |
|  2  |         CERT\_ID        |  varchar |   32  |  0  |   N  |  Y  |                    |   证书ID   |
|  3  |   CERT\_MP\_FILE\_NAME  |  varchar |  128  |  0  |   N  |  N  |                    | 证书mp文件名称 |
|  4  | CERT\_MP\_FILE\_CONTENT |   blob   | 65535 |  0  |   N  |  N  |                    | 证书mp文件内容 |
|  5  |  CERT\_DEVELOPER\_NAME  |  varchar |  128  |  0  |   N  |  N  |                    |  证书开发者名称 |
|  6  |     CERT\_TEAM\_NAME    |  varchar |  128  |  0  |   N  |  N  |                    |  证书团队名称  |
|  7  |        CERT\_UUID       |  varchar |   64  |  0  |   N  |  N  |                    |  证书uuid  |
|  8  |    CERT\_UPDATE\_TIME   | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   更新时间   |
|  9  |    CERT\_EXPIRE\_DATE   | datetime |   19  |  0  |   N  |  N  | 2019-08-0100:00:00 |  证书过期时间  |
|  10 |    CERT\_CREATE\_TIME   | datetime |   19  |  0  |   N  |  N  | 2019-08-0100:00:00 |  证书创建时间  |

**表名：** T\_CERT\_TLS

**说明：** TLS证书表

**数据列：**

|  序号 |               名称              |    数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |         说明        |
| :-: | :---------------------------: | :-------: | :---: | :-: | :--: | :-: | :----------------: | :---------------: |
|  1  |          PROJECT\_ID          |  varchar  |   64  |  0  |   N  |  Y  |                    |        项目ID       |
|  2  |            CERT\_ID           |  varchar  |   32  |  0  |   N  |  Y  |                    |        证书ID       |
|  3  | CERT\_SERVER\_CRT\_FILE\_NAME |  varchar  |  128  |  0  |   N  |  N  |                    |     服务器crt证书名     |
|  4  |    CERT\_SERVER\_CRT\_FILE    |    blob   | 65535 |  0  |   N  |  N  |                    | Base64编码的加密后的证书内容 |
|  5  | CERT\_SERVER\_KEY\_FILE\_NAME |  varchar  |  128  |  0  |   N  |  N  |                    |     服务器key证书名     |
|  6  |    CERT\_SERVER\_KEY\_FILE    |    blob   | 65535 |  0  |   N  |  N  |                    | Base64编码的加密后的证书内容 |
|  7  | CERT\_CLIENT\_CRT\_FILE\_NAME |  varchar  |  128  |  0  |   Y  |  N  |                    |     客户端crt证书名     |
|  8  |    CERT\_CLIENT\_CRT\_FILE    |    blob   | 65535 |  0  |   Y  |  N  |                    | Base64编码的加密后的证书内容 |
|  9  | CERT\_CLIENT\_KEY\_FILE\_NAME |  varchar  |  128  |  0  |   Y  |  N  |                    |     客户端key证书名     |
|  10 |    CERT\_CLIENT\_KEY\_FILE    |    blob   | 65535 |  0  |   Y  |  N  |                    | Base64编码的加密后的证书内容 |
|  11 |       CERT\_CREATE\_TIME      | timestamp |   19  |  0  |   N  |  N  | 2019-08-0100:00:00 |       证书创建时间      |
|  12 |       CERT\_UPDATE\_TIME      | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |       证书更新时间      |

**表名：** T\_CREDENTIAL

**说明：** 凭证表

**数据列：**

|  序号 |          名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :------------------: | :------: | :---: | :-: | :--: | :-: | :-: | :----: |
|  1  |      PROJECT\_ID     |  varchar |   64  |  0  |   N  |  Y  |     |  项目ID  |
|  2  |    CREDENTIAL\_ID    |  varchar |   64  |  0  |   N  |  Y  |     |  凭据ID  |
|  3  |   CREDENTIAL\_NAME   |  varchar |   64  |  0  |   Y  |  N  |     |  凭据名称  |
|  4  | CREDENTIAL\_USER\_ID |  varchar |   64  |  0  |   N  |  N  |     | 凭据用户ID |
|  5  |   CREDENTIAL\_TYPE   |  varchar |   64  |  0  |   N  |  N  |     |  凭据类型  |
|  6  |  CREDENTIAL\_REMARK  |   text   | 65535 |  0  |   Y  |  N  |     |  凭据备注  |
|  7  |    CREDENTIAL\_V1    |   text   | 65535 |  0  |   N  |  N  |     |  凭据内容  |
|  8  |    CREDENTIAL\_V2    |   text   | 65535 |  0  |   Y  |  N  |     |  凭据内容  |
|  9  |    CREDENTIAL\_V3    |   text   | 65535 |  0  |   Y  |  N  |     |  凭据内容  |
|  10 |    CREDENTIAL\_V4    |   text   | 65535 |  0  |   Y  |  N  |     |  凭据内容  |
|  11 |     CREATED\_TIME    | datetime |   19  |  0  |   N  |  N  |     |  创建时间  |
|  12 |     UPDATED\_TIME    | datetime |   19  |  0  |   N  |  N  |     |  更新时间  |
|  13 |     UPDATE\_USER     |  varchar |   64  |  0  |   Y  |  N  |     |   修改人  |
