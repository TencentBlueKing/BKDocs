# devops\_ci\_op

**数据库名：** devops\_ci\_op

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_op的数据库文档

|                        表名                       |  说明 |
| :---------------------------------------------: | :-: |
|          [dept\_info](broken-reference)         |     |
|        [project\_info](broken-reference)        |     |
|             [role](broken-reference)            |     |
|       [role\_permission](broken-reference)      |     |
|       [schema\_version](broken-reference)       |     |
|       [spring\_session](broken-reference)       |     |
| [SPRING\_SESSION\_ATTRIBUTES](broken-reference) |     |
|        [t\_user\_token](broken-reference)       |     |
|         [url\_action](broken-reference)         |     |
|             [user](broken-reference)            |     |
|       [user\_permission](broken-reference)      |     |
|          [user\_role](broken-reference)         |     |

**表名：** dept\_info

**说明：**

**数据列：**

|  序号 |        名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |     说明     |
| :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--------: |
|  1  |        id        |    int   |  10 |  0  |   N  |  Y  |     |    主键ID    |
|  2  |   create\_time   | datetime |  19 |  0  |   Y  |  N  |     |    创建时间    |
|  3  |     dept\_id     |    int   |  10 |  0  |   N  |  N  |     | 项目所属二级机构ID |
|  4  |    dept\_name    |  varchar | 100 |  0  |   N  |  N  |     | 项目所属二级机构名称 |
|  5  |       level      |    int   |  10 |  0  |   N  |  N  |     |    层级ID    |
|  6  | parent\_dept\_id |    int   |  10 |  0  |   Y  |  N  |     |            |
|  7  |   UPDATE\_TIME   | datetime |  19 |  0  |   Y  |  N  |     |    更新时间    |

**表名：** project\_info

**说明：**

**数据列：**

|  序号 |           名称          |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |       说明      |
| :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-----------: |
|  1  |           id          |    int   |  10 |  0  |   N  |  Y  |     |      主键ID     |
|  2  |    approval\_status   |    int   |  10 |  0  |   Y  |  N  |     |      审核状态     |
|  3  |     approval\_time    | datetime |  19 |  0  |   Y  |  N  |     |      批准时间     |
|  4  |        approver       |  varchar | 100 |  0  |   Y  |  N  |     |      批准人      |
|  5  |      cc\_app\_id      |    int   |  10 |  0  |   Y  |  N  |     |      应用ID     |
|  6  |      created\_at      | datetime |  19 |  0  |   Y  |  N  |     |      创建时间     |
|  7  |        creator        |  varchar | 100 |  0  |   Y  |  N  |     |      创建者      |
|  8  |   creator\_bg\_name   |  varchar | 100 |  0  |   Y  |  N  |     |    创建者事业群名称   |
|  9  | creator\_center\_name |  varchar | 100 |  0  |   Y  |  N  |     |    创建者中心名字    |
|  10 |  creator\_dept\_name  |  varchar | 100 |  0  |   Y  |  N  |     | 创建者项目所属二级机构名称 |
|  11 |     english\_name     |  varchar | 255 |  0  |   Y  |  N  |     |      英文名称     |
|  12 |      is\_offlined     |    bit   |  1  |  0  |   Y  |  N  |     |      是否停用     |
|  13 |      is\_secrecy      |    bit   |  1  |  0  |   Y  |  N  |     |      是否保密     |
|  14 |    project\_bg\_id    |    int   |  10 |  0  |   Y  |  N  |     |     事业群ID     |
|  15 |   project\_bg\_name   |  varchar | 100 |  0  |   Y  |  N  |     |     事业群名称     |
|  16 |  project\_center\_id  |  varchar |  50 |  0  |   Y  |  N  |     |      中心ID     |
|  17 | project\_center\_name |  varchar | 100 |  0  |   Y  |  N  |     |      中心名字     |
|  18 |   project\_dept\_id   |    int   |  10 |  0  |   Y  |  N  |     |      机构ID     |
|  19 |  project\_dept\_name  |  varchar | 100 |  0  |   Y  |  N  |     |   项目所属二级机构名称  |
|  20 |      project\_id      |  varchar | 100 |  0  |   Y  |  N  |     |      项目ID     |
|  21 |     project\_name     |  varchar | 100 |  0  |   Y  |  N  |     |      项目名称     |
|  22 |     project\_type     |    int   |  10 |  0  |   Y  |  N  |     |      项目类型     |
|  23 |        use\_bk        |    bit   |  1  |  0  |   Y  |  N  |     |     是否用蓝鲸     |

**表名：** role

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |      id      |    int   |  10 |  0  |   N  |  Y  |     | 主键ID |
|  2  |  description |  varchar | 255 |  0  |   Y  |  N  |     |  描述  |
|  3  |     name     |  varchar | 255 |  0  |   N  |  N  |     |  名称  |
|  4  |   ch\_name   |  varchar | 255 |  0  |   Y  |  N  |     |  分支名 |
|  5  | create\_time | datetime |  19 |  0  |   Y  |  N  |     | 创建时间 |
|  6  | modify\_time | datetime |  19 |  0  |   Y  |  N  |     | 修改时间 |

**表名：** role\_permission

**说明：**

**数据列：**

|  序号 |        名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |        id       |    int   |  10 |  0  |   N  |  Y  |     | 主键ID |
|  2  |   expire\_time  | datetime |  19 |  0  |   Y  |  N  |     | 过期时间 |
|  3  |     role\_id    |    int   |  10 |  0  |   Y  |  N  |     | 角色ID |
|  4  | url\_action\_id |    int   |  10 |  0  |   Y  |  N  |     |      |
|  5  |   create\_time  | datetime |  19 |  0  |   Y  |  N  |     | 创建时间 |
|  6  |   modify\_time  | datetime |  19 |  0  |   Y  |  N  |     | 修改时间 |

**表名：** schema\_version

**说明：**

**数据列：**

|  序号 |        名称       |    数据类型   |  长度  | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :-------------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :--: |
|  1  | installed\_rank |    int    |  10  |  0  |   N  |  Y  |                    |      |
|  2  |     version     |  varchar  |  50  |  0  |   Y  |  N  |                    |  版本号 |
|  3  |   description   |  varchar  |  200 |  0  |   N  |  N  |                    |  描述  |
|  4  |       type      |  varchar  |  20  |  0  |   N  |  N  |                    |  类型  |
|  5  |      script     |  varchar  | 1000 |  0  |   N  |  N  |                    | 打包脚本 |
|  6  |     checksum    |    int    |  10  |  0  |   Y  |  N  |                    |  校验和 |
|  7  |  installed\_by  |  varchar  |  100 |  0  |   N  |  N  |                    |  安装者 |
|  8  |  installed\_on  | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 安装时间 |
|  9  | execution\_time |    int    |  10  |  0  |   N  |  N  |                    | 执行时间 |
|  10 |     success     |    bit    |   1  |  0  |   N  |  N  |                    | 是否成功 |

**表名：** spring\_session

**说明：**

**数据列：**

|  序号 |            名称           |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |     说明    |
| :-: | :---------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :-------: |
|  1  |       SESSION\_ID       |   char  |  36 |  0  |   N  |  Y  |     | SESSIONID |
|  2  |      CREATION\_TIME     |  bigint |  20 |  0  |   N  |  N  |     |    创建时间   |
|  3  |    LAST\_ACCESS\_TIME   |  bigint |  20 |  0  |   N  |  N  |     |           |
|  4  | MAX\_INACTIVE\_INTERVAL |   int   |  10 |  0  |   N  |  N  |     |           |
|  5  |     PRINCIPAL\_NAME     | varchar | 100 |  0  |   Y  |  N  |     |           |

**表名：** SPRING\_SESSION\_ATTRIBUTES

**说明：**

**数据列：**

|  序号 |        名称        |   数据类型  |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |     说明    |
| :-: | :--------------: | :-----: | :---: | :-: | :--: | :-: | :-: | :-------: |
|  1  |    SESSION\_ID   |   char  |   36  |  0  |   N  |  Y  |     | SESSIONID |
|  2  |  ATTRIBUTE\_NAME | varchar |  200  |  0  |   N  |  Y  |     |    属性名称   |
|  3  | ATTRIBUTE\_BYTES |   blob  | 65535 |  0  |   Y  |  N  |     |    属性字节   |

**表名：** t\_user\_token

**说明：**

**数据列：**

|  序号 |             名称            |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |    说明   |
| :-: | :-----------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :-----: |
|  1  |          user\_Id         | varchar | 255 |  0  |   N  |  Y  |     |   用户ID  |
|  2  |       access\_Token       | varchar | 255 |  0  |   Y  |  N  |     | 权限Token |
|  3  |    expire\_Time\_Mills    |  bigint |  20 |  0  |   N  |  N  |     |   过期时间  |
|  4  | last\_Access\_Time\_Mills |  bigint |  20 |  0  |   N  |  N  |     |  最近鉴权时间 |
|  5  |       refresh\_Token      | varchar | 255 |  0  |   Y  |  N  |     | 刷新token |
|  6  |         user\_Type        | varchar | 255 |  0  |   Y  |  N  |     |   用户类型  |

**表名：** url\_action

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |      id      |    int   |  10 |  0  |   N  |  Y  |     |  主键ID |
|  2  |    action    |  varchar | 255 |  0  |   N  |  N  |     |   操作  |
|  3  |  description |  varchar | 255 |  0  |   Y  |  N  |     |   描述  |
|  4  |      url     |  varchar | 255 |  0  |   N  |  N  |     | url地址 |
|  5  | create\_time | datetime |  19 |  0  |   Y  |  N  |     |  创建时间 |
|  6  | modify\_time | datetime |  19 |  0  |   Y  |  N  |     |  修改时间 |

**表名：** user

**说明：**

**数据列：**

|  序号 |         名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |         id        |    int   |  10 |  0  |   N  |  Y  |     |  主键ID  |
|  2  |       chname      |  varchar | 255 |  0  |   Y  |  N  |     |        |
|  3  |    create\_time   | datetime |  19 |  0  |   Y  |  N  |     |  创建时间  |
|  4  |       email       |  varchar | 255 |  0  |   Y  |  N  |     |  email |
|  5  |        lang       |  varchar | 255 |  0  |   Y  |  N  |     |   语言   |
|  6  | last\_login\_time | datetime |  19 |  0  |   Y  |  N  |     | 最近登录时间 |
|  7  |       phone       |  varchar | 255 |  0  |   Y  |  N  |     |   电话   |
|  8  |      username     |  varchar | 255 |  0  |   N  |  N  |     |  用户名称  |

**表名：** user\_permission

**说明：**

**数据列：**

|  序号 |        名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |        id       |    int   |  10 |  0  |   N  |  Y  |     | 主键ID |
|  2  |   expire\_time  | datetime |  19 |  0  |   Y  |  N  |     | 过期时间 |
|  3  | url\_action\_id |    int   |  10 |  0  |   Y  |  N  |     |      |
|  4  |     user\_id    |    int   |  10 |  0  |   Y  |  N  |     | 用户ID |
|  5  |   create\_time  | datetime |  19 |  0  |   Y  |  N  |     | 创建时间 |
|  6  |   modify\_time  | datetime |  19 |  0  |   Y  |  N  |     | 修改时间 |

**表名：** user\_role

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |      id      |    int   |  10 |  0  |   N  |  Y  |     | 主键ID |
|  2  |   role\_id   |    int   |  10 |  0  |   Y  |  N  |     | 角色ID |
|  3  |   user\_id   |    int   |  10 |  0  |   Y  |  N  |     | 用户ID |
|  4  | expire\_time | datetime |  19 |  0  |   Y  |  N  |     | 过期时间 |
|  5  | create\_time | datetime |  19 |  0  |   Y  |  N  |     | 创建时间 |
|  6  | modify\_time | datetime |  19 |  0  |   Y  |  N  |     | 修改时间 |
