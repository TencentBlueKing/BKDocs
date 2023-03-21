# devops\_ci\_quality

**数据库名：** devops\_ci\_quality

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_quality的数据库文档

|                              表名                             |      说明     |
| :---------------------------------------------------------: | :---------: |
|            [T\_CONTROL\_POINT](broken-reference)            |             |
|       [T\_CONTROL\_POINT\_METADATA](broken-reference)       |             |
|         [T\_CONTROL\_POINT\_TASK](broken-reference)         |             |
|           [T\_COUNT\_INTERCEPT](broken-reference)           |             |
|            [T\_COUNT\_PIPELINE](broken-reference)           |             |
|              [T\_COUNT\_RULE](broken-reference)             |             |
|                 [T\_GROUP](broken-reference)                |             |
|                [T\_HISTORY](broken-reference)               |             |
|        [T\_QUALITY\_CONTROL\_POINT](broken-reference)       |   质量红线控制点表  |
|    [T\_QUALITY\_HIS\_DETAIL\_METADATA](broken-reference)    | 执行结果详细基础数据表 |
|    [T\_QUALITY\_HIS\_ORIGIN\_METADATA](broken-reference)    |  执行结果基础数据表  |
|          [T\_QUALITY\_INDICATOR](broken-reference)          |   质量红线指标表   |
|           [T\_QUALITY\_METADATA](broken-reference)          |  质量红线基础数据表  |
|             [T\_QUALITY\_RULE](broken-reference)            |             |
|       [T\_QUALITY\_RULE\_BUILD\_HIS](broken-reference)      |             |
| [T\_QUALITY\_RULE\_BUILD\_HIS\_OPERATION](broken-reference) |             |
|          [T\_QUALITY\_RULE\_MAP](broken-reference)          |             |
|       [T\_QUALITY\_RULE\_OPERATION](broken-reference)       |             |
|        [T\_QUALITY\_RULE\_TEMPLATE](broken-reference)       |   质量红线模板表   |
|   [T\_QUALITY\_TEMPLATE\_INDICATOR\_MAP](broken-reference)  |   模板-指标关系表  |
|                 [T\_RULE](broken-reference)                 |             |
|                 [T\_TASK](broken-reference)                 |             |

**表名：** T\_CONTROL\_POINT

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :-: | :----: |
|  1  |      ID      |    int   |   10  |  0  |   N  |  Y  |     |  主键ID  |
|  2  |     NAME     |  varchar |   64  |  0  |   N  |  N  |     |   名称   |
|  3  |  TASK\_LIST  |   text   | 65535 |  0  |   N  |  N  |     | 任务信息列表 |
|  4  |    ONLINE    |    bit   |   1   |  0  |   N  |  N  |     |  是否在线  |
|  5  | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  |     |  创建时间  |
|  6  | UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  |     |  更新时间  |

**表名：** T\_CONTROL\_POINT\_METADATA

**说明：**

**数据列：**

|  序号 |       名称       |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :------------: | :------: | :---: | :-: | :--: | :-: | :-: | :---: |
|  1  |  METADATA\_ID  |  varchar |  128  |  0  |   N  |  Y  |     | 元数据ID |
|  2  | METADATA\_TYPE |  varchar |   32  |  0  |   N  |  N  |     | 元数据类型 |
|  3  | METADATA\_NAME |   text   | 65535 |  0  |   N  |  N  |     | 元数据名称 |
|  4  |    TASK\_ID    |  varchar |   64  |  0  |   N  |  N  |     |  任务ID |
|  5  |     ONLINE     |    bit   |   1   |  0  |   N  |  N  |     |  是否在线 |
|  6  |  CREATE\_TIME  | datetime |   19  |  0  |   N  |  N  |     |  创建时间 |
|  7  |  UPDATE\_TIME  | datetime |   19  |  0  |   N  |  N  |     |  更新时间 |

**表名：** T\_CONTROL\_POINT\_TASK

**说明：**

**数据列：**

|  序号 |       名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |       ID       |  varchar |  64 |  0  |   N  |  Y  |     |  主键ID  |
|  2  | CONTROL\_STAGE |  varchar |  32 |  0  |   N  |  N  |     | 原子控制阶段 |
|  3  |  CREATE\_TIME  | datetime |  19 |  0  |   N  |  N  |     |  创建时间  |
|  4  |  UPDATE\_TIME  | datetime |  19 |  0  |   N  |  N  |     |  更新时间  |

**表名：** T\_COUNT\_INTERCEPT

**说明：**

**数据列：**

|  序号 |           名称           |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |               说明              |
| :-: | :--------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :---------------------------: |
|  1  |           ID           |  bigint  |  20 |  0  |   N  |  Y  |     |              主键ID             |
|  2  |       PROJECT\_ID      |  varchar |  32 |  0  |   N  |  N  |     |              项目ID             |
|  3  |          DATE          |   date   |  10 |  0  |   N  |  N  |     |               日期              |
|  4  |          COUNT         |    int   |  10 |  0  |   N  |  N  |     |               计数              |
|  5  |      CREATE\_TIME      | datetime |  19 |  0  |   N  |  N  |     |              创建时间             |
|  6  |      UPDATE\_TIME      | datetime |  19 |  0  |   N  |  N  |     |              更新时间             |
|  7  |    INTERCEPT\_COUNT    |    int   |  10 |  0  |   N  |  N  |  0  |              拦截数              |
|  8  | RULE\_INTERCEPT\_COUNT |    int   |  10 |  0  |   N  |  N  |  0  | RULE\_INTERCEPT\_COUNT+count) |

**表名：** T\_COUNT\_PIPELINE

**说明：**

**数据列：**

|  序号 |           名称          |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |           ID          |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID  |
|  2  |      PROJECT\_ID      |  varchar |  32 |  0  |   N  |  N  |     |  项目ID  |
|  3  |      PIPELINE\_ID     |  varchar |  34 |  0  |   N  |  N  |     |  流水线ID |
|  4  |          DATE         |   date   |  10 |  0  |   N  |  N  |     |   日期   |
|  5  |         COUNT         |    int   |  10 |  0  |   N  |  N  |     |   计数   |
|  6  | LAST\_INTERCEPT\_TIME | datetime |  19 |  0  |   N  |  N  |     | 上次拦截时间 |
|  7  |      CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  |     |  创建时间  |
|  8  |      UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  |     |  更新时间  |
|  9  |    INTERCEPT\_COUNT   |    int   |  10 |  0  |   N  |  N  |  0  |   拦截数  |

**表名：** T\_COUNT\_RULE

**说明：**

**数据列：**

|  序号 |           名称          |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |           ID          |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID  |
|  2  |      PROJECT\_ID      |  varchar |  32 |  0  |   N  |  N  |     |  项目ID  |
|  3  |        RULE\_ID       |  bigint  |  20 |  0  |   N  |  N  |     |  规则ID  |
|  4  |          DATE         |   date   |  10 |  0  |   N  |  N  |     |   日期   |
|  5  |         COUNT         |    int   |  10 |  0  |   N  |  N  |     |   计数   |
|  6  |    INTERCEPT\_COUNT   |    int   |  10 |  0  |   N  |  N  |  0  |   拦截数  |
|  7  | LAST\_INTERCEPT\_TIME | datetime |  19 |  0  |   N  |  N  |     | 上次拦截时间 |
|  8  |      CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  |     |  创建时间  |
|  9  |      UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  |     |  更新时间  |

**表名：** T\_GROUP

**说明：**

**数据列：**

|  序号 |          名称         |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :-----------------: | :------: | :---: | :-: | :--: | :-: | :-: | :----: |
|  1  |          ID         |  bigint  |   20  |  0  |   N  |  Y  |     |  主键ID  |
|  2  |     PROJECT\_ID     |  varchar |   64  |  0  |   N  |  N  |     |  项目ID  |
|  3  |         NAME        |  varchar |   64  |  0  |   N  |  N  |     |   名称   |
|  4  |     INNER\_USERS    |   text   | 65535 |  0  |   N  |  N  |     |  内部人员  |
|  5  | INNER\_USERS\_COUNT |    int   |   10  |  0  |   N  |  N  |     | 内部人员计数 |
|  6  |     OUTER\_USERS    |   text   | 65535 |  0  |   N  |  N  |     |  外部人员  |
|  7  | OUTER\_USERS\_COUNT |    int   |   10  |  0  |   N  |  N  |     | 外部人员计数 |
|  8  |        REMARK       |   text   | 65535 |  0  |   Y  |  N  |     |   评论   |
|  9  |       CREATOR       |  varchar |   64  |  0  |   N  |  N  |     |   创建者  |
|  10 |       UPDATOR       |  varchar |   64  |  0  |   N  |  N  |     |   更新人  |
|  11 |     CREATE\_TIME    | datetime |   19  |  0  |   N  |  N  |     |  创建时间  |
|  12 |     UPDATE\_TIME    | datetime |   19  |  0  |   N  |  N  |     |  更新时间  |

**表名：** T\_HISTORY

**说明：**

**数据列：**

|  序号 |        名称       |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |        ID       |  bigint  |   20  |  0  |   N  |  Y  |                    |  主键ID |
|  2  |   PROJECT\_ID   |  varchar |   32  |  0  |   N  |  N  |                    |  项目ID |
|  3  |     RULE\_ID    |  bigint  |   20  |  0  |   N  |  N  |                    |  规则ID |
|  4  |   PIPELINE\_ID  |  varchar |   34  |  0  |   N  |  N  |                    | 流水线ID |
|  5  |    BUILD\_ID    |  varchar |   34  |  0  |   N  |  N  |                    |  构建ID |
|  6  |      RESULT     |  varchar |   34  |  0  |   N  |  N  |                    |       |
|  7  | INTERCEPT\_LIST |   text   | 65535 |  0  |   N  |  N  |                    |  拦截列表 |
|  8  |   CREATE\_TIME  | datetime |   19  |  0  |   N  |  N  |                    |  创建时间 |
|  9  |   UPDATE\_TIME  | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间 |
|  10 |   PROJECT\_NUM  |  bigint  |   20  |  0  |   N  |  N  |          0         |  项目数量 |
|  11 |   CHECK\_TIMES  |    int   |   10  |  0  |   Y  |  N  |          1         | 第几次检查 |

**表名：** T\_QUALITY\_CONTROL\_POINT

**说明：** 质量红线控制点表

**数据列：**

|  序号 |          名称         |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |  默认值  |             说明             |
| :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :---: | :------------------------: |
|  1  |          ID         |  bigint  |  20 |  0  |   N  |  Y  |       |            主键ID            |
|  2  |    ELEMENT\_TYPE    |  varchar |  64 |  0  |   Y  |  N  |       |        原子的ClassType        |
|  3  |         NAME        |  varchar |  64 |  0  |   Y  |  N  |       |         控制点名称(原子名称)        |
|  4  |        STAGE        |  varchar |  64 |  0  |   Y  |  N  |       |            研发阶段            |
|  5  | AVAILABLE\_POSITION |  varchar |  64 |  0  |   Y  |  N  |       | 支持红线位置(准入-BEFORE,准出-AFTER) |
|  6  |  DEFAULT\_POSITION  |  varchar |  64 |  0  |   Y  |  N  |       |           默认红线位置           |
|  7  |        ENABLE       |    bit   |  1  |  0  |   Y  |  N  |       |            是否启用            |
|  8  |     CREATE\_USER    |  varchar |  64 |  0  |   Y  |  N  |       |            创建用户            |
|  9  |     UPDATE\_USER    |  varchar |  64 |  0  |   Y  |  N  |       |            更新用户            |
|  10 |     CREATE\_TIME    | datetime |  19 |  0  |   Y  |  N  |       |            创建时间            |
|  11 |     UPDATE\_TIME    | datetime |  19 |  0  |   Y  |  N  |       |            更新时间            |
|  12 |    ATOM\_VERSION    |  varchar |  16 |  0  |   Y  |  N  | 1.0.0 |            插件版本            |
|  13 |    TEST\_PROJECT    |  varchar |  64 |  0  |   N  |  N  |       |            测试的项目           |
|  14 |         TAG         |  varchar |  64 |  0  |   Y  |  N  |       |                            |

**表名：** T\_QUALITY\_HIS\_DETAIL\_METADATA

**说明：** 执行结果详细基础数据表

**数据列：**

|  序号 |        名称       |   数据类型  |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |      说明      |
| :-: | :-------------: | :-----: | :---: | :-: | :--: | :-: | :-: | :----------: |
|  1  |        ID       |  bigint |   20  |  0  |   N  |  Y  |     |     主键ID     |
|  2  |     DATA\_ID    | varchar |  128  |  0  |   Y  |  N  |     |     数据ID     |
|  3  |    DATA\_NAME   | varchar |  128  |  0  |   Y  |  N  |     |     数据名称     |
|  4  |    DATA\_TYPE   | varchar |   32  |  0  |   Y  |  N  |     |     数据类型     |
|  5  |    DATA\_DESC   | varchar |  128  |  0  |   Y  |  N  |     |     数据描述     |
|  6  |   DATA\_VALUE   | varchar |  256  |  0  |   Y  |  N  |     |      数据值     |
|  7  |  ELEMENT\_TYPE  | varchar |   64  |  0  |   Y  |  N  |     | 原子的ClassType |
|  8  | ELEMENT\_DETAIL | varchar |   64  |  0  |   Y  |  N  |     |    工具/原子子类   |
|  9  |   PROJECT\_ID   | varchar |   64  |  0  |   Y  |  N  |     |     项目ID     |
|  10 |   PIPELINE\_ID  | varchar |   64  |  0  |   Y  |  N  |     |     流水线ID    |
|  11 |    BUILD\_ID    | varchar |   64  |  0  |   Y  |  N  |     |     构建ID     |
|  12 |    BUILD\_NO    | varchar |   64  |  0  |   Y  |  N  |     |      构建号     |
|  13 |   CREATE\_TIME  |  bigint |   20  |  0  |   Y  |  N  |     |     创建时间     |
|  14 |      EXTRA      |   text  | 65535 |  0  |   Y  |  N  |     |     额外信息     |

**表名：** T\_QUALITY\_HIS\_ORIGIN\_METADATA

**说明：** 执行结果基础数据表

**数据列：**

|  序号 |      名称      |   数据类型  |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :-----: | :---: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |  bigint |   20  |  0  |   N  |  Y  |     |  主键ID |
|  2  |  PROJECT\_ID | varchar |   64  |  0  |   Y  |  N  |     |  项目ID |
|  3  | PIPELINE\_ID | varchar |   64  |  0  |   Y  |  N  |     | 流水线ID |
|  4  |   BUILD\_ID  | varchar |   64  |  0  |   Y  |  N  |     |  构建ID |
|  5  |   BUILD\_NO  | varchar |   64  |  0  |   Y  |  N  |     |  构建号  |
|  6  | RESULT\_DATA |   text  | 65535 |  0  |   Y  |  N  |     |  返回数据 |
|  7  | CREATE\_TIME |  bigint |   20  |  0  |   Y  |  N  |     |  创建时间 |

**表名：** T\_QUALITY\_INDICATOR

**说明：** 质量红线指标表

**数据列：**

|  序号 |           名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |   默认值  |       说明      |
| :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----: | :-----------: |
|  1  |           ID          |  bigint  |   20  |  0  |   N  |  Y  |        |      主键ID     |
|  2  |     ELEMENT\_TYPE     |  varchar |   32  |  0  |   Y  |  N  |        |  原子的ClassType |
|  3  |     ELEMENT\_NAME     |  varchar |   64  |  0  |   Y  |  N  |        |      产出原子     |
|  4  |    ELEMENT\_DETAIL    |  varchar |   64  |  0  |   Y  |  N  |        |    工具/原子子类    |
|  5  |        EN\_NAME       |  varchar |   64  |  0  |   Y  |  N  |        |     指标英文名     |
|  6  |        CN\_NAME       |  varchar |   64  |  0  |   Y  |  N  |        |     指标中文名     |
|  7  |     METADATA\_IDS     |   text   | 65535 |  0  |   Y  |  N  |        |   指标所包含基础数据   |
|  8  |   DEFAULT\_OPERATION  |  varchar |   32  |  0  |   Y  |  N  |        |      默认操作     |
|  9  |  OPERATION\_AVAILABLE |   text   | 65535 |  0  |   Y  |  N  |        |      可用操作     |
|  10 |       THRESHOLD       |  varchar |   64  |  0  |   Y  |  N  |        |      默认阈值     |
|  11 |    THRESHOLD\_TYPE    |  varchar |   32  |  0  |   Y  |  N  |        |      阈值类型     |
|  12 |          DESC         |  varchar |  256  |  0  |   Y  |  N  |        |       描述      |
|  13 | INDICATOR\_READ\_ONLY |    bit   |   1   |  0  |   Y  |  N  |        |      是否只读     |
|  14 |         STAGE         |  varchar |   32  |  0  |   Y  |  N  |        |       阶段      |
|  15 |    INDICATOR\_RANGE   |   text   | 65535 |  0  |   Y  |  N  |        |      指标范围     |
|  16 |         ENABLE        |    bit   |   1   |  0  |   Y  |  N  |        |      是否启用     |
|  17 |          TYPE         |  varchar |   32  |  0  |   Y  |  N  | SYSTEM |      指标类型     |
|  18 |          TAG          |  varchar |   32  |  0  |   Y  |  N  |        | 指标标签，用于前端区分控制 |
|  19 |      CREATE\_USER     |  varchar |   64  |  0  |   Y  |  N  |        |      创建用户     |
|  20 |      UPDATE\_USER     |  varchar |   64  |  0  |   Y  |  N  |        |      更新用户     |
|  21 |      CREATE\_TIME     | datetime |   19  |  0  |   Y  |  N  |        |      创建时间     |
|  22 |      UPDATE\_TIME     | datetime |   19  |  0  |   Y  |  N  |        |      更新时间     |
|  23 |     ATOM\_VERSION     |  varchar |   16  |  0  |   N  |  N  |  1.0.0 |     插件版本号     |
|  24 |      LOG\_PROMPT      |  varchar |  1024 |  0  |   N  |  N  |        |      日志提示     |

**表名：** T\_QUALITY\_METADATA

**说明：** 质量红线基础数据表

**数据列：**

|  序号 |        名称       |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |      说明      |
| :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :-: | :----------: |
|  1  |        ID       |  bigint  |   20  |  0  |   N  |  Y  |     |     主键ID     |
|  2  |     DATA\_ID    |  varchar |   64  |  0  |   Y  |  N  |     |     数据ID     |
|  3  |    DATA\_NAME   |  varchar |   64  |  0  |   Y  |  N  |     |     数据名称     |
|  4  |  ELEMENT\_TYPE  |  varchar |   64  |  0  |   Y  |  N  |     | 原子的ClassType |
|  5  |  ELEMENT\_NAME  |  varchar |   64  |  0  |   Y  |  N  |     |     产出原子     |
|  6  | ELEMENT\_DETAIL |  varchar |   64  |  0  |   Y  |  N  |     |    工具/原子子类   |
|  7  |   VALUE\_TYPE   |  varchar |   32  |  0  |   Y  |  N  |     | value值前端组件类型 |
|  8  |       DESC      |  varchar |  256  |  0  |   Y  |  N  |     |      描述      |
|  9  |      EXTRA      |   text   | 65535 |  0  |   Y  |  N  |     |     额外信息     |
|  10 |   CREATE\_USER  |  varchar |   64  |  0  |   Y  |  N  |     |      创建者     |
|  11 |   UPDATE\_USER  |  varchar |   64  |  0  |   Y  |  N  |     |      修改人     |
|  12 |   create\_time  | datetime |   19  |  0  |   Y  |  N  |     |     创建时间     |
|  13 |   UPDATE\_TIME  | datetime |   19  |  0  |   Y  |  N  |     |     更新时间     |

**表名：** T\_QUALITY\_RULE

**说明：**

**数据列：**

|  序号 |             名称            |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |  默认值 |     说明    |
| :-: | :-----------------------: | :------: | :---: | :-: | :--: | :-: | :--: | :-------: |
|  1  |             ID            |  bigint  |   20  |  0  |   N  |  Y  |      |    主键ID   |
|  2  |            NAME           |  varchar |  128  |  0  |   Y  |  N  |      |    规则名称   |
|  3  |            DESC           |  varchar |  256  |  0  |   Y  |  N  |      |    规则描述   |
|  4  |      INDICATOR\_RANGE     |   text   | 65535 |  0  |   Y  |  N  |      |    指标范围   |
|  5  |       CONTROL\_POINT      |  varchar |   64  |  0  |   Y  |  N  |      |  控制点原子类型  |
|  6  |  CONTROL\_POINT\_POSITION |  varchar |   64  |  0  |   Y  |  N  |      |  控制点红线位置  |
|  7  |        CREATE\_USER       |  varchar |   64  |  0  |   Y  |  N  |      |    创建用户   |
|  8  |        UPDATE\_USER       |  varchar |   64  |  0  |   Y  |  N  |      |    更新用户   |
|  9  |        CREATE\_TIME       | datetime |   19  |  0  |   Y  |  N  |      |    创建时间   |
|  10 |        UPDATE\_TIME       | datetime |   19  |  0  |   Y  |  N  |      |    更新时间   |
|  11 |           ENABLE          |    bit   |   1   |  0  |   Y  |  N  | b'1' |    是否启用   |
|  12 |        PROJECT\_ID        |  varchar |   64  |  0  |   Y  |  N  |      |    项目id   |
|  13 |      INTERCEPT\_TIMES     |    int   |   10  |  0  |   Y  |  N  |   0  |    拦截次数   |
|  14 |       EXECUTE\_COUNT      |    int   |   10  |  0  |   Y  |  N  |   0  |  生效流水线执行数 |
|  15 | PIPELINE\_TEMPLATE\_RANGE |   text   | 65535 |  0  |   Y  |  N  |      | 流水线模板生效范围 |
|  16 |        GATEWAY\_ID        |  varchar |  128  |  0  |   N  |  N  |      |  红线匹配的id  |

**表名：** T\_QUALITY\_RULE\_BUILD\_HIS

**说明：**

**数据列：**

|  序号 |           名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |      说明      |
| :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :-: | :----------: |
|  1  |           ID          |  bigint  |   20  |  0  |   N  |  Y  |     |     主键ID     |
|  2  |      PROJECT\_ID      |  varchar |   64  |  0  |   Y  |  N  |     |     项目ID     |
|  3  |      PIPELINE\_ID     |  varchar |   40  |  0  |   Y  |  N  |     |     流水线ID    |
|  4  |       BUILD\_ID       |  varchar |   40  |  0  |   Y  |  N  |     |     构建ID     |
|  5  |       RULE\_POS       |  varchar |   8   |  0  |   Y  |  N  |     |     控制点位置    |
|  6  |       RULE\_NAME      |  varchar |  123  |  0  |   Y  |  N  |     |     规则名称     |
|  7  |       RULE\_DESC      |  varchar |  256  |  0  |   Y  |  N  |     |     规则描述     |
|  8  |      GATEWAY\_ID      |  varchar |  128  |  0  |   Y  |  N  |     |    红线匹配的id   |
|  9  |    PIPELINE\_RANGE    |   text   | 65535 |  0  |   Y  |  N  |     |  生效的流水线id集合  |
|  10 |    TEMPLATE\_RANGE    |   text   | 65535 |  0  |   Y  |  N  |     | 生效的流水线模板id集合 |
|  11 |     INDICATOR\_IDS    |   text   | 65535 |  0  |   Y  |  N  |     |     指标类型     |
|  12 | INDICATOR\_OPERATIONS |   text   | 65535 |  0  |   Y  |  N  |     |     指标操作     |
|  13 | INDICATOR\_THRESHOLDS |   text   | 65535 |  0  |   Y  |  N  |     |     指标阈值     |
|  14 |    OPERATION\_LIST    |   text   | 65535 |  0  |   Y  |  N  |     |     操作清单     |
|  15 |      CREATE\_TIME     | datetime |   19  |  0  |   Y  |  N  |     |     创建时间     |
|  16 |      CREATE\_USER     |  varchar |   32  |  0  |   Y  |  N  |     |      创建人     |
|  17 |       STAGE\_ID       |  varchar |   40  |  0  |   N  |  N  |  1  |   stage\_id  |
|  18 |         STATUS        |  varchar |   20  |  0  |   Y  |  N  |     |     红线状态     |
|  19 |     GATE\_KEEPERS     |  varchar |  1024 |  0  |   Y  |  N  |     |     红线把关人    |

**表名：** T\_QUALITY\_RULE\_BUILD\_HIS\_OPERATION

**说明：**

**数据列：**

|  序号 |        名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |        ID       |  bigint  |  20 |  0  |   N  |  Y  |     | 主键ID |
|  2  |     RULE\_ID    |  bigint  |  20 |  0  |   N  |  N  |     | 规则id |
|  3  |    STAGE\_ID    |  varchar |  40 |  0  |   N  |  N  |     |      |
|  4  | GATE\_OPT\_USER |  varchar |  32 |  0  |   Y  |  N  |     |      |
|  5  | GATE\_OPT\_TIME | datetime |  19 |  0  |   Y  |  N  |     |      |

**表名：** T\_QUALITY\_RULE\_MAP

**说明：**

**数据列：**

|  序号 |           名称          |  数据类型  |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-------------------: | :----: | :---: | :-: | :--: | :-: | :-: | :--: |
|  1  |           ID          | bigint |   20  |  0  |   N  |  Y  |     | 主键ID |
|  2  |        RULE\_ID       | bigint |   20  |  0  |   Y  |  N  |     | 规则ID |
|  3  |     INDICATOR\_IDS    |  text  | 65535 |  0  |   Y  |  N  |     | 指标类型 |
|  4  | INDICATOR\_OPERATIONS |  text  | 65535 |  0  |   Y  |  N  |     | 指标操作 |
|  5  | INDICATOR\_THRESHOLDS |  text  | 65535 |  0  |   Y  |  N  |     | 指标阈值 |

**表名：** T\_QUALITY\_RULE\_OPERATION

**说明：**

**数据列：**

|  序号 |         名称        |   数据类型  |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :---------------: | :-----: | :---: | :-: | :--: | :-: | :-: | :----: |
|  1  |         ID        |  bigint |   20  |  0  |   N  |  Y  |     |  主键ID  |
|  2  |      RULE\_ID     |  bigint |   20  |  0  |   Y  |  N  |     |  规则ID  |
|  3  |        TYPE       | varchar |   16  |  0  |   Y  |  N  |     |   类型   |
|  4  |    NOTIFY\_USER   |   text  | 65535 |  0  |   Y  |  N  |     |  通知人员  |
|  5  | NOTIFY\_GROUP\_ID |   text  | 65535 |  0  |   Y  |  N  |     |  用户组ID |
|  6  |   NOTIFY\_TYPES   | varchar |   64  |  0  |   Y  |  N  |     |  通知类型  |
|  7  |    AUDIT\_USER    |   text  | 65535 |  0  |   Y  |  N  |     |  审核人员  |
|  8  |   AUDIT\_TIMEOUT  |   int   |   10  |  0  |   Y  |  N  |     | 审核超时时间 |

**表名：** T\_QUALITY\_RULE\_TEMPLATE

**说明：** 质量红线模板表

**数据列：**

|  序号 |            名称            |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |  默认值 |    说明   |
| :-: | :----------------------: | :------: | :-: | :-: | :--: | :-: | :--: | :-----: |
|  1  |            ID            |  bigint  |  20 |  0  |   N  |  Y  |      |   主键ID  |
|  2  |           NAME           |  varchar |  64 |  0  |   Y  |  N  |      |    名称   |
|  3  |           TYPE           |  varchar |  16 |  0  |   Y  |  N  |      |    类型   |
|  4  |           DESC           |  varchar | 256 |  0  |   Y  |  N  |      |    描述   |
|  5  |           STAGE          |  varchar |  64 |  0  |   Y  |  N  |      |    阶段   |
|  6  |      CONTROL\_POINT      |  varchar |  64 |  0  |   Y  |  N  |      | 控制点原子类型 |
|  7  | CONTROL\_POINT\_POSITION |  varchar |  64 |  0  |   Y  |  N  |      | 控制点红线位置 |
|  8  |       CREATE\_USER       |  varchar |  64 |  0  |   Y  |  N  |      |   创建者   |
|  9  |       UPDATE\_USER       |  varchar |  64 |  0  |   Y  |  N  |      |   修改人   |
|  10 |       create\_time       | datetime |  19 |  0  |   Y  |  N  |      |   创建时间  |
|  11 |       UPDATE\_TIME       | datetime |  19 |  0  |   Y  |  N  |      |   更新时间  |
|  12 |          ENABLE          |    bit   |  1  |  0  |   Y  |  N  | b'1' |   是否启用  |

**表名：** T\_QUALITY\_TEMPLATE\_INDICATOR\_MAP

**说明：** 模板-指标关系表

**数据列：**

|  序号 |       名称      |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-----------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |       ID      |  bigint |  20 |  0  |   N  |  Y  |     | 主键ID |
|  2  |  TEMPLATE\_ID |  bigint |  20 |  0  |   Y  |  N  |     | 模板ID |
|  3  | INDICATOR\_ID |  bigint |  20 |  0  |   Y  |  N  |     | 指标ID |
|  4  |   OPERATION   | varchar |  32 |  0  |   Y  |  N  |     | 可选操作 |
|  5  |   THRESHOLD   | varchar |  64 |  0  |   Y  |  N  |     | 默认阈值 |

**表名：** T\_RULE

**说明：**

**数据列：**

|  序号 |                 名称                 |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |               说明              |
| :-: | :--------------------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :---------------------------: |
|  1  |                 ID                 |  bigint  |   20  |  0  |   N  |  Y  |                    |              主键ID             |
|  2  |             PROJECT\_ID            |  varchar |   32  |  0  |   N  |  N  |                    |              项目ID             |
|  3  |                NAME                |  varchar |  128  |  0  |   N  |  N  |                    |               名称              |
|  4  |               REMARK               |   text   | 65535 |  0  |   Y  |  N  |                    |               评论              |
|  5  |                TYPE                |  varchar |   32  |  0  |   N  |  N  |                    |               类型              |
|  6  |           CONTROL\_POINT           |  varchar |   32  |  0  |   N  |  N  |                    |            控制点原子类型            |
|  7  |              TASK\_ID              |  varchar |   64  |  0  |   N  |  N  |                    |              任务ID             |
|  8  |              THRESHOLD             |   text   | 65535 |  0  |   N  |  N  |                    |              默认阈值             |
|  9  |          INDICATOR\_RANGE          |   text   | 65535 |  0  |   Y  |  N  |                    |              指标范围             |
|  10 |        RANGE\_IDENTIFICATION       |   text   | 65535 |  0  |   N  |  N  |                    | ANY-项目ID集合,PART\_BY\_NAME-空集合 |
|  11 |              OPERATION             |  varchar |   32  |  0  |   N  |  N  |                    |              可选操作             |
|  12 |    OPERATION\_END\_NOTIFY\_TYPE    |  varchar |  128  |  0  |   Y  |  N  |                    |            操作结束通知类型           |
|  13 |    OPERATION\_END\_NOTIFY\_GROUP   |   text   | 65535 |  0  |   Y  |  N  |                    |           操作结束通知用户组           |
|  14 |    OPERATION\_END\_NOTIFY\_USER    |   text   | 65535 |  0  |   Y  |  N  |                    |            操作结束通知用户           |
|  15 |   OPERATION\_AUDIT\_NOTIFY\_USER   |   text   | 65535 |  0  |   Y  |  N  |                    |            操作审核通知用户           |
|  16 |          INTERCEPT\_TIMES          |    int   |   10  |  0  |   N  |  N  |          0         |              拦截次数             |
|  17 |               ENABLE               |    bit   |   1   |  0  |   N  |  N  |                    |              是否启用             |
|  18 |               CREATOR              |  varchar |   32  |  0  |   N  |  N  |                    |              创建者              |
|  19 |               UPDATOR              |  varchar |   32  |  0  |   N  |  N  |                    |              更新人              |
|  20 |            CREATE\_TIME            | datetime |   19  |  0  |   N  |  N  |                    |              创建时间             |
|  21 |            UPDATE\_TIME            | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |              更新时间             |
|  22 |             IS\_DELETED            |    bit   |   1   |  0  |   N  |  N  |                    |           是否删除0可用1删除          |
|  23 | OPERATION\_AUDIT\_TIMEOUT\_MINUTES |    int   |   10  |  0  |   Y  |  N  |                    |             审核超时时间            |

**表名：** T\_TASK

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |      ID      |  varchar |  64 |  0  |   N  |  Y  |     | 主键ID |
|  2  |     NAME     |  varchar | 255 |  0  |   N  |  N  |     |  名称  |
|  3  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | 创建时间 |
|  4  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | 更新时间 |
