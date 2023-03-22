# devops\_ci\_auth

**数据库名：** devops\_ci\_auth

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_auth的数据库文档

|                          表名                         |         说明        |
| :-------------------------------------------------: | :---------------: |
|       [T\_AUTH\_GROUP\_INFO](broken-reference)      |       用户组信息表      |
|     [T\_AUTH\_GROUP\_PERSSION](broken-reference)    |                   |
|       [T\_AUTH\_GROUP\_USER](broken-reference)      |                   |
|      [T\_AUTH\_IAM\_CALLBACK](broken-reference)     |      IAM回调地址      |
|         [T\_AUTH\_MANAGER](broken-reference)        |       管理员策略表      |
|      [T\_AUTH\_MANAGER\_USER](broken-reference)     | 管理员用户表(只存有效期内的用户) |
| [T\_AUTH\_MANAGER\_USER\_HISTORY](broken-reference) |      管理员用户历史表     |
|   [T\_AUTH\_MANAGER\_WHITELIST](broken-reference)   |    管理员自助申请表名单表    |
|        [T\_AUTH\_STRATEGY](broken-reference)        |       权限策略表       |

**表名：** T\_AUTH\_GROUP\_INFO

**说明：** 用户组信息表

**数据列：**

|  序号 |       名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |  默认值 |       说明       |
| :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :--: | :------------: |
|  1  |       ID      |    int   |  10 |  0  |   N  |  Y  |      |      主健ID      |
|  2  |  GROUP\_NAME  |  varchar |  32 |  0  |   N  |  N  |  ""  |      用户组名称     |
|  3  |  GROUP\_CODE  |  varchar |  32 |  0  |   N  |  N  |      | 用户组标识默认用户组标识一致 |
|  4  |  GROUP\_TYPE  |    bit   |  1  |  0  |   N  |  N  |      |   用户组类型0默认分组   |
|  5  | PROJECT\_CODE |  varchar |  64 |  0  |   N  |  N  |  ""  |     用户组所属项目    |
|  6  |   IS\_DELETE  |    bit   |  1  |  0  |   N  |  N  | b'0' |   是否删除0可用1删除   |
|  7  |  CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |  ""  |       添加人      |
|  8  |  UPDATE\_USER |  varchar |  64 |  0  |   Y  |  N  |      |       修改人      |
|  9  |  CREATE\_TIME | datetime |  23 |  0  |   N  |  N  |      |      创建时间      |
|  10 |  UPDATE\_TIME | datetime |  23 |  0  |   Y  |  N  |      |      修改时间      |
|  11 | DISPLAY\_NAME |  varchar |  32 |  0  |   Y  |  N  |      |      用户组别名     |
|  12 |  RELATION\_ID |  varchar |  32 |  0  |   Y  |  N  |      |     关联系统ID     |

**表名：** T\_AUTH\_GROUP\_PERSSION

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |            说明            |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :----------------------: |
|  1  |      ID      |  varchar |  64 |  0  |   N  |  Y  |     |           主健ID           |
|  2  | AUTH\_ACTION |  varchar |  64 |  0  |   N  |  N  |  "" |           权限动作           |
|  3  |  GROUP\_CODE |  varchar |  64 |  0  |   N  |  N  |  "" | 用户组编号默认7个内置组编号固定自定义组编码随机 |
|  4  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |  "" |            创建人           |
|  5  | UPDATE\_USER |  varchar |  64 |  0  |   Y  |  N  |     |            修改人           |
|  6  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  |     |           创建时间           |
|  7  | UPDATE\_TIME | datetime |  23 |  0  |   Y  |  N  |     |           修改时间           |

**表名：** T\_AUTH\_GROUP\_USER

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |  varchar |  64 |  0  |   N  |  Y  |     |  主键ID |
|  2  |   USER\_ID   |  varchar |  64 |  0  |   N  |  N  |  "" |  用户ID |
|  3  |   GROUP\_ID  |  varchar |  64 |  0  |   N  |  N  |  "" | 用户组ID |
|  4  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |  "" |  添加用户 |
|  5  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  |     |  添加时间 |

**表名：** T\_AUTH\_IAM\_CALLBACK

**说明：** IAM回调地址

**数据列：**

|  序号 |      名称      |   数据类型  |  长度  | 小数位 | 允许空值 |  主键 |  默认值 |         说明        |
| :-: | :----------: | :-----: | :--: | :-: | :--: | :-: | :--: | :---------------: |
|  1  |      ID      |   int   |  10  |  0  |   N  |  Y  |      |        主键ID       |
|  2  |    GATEWAY   | varchar |  255 |  0  |   N  |  N  |  ""  |       目标服务网关      |
|  3  |     PATH     | varchar | 1024 |  0  |   N  |  N  |  ""  |       目标接口路径      |
|  4  | DELETE\_FLAG |   bit   |   1  |  0  |   Y  |  N  | b'0' | 是否删除true-是false-否 |
|  5  |   RESOURCE   | varchar |  32  |  0  |   N  |  N  |  ""  |        资源类型       |
|  6  |    SYSTEM    | varchar |  32  |  0  |   N  |  N  |  ""  |        接入系统       |

**表名：** T\_AUTH\_MANAGER

**说明：** 管理员策略表

**数据列：**

|  序号 |        名称        |    数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :--------------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |        ID        |    int    |  10 |  0  |   N  |  Y  |                    |  主键ID  |
|  2  |       NAME       |  varchar  |  32 |  0  |   N  |  N  |                    |   名称   |
|  3  | ORGANIZATION\_ID |    int    |  10 |  0  |   N  |  N  |                    |  组织ID  |
|  4  |       LEVEL      |    int    |  10 |  0  |   N  |  N  |                    |  层级ID  |
|  5  |    STRATEGYID    |    int    |  10 |  0  |   N  |  N  |                    | 权限策略ID |
|  6  |    IS\_DELETE    |    bit    |  1  |  0  |   N  |  N  |          0         |  是否删除  |
|  7  |   CREATE\_USER   |  varchar  |  11 |  0  |   N  |  N  |         ""         |  创建用户  |
|  8  |   UPDATE\_USER   |  varchar  |  11 |  0  |   Y  |  N  |         ""         |  修改用户  |
|  9  |   CREATE\_TIME   | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  10 |   UPDATE\_TIME   | timestamp |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |  修改时间  |

**表名：** T\_AUTH\_MANAGER\_USER

**说明：** 管理员用户表(只存有效期内的用户)

**数据列：**

|  序号 |      名称      |    数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |    说明    |
| :-: | :----------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :------: |
|  1  |      ID      |    int    |  10 |  0  |   N  |  Y  |                    |   主键ID   |
|  2  |   USER\_ID   |  varchar  |  64 |  0  |   N  |  N  |                    |   用户ID   |
|  3  |  MANAGER\_ID |    int    |  10 |  0  |   N  |  N  |                    |  管理员权限ID |
|  4  |  START\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 权限生效起始时间 |
|  5  |   END\_TIME  | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 权限生效结束时间 |
|  6  | CREATE\_USER |  varchar  |  64 |  0  |   N  |  N  |                    |   创建用户   |
|  7  | UPDATE\_USER |  varchar  |  64 |  0  |   Y  |  N  |                    |   修改用户   |
|  8  | CREATE\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   创建时间   |
|  9  | UPDATE\_TIME | timestamp |  19 |  0  |   Y  |  N  |                    |   修改时间   |

**表名：** T\_AUTH\_MANAGER\_USER\_HISTORY

**说明：** 管理员用户历史表

**数据列：**

|  序号 |      名称      |    数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |    说明    |
| :-: | :----------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :------: |
|  1  |      ID      |    int    |  10 |  0  |   N  |  Y  |                    |   主键ID   |
|  2  |   USER\_ID   |  varchar  |  64 |  0  |   N  |  N  |                    |   用户ID   |
|  3  |  MANAGER\_ID |    int    |  10 |  0  |   N  |  N  |                    |  管理员权限ID |
|  4  |  START\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 权限生效起始时间 |
|  5  |   END\_TIME  | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 权限生效结束时间 |
|  6  | CREATE\_USER |  varchar  |  64 |  0  |   N  |  N  |                    |   创建用户   |
|  7  | UPDATE\_USER |  varchar  |  64 |  0  |   Y  |  N  |                    |   修改用户   |
|  8  | CREATE\_TIME | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   创建时间   |
|  9  | UPDATE\_TIME | timestamp |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |   修改时间   |

**表名：** T\_AUTH\_MANAGER\_WHITELIST

**说明：** 管理员自助申请表名单表

**数据列：**

|  序号 |      名称     |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |      ID     |   int   |  10 |  0  |   N  |  Y  |     |  主键ID  |
|  2  | MANAGER\_ID |   int   |  10 |  0  |   N  |  N  |     | 管理策略ID |
|  3  |   USER\_ID  | varchar |  64 |  0  |   N  |  N  |     |  用户ID  |

**表名：** T\_AUTH\_STRATEGY

**说明：** 权限策略表

**数据列：**

|  序号 |       名称       |    数据类型   |  长度  | 小数位 | 允许空值 |  主键 |         默认值        |      说明     |
| :-: | :------------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :---------: |
|  1  |       ID       |    int    |  10  |  0  |   N  |  Y  |                    |    策略主键ID   |
|  2  | STRATEGY\_NAME |  varchar  |  32  |  0  |   N  |  N  |                    |     策略名称    |
|  3  | STRATEGY\_BODY |  varchar  | 2000 |  0  |   N  |  N  |                    |     策略内容    |
|  4  |   IS\_DELETE   |    bit    |   1  |  0  |   N  |  N  |          0         | 是否删除0未删除1删除 |
|  5  |  CREATE\_TIME  | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |     创建时间    |
|  6  |  UPDATE\_TIME  | timestamp |  19  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |     修改时间    |
|  7  |  CREATE\_USER  |  varchar  |  32  |  0  |   N  |  N  |                    |     创建人     |
|  8  |  UPDATE\_USER  |  varchar  |  32  |  0  |   Y  |  N  |                    |     修改人     |
