# devops\_ci\_environment

**数据库名：** devops\_ci\_environment

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_environment的数据库文档

|                                表名                                |       说明       |
| :--------------------------------------------------------------: | :------------: |
|        [T\_AGENT\_FAILURE\_NOTIFY\_USER](broken-reference)       |                |
|            [T\_AGENT\_PIPELINE\_REF](broken-reference)           |                |
|                    [T\_ENV](broken-reference)                    |      环境信息表     |
|        [T\_ENVIRONMENT\_AGENT\_PIPELINE](broken-reference)       |                |
|        [T\_ENVIRONMENT\_SLAVE\_GATEWAY](broken-reference)        |                |
|       [T\_ENVIRONMENT\_THIRDPARTY\_AGENT](broken-reference)      | 第三方构建机agent信息表 |
|   [T\_ENVIRONMENT\_THIRDPARTY\_AGENT\_ACTION](broken-reference)  |                |
| [T\_ENVIRONMENT\_THIRDPARTY\_ENABLE\_PROJECTS](broken-reference) |                |
|                 [T\_ENV\_NODE](broken-reference)                 |    环境-节点映射表    |
|            [T\_ENV\_SHARE\_PROJECT](broken-reference)            |                |
|                    [T\_NODE](broken-reference)                   |      节点信息表     |
|              [T\_PROJECT\_CONFIG](broken-reference)              |                |

**表名：** T\_AGENT\_FAILURE\_NOTIFY\_USER

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-----------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |       ID      |  bigint |  20 |  0  |   N  |  Y  |     | 主键ID |
|  2  |    USER\_ID   | varchar |  32 |  0  |   Y  |  N  |     | 用户ID |
|  3  | NOTIFY\_TYPES | varchar |  32 |  0  |   Y  |  N  |     | 通知类型 |

**表名：** T\_AGENT\_PIPELINE\_REF

**说明：**

**数据列：**

|  序号 |         名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |    说明   |
| :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-----: |
|  1  |         ID        |  bigint  |  20 |  0  |   N  |  Y  |     |   主键ID  |
|  2  |      NODE\_ID     |  bigint  |  20 |  0  |   N  |  N  |     |   节点ID  |
|  3  |     AGENT\_ID     |  bigint  |  20 |  0  |   N  |  N  |     |  构建机ID  |
|  4  |    PROJECT\_ID    |  varchar |  64 |  0  |   N  |  N  |     |   项目ID  |
|  5  |    PIPELINE\_ID   |  varchar |  34 |  0  |   N  |  N  |     |  流水线ID  |
|  6  |   PIEPLINE\_NAME  |  varchar | 255 |  0  |   N  |  N  |     |  流水线名称  |
|  7  |    VM\_SEQ\_ID    |  varchar |  34 |  0  |   Y  |  N  |     |  构建序列号  |
|  8  |      JOB\_ID      |  varchar |  34 |  0  |   Y  |  N  |     |  JOBID  |
|  9  |     JOB\_NAME     |  varchar | 255 |  0  |   N  |  N  |     | JOBNAME |
|  10 | LAST\_BUILD\_TIME | datetime |  19 |  0  |   N  |  N  |     |  最近构建时间 |

**表名：** T\_ENV

**说明：** 环境信息表

**数据列：**

|  序号 |       名称      |    数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |       说明       |
| :-: | :-----------: | :-------: | :---: | :-: | :--: | :-: | :-: | :------------: |
|  1  |    ENV\_ID    |   bigint  |   20  |  0  |   N  |  Y  |     |      主键ID      |
|  2  |  PROJECT\_ID  |  varchar  |   64  |  0  |   N  |  N  |     |      项目ID      |
|  3  |   ENV\_NAME   |  varchar  |  128  |  0  |   N  |  N  |     |      环境名称      |
|  4  |   ENV\_DESC   |  varchar  |  128  |  0  |   N  |  N  |     |      环境描述      |
|  5  |   ENV\_TYPE   |  varchar  |  128  |  0  |   N  |  N  |     | 环境类型（开发环境{DEV} |
|  6  |   ENV\_VARS   |    text   | 65535 |  0  |   N  |  N  |     |      环境变量      |
|  7  | CREATED\_USER |  varchar  |   64  |  0  |   N  |  N  |     |       创建人      |
|  8  | UPDATED\_USER |  varchar  |   64  |  0  |   N  |  N  |     |       修改人      |
|  9  | CREATED\_TIME | timestamp |   19  |  0  |   Y  |  N  |     |      创建时间      |
|  10 | UPDATED\_TIME | timestamp |   19  |  0  |   Y  |  N  |     |      修改时间      |
|  11 |  IS\_DELETED  |    bit    |   1   |  0  |   N  |  N  |     |      是否删除      |

**表名：** T\_ENVIRONMENT\_AGENT\_PIPELINE

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |      说明      |
| :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :-: | :----------: |
|  1  |       ID      |  bigint  |   20  |  0  |   N  |  Y  |     |     主键ID     |
|  2  |   AGENT\_ID   |  bigint  |   20  |  0  |   N  |  N  |     |     构建机ID    |
|  3  |  PROJECT\_ID  |  varchar |   32  |  0  |   N  |  N  |     |     项目ID     |
|  4  |    USER\_ID   |  varchar |   32  |  0  |   N  |  N  |     |     用户ID     |
|  5  | CREATED\_TIME | datetime |   19  |  0  |   N  |  N  |     |     创建时间     |
|  6  | UPDATED\_TIME | datetime |   19  |  0  |   N  |  N  |     |     更新时间     |
|  7  |     STATUS    |    int   |   10  |  0  |   N  |  N  |     |      状态      |
|  8  |    PIPELINE   |  varchar |  1024 |  0  |   N  |  N  |     | PipelineType |
|  9  |    RESPONSE   |   text   | 65535 |  0  |   Y  |  N  |     |              |

**表名：** T\_ENVIRONMENT\_SLAVE\_GATEWAY

**说明：**

**数据列：**

|  序号 |     名称     |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :--------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |     ID     |  bigint |  20 |  0  |   N  |  Y  |     | 主键ID |
|  2  |    NAME    | varchar |  32 |  0  |   N  |  N  |     |  名称  |
|  3  | SHOW\_NAME | varchar |  32 |  0  |   N  |  N  |     | 展示名称 |
|  4  |   GATEWAY  | varchar | 127 |  0  |   Y  |  N  |     | 网关地址 |

**表名：** T\_ENVIRONMENT\_THIRDPARTY\_AGENT

**说明：** 第三方构建机agent信息表

**数据列：**

|  序号 |           名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |    说明   |
| :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :-: | :-----: |
|  1  |           ID          |  bigint  |   20  |  0  |   N  |  Y  |     |   主键ID  |
|  2  |        NODE\_ID       |  bigint  |   20  |  0  |   Y  |  N  |     |   节点ID  |
|  3  |      PROJECT\_ID      |  varchar |   64  |  0  |   N  |  N  |     |   项目ID  |
|  4  |        HOSTNAME       |  varchar |  128  |  0  |   Y  |  N  |     |   主机名称  |
|  5  |           IP          |  varchar |   64  |  0  |   Y  |  N  |     |   ip地址  |
|  6  |           OS          |  varchar |   16  |  0  |   N  |  N  |     |   操作系统  |
|  7  |       DETECT\_OS      |  varchar |  128  |  0  |   Y  |  N  |     |  检测操作系统 |
|  8  |         STATUS        |    int   |   10  |  0  |   N  |  N  |     |    状态   |
|  9  |      SECRET\_KEY      |  varchar |  256  |  0  |   N  |  N  |     |    密钥   |
|  10 |     CREATED\_USER     |  varchar |   64  |  0  |   N  |  N  |     |   创建者   |
|  11 |     CREATED\_TIME     | datetime |   19  |  0  |   N  |  N  |     |   创建时间  |
|  12 |   START\_REMOTE\_IP   |  varchar |   64  |  0  |   Y  |  N  |     |   主机IP  |
|  13 |        GATEWAY        |  varchar |  256  |  0  |   Y  |  N  |     |  目标服务网关 |
|  14 |        VERSION        |  varchar |  128  |  0  |   Y  |  N  |     |   版本号   |
|  15 |    MASTER\_VERSION    |  varchar |  128  |  0  |   Y  |  N  |     |   主版本   |
|  16 | PARALLEL\_TASK\_COUNT |    int   |   10  |  0  |   Y  |  N  |     |  并行任务计数 |
|  17 |  AGENT\_INSTALL\_PATH |  varchar |  512  |  0  |   Y  |  N  |     | 构建机安装路径 |
|  18 |     STARTED\_USER     |  varchar |   64  |  0  |   Y  |  N  |     |   启动者   |
|  19 |      AGENT\_ENVS      |   text   | 65535 |  0  |   Y  |  N  |     |   环境变量  |
|  20 |     FILE\_GATEWAY     |  varchar |  256  |  0  |   Y  |  N  |     |  文件网关路径 |

**表名：** T\_ENVIRONMENT\_THIRDPARTY\_AGENT\_ACTION

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID |
|  2  |   AGENT\_ID  |  bigint  |  20 |  0  |   N  |  N  |     | 构建机ID |
|  3  |  PROJECT\_ID |  varchar |  64 |  0  |   N  |  N  |     |  项目ID |
|  4  |    ACTION    |  varchar |  64 |  0  |   N  |  N  |     |   操作  |
|  5  | ACTION\_TIME | datetime |  19 |  0  |   N  |  N  |     |  操作时间 |

**表名：** T\_ENVIRONMENT\_THIRDPARTY\_ENABLE\_PROJECTS

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |  PROJECT\_ID  |  varchar |  64 |  0  |   N  |  Y  |     | 项目ID |
|  2  |     ENALBE    |    bit   |  1  |  0  |   Y  |  N  |     | 是否启用 |
|  3  | CREATED\_TIME | datetime |  19 |  0  |   N  |  N  |     | 创建时间 |
|  4  | UPDATED\_TIME | datetime |  19 |  0  |   N  |  N  |     | 更新时间 |

**表名：** T\_ENV\_NODE

**说明：** 环境-节点映射表

**数据列：**

|  序号 |      名称     |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |   ENV\_ID   |  bigint |  20 |  0  |   N  |  Y  |     | 环境ID |
|  2  |   NODE\_ID  |  bigint |  20 |  0  |   N  |  Y  |     | 节点ID |
|  3  | PROJECT\_ID | varchar |  64 |  0  |   N  |  N  |     | 项目ID |

**表名：** T\_ENV\_SHARE\_PROJECT

**说明：**

**数据列：**

|  序号 |           名称          |    数据类型   |  长度  | 小数位 | 允许空值 |  主键 | 默认值 |     说明    |
| :-: | :-------------------: | :-------: | :--: | :-: | :--: | :-: | :-: | :-------: |
|  1  |        ENV\_ID        |   bigint  |  20  |  0  |   N  |  Y  |     |    环境ID   |
|  2  |       ENV\_NAME       |  varchar  |  128 |  0  |   N  |  N  |     |    环境名称   |
|  3  |   MAIN\_PROJECT\_ID   |  varchar  |  64  |  0  |   N  |  Y  |     |   主项目ID   |
|  4  |  SHARED\_PROJECT\_ID  |  varchar  |  64  |  0  |   N  |  Y  |     | 共享的目标项目ID |
|  5  | SHARED\_PROJECT\_NAME |  varchar  | 1024 |  0  |   Y  |  N  |     |   目标项目名称  |
|  6  |          TYPE         |  varchar  |  64  |  0  |   N  |  N  |     |     类型    |
|  7  |        CREATOR        |  varchar  |  64  |  0  |   N  |  N  |     |    创建者    |
|  8  |      CREATE\_TIME     | timestamp |  19  |  0  |   Y  |  N  |     |    创建时间   |
|  9  |      UPDATE\_TIME     | timestamp |  19  |  0  |   Y  |  N  |     |    更新时间   |

**表名：** T\_NODE

**说明：** 节点信息表

**数据列：**

|  序号 |          名称          |    数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |     说明    |
| :-: | :------------------: | :-------: | :-: | :-: | :--: | :-: | :-: | :-------: |
|  1  |       NODE\_ID       |   bigint  |  20 |  0  |   N  |  Y  |     |  节点ID主键ID |
|  2  |   NODE\_STRING\_ID   |  varchar  |  32 |  0  |   Y  |  N  |     |  节点ID字符串  |
|  3  |      PROJECT\_ID     |  varchar  |  64 |  0  |   N  |  N  |     |    项目ID   |
|  4  |       NODE\_IP       |  varchar  |  64 |  0  |   N  |  N  |     |    节点IP   |
|  5  |      NODE\_NAME      |  varchar  |  64 |  0  |   N  |  N  |     |    节点名称   |
|  6  |     NODE\_STATUS     |  varchar  |  64 |  0  |   N  |  N  |     |    节点状态   |
|  7  |      NODE\_TYPE      |  varchar  |  64 |  0  |   N  |  N  |     |    节点类型   |
|  8  |   NODE\_CLUSTER\_ID  |  varchar  | 128 |  0  |   Y  |  N  |     |    集群ID   |
|  9  |    NODE\_NAMESPACE   |  varchar  | 128 |  0  |   Y  |  N  |     |   节点命名空间  |
|  10 |     CREATED\_USER    |  varchar  |  64 |  0  |   N  |  N  |     |    创建者    |
|  11 |     CREATED\_TIME    | timestamp |  19 |  0  |   Y  |  N  |     |    创建时间   |
|  12 |     EXPIRE\_TIME     | timestamp |  19 |  0  |   Y  |  N  |     |    过期时间   |
|  13 |       OS\_NAME       |  varchar  | 128 |  0  |   Y  |  N  |     |   操作系统名称  |
|  14 |       OPERATOR       |  varchar  | 256 |  0  |   Y  |  N  |     |    操作者    |
|  15 |     BAK\_OPERATOR    |  varchar  | 256 |  0  |   Y  |  N  |     |   备份责任人   |
|  16 |     AGENT\_STATUS    |    bit    |  1  |  0  |   Y  |  N  |     |   构建机状态   |
|  17 |     DISPLAY\_NAME    |  varchar  | 128 |  0  |   N  |  N  |     |     别名    |
|  18 |         IMAGE        |  varchar  | 512 |  0  |   Y  |  N  |     |     镜像    |
|  19 |       TASK\_ID       |   bigint  |  20 |  0  |   Y  |  N  |     |    任务id   |
|  20 |  LAST\_MODIFY\_TIME  | timestamp |  19 |  0  |   Y  |  N  |     |   最近修改时间  |
|  21 |  LAST\_MODIFY\_USER  |  varchar  | 512 |  0  |   Y  |  N  |     |   最近修改者   |
|  22 |        BIZ\_ID       |   bigint  |  20 |  0  |   Y  |  N  |     |    所属业务   |
|  23 | PIPELINE\_REF\_COUNT |    int    |  10 |  0  |   N  |  N  |  0  | 流水线Job引用数 |
|  24 |   LAST\_BUILD\_TIME  |  datetime |  19 |  0  |   Y  |  N  |     |   最近构建时间  |

**表名：** T\_PROJECT\_CONFIG

**说明：**

**数据列：**

|  序号 |          名称         |    数据类型   |  长度 | 小数位 | 允许空值 |  主键 |  默认值 |  说明  |
| :-: | :-----------------: | :-------: | :-: | :-: | :--: | :-: | :--: | :--: |
|  1  |     PROJECT\_ID     |  varchar  |  64 |  0  |   N  |  Y  |      | 项目ID |
|  2  |    UPDATED\_USER    |  varchar  |  64 |  0  |   N  |  N  |      |  修改者 |
|  3  |    UPDATED\_TIME    | timestamp |  19 |  0  |   Y  |  N  |      | 修改时间 |
|  4  |    BCSVM\_ENALBED   |    bit    |  1  |  0  |   N  |  N  | b'0' |      |
|  5  |     BCSVM\_QUOTA    |    int    |  10 |  0  |   N  |  N  |   0  |      |
|  6  |    IMPORT\_QUOTA    |    int    |  10 |  0  |   N  |  N  |  30  |      |
|  7  | DEV\_CLOUD\_ENALBED |    bit    |  1  |  0  |   N  |  N  | b'0' |      |
|  8  |  DEV\_CLOUD\_QUOTA  |    int    |  10 |  0  |   N  |  N  |   0  |      |
