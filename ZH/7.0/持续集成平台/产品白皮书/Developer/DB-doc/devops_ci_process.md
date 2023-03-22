# devops\_ci\_process

**数据库名：** devops\_ci\_process

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_process的数据库文档

|                              表名                              |      说明      |
| :----------------------------------------------------------: | :----------: |
|            [T\_AUDIT\_RESOURCE](broken-reference)            |              |
|         [T\_BUILD\_STARTUP\_PARAM](broken-reference)         |   流水线启动变量表   |
|                [T\_METADATA](broken-reference)               |              |
|     [T\_PIPELINE\_ATOM\_REPLACE\_BASE](broken-reference)     | 流水线插件替换基本信息表 |
|    [T\_PIPELINE\_ATOM\_REPLACE\_HISTORY](broken-reference)   | 流水线插件替换历史信息表 |
|     [T\_PIPELINE\_ATOM\_REPLACE\_ITEM](broken-reference)     |  流水线插件替换项信息表 |
|       [T\_PIPELINE\_BUILD\_CONTAINER](broken-reference)      |  流水线构建容器环境表  |
|        [T\_PIPELINE\_BUILD\_DETAIL](broken-reference)        |   流水线构建详情表   |
|        [T\_PIPELINE\_BUILD\_HISTORY](broken-reference)       |   流水线构建历史表   |
|   [T\_PIPELINE\_BUILD\_HIS\_DATA\_CLEAR](broken-reference)   | 流水线构建数据清理统计表 |
|         [T\_PIPELINE\_BUILD\_STAGE](broken-reference)        |   流水线构建阶段表   |
|        [T\_PIPELINE\_BUILD\_SUMMARY](broken-reference)       |   流水线构建摘要表   |
|         [T\_PIPELINE\_BUILD\_TASK](broken-reference)         |   流水线构建任务表   |
|          [T\_PIPELINE\_BUILD\_VAR](broken-reference)         |    流水线变量表    |
|      [T\_PIPELINE\_CONTAINER\_MONITOR](broken-reference)     |              |
|         [T\_PIPELINE\_DATA\_CLEAR](broken-reference)         |  流水线数据清理统计表  |
|    [T\_PIPELINE\_FAILURE\_NOTIFY\_USER](broken-reference)    |              |
|            [T\_PIPELINE\_FAVOR](broken-reference)            |    流水线收藏表    |
|            [T\_PIPELINE\_GROUP](broken-reference)            |    流水线分组表    |
|             [T\_PIPELINE\_INFO](broken-reference)            |    流水线信息表    |
|      [T\_PIPELINE\_JOB\_MUTEX\_GROUP](broken-reference)      |              |
|            [T\_PIPELINE\_LABEL](broken-reference)            |    流水线标签表    |
|       [T\_PIPELINE\_LABEL\_PIPELINE](broken-reference)       |   流水线-标签映射表  |
|         [T\_PIPELINE\_MODEL\_TASK](broken-reference)         | 流水线模型task任务表 |
|         [T\_PIPELINE\_MUTEX\_GROUP](broken-reference)        |    流水线互斥表    |
|         [T\_PIPELINE\_PAUSE\_VALUE](broken-reference)        |   流水线暂停变量表   |
|         [T\_PIPELINE\_REMOTE\_AUTH](broken-reference)        | 流水线远程触发auth表 |
|           [T\_PIPELINE\_RESOURCE](broken-reference)          |    流水线资源表    |
|      [T\_PIPELINE\_RESOURCE\_VERSION](broken-reference)      |   流水线资源版本表   |
|             [T\_PIPELINE\_RULE](broken-reference)            |   流水线规则信息表   |
|           [T\_PIPELINE\_SETTING](broken-reference)           |   流水线基础配置表   |
|       [T\_PIPELINE\_SETTING\_VERSION](broken-reference)      |  流水线基础配置版本表  |
|          [T\_PIPELINE\_STAGE\_TAG](broken-reference)         |              |
|           [T\_PIPELINE\_TEMPLATE](broken-reference)          |    流水线模板表    |
|            [T\_PIPELINE\_TIMER](broken-reference)            |              |
|             [T\_PIPELINE\_USER](broken-reference)            |              |
|             [T\_PIPELINE\_VIEW](broken-reference)            |              |
|         [T\_PIPELINE\_VIEW\_LABEL](broken-reference)         |              |
|        [T\_PIPELINE\_VIEW\_PROJECT](broken-reference)        |              |
|    [T\_PIPELINE\_VIEW\_USER\_LAST\_VIEW](broken-reference)   |              |
|     [T\_PIPELINE\_VIEW\_USER\_SETTINGS](broken-reference)    |              |
|           [T\_PIPELINE\_WEBHOOK](broken-reference)           |              |
|     [T\_PIPELINE\_WEBHOOK\_BUILD\_LOG](broken-reference)     |              |
| [T\_PIPELINE\_WEBHOOK\_BUILD\_LOG\_DETAIL](broken-reference) |              |
|        [T\_PIPELINE\_WEBHOOK\_QUEUE](broken-reference)       |              |
|      [T\_PROJECT\_PIPELINE\_CALLBACK](broken-reference)      |              |
|  [T\_PROJECT\_PIPELINE\_CALLBACK\_HISTORY](broken-reference) |              |
|                 [T\_REPORT](broken-reference)                |    流水线产物表    |
|                [T\_TEMPLATE](broken-reference)               |   流水线模板信息表   |
|        [T\_TEMPLATE\_INSTANCE\_BASE](broken-reference)       |  模板实列化基本信息表  |
|        [T\_TEMPLATE\_INSTANCE\_ITEM](broken-reference)       |   模板实列化项信息表  |
|           [T\_TEMPLATE\_PIPELINE](broken-reference)          |  流水线模板-实例映射表 |

**表名：** T\_AUDIT\_RESOURCE

**说明：**

**数据列：**

|  序号 |        名称       |    数据类型   |  长度  | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :-------------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :--: |
|  1  |        ID       |   bigint  |  20  |  0  |   N  |  Y  |                    | 主键ID |
|  2  |  RESOURCE\_TYPE |  varchar  |  32  |  0  |   N  |  N  |                    | 资源类型 |
|  3  |   RESOURCE\_ID  |  varchar  |  128 |  0  |   N  |  N  |                    | 资源ID |
|  4  |  RESOURCE\_NAME |  varchar  |  128 |  0  |   N  |  N  |                    | 资源名称 |
|  5  |     USER\_ID    |  varchar  |  64  |  0  |   N  |  N  |                    | 用户ID |
|  6  |      ACTION     |  varchar  |  64  |  0  |   N  |  N  |                    |  操作  |
|  7  | ACTION\_CONTENT |  varchar  | 1024 |  0  |   N  |  N  |                    | 操作内容 |
|  8  |  CREATED\_TIME  | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 创建时间 |
|  9  |      STATUS     |  varchar  |  32  |  0  |   Y  |  N  |                    |  状态  |
|  10 |   PROJECT\_ID   |  varchar  |  128 |  0  |   N  |  N  |                    | 项目ID |

**表名：** T\_BUILD\_STARTUP\_PARAM

**说明：** 流水线启动变量表

**数据列：**

|  序号 |      名称      |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |   bigint   |    20    |  0  |   N  |  Y  |     |  主键ID |
|  2  |   BUILD\_ID  |   varchar  |    64    |  0  |   N  |  N  |     |  构建ID |
|  3  |     PARAM    | mediumtext | 16777215 |  0  |   N  |  N  |     |   参数  |
|  4  |  PROJECT\_ID |   varchar  |    64    |  0  |   Y  |  N  |     |  项目ID |
|  5  | PIPELINE\_ID |   varchar  |    64    |  0  |   Y  |  N  |     | 流水线ID |

**表名：** T\_METADATA

**说明：**

**数据列：**

|  序号 |         名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |         ID        |  bigint  |  20 |  0  |   N  |  Y  |                    |  主键ID |
|  2  |    PROJECT\_ID    |  varchar |  32 |  0  |   N  |  N  |                    |  项目ID |
|  3  |    PIPELINE\_ID   |  varchar |  34 |  0  |   N  |  N  |                    | 流水线ID |
|  4  |     BUILD\_ID     |  varchar |  34 |  0  |   N  |  N  |                    |  构建ID |
|  5  |   META\_DATA\_ID  |  varchar | 128 |  0  |   N  |  N  |                    | 元数据ID |
|  6  | META\_DATA\_VALUE |  varchar | 255 |  0  |   N  |  N  |                    |  元数据值 |
|  7  |    CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间 |

**表名：** T\_PIPELINE\_ATOM\_REPLACE\_BASE

**说明：** 流水线插件替换基本信息表

**数据列：**

|  序号 |         名称         |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |          默认值          |    说明   |
| :-: | :----------------: | :------: | :---: | :-: | :--: | :-: | :-------------------: | :-----: |
|  1  |         ID         |  varchar |   32  |  0  |   N  |  Y  |                       |   主键ID  |
|  2  |     PROJECT\_ID    |  varchar |   64  |  0  |   Y  |  N  |                       |   项目ID  |
|  3  | PIPELINE\_ID\_INFO |   text   | 65535 |  0  |   Y  |  N  |                       | 流水线ID信息 |
|  4  |  FROM\_ATOM\_CODE  |  varchar |   64  |  0  |   N  |  N  |                       | 被替换插件代码 |
|  5  |   TO\_ATOM\_CODE   |  varchar |   64  |  0  |   N  |  N  |                       | 被替换插件代码 |
|  6  |       STATUS       |  varchar |   32  |  0  |   N  |  N  |          INIT         |    状态   |
|  7  |       CREATOR      |  varchar |   50  |  0  |   N  |  N  |         system        |   创建者   |
|  8  |      MODIFIER      |  varchar |   50  |  0  |   N  |  N  |         system        |   修改者   |
|  9  |    UPDATE\_TIME    | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   修改时间  |
|  10 |    CREATE\_TIME    | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   创建时间  |

**表名：** T\_PIPELINE\_ATOM\_REPLACE\_HISTORY

**说明：** 流水线插件替换历史信息表

**数据列：**

|  序号 |        名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |          默认值          |     说明     |
| :-: | :-------------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :--------: |
|  1  |        ID       |  varchar |  32 |  0  |   N  |  Y  |                       |    主键ID    |
|  2  |   PROJECT\_ID   |  varchar |  64 |  0  |   Y  |  N  |                       |    项目ID    |
|  3  |     BUS\_ID     |  varchar |  34 |  0  |   N  |  N  |                       |    业务ID    |
|  4  |    BUS\_TYPE    |  varchar |  32 |  0  |   N  |  N  |        PIPELINE       |    业务类型    |
|  5  | SOURCE\_VERSION |    int   |  10 |  0  |   N  |  N  |                       |    源版本号    |
|  6  | TARGET\_VERSION |    int   |  10 |  0  |   Y  |  N  |                       |    目标版本号   |
|  7  |      STATUS     |  varchar |  32 |  0  |   N  |  N  |                       |     状态     |
|  8  |       LOG       |  varchar | 128 |  0  |   Y  |  N  |                       |     日志     |
|  9  |     BASE\_ID    |  varchar |  32 |  0  |   N  |  N  |                       | 插件替换基本信息ID |
|  10 |     ITEM\_ID    |  varchar |  32 |  0  |   N  |  N  |                       |  插件替换项信息ID |
|  11 |     CREATOR     |  varchar |  50 |  0  |   N  |  N  |         system        |     创建者    |
|  12 |     MODIFIER    |  varchar |  50 |  0  |   N  |  N  |         system        |     修改者    |
|  13 |   UPDATE\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    修改时间    |
|  14 |   CREATE\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    创建时间    |

**表名：** T\_PIPELINE\_ATOM\_REPLACE\_ITEM

**说明：** 流水线插件替换项信息表

**数据列：**

|  序号 |          名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |          默认值          |     说明     |
| :-: | :------------------: | :------: | :---: | :-: | :--: | :-: | :-------------------: | :--------: |
|  1  |          ID          |  varchar |   32  |  0  |   N  |  Y  |                       |    主键ID    |
|  2  |   FROM\_ATOM\_CODE   |  varchar |   64  |  0  |   N  |  N  |                       |   被替换插件代码  |
|  3  |  FROM\_ATOM\_VERSION |  varchar |   20  |  0  |   N  |  N  |                       |  被替换插件版本号  |
|  4  |    TO\_ATOM\_CODE    |  varchar |   64  |  0  |   N  |  N  |                       |   替换插件代码   |
|  5  |   TO\_ATOM\_VERSION  |  varchar |   20  |  0  |   N  |  N  |                       |   替换插件版本号  |
|  6  |        STATUS        |  varchar |   32  |  0  |   N  |  N  |          INIT         |     状态     |
|  7  | PARAM\_REPLACE\_INFO |   text   | 65535 |  0  |   Y  |  N  |                       |  插件参数替换信息  |
|  8  |       BASE\_ID       |  varchar |   32  |  0  |   N  |  N  |                       | 插件替换基本信息ID |
|  9  |        CREATOR       |  varchar |   50  |  0  |   N  |  N  |         system        |     创建者    |
|  10 |       MODIFIER       |  varchar |   50  |  0  |   N  |  N  |         system        |     修改者    |
|  11 |     UPDATE\_TIME     | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    修改时间    |
|  12 |     CREATE\_TIME     | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    创建时间    |

**表名：** T\_PIPELINE\_BUILD\_CONTAINER

**说明：** 流水线构建容器环境表

**数据列：**

|  序号 |        名称       |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :-------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |   PROJECT\_ID   |   varchar  |    64    |  0  |   N  |  N  |                    |    项目ID   |
|  2  |   PIPELINE\_ID  |   varchar  |    64    |  0  |   N  |  N  |                    |   流水线ID   |
|  3  |    BUILD\_ID    |   varchar  |    64    |  0  |   N  |  Y  |                    |    构建ID   |
|  4  |    STAGE\_ID    |   varchar  |    64    |  0  |   N  |  Y  |                    | 当前stageId |
|  5  |  CONTAINER\_ID  |   varchar  |    64    |  0  |   N  |  Y  |                    |   构建容器ID  |
|  6  | CONTAINER\_TYPE |   varchar  |    45    |  0  |   Y  |  N  |                    |    容器类型   |
|  7  |       SEQ       |     int    |    10    |  0  |   N  |  N  |                    |           |
|  8  |      STATUS     |     int    |    10    |  0  |   Y  |  N  |                    |     状态    |
|  9  |   START\_TIME   |  timestamp |    19    |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |    开始时间   |
|  10 |    END\_TIME    |  timestamp |    19    |  0  |   Y  |  N  |                    |    结束时间   |
|  11 |       COST      |     int    |    10    |  0  |   Y  |  N  |          0         |     花费    |
|  12 |  EXECUTE\_COUNT |     int    |    10    |  0  |   Y  |  N  |          1         |    执行次数   |
|  13 |    CONDITIONS   | mediumtext | 16777215 |  0  |   Y  |  N  |                    |     状况    |

**表名：** T\_PIPELINE\_BUILD\_DETAIL

**说明：** 流水线构建详情表

**数据列：**

|  序号 |      名称      |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :-: | :---: |
|  1  |  PROJECT\_ID |   varchar  |    64    |  0  |   N  |  N  |     |       |
|  2  |   BUILD\_ID  |   varchar  |    34    |  0  |   N  |  Y  |     |  构建ID |
|  3  |  BUILD\_NUM  |     int    |    10    |  0  |   Y  |  N  |     |  构建次数 |
|  4  |     MODEL    | mediumtext | 16777215 |  0  |   Y  |  N  |     | 流水线模型 |
|  5  |  START\_USER |   varchar  |    32    |  0  |   Y  |  N  |     |  启动者  |
|  6  |    TRIGGER   |   varchar  |    32    |  0  |   Y  |  N  |     |  触发器  |
|  7  |  START\_TIME |  datetime  |    19    |  0  |   Y  |  N  |     |  开始时间 |
|  8  |   END\_TIME  |  datetime  |    19    |  0  |   Y  |  N  |     |  结束时间 |
|  9  |    STATUS    |   varchar  |    32    |  0  |   Y  |  N  |     |   状态  |
|  10 | CANCEL\_USER |   varchar  |    32    |  0  |   Y  |  N  |     |  取消者  |

**表名：** T\_PIPELINE\_BUILD\_HISTORY

**说明：** 流水线构建历史表

**数据列：**

|  序号 |         名称         |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |  默认值 |     说明    |
| :-: | :----------------: | :--------: | :------: | :-: | :--: | :-: | :--: | :-------: |
|  1  |      BUILD\_ID     |   varchar  |    34    |  0  |   N  |  Y  |      |    构建ID   |
|  2  |  PARENT\_BUILD\_ID |   varchar  |    34    |  0  |   Y  |  N  |      |   父级构建ID  |
|  3  |  PARENT\_TASK\_ID  |   varchar  |    34    |  0  |   Y  |  N  |      |   父级任务ID  |
|  4  |     BUILD\_NUM     |     int    |    10    |  0  |   Y  |  N  |   0  |    构建次数   |
|  5  |     PROJECT\_ID    |   varchar  |    64    |  0  |   N  |  N  |      |    项目ID   |
|  6  |    PIPELINE\_ID    |   varchar  |    34    |  0  |   N  |  N  |      |   流水线ID   |
|  7  |       VERSION      |     int    |    10    |  0  |   Y  |  N  |      |    版本号    |
|  8  |     START\_USER    |   varchar  |    64    |  0  |   Y  |  N  |      |    启动者    |
|  9  |       TRIGGER      |   varchar  |    32    |  0  |   N  |  N  |      |    触发器    |
|  10 |     START\_TIME    |  timestamp |    19    |  0  |   Y  |  N  |      |    开始时间   |
|  11 |      END\_TIME     |  timestamp |    19    |  0  |   Y  |  N  |      |    结束时间   |
|  12 |       STATUS       |     int    |    10    |  0  |   Y  |  N  |      |     状态    |
|  13 |    STAGE\_STATUS   |    text    |   65535  |  0  |   Y  |  N  |      |  流水线各阶段状态 |
|  14 |     TASK\_COUNT    |     int    |    10    |  0  |   Y  |  N  |      |  流水线任务数量  |
|  15 |   FIRST\_TASK\_ID  |   varchar  |    34    |  0  |   Y  |  N  |      |   首次任务id  |
|  16 |       CHANNEL      |   varchar  |    32    |  0  |   Y  |  N  |      |    项目渠道   |
|  17 |    TRIGGER\_USER   |   varchar  |    64    |  0  |   Y  |  N  |      |    触发者    |
|  18 |      MATERIAL      | mediumtext | 16777215 |  0  |   Y  |  N  |      |    原材料    |
|  19 |     QUEUE\_TIME    |  timestamp |    19    |  0  |   Y  |  N  |      |   排队开始时间  |
|  20 |   ARTIFACT\_INFO   | mediumtext | 16777215 |  0  |   Y  |  N  |      |   构件列表信息  |
|  21 |       REMARK       |   varchar  |   4096   |  0  |   Y  |  N  |      |     评论    |
|  22 |    EXECUTE\_TIME   |   bigint   |    20    |  0  |   Y  |  N  |      |    执行时间   |
|  23 |  BUILD\_PARAMETERS | mediumtext | 16777215 |  0  |   Y  |  N  |      |   构建环境参数  |
|  24 |    WEBHOOK\_TYPE   |   varchar  |    64    |  0  |   Y  |  N  |      | WEBHOOK类型 |
|  25 | RECOMMEND\_VERSION |   varchar  |    64    |  0  |   Y  |  N  |      |   推荐版本号   |
|  26 |     ERROR\_TYPE    |     int    |    10    |  0  |   Y  |  N  |      |    错误类型   |
|  27 |     ERROR\_CODE    |     int    |    10    |  0  |   Y  |  N  |      |    错误码    |
|  28 |     ERROR\_MSG     |    text    |   65535  |  0  |   Y  |  N  |      |    错误描述   |
|  29 |    WEBHOOK\_INFO   |    text    |   65535  |  0  |   Y  |  N  |      | WEBHOOK信息 |
|  30 |      IS\_RETRY     |     bit    |     1    |  0  |   Y  |  N  | b'0' |    是否重试   |
|  31 |     ERROR\_INFO    |    text    |   65535  |  0  |   Y  |  N  |      |    错误信息   |
|  32 |     BUILD\_MSG     |   varchar  |    255   |  0  |   Y  |  N  |      |    构建信息   |
|  33 |  BUILD\_NUM\_ALIAS |   varchar  |    256   |  0  |   Y  |  N  |      |   自定义构建号  |

**表名：** T\_PIPELINE\_BUILD\_HIS\_DATA\_CLEAR

**说明：** 流水线构建数据清理统计表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |          默认值          |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :---: |
|  1  |   BUILD\_ID  |  varchar |  34 |  0  |   N  |  Y  |                       |  构建ID |
|  2  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                       | 流水线ID |
|  3  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |                       |  项目ID |
|  4  |   DEL\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |       |

**表名：** T\_PIPELINE\_BUILD\_STAGE

**说明：** 流水线构建阶段表

**数据列：**

|  序号 |       名称       |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |   PROJECT\_ID  |   varchar  |    64    |  0  |   N  |  N  |                    |    项目ID   |
|  2  |  PIPELINE\_ID  |   varchar  |    64    |  0  |   N  |  N  |                    |   流水线ID   |
|  3  |    BUILD\_ID   |   varchar  |    64    |  0  |   N  |  Y  |                    |    构建ID   |
|  4  |    STAGE\_ID   |   varchar  |    64    |  0  |   N  |  Y  |                    | 当前stageId |
|  5  |       SEQ      |     int    |    10    |  0  |   N  |  N  |                    |           |
|  6  |     STATUS     |     int    |    10    |  0  |   Y  |  N  |                    |     状态    |
|  7  |   START\_TIME  |  timestamp |    19    |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |    开始时间   |
|  8  |    END\_TIME   |  timestamp |    19    |  0  |   Y  |  N  |                    |    结束时间   |
|  9  |      COST      |     int    |    10    |  0  |   Y  |  N  |          0         |     花费    |
|  10 | EXECUTE\_COUNT |     int    |    10    |  0  |   Y  |  N  |          1         |    执行次数   |
|  11 |   CONDITIONS   | mediumtext | 16777215 |  0  |   Y  |  N  |                    |     状况    |
|  12 |    CHECK\_IN   | mediumtext | 16777215 |  0  |   Y  |  N  |                    |   准入检查配置  |
|  13 |   CHECK\_OUT   | mediumtext | 16777215 |  0  |   Y  |  N  |                    |   准出检查配置  |

**表名：** T\_PIPELINE\_BUILD\_SUMMARY

**说明：** 流水线构建摘要表

**数据列：**

|  序号 |          名称         |    数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :-----------------: | :-------: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |     PIPELINE\_ID    |  varchar  |  34 |  0  |   N  |  Y  |     |  流水线ID |
|  2  |     PROJECT\_ID     |  varchar  |  64 |  0  |   N  |  N  |     |  项目ID  |
|  3  |      BUILD\_NUM     |    int    |  10 |  0  |   Y  |  N  |  0  |  构建次数  |
|  4  |      BUILD\_NO      |    int    |  10 |  0  |   Y  |  N  |  0  |   构建号  |
|  5  |    FINISH\_COUNT    |    int    |  10 |  0  |   Y  |  N  |  0  |  完成次数  |
|  6  |    RUNNING\_COUNT   |    int    |  10 |  0  |   Y  |  N  |  0  |  运行次数  |
|  7  |     QUEUE\_COUNT    |    int    |  10 |  0  |   Y  |  N  |  0  |  排队次数  |
|  8  |  LATEST\_BUILD\_ID  |  varchar  |  34 |  0  |   Y  |  N  |     | 最近构建ID |
|  9  |   LATEST\_TASK\_ID  |  varchar  |  34 |  0  |   Y  |  N  |     | 最近任务ID |
|  10 | LATEST\_START\_USER |  varchar  |  64 |  0  |   Y  |  N  |     |  最近启动者 |
|  11 | LATEST\_START\_TIME | timestamp |  19 |  0  |   Y  |  N  |     | 最近启动时间 |
|  12 |  LATEST\_END\_TIME  | timestamp |  19 |  0  |   Y  |  N  |     | 最近结束时间 |
|  13 | LATEST\_TASK\_COUNT |    int    |  10 |  0  |   Y  |  N  |     | 最近任务计数 |
|  14 |  LATEST\_TASK\_NAME |  varchar  | 128 |  0  |   Y  |  N  |     | 最近任务名称 |
|  15 |    LATEST\_STATUS   |    int    |  10 |  0  |   Y  |  N  |     |  最近状态  |
|  16 |  BUILD\_NUM\_ALIAS  |  varchar  | 256 |  0  |   Y  |  N  |     | 自定义构建号 |

**表名：** T\_PIPELINE\_BUILD\_TASK

**说明：** 流水线构建任务表

**数据列：**

|  序号 |          名称         |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 | 默认值 |     说明    |
| :-: | :-----------------: | :--------: | :------: | :-: | :--: | :-: | :-: | :-------: |
|  1  |     PIPELINE\_ID    |   varchar  |    34    |  0  |   N  |  N  |     |   流水线ID   |
|  2  |     PROJECT\_ID     |   varchar  |    64    |  0  |   N  |  N  |     |    项目ID   |
|  3  |      BUILD\_ID      |   varchar  |    34    |  0  |   N  |  Y  |     |    构建ID   |
|  4  |      STAGE\_ID      |   varchar  |    34    |  0  |   N  |  N  |     | 当前stageId |
|  5  |    CONTAINER\_ID    |   varchar  |    34    |  0  |   N  |  N  |     |   构建容器ID  |
|  6  |      TASK\_NAME     |   varchar  |    128   |  0  |   Y  |  N  |     |    任务名称   |
|  7  |       TASK\_ID      |   varchar  |    34    |  0  |   N  |  Y  |     |    任务ID   |
|  8  |     TASK\_PARAMS    | mediumtext | 16777215 |  0  |   Y  |  N  |     |   任务参数集合  |
|  9  |      TASK\_TYPE     |   varchar  |    64    |  0  |   N  |  N  |     |    任务类型   |
|  10 |      TASK\_ATOM     |   varchar  |    128   |  0  |   Y  |  N  |     |  任务atom代码 |
|  11 |      ATOM\_CODE     |   varchar  |    128   |  0  |   Y  |  N  |     |  插件的唯一标识  |
|  12 |     START\_TIME     |  timestamp |    19    |  0  |   Y  |  N  |     |    开始时间   |
|  13 |      END\_TIME      |  timestamp |    19    |  0  |   Y  |  N  |     |    结束时间   |
|  14 |       STARTER       |   varchar  |    64    |  0  |   N  |  N  |     |    执行人    |
|  15 |       APPROVER      |   varchar  |    64    |  0  |   Y  |  N  |     |    批准人    |
|  16 |        STATUS       |     int    |    10    |  0  |   Y  |  N  |     |     状态    |
|  17 |    EXECUTE\_COUNT   |     int    |    10    |  0  |   Y  |  N  |  0  |    执行次数   |
|  18 |      TASK\_SEQ      |     int    |    10    |  0  |   Y  |  N  |  1  |    任务序列   |
|  19 |   SUB\_PROJECT\_ID  |   varchar  |    64    |  0  |   Y  |  N  |     |   子项目id   |
|  20 |    SUB\_BUILD\_ID   |   varchar  |    34    |  0  |   Y  |  N  |     |   子构建id   |
|  21 |   CONTAINER\_TYPE   |   varchar  |    45    |  0  |   Y  |  N  |     |    容器类型   |
|  22 | ADDITIONAL\_OPTIONS | mediumtext | 16777215 |  0  |   Y  |  N  |     |    其他选项   |
|  23 |     TOTAL\_TIME     |   bigint   |    20    |  0  |   Y  |  N  |     |    总共时间   |
|  24 |     ERROR\_TYPE     |     int    |    10    |  0  |   Y  |  N  |     |    错误类型   |
|  25 |     ERROR\_CODE     |     int    |    10    |  0  |   Y  |  N  |     |    错误码    |
|  26 |      ERROR\_MSG     |    text    |   65535  |  0  |   Y  |  N  |     |    错误描述   |
|  27 | CONTAINER\_HASH\_ID |   varchar  |    64    |  0  |   Y  |  N  |     | 构建Job唯一标识 |

**表名：** T\_PIPELINE\_BUILD\_VAR

**说明：** 流水线变量表

**数据列：**

|  序号 |      名称      |   数据类型  |  长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :-----: | :--: | :-: | :--: | :-: | :-: | :---: |
|  1  |   BUILD\_ID  | varchar |  34  |  0  |   N  |  Y  |     |  构建ID |
|  2  |      KEY     | varchar |  255 |  0  |   N  |  Y  |     |   键   |
|  3  |     VALUE    | varchar | 4000 |  0  |   Y  |  N  |     |   值   |
|  4  |  PROJECT\_ID | varchar |  64  |  0  |   Y  |  N  |     |  项目ID |
|  5  | PIPELINE\_ID | varchar |  64  |  0  |   Y  |  N  |     | 流水线ID |
|  6  |   VAR\_TYPE  | varchar |  64  |  0  |   Y  |  N  |     |  变量类型 |
|  7  |  READ\_ONLY  |   bit   |   1  |  0  |   Y  |  N  |     |  是否只读 |

**表名：** T\_PIPELINE\_CONTAINER\_MONITOR

**说明：**

**数据列：**

|  序号 |         名称         |   数据类型  |  长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :----------------: | :-----: | :--: | :-: | :--: | :-: | :-: | :----: |
|  1  |         ID         |  bigint |  20  |  0  |   N  |  Y  |     |  主键ID  |
|  2  |      OS\_TYPE      | varchar |  32  |  0  |   N  |  N  |     |  系统类型  |
|  3  |     BUILD\_TYPE    | varchar |  32  |  0  |   N  |  N  |     |  构建类型  |
|  4  | MAX\_STARTUP\_TIME |  bigint |  20  |  0  |   N  |  N  |     | 最长启动时间 |
|  5  | MAX\_EXECUTE\_TIME |  bigint |  20  |  0  |   N  |  N  |     | 最长执行时间 |
|  6  |        USERS       | varchar | 1024 |  0  |   N  |  N  |     |  用户列表  |

**表名：** T\_PIPELINE\_DATA\_CLEAR

**说明：** 流水线数据清理统计表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |          默认值          |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :---: |
|  1  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  Y  |                       | 流水线ID |
|  2  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |                       |  项目ID |
|  3  |   DEL\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |       |

**表名：** T\_PIPELINE\_FAILURE\_NOTIFY\_USER

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-----------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |       ID      |  bigint |  20 |  0  |   N  |  Y  |     | 主键ID |
|  2  |    USER\_ID   | varchar |  32 |  0  |   Y  |  N  |     | 用户ID |
|  3  | NOTIFY\_TYPES | varchar |  32 |  0  |   Y  |  N  |     | 通知类型 |

**表名：** T\_PIPELINE\_FAVOR

**说明：** 流水线收藏表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID |
|  2  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     |  项目ID |
|  3  | PIPELINE\_ID |  varchar |  64 |  0  |   N  |  N  |     | 流水线ID |
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  创建时间 |
|  5  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  创建者  |

**表名：** T\_PIPELINE\_GROUP

**说明：** 流水线分组表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     | 主键ID |
|  2  |  PROJECT\_ID |  varchar |  32 |  0  |   N  |  N  |     | 项目ID |
|  3  |     NAME     |  varchar |  64 |  0  |   N  |  N  |     |  名称  |
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | 创建时间 |
|  5  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | 更新时间 |
|  6  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  创建者 |
|  7  | UPDATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  修改人 |

**表名：** T\_PIPELINE\_INFO

**说明：** 流水线信息表

**数据列：**

|  序号 |           名称           |    数据类型   |  长度  | 小数位 | 允许空值 |  主键 |         默认值        |    说明   |
| :-: | :--------------------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :-----: |
|  1  |      PIPELINE\_ID      |  varchar  |  34  |  0  |   N  |  Y  |                    |  流水线ID  |
|  2  |       PROJECT\_ID      |  varchar  |  64  |  0  |   N  |  N  |                    |   项目ID  |
|  3  |     PIPELINE\_NAME     |  varchar  |  255 |  0  |   N  |  N  |                    |  流水线名称  |
|  4  |     PIPELINE\_DESC     |  varchar  |  255 |  0  |   Y  |  N  |                    |  流水线描述  |
|  5  |         VERSION        |    int    |  10  |  0  |   Y  |  N  |          1         |   版本号   |
|  6  |      CREATE\_TIME      | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   创建时间  |
|  7  |         CREATOR        |  varchar  |  64  |  0  |   N  |  N  |                    |   创建者   |
|  8  |      UPDATE\_TIME      | timestamp |  19  |  0  |   Y  |  N  |                    |   更新时间  |
|  9  |   LAST\_MODIFY\_USER   |  varchar  |  64  |  0  |   N  |  N  |                    |  最近修改者  |
|  10 |         CHANNEL        |  varchar  |  32  |  0  |   Y  |  N  |                    |   项目渠道  |
|  11 |     MANUAL\_STARTUP    |    int    |  10  |  0  |   Y  |  N  |          1         |  是否手工启动 |
|  12 |      ELEMENT\_SKIP     |    int    |  10  |  0  |   Y  |  N  |          0         |  是否跳过插件 |
|  13 |       TASK\_COUNT      |    int    |  10  |  0  |   Y  |  N  |          0         | 流水线任务数量 |
|  14 |         DELETE         |    bit    |   1  |  0  |   Y  |  N  |        b'0'        |   是否删除  |
|  15 |           ID           |   bigint  |  20  |  0  |   N  |  N  |                    |   主键ID  |
|  16 | PIPELINE\_NAME\_PINYIN |  varchar  | 1300 |  0  |   Y  |  N  |                    | 流水线名称拼音 |

**表名：** T\_PIPELINE\_JOB\_MUTEX\_GROUP

**说明：**

**数据列：**

|  序号 |            名称           |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |    说明    |
| :-: | :---------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :------: |
|  1  |       PROJECT\_ID       | varchar |  64 |  0  |   N  |  Y  |     |   项目ID   |
|  2  | JOB\_MUTEX\_GROUP\_NAME | varchar | 127 |  0  |   N  |  Y  |     | Job互斥组名字 |

**表名：** T\_PIPELINE\_LABEL

**说明：** 流水线标签表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID |
|  2  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     |  项目ID |
|  3  |   GROUP\_ID  |  bigint  |  20 |  0  |   N  |  N  |     | 用户组ID |
|  4  |     NAME     |  varchar |  64 |  0  |   N  |  N  |     |   名称  |
|  5  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  创建时间 |
|  6  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  更新时间 |
|  7  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  创建者  |
|  8  | UPDATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  修改人  |

**表名：** T\_PIPELINE\_LABEL\_PIPELINE

**说明：** 流水线-标签映射表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID |
|  2  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     |  项目ID |
|  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |     | 流水线ID |
|  4  |   LABEL\_ID  |  bigint  |  20 |  0  |   N  |  N  |     |  标签ID |
|  5  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  创建时间 |
|  6  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  创建者  |

**表名：** T\_PIPELINE\_MODEL\_TASK

**说明：** 流水线模型task任务表

**数据列：**

|  序号 |          名称         |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 | 默认值 |     说明    |
| :-: | :-----------------: | :--------: | :------: | :-: | :--: | :-: | :-: | :-------: |
|  1  |     PIPELINE\_ID    |   varchar  |    64    |  0  |   N  |  Y  |     |   流水线ID   |
|  2  |     PROJECT\_ID     |   varchar  |    64    |  0  |   N  |  Y  |     |    项目ID   |
|  3  |      STAGE\_ID      |   varchar  |    64    |  0  |   N  |  Y  |     | 当前stageId |
|  4  |    CONTAINER\_ID    |   varchar  |    64    |  0  |   N  |  Y  |     |   构建容器ID  |
|  5  |       TASK\_ID      |   varchar  |    64    |  0  |   N  |  Y  |     |    任务ID   |
|  6  |      TASK\_NAME     |   varchar  |    128   |  0  |   Y  |  N  |     |    任务名称   |
|  7  |     CLASS\_TYPE     |   varchar  |    64    |  0  |   N  |  N  |     |    插件大类   |
|  8  |      TASK\_ATOM     |   varchar  |    128   |  0  |   Y  |  N  |     |  任务atom代码 |
|  9  |      TASK\_SEQ      |     int    |    10    |  0  |   Y  |  N  |  1  |    任务序列   |
|  10 |     TASK\_PARAMS    | mediumtext | 16777215 |  0  |   Y  |  N  |     |   任务参数集合  |
|  11 |          OS         |   varchar  |    45    |  0  |   Y  |  N  |     |    操作系统   |
|  12 | ADDITIONAL\_OPTIONS | mediumtext | 16777215 |  0  |   Y  |  N  |     |    其他选项   |
|  13 |      ATOM\_CODE     |   varchar  |    32    |  0  |   N  |  N  |     |  插件的唯一标识  |
|  14 |    ATOM\_VERSION    |   varchar  |    20    |  0  |   Y  |  N  |     |   插件版本号   |
|  15 |     CREATE\_TIME    |  datetime  |    23    |  0  |   Y  |  N  |     |    创建时间   |
|  16 |     UPDATE\_TIME    |  datetime  |    23    |  0  |   Y  |  N  |     |    更新时间   |

**表名：** T\_PIPELINE\_MUTEX\_GROUP

**说明：** 流水线互斥表

**数据列：**

|  序号 |      名称     |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  | PROJECT\_ID | varchar |  64 |  0  |   N  |  Y  |     |  项目ID |
|  2  | GROUP\_NAME | varchar | 127 |  0  |   N  |  Y  |     | 用户组名称 |

**表名：** T\_PIPELINE\_PAUSE\_VALUE

**说明：** 流水线暂停变量表

**数据列：**

|  序号 |       名称       |    数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |     说明     |
| :-: | :------------: | :-------: | :---: | :-: | :--: | :-: | :-: | :--------: |
|  1  |   PROJECT\_ID  |  varchar  |   64  |  0  |   N  |  N  |     |            |
|  2  |    BUILD\_ID   |  varchar  |   34  |  0  |   N  |  Y  |     |    构建ID    |
|  3  |    TASK\_ID    |  varchar  |   34  |  0  |   N  |  Y  |     |    任务ID    |
|  4  | DEFAULT\_VALUE |    text   | 65535 |  0  |   Y  |  N  |     |    默认变量    |
|  5  |   NEW\_VALUE   |    text   | 65535 |  0  |   Y  |  N  |     | 暂停后用户提供的变量 |
|  6  |  CREATE\_TIME  | timestamp |   19  |  0  |   Y  |  N  |     |    添加时间    |

**表名：** T\_PIPELINE\_REMOTE\_AUTH

**说明：** 流水线远程触发auth表

**数据列：**

|  序号 |       名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |  PIPELINE\_ID  |  varchar |  34 |  0  |   N  |  Y  |     | 流水线ID |
|  2  | PIPELINE\_AUTH |  varchar |  32 |  0  |   N  |  N  |     | 流水线权限 |
|  3  |   PROJECT\_ID  |  varchar |  32 |  0  |   N  |  N  |     |  项目ID |
|  4  |  CREATE\_TIME  | datetime |  19 |  0  |   N  |  N  |     |  创建时间 |
|  5  |  CREATE\_USER  |  varchar |  64 |  0  |   N  |  N  |     |  创建者  |

**表名：** T\_PIPELINE\_RESOURCE

**说明：** 流水线资源表

**数据列：**

|  序号 |      名称      |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |  PROJECT\_ID |   varchar  |    64    |  0  |   N  |  N  |                    |  项目ID |
|  2  | PIPELINE\_ID |   varchar  |    34    |  0  |   N  |  Y  |                    | 流水线ID |
|  3  |    VERSION   |     int    |    10    |  0  |   N  |  Y  |          1         |  版本号  |
|  4  |     MODEL    | mediumtext | 16777215 |  0  |   Y  |  N  |                    | 流水线模型 |
|  5  |    CREATOR   |   varchar  |    64    |  0  |   Y  |  N  |                    |  创建者  |
|  6  | CREATE\_TIME |  timestamp |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间 |

**表名：** T\_PIPELINE\_RESOURCE\_VERSION

**说明：** 流水线资源版本表

**数据列：**

|  序号 |       名称      |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :-----------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |  PROJECT\_ID  |   varchar  |    64    |  0  |   N  |  N  |                    |  项目ID |
|  2  |  PIPELINE\_ID |   varchar  |    34    |  0  |   N  |  Y  |                    | 流水线ID |
|  3  |    VERSION    |     int    |    10    |  0  |   N  |  Y  |          1         |  版本号  |
|  4  | VERSION\_NAME |   varchar  |    64    |  0  |   N  |  N  |                    |  版本名称 |
|  5  |     MODEL     | mediumtext | 16777215 |  0  |   Y  |  N  |                    | 流水线模型 |
|  6  |    CREATOR    |   varchar  |    64    |  0  |   Y  |  N  |                    |  创建者  |
|  7  |  CREATE\_TIME |  timestamp |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间 |

**表名：** T\_PIPELINE\_RULE

**说明：** 流水线规则信息表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |          默认值          |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :--: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                       | 主键ID |
|  2  |  RULE\_NAME  |  varchar | 256 |  0  |   N  |  N  |                       | 规则名称 |
|  3  |   BUS\_CODE  |  varchar | 128 |  0  |   N  |  N  |                       | 业务标识 |
|  4  |   PROCESSOR  |  varchar | 128 |  0  |   N  |  N  |                       |  处理器 |
|  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |         system        |  创建者 |
|  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |         system        |  修改者 |
|  7  | UPDATE\_TIME | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) | 修改时间 |
|  8  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) | 创建时间 |

**表名：** T\_PIPELINE\_SETTING

**说明：** 流水线基础配置表

**数据列：**

|  序号 |                   名称                   |    数据类型    |     长度     | 小数位 | 允许空值 |  主键 |  默认值 |            说明            |
| :-: | :------------------------------------: | :--------: | :--------: | :-: | :--: | :-: | :--: | :----------------------: |
|  1  |              PIPELINE\_ID              |   varchar  |     34     |  0  |   N  |  Y  |      |           流水线ID          |
|  2  |                  DESC                  |   varchar  |    1024    |  0  |   Y  |  N  |      |            描述            |
|  3  |                RUN\_TYPE               |     int    |     10     |  0  |   Y  |  N  |      |                          |
|  4  |                  NAME                  |   varchar  |     255    |  0  |   Y  |  N  |      |            名称            |
|  5  |            SUCCESS\_RECEIVER           | mediumtext |  16777215  |  0  |   Y  |  N  |      |           成功接受者          |
|  6  |             FAIL\_RECEIVER             | mediumtext |  16777215  |  0  |   Y  |  N  |      |           失败接受者          |
|  7  |             SUCCESS\_GROUP             | mediumtext |  16777215  |  0  |   Y  |  N  |      |            成功组           |
|  8  |               FAIL\_GROUP              | mediumtext |  16777215  |  0  |   Y  |  N  |      |            失败组           |
|  9  |              SUCCESS\_TYPE             |   varchar  |     32     |  0  |   Y  |  N  |      |          成功的通知方式         |
|  10 |               FAIL\_TYPE               |   varchar  |     32     |  0  |   Y  |  N  |      |          失败的通知方式         |
|  11 |               PROJECT\_ID              |   varchar  |     64     |  0  |   Y  |  N  |      |           项目ID           |
|  12 |      SUCCESS\_WECHAT\_GROUP\_FLAG      |     bit    |      1     |  0  |   N  |  N  | b'0' |       成功的企业微信群通知开关       |
|  13 |         SUCCESS\_WECHAT\_GROUP         |   varchar  |    1024    |  0  |   N  |  N  |      |       成功的企业微信群通知群ID      |
|  14 |        FAIL\_WECHAT\_GROUP\_FLAG       |     bit    |      1     |  0  |   N  |  N  | b'0' |       失败的企业微信群通知开关       |
|  15 |           FAIL\_WECHAT\_GROUP          |   varchar  |    1024    |  0  |   N  |  N  |      |       失败的企业微信群通知群ID      |
|  16 |             RUN\_LOCK\_TYPE            |     int    |     10     |  0  |   Y  |  N  |   1  |          Lock类型          |
|  17 |          SUCCESS\_DETAIL\_FLAG         |     bit    |      1     |  0  |   Y  |  N  | b'0' |      成功的通知的流水线详情连接开关     |
|  18 |           FAIL\_DETAIL\_FLAG           |     bit    |      1     |  0  |   Y  |  N  | b'0' |      失败的通知的流水线详情连接开关     |
|  19 |            SUCCESS\_CONTENT            |  longtext  | 2147483647 |  0  |   Y  |  N  |      |        成功的自定义通知内容        |
|  20 |              FAIL\_CONTENT             |  longtext  | 2147483647 |  0  |   Y  |  N  |      |        失败的自定义通知内容        |
|  21 |        WAIT\_QUEUE\_TIME\_SECOND       |     int    |     10     |  0  |   Y  |  N  | 7200 |          最大排队时长          |
|  22 |            MAX\_QUEUE\_SIZE            |     int    |     10     |  0  |   Y  |  N  |  10  |          最大排队数量          |
|  23 |              IS\_TEMPLATE              |     bit    |      1     |  0  |   Y  |  N  | b'0' |           是否模板           |
|  24 | SUCCESS\_WECHAT\_GROUP\_MARKDOWN\_FLAG |     bit    |      1     |  0  |   N  |  N  | b'0' | 成功的企业微信群通知转为Markdown格式开关 |
|  25 |   FAIL\_WECHAT\_GROUP\_MARKDOWN\_FLAG  |     bit    |      1     |  0  |   N  |  N  | b'0' | 失败的企业微信群通知转为Markdown格式开关 |
|  26 |         MAX\_PIPELINE\_RES\_NUM        |     int    |     10     |  0  |   Y  |  N  |  500 |       保存流水线编排的最大个数       |
|  27 |     MAX\_CON\_RUNNING\_QUEUE\_SIZE     |     int    |     10     |  0  |   Y  |  N  |  50  |         并发构建数量限制         |
|  28 |            BUILD\_NUM\_RULE            |   varchar  |     512    |  0  |   Y  |  N  |      |          构建号生成规则         |

**表名：** T\_PIPELINE\_SETTING\_VERSION

**说明：** 流水线基础配置版本表

**数据列：**

|  序号 |                   名称                   |    数据类型    |     长度     | 小数位 | 允许空值 |  主键 |  默认值 |            说明            |
| :-: | :------------------------------------: | :--------: | :--------: | :-: | :--: | :-: | :--: | :----------------------: |
|  1  |                   ID                   |   bigint   |     20     |  0  |   N  |  Y  |      |           主键ID           |
|  2  |              PIPELINE\_ID              |   varchar  |     34     |  0  |   N  |  N  |      |           流水线ID          |
|  3  |            SUCCESS\_RECEIVER           | mediumtext |  16777215  |  0  |   Y  |  N  |      |           成功接受者          |
|  4  |             FAIL\_RECEIVER             | mediumtext |  16777215  |  0  |   Y  |  N  |      |           失败接受者          |
|  5  |             SUCCESS\_GROUP             | mediumtext |  16777215  |  0  |   Y  |  N  |      |            成功组           |
|  6  |               FAIL\_GROUP              | mediumtext |  16777215  |  0  |   Y  |  N  |      |            失败组           |
|  7  |              SUCCESS\_TYPE             |   varchar  |     32     |  0  |   Y  |  N  |      |          成功的通知方式         |
|  8  |               FAIL\_TYPE               |   varchar  |     32     |  0  |   Y  |  N  |      |          失败的通知方式         |
|  9  |               PROJECT\_ID              |   varchar  |     64     |  0  |   Y  |  N  |      |           项目ID           |
|  10 |      SUCCESS\_WECHAT\_GROUP\_FLAG      |     bit    |      1     |  0  |   N  |  N  | b'0' |       成功的企业微信群通知开关       |
|  11 |         SUCCESS\_WECHAT\_GROUP         |   varchar  |    1024    |  0  |   N  |  N  |      |       成功的企业微信群通知群ID      |
|  12 |        FAIL\_WECHAT\_GROUP\_FLAG       |     bit    |      1     |  0  |   N  |  N  | b'0' |       失败的企业微信群通知开关       |
|  13 |           FAIL\_WECHAT\_GROUP          |   varchar  |    1024    |  0  |   N  |  N  |      |       失败的企业微信群通知群ID      |
|  14 |          SUCCESS\_DETAIL\_FLAG         |     bit    |      1     |  0  |   Y  |  N  | b'0' |      成功的通知的流水线详情连接开关     |
|  15 |           FAIL\_DETAIL\_FLAG           |     bit    |      1     |  0  |   Y  |  N  | b'0' |      失败的通知的流水线详情连接开关     |
|  16 |            SUCCESS\_CONTENT            |  longtext  | 2147483647 |  0  |   Y  |  N  |      |        成功的自定义通知内容        |
|  17 |              FAIL\_CONTENT             |  longtext  | 2147483647 |  0  |   Y  |  N  |      |        失败的自定义通知内容        |
|  18 |              IS\_TEMPLATE              |     bit    |      1     |  0  |   Y  |  N  | b'0' |           是否模板           |
|  19 |                 VERSION                |     int    |     10     |  0  |   N  |  N  |   1  |            版本号           |
|  20 | SUCCESS\_WECHAT\_GROUP\_MARKDOWN\_FLAG |     bit    |      1     |  0  |   N  |  N  | b'0' | 成功的企业微信群通知转为Markdown格式开关 |
|  21 |   FAIL\_WECHAT\_GROUP\_MARKDOWN\_FLAG  |     bit    |      1     |  0  |   N  |  N  | b'0' | 失败的企业微信群通知转为Markdown格式开关 |

**表名：** T\_PIPELINE\_STAGE\_TAG

**说明：**

**数据列：**

|  序号 |        名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |        ID        |  varchar |  32 |  0  |   N  |  Y  |                    |   主键   |
|  2  | STAGE\_TAG\_NAME |  varchar |  45 |  0  |   N  |  N  |                    | 阶段标签名称 |
|  3  |      WEIGHT      |    int   |  10 |  0  |   N  |  N  |          0         | 阶段标签权值 |
|  4  |      CREATOR     |  varchar |  50 |  0  |   N  |  N  |       system       |   创建人  |
|  5  |     MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |  最近修改人 |
|  6  |   CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  7  |   UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  修改时间  |

**表名：** T\_PIPELINE\_TEMPLATE

**说明：** 流水线模板表

**数据列：**

|  序号 |         名称        |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :---------------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |         ID        |   bigint   |    20    |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |        TYPE       |   varchar  |    32    |  0  |   N  |  N  |       FREEDOM      |     类型    |
|  3  |      CATEGORY     |   varchar  |    128   |  0  |   Y  |  N  |                    |    应用范畴   |
|  4  |   TEMPLATE\_NAME  |   varchar  |    64    |  0  |   N  |  N  |                    |    模板名称   |
|  5  |        ICON       |   varchar  |    32    |  0  |   N  |  N  |                    |    模板图标   |
|  6  |     LOGO\_URL     |   varchar  |    512   |  0  |   Y  |  N  |                    | LOGOURL地址 |
|  7  |   PROJECT\_CODE   |   varchar  |    32    |  0  |   Y  |  N  |                    |  用户组所属项目  |
|  8  | SRC\_TEMPLATE\_ID |   varchar  |    32    |  0  |   Y  |  N  |                    |   源模版ID   |
|  9  |       AUTHOR      |   varchar  |    64    |  0  |   N  |  N  |                    |     作者    |
|  10 |      ATOMNUM      |     int    |    10    |  0  |   N  |  N  |                    |    插件数量   |
|  11 |    PUBLIC\_FLAG   |     bit    |     1    |  0  |   N  |  N  |        b'0'        |  是否为公共镜像  |
|  12 |      TEMPLATE     | mediumtext | 16777215 |  0  |   Y  |  N  |                    |     模板    |
|  13 |      CREATOR      |   varchar  |    32    |  0  |   N  |  N  |                    |    创建者    |
|  14 |    CREATE\_TIME   |  datetime  |    19    |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |    创建时间   |

**表名：** T\_PIPELINE\_TIMER

**说明：**

**数据列：**

|  序号 |      名称      |    数据类型   |  长度  | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :----------: | :-------: | :--: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |  PROJECT\_ID |  varchar  |  32  |  0  |   N  |  Y  |                    |  项目ID |
|  2  | PIPELINE\_ID |  varchar  |  34  |  0  |   N  |  Y  |                    | 流水线ID |
|  3  |    CRONTAB   |  varchar  | 2048 |  0  |   N  |  N  |                    |  任务ID |
|  4  |    CREATOR   |  varchar  |  64  |  0  |   N  |  N  |                    |  创建者  |
|  5  | CREATE\_TIME | timestamp |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间 |
|  6  |    CHANNEL   |  varchar  |  32  |  0  |   N  |  N  |         BS         |  项目渠道 |

**表名：** T\_PIPELINE\_USER

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID |
|  2  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |     | 流水线ID |
|  3  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  创建时间 |
|  4  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  更新时间 |
|  5  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  创建者  |
|  6  | UPDATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  修改人  |

**表名：** T\_PIPELINE\_VIEW

**说明：**

**数据列：**

|  序号 |             名称            |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |  默认值 |    说明    |
| :-: | :-----------------------: | :--------: | :------: | :-: | :--: | :-: | :--: | :------: |
|  1  |             ID            |   bigint   |    20    |  0  |   N  |  Y  |      |   主键ID   |
|  2  |        PROJECT\_ID        |   varchar  |    32    |  0  |   N  |  N  |      |   项目ID   |
|  3  |            NAME           |   varchar  |    64    |  0  |   N  |  N  |      |    名称    |
|  4  | FILTER\_BY\_PIPEINE\_NAME |   varchar  |    128   |  0  |   Y  |  N  |      | 流水线名称过滤器 |
|  5  |    FILTER\_BY\_CREATOR    |   varchar  |    64    |  0  |   Y  |  N  |      |  创建者过滤器  |
|  6  |        CREATE\_TIME       |  datetime  |    19    |  0  |   N  |  N  |      |   创建时间   |
|  7  |        UPDATE\_TIME       |  datetime  |    19    |  0  |   N  |  N  |      |   更新时间   |
|  8  |        CREATE\_USER       |   varchar  |    64    |  0  |   N  |  N  |      |    创建者   |
|  9  |        IS\_PROJECT        |     bit    |     1    |  0  |   Y  |  N  | b'0' |   是否项目   |
|  10 |           LOGIC           |   varchar  |    32    |  0  |   Y  |  N  |  AND |    逻辑符   |
|  11 |          FILTERS          | mediumtext | 16777215 |  0  |   Y  |  N  |      |    过滤器   |

**表名：** T\_PIPELINE\_VIEW\_LABEL

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     | 项目ID |
|  2  |   VIEW\_ID   |  bigint  |  20 |  0  |   N  |  Y  |     | 视图ID |
|  3  |   LABEL\_ID  |  bigint  |  20 |  0  |   N  |  Y  |     | 标签ID |
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | 创建时间 |

**表名：** T\_PIPELINE\_VIEW\_PROJECT

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     | 主键ID |
|  2  |   VIEW\_ID   |  bigint  |  20 |  0  |   N  |  N  |     | 视图ID |
|  3  |  PROJECT\_ID |  varchar |  32 |  0  |   N  |  N  |     | 项目ID |
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | 创建时间 |
|  5  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | 更新时间 |
|  6  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |  创建者 |

**表名：** T\_PIPELINE\_VIEW\_USER\_LAST\_VIEW

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: |
|  1  |   USER\_ID   |  varchar |  32 |  0  |   N  |  Y  |                    | 用户ID |
|  2  |  PROJECT\_ID |  varchar |  32 |  0  |   N  |  Y  |                    | 项目ID |
|  3  |   VIEW\_ID   |  varchar |  64 |  0  |   N  |  N  |                    | 视图ID |
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |                    | 创建时间 |
|  5  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 更新时间 |

**表名：** T\_PIPELINE\_VIEW\_USER\_SETTINGS

**说明：**

**数据列：**

|  序号 |      名称      |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |   USER\_ID   |   varchar  |    255   |  0  |   N  |  Y  |                    |  用户ID |
|  2  |  PROJECT\_ID |   varchar  |    32    |  0  |   N  |  Y  |                    |  项目ID |
|  3  |   SETTINGS   | mediumtext | 16777215 |  0  |   N  |  N  |                    | 属性配置表 |
|  4  | CREATE\_TIME |  datetime  |    19    |  0  |   N  |  N  |                    |  创建时间 |
|  5  | UPDATE\_TIME |  datetime  |    19    |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间 |

**表名：** T\_PIPELINE\_WEBHOOK

**说明：**

**数据列：**

|  序号 |        名称        |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 |  默认值 |      说明     |
| :-: | :--------------: | :-----: | :-: | :-: | :--: | :-: | :--: | :---------: |
|  1  | REPOSITORY\_TYPE | varchar |  64 |  0  |   N  |  N  |      | 新版的git插件的类型 |
|  2  |    PROJECT\_ID   | varchar |  32 |  0  |   N  |  N  |      |     项目ID    |
|  3  |   PIPELINE\_ID   | varchar |  34 |  0  |   N  |  N  |      |    流水线ID    |
|  4  |  REPO\_HASH\_ID  | varchar |  45 |  0  |   Y  |  N  |      |  存储库HASHID  |
|  5  |        ID        |  bigint |  20 |  0  |   N  |  Y  |      |     主键ID    |
|  6  |    REPO\_NAME    | varchar | 128 |  0  |   Y  |  N  |      |    代码库别名    |
|  7  |    REPO\_TYPE    | varchar |  32 |  0  |   Y  |  N  |      |    代码库类型    |
|  8  |   PROJECT\_NAME  | varchar | 128 |  0  |   Y  |  N  |      |     项目名称    |
|  9  |     TASK\_ID     | varchar |  34 |  0  |   Y  |  N  |      |     任务id    |
|  10 |      DELETE      |   bit   |  1  |  0  |   Y  |  N  | b'0' |     是否删除    |

**表名：** T\_PIPELINE\_WEBHOOK\_BUILD\_LOG

**说明：**

**数据列：**

|  序号 |        名称        |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :--------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |        ID        |  bigint  |   20  |  0  |   N  |  Y  |                    |  主键ID  |
|  2  |    CODE\_TYPE    |  varchar |   32  |  0  |   N  |  N  |                    |  代码库类型 |
|  3  |    REPO\_NAME    |  varchar |  128  |  0  |   N  |  N  |                    |  代码库别名 |
|  4  |    COMMIT\_ID    |  varchar |   64  |  0  |   N  |  N  |                    | 代码提交ID |
|  5  | REQUEST\_CONTENT |   text   | 65535 |  0  |   Y  |  N  |                    |  事件内容  |
|  6  |   CREATED\_TIME  | datetime |   19  |  0  |   N  |  Y  | CURRENT\_TIMESTAMP |  创建时间  |
|  7  |  RECEIVED\_TIME  | datetime |   19  |  0  |   N  |  N  |                    |  接收时间  |
|  8  |  FINISHED\_TIME  | datetime |   19  |  0  |   N  |  N  |                    |  完成时间  |

**表名：** T\_PIPELINE\_WEBHOOK\_BUILD\_LOG\_DETAIL

**说明：**

**数据列：**

|  序号 |        名称       |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |        ID       |  bigint  |   20  |  0  |   N  |  Y  |                    |  主键ID  |
|  2  |     LOG\_ID     |  bigint  |   20  |  0  |   N  |  N  |                    |        |
|  3  |    CODE\_TYPE   |  varchar |   32  |  0  |   N  |  N  |                    |  代码库类型 |
|  4  |    REPO\_NAME   |  varchar |  128  |  0  |   N  |  N  |                    |  代码库别名 |
|  5  |    COMMIT\_ID   |  varchar |   64  |  0  |   N  |  N  |                    | 代码提交ID |
|  6  |   PROJECT\_ID   |  varchar |   32  |  0  |   N  |  N  |                    |  项目ID  |
|  7  |   PIPELINE\_ID  |  varchar |   34  |  0  |   N  |  N  |                    |  流水线ID |
|  8  |     TASK\_ID    |  varchar |   34  |  0  |   N  |  N  |                    |  任务id  |
|  9  |    TASK\_NAME   |  varchar |  128  |  0  |   Y  |  N  |                    |  任务名称  |
|  10 |     SUCCESS     |    bit   |   1   |  0  |   Y  |  N  |        b'0'        |  是否成功  |
|  11 | TRIGGER\_RESULT |   text   | 65535 |  0  |   Y  |  N  |                    |  触发结果  |
|  12 |  CREATED\_TIME  | datetime |   19  |  0  |   N  |  Y  | CURRENT\_TIMESTAMP |  创建时间  |

**表名：** T\_PIPELINE\_WEBHOOK\_QUEUE

**说明：**

**数据列：**

|  序号 |          名称         |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |    说明   |
| :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: |
|  1  |          ID         |  bigint  |  20 |  0  |   N  |  Y  |                    |   主键ID  |
|  2  |     PROJECT\_ID     |  varchar |  64 |  0  |   N  |  N  |                    |   项目ID  |
|  3  |     PIPELINE\_ID    |  varchar |  64 |  0  |   N  |  N  |                    |  流水线ID  |
|  4  | SOURCE\_PROJECT\_ID |  bigint  |  20 |  0  |   N  |  N  |                    |  源项目ID  |
|  5  |  SOURCE\_REPO\_NAME |  varchar | 255 |  0  |   N  |  N  |                    |  源代码库名称 |
|  6  |    SOURCE\_BRANCH   |  varchar | 255 |  0  |   N  |  N  |                    |   源分支   |
|  7  | TARGET\_PROJECT\_ID |  bigint  |  20 |  0  |   Y  |  N  |                    |  目标项目ID |
|  8  |  TARGET\_REPO\_NAME |  varchar | 255 |  0  |   Y  |  N  |                    | 目标代码库名称 |
|  9  |    TARGET\_BRANCH   |  varchar | 255 |  0  |   Y  |  N  |                    |   目标分支  |
|  10 |      BUILD\_ID      |  varchar |  34 |  0  |   N  |  N  |                    |   构建ID  |
|  11 |     CREATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   创建时间  |

**表名：** T\_PROJECT\_PIPELINE\_CALLBACK

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |  默认值 |                        说明                       |
| :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :--: | :---------------------------------------------: |
|  1  |       ID      |  bigint  |   20  |  0  |   N  |  Y  |      |                       主键ID                      |
|  2  |  PROJECT\_ID  |  varchar |   64  |  0  |   N  |  N  |      |                       项目ID                      |
|  3  |     EVENTS    |  varchar |  255  |  0  |   Y  |  N  |      |                        事件                       |
|  4  | CALLBACK\_URL |  varchar |  255  |  0  |   N  |  N  |      |                     回调url地址                     |
|  5  |    CREATOR    |  varchar |   64  |  0  |   N  |  N  |      |                       创建者                       |
|  6  |    UPDATOR    |  varchar |   64  |  0  |   N  |  N  |      |                       更新人                       |
|  7  | CREATED\_TIME | datetime |   19  |  0  |   N  |  N  |      |                       创建时间                      |
|  8  | UPDATED\_TIME | datetime |   19  |  0  |   N  |  N  |      |                       更新时间                      |
|  9  | SECRET\_TOKEN |   text   | 65535 |  0  |   Y  |  N  |      | Sendtoyourwithhttpheader:X-DEVOPS-WEBHOOK-TOKEN |
|  10 |     ENABLE    |    bit   |   1   |  0  |   N  |  N  | b'1' |                        启用                       |

**表名：** T\_PROJECT\_PIPELINE\_CALLBACK\_HISTORY

**说明：**

**数据列：**

|  序号 |        名称       |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |    说明   |
| :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :-: | :-----: |
|  1  |        ID       |  bigint  |   20  |  0  |   N  |  Y  |     |   主键ID  |
|  2  |   PROJECT\_ID   |  varchar |   64  |  0  |   N  |  N  |     |   项目ID  |
|  3  |      EVENTS     |  varchar |  255  |  0  |   Y  |  N  |     |    事件   |
|  4  |  CALLBACK\_URL  |  varchar |  255  |  0  |   N  |  N  |     | 回调url地址 |
|  5  |      STATUS     |  varchar |   20  |  0  |   N  |  N  |     |    状态   |
|  6  |    ERROR\_MSG   |   text   | 65535 |  0  |   Y  |  N  |     |   错误描述  |
|  7  | REQUEST\_HEADER |   text   | 65535 |  0  |   Y  |  N  |     |   请求头   |
|  8  |  REQUEST\_BODY  |   text   | 65535 |  0  |   N  |  N  |     |  请求body |
|  9  |  RESPONSE\_CODE |    int   |   10  |  0  |   Y  |  N  |     |  响应code |
|  10 |  RESPONSE\_BODY |   text   | 65535 |  0  |   Y  |  N  |     |  响应body |
|  11 |   START\_TIME   | datetime |   19  |  0  |   N  |  N  |     |   开始时间  |
|  12 |    END\_TIME    | datetime |   19  |  0  |   N  |  N  |     |   结束时间  |
|  13 |  CREATED\_TIME  | datetime |   19  |  0  |   N  |  Y  |     |   创建时间  |

**表名：** T\_REPORT

**说明：** 流水线产物表

**数据列：**

|  序号 |      名称      |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |    默认值   |   说明  |
| :-: | :----------: | :--------: | :------: | :-: | :--: | :-: | :------: | :---: |
|  1  |      ID      |   bigint   |    20    |  0  |   N  |  Y  |          |  主键ID |
|  2  |  PROJECT\_ID |   varchar  |    32    |  0  |   N  |  N  |          |  项目ID |
|  3  | PIPELINE\_ID |   varchar  |    34    |  0  |   N  |  N  |          | 流水线ID |
|  4  |   BUILD\_ID  |   varchar  |    34    |  0  |   N  |  N  |          |  构建ID |
|  5  |  ELEMENT\_ID |   varchar  |    34    |  0  |   N  |  N  |          |  原子ID |
|  6  |     TYPE     |   varchar  |    32    |  0  |   N  |  N  | INTERNAL |   类型  |
|  7  |  INDEX\_FILE | mediumtext | 16777215 |  0  |   N  |  N  |          |  入口文件 |
|  8  |     NAME     |    text    |   65535  |  0  |   N  |  N  |          |   名称  |
|  9  | CREATE\_TIME |  datetime  |    19    |  0  |   N  |  N  |          |  创建时间 |
|  10 | UPDATE\_TIME |  datetime  |    19    |  0  |   N  |  N  |          |  更新时间 |

**表名：** T\_TEMPLATE

**说明：** 流水线模板信息表

**数据列：**

|  序号 |         名称        |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |    默认值    |      说明     |
| :-: | :---------------: | :--------: | :------: | :-: | :--: | :-: | :-------: | :---------: |
|  1  |      VERSION      |   bigint   |    20    |  0  |   N  |  Y  |           |     主键ID    |
|  2  |         ID        |   varchar  |    32    |  0  |   N  |  N  |           |     主键ID    |
|  3  |   TEMPLATE\_NAME  |   varchar  |    64    |  0  |   N  |  N  |           |     模板名称    |
|  4  |    PROJECT\_ID    |   varchar  |    34    |  0  |   N  |  N  |           |     项目ID    |
|  5  |   VERSION\_NAME   |   varchar  |    64    |  0  |   N  |  N  |           |     版本名称    |
|  6  |      CREATOR      |   varchar  |    64    |  0  |   N  |  N  |           |     创建者     |
|  7  |   CREATED\_TIME   |  datetime  |    19    |  0  |   Y  |  N  |           |     创建时间    |
|  8  |      TEMPLATE     | mediumtext | 16777215 |  0  |   Y  |  N  |           |      模板     |
|  9  |        TYPE       |   varchar  |    32    |  0  |   N  |  N  | CUSTOMIZE |      类型     |
|  10 |      CATEGORY     |   varchar  |    128   |  0  |   Y  |  N  |           |     应用范畴    |
|  11 |     LOGO\_URL     |   varchar  |    512   |  0  |   Y  |  N  |           |  LOGOURL地址  |
|  12 | SRC\_TEMPLATE\_ID |   varchar  |    32    |  0  |   Y  |  N  |           |    源模版ID    |
|  13 |    STORE\_FLAG    |     bit    |     1    |  0  |   Y  |  N  |    b'0'   | 是否已关联到store |
|  14 |       WEIGHT      |     int    |    10    |  0  |   Y  |  N  |     0     |      权值     |

**表名：** T\_TEMPLATE\_INSTANCE\_BASE

**说明：** 模板实列化基本信息表

**数据列：**

|  序号 |               名称              |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |          默认值          |    说明    |
| :-: | :---------------------------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :------: |
|  1  |               ID              |  varchar |  32 |  0  |   N  |  Y  |                       |   主键ID   |
|  2  |          TEMPLATE\_ID         |  varchar |  32 |  0  |   Y  |  N  |                       |   模板ID   |
|  3  |       TEMPLATE\_VERSION       |  varchar |  32 |  0  |   N  |  N  |                       |   模板版本   |
|  4  | USE\_TEMPLATE\_SETTINGS\_FLAG |    bit   |  1  |  0  |   N  |  N  |                       | 是否使用模板配置 |
|  5  |          PROJECT\_ID          |  varchar |  64 |  0  |   N  |  N  |                       |   项目ID   |
|  6  |        TOTAL\_ITEM\_NUM       |    int   |  10 |  0  |   N  |  N  |           0           |  总实例化数量  |
|  7  |       SUCCESS\_ITEM\_NUM      |    int   |  10 |  0  |   N  |  N  |           0           |  实例化成功数量 |
|  8  |        FAIL\_ITEM\_NUM        |    int   |  10 |  0  |   N  |  N  |           0           |  实例化失败数量 |
|  9  |             STATUS            |  varchar |  32 |  0  |   N  |  N  |                       |    状态    |
|  10 |            CREATOR            |  varchar |  50 |  0  |   N  |  N  |         system        |    创建者   |
|  11 |            MODIFIER           |  varchar |  50 |  0  |   N  |  N  |         system        |    修改者   |
|  12 |          UPDATE\_TIME         | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   修改时间   |
|  13 |          CREATE\_TIME         | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   创建时间   |

**表名：** T\_TEMPLATE\_INSTANCE\_ITEM

**说明：** 模板实列化项信息表

**数据列：**

|  序号 |        名称       |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |          默认值          |     说明    |
| :-: | :-------------: | :--------: | :------: | :-: | :--: | :-: | :-------------------: | :-------: |
|  1  |        ID       |   varchar  |    32    |  0  |   N  |  Y  |                       |    主键ID   |
|  2  |   PROJECT\_ID   |   varchar  |    64    |  0  |   N  |  N  |                       |    项目ID   |
|  3  |   PIPELINE\_ID  |   varchar  |    34    |  0  |   N  |  N  |                       |   流水线ID   |
|  4  |  PIPELINE\_NAME |   varchar  |    255   |  0  |   N  |  N  |                       |   流水线名称   |
|  5  | BUILD\_NO\_INFO |   varchar  |    512   |  0  |   Y  |  N  |                       |   构建号信息   |
|  6  |      STATUS     |   varchar  |    32    |  0  |   N  |  N  |                       |     状态    |
|  7  |     BASE\_ID    |   varchar  |    32    |  0  |   N  |  N  |                       | 实列化基本信息ID |
|  8  |      PARAM      | mediumtext | 16777215 |  0  |   Y  |  N  |                       |     参数    |
|  9  |     CREATOR     |   varchar  |    50    |  0  |   N  |  N  |         system        |    创建者    |
|  10 |     MODIFIER    |   varchar  |    50    |  0  |   N  |  N  |         system        |    修改者    |
|  11 |   UPDATE\_TIME  |  datetime  |    23    |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    修改时间   |
|  12 |   CREATE\_TIME  |  datetime  |    23    |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |    创建时间   |

**表名：** T\_TEMPLATE\_PIPELINE

**说明：** 流水线模板-实例映射表

**数据列：**

|  序号 |         名称         |    数据类型    |    长度    | 小数位 | 允许空值 |  主键 |     默认值    |                说明               |
| :-: | :----------------: | :--------: | :------: | :-: | :--: | :-: | :--------: | :-----------------------------: |
|  1  |     PROJECT\_ID    |   varchar  |    64    |  0  |   N  |  N  |            |               项目ID              |
|  2  |    PIPELINE\_ID    |   varchar  |    34    |  0  |   N  |  Y  |            |              流水线ID              |
|  3  |   INSTANCE\_TYPE   |   varchar  |    32    |  0  |   N  |  N  | CONSTRAINT | 实例化类型：FREEDOM自由模式CONSTRAINT约束模式 |
|  4  | ROOT\_TEMPLATE\_ID |   varchar  |    32    |  0  |   Y  |  N  |            |              源模板ID              |
|  5  |       VERSION      |   bigint   |    20    |  0  |   N  |  N  |            |               版本号               |
|  6  |    VERSION\_NAME   |   varchar  |    64    |  0  |   N  |  N  |            |               版本名称              |
|  7  |    TEMPLATE\_ID    |   varchar  |    32    |  0  |   N  |  N  |            |               模板ID              |
|  8  |       CREATOR      |   varchar  |    64    |  0  |   N  |  N  |            |               创建者               |
|  9  |       UPDATOR      |   varchar  |    64    |  0  |   N  |  N  |            |               更新人               |
|  10 |    CREATED\_TIME   |  datetime  |    19    |  0  |   N  |  N  |            |               创建时间              |
|  11 |    UPDATED\_TIME   |  datetime  |    19    |  0  |   N  |  N  |            |               更新时间              |
|  12 |      BUILD\_NO     |    text    |   65535  |  0  |   Y  |  N  |            |               构建号               |
|  13 |        PARAM       | mediumtext | 16777215 |  0  |   Y  |  N  |            |                参数               |
|  14 |       DELETED      |     bit    |     1    |  0  |   Y  |  N  |    b'0'    |             流水线已被软删除            |
